
//
//  JDTableView.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDTableView.h"
#import "JDCellModel.h"
#import "UIView+Extension.h"
#import "JDTableViewCell.h"
/** 1. 数据准备
    1.1 cell 的数量
    1.2 cell 的位置和高度
 
    2. UI
 
 */

@interface JDTableView()<UIScrollViewDelegate>
@end

@implementation JDTableView {
    
    NSMutableArray *_cellInfoArray;
    NSMutableDictionary *_visibleCells;
    NSMutableArray *_reuseCellArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        
        _cellInfoArray = [NSMutableArray array];
        _visibleCells = [NSMutableDictionary dictionary];
        _reuseCellArray = [NSMutableArray array];
        self.delegate = self;
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"_visibleCells = %ld -- _reuseCellArray = %ld", _visibleCells.allKeys.count, _reuseCellArray.count);
}

// 1. 数据准备
- (void)dataHandle{
    
    // 1.1 获取 cell 数量(不做 section 处理)
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSInteger allCellCount = [self.jdDelegate tableView:self numberOfRowsInSection:0];
    
    // 1.2 获取 cell 位置和高度
    CGFloat addupHeight = 0.f;
    for (int i = 0; i<allCellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat cellHeight = [self.jdDelegate tableView:self heightForRowAtIndexPath:indexPath];
        
        JDCellModel *model = [JDCellModel new];
        model.height = cellHeight;
        model.y = addupHeight;
        
        addupHeight += cellHeight;
        
        [_cellInfoArray addObject:model];
    }
    
    [self setContentSize:CGSizeMake(self.width, addupHeight)];
}

// 2. UI 布局
- (void)layoutSubviews {
    // 2.1 计算可视范围
    CGFloat startY = self.contentOffset.y < 0 ?0 : self.contentOffset.y ;
    CGFloat endY = (self.contentOffset.y+self.height > self.contentSize.height) ? self.contentSize.height : (self.contentOffset.y+self.height);
    
    // 2.2 添加响应的 cell
    NSInteger statIndex = 0;
    NSInteger endIndex = 0;
    NSInteger i = 0;
    // 计算 startIndex
    for (; i < _cellInfoArray.count; i++) {
        JDCellModel *model = _cellInfoArray[i];
        
        if (model.y <= startY && model.y+model.height > startY) {
            statIndex = i;
            break;
        }
    }
    
    for (; i < _cellInfoArray.count; i++) {
        JDCellModel *model = _cellInfoArray[i];
        
        if (model.y < endY && model.y+model.height >= endY) {
            endIndex = i;
            break;
        }
    }
    
    // 获取响应的 cell
    for (NSInteger i = statIndex; i<=endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        // 如果 index 对应的cell 已经在界面上了,
        JDTableViewCell *cell = _visibleCells[@(indexPath.row)];
        if (!cell) {
            
            cell = [self.jdDelegate tableView:self cellForRowAtIndexPath:indexPath];
            [self addSubview:cell];
        }
        
        [_visibleCells setObject:cell forKey:@(indexPath.row)];
        
        // 这个 cell 可能是从重用池中拿出来的
        [_reuseCellArray removeObject:cell];
        
        JDCellModel *model = _cellInfoArray[indexPath.row];
        cell.frame = CGRectMake(0, model.y, self.width, model.height);
    }
    
    
    // 2.3 移除不在可视范围的 cell, 放入重用池
    // _visibleCells这个里面的数据进行处理(不在界面上)
    NSArray *allkeys = [_visibleCells allKeys];
    for (NSInteger i = 0; i<allkeys.count; i++) {
        NSInteger index = [allkeys[i] integerValue];
        if (index < statIndex || index > endIndex) {
            //
            JDTableViewCell *cell = _visibleCells[@(index)];
            if (cell) {
                [_reuseCellArray addObject:cell];
                [_visibleCells removeObjectForKey:allkeys[i]];
                
                [cell removeFromSuperview];
            }
            
        }
    }
}


/** 二分查找法 计算index
 
 
 */
int binarySearch(int *a, int min, int max, int target) {
    int mid;
    while (min < max) {
        mid = min + (max -min)/2;
        
        if (target == a[mid]) {
            return mid;
        }else if (target < a[mid]){
            // 在左边
            max = mid;
        }else{
            // 在右边
            min = mid;
        }
    }
    
    return -1;
}

- (NSInteger)binarySearch:(NSArray *)array target:(JDCellModel *)cellModel {
    NSInteger mid;
    NSInteger min = 0;
    NSInteger max = array.count-1;
    while (min < max) {
        mid = min + (max -min)/2;
        
        JDCellModel *midModel = array[mid];
        if (midModel.y < cellModel.y && midModel.y +midModel.height > cellModel.y) {
            return mid;
        }else if (midModel.y < cellModel.y){
            // 在左边
            max = mid-1;
        }else{
            // 在右边
            min = mid+1;
        }
    }
    
    return -1;
}


// 重用池中获取 cell
- (nullable __kindof JDTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    
    for (int i = 0; i < _reuseCellArray.count; i++) {
        JDTableViewCell *cell = _reuseCellArray[i];
        if ([cell.reuseID isEqualToString:identifier]) {
            return cell;
        }
    }
    
    return nil;
}

- (void)reloadData {
    
    [self dataHandle];
    
    /** setNeedsLayout -> 标记为刷新, 调用layoutSubviews, 等待下个刷新周期刷新 UI
        layoutIfNeeded -> 立即刷新, 耗费性能
     */
    [self setNeedsLayout];
 
}

#pragma mark - delegate



@end
