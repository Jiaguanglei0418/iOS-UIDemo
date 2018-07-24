//
//  JDCollectionViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDCollectionViewController.h"
#import "JDCollectionViewCell.h"
#import "JDCollectionHeaderView.h"
#import "UIView+Extension.h"
#import "JDDateModel.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString const *reuseID = @"collectionCellID";
static NSString const *kHeaderID = @"JDCollectionViewHeaderID";
@interface JDCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation JDCollectionViewController {
    NSMutableArray *_dayArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dayArray = [NSMutableArray array];
    
    NSInteger dayCount = [JDDateModel weekDayMonthOfFirstDayForDate:[NSDate date]];
    NSInteger totalDayCount = [[JDDateModel new] totalDaysInMoothForDate:[NSDate date]];
    // 补前
    for (int i=1; i< dayCount; i++) {
        [_dayArray addObject:@""];
    }
    
    for (int i = 0; i<totalDayCount; i++) {
        [_dayArray addObject:@(i+1)];
    }
    
    // 补后面
    int leftDay = 0;
    if (_dayArray.count %7) {
        leftDay = 7 - _dayArray.count %7;
    }
    
    for (int i = 0; i<leftDay; i++) {
        [_dayArray addObject:@""];
    }
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0.f;
    layout.itemSize = CGSizeMake(kScreenWidth/7, kScreenWidth/7);
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 44.f);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:NSClassFromString(@"JDCollectionHeaderView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JDCollectionViewHeaderID"];
    [_collectionView registerClass:NSClassFromString(@"JDCollectionViewCell") forCellWithReuseIdentifier:reuseID];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dayArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _dayArray[indexPath.row]];
    return cell;
}

 

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        JDCollectionHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderID forIndexPath:indexPath];
        headView.frame = CGRectMake(0, 0, kScreenWidth, 44.f);
        
        
        return headView;
    }
    return nil;
}
@end
