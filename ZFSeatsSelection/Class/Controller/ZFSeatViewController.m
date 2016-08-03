//
//  ZFSeatViewController.m
//  
//
//  Created by qq 316917975  on 16/1/27.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//

#import "ZFSeatViewController.h"
#import "MJExtension.h"
#import "ZFSeatsModel.h"
#import "ZFSeatSelectionView.h"
#import "MBProgressHUD.h"

@interface ZFSeatViewController ()

@end

@implementation ZFSeatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *maoyanLabel = [[UILabel alloc]init];
    maoyanLabel.text = @"高仿猫眼选票";
    [maoyanLabel sizeToFit];
    maoyanLabel.font = [UIFont systemFontOfSize:25];
    maoyanLabel.textColor = [UIColor redColor];
    
    self.navigationItem.titleView = maoyanLabel;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    HUD.tintColor = [UIColor blackColor];
    [self.view addSubview:HUD];
    [HUD showAnimated:YES];
    
    //模拟延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"seats %zd.plist",arc4random_uniform(5)] ofType:nil];
        //模拟网络加载数据
        NSDictionary *seatsDic = [NSDictionary dictionaryWithContentsOfFile:path];
        __block  NSMutableArray *  seatsArray = seatsDic[@"seats"];
        
        __block  NSMutableArray *seatsModelArray = [NSMutableArray array];
        
        [seatsArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL *stop) {
            ZFSeatsModel *seatModel = [ZFSeatsModel mj_objectWithKeyValues:obj];
            [seatsModelArray addObject:seatModel];
        }];
        [HUD hideAnimated:YES];


        //数据回来初始化选座模块
        [self initSelectionView:seatsModelArray];
    });
    
}
//创建选座模块
-(void)initSelectionView:(NSMutableArray *)seatsModelArray{
    
    ZFSeatSelectionView *selectionView = [[ZFSeatSelectionView alloc]initWithFrame:CGRectMake(0, 10,375, 300) SeatsArray:seatsModelArray HallName:@"七号杜比全景声4K厅" seatBtnActionBlock:^(NSMutableArray *seatsBtnsArray) {
        NSLog(@"%zd个选中按钮",seatsBtnsArray.count);
        
    }];
    
    [self.view addSubview:selectionView];
    
    ZFSeatSelectionView *selectionView1 = [[ZFSeatSelectionView alloc]initWithFrame:CGRectMake(50, 320,275, 200) SeatsArray:seatsModelArray HallName:@"七号杜比全景声4K厅" seatBtnActionBlock:^(NSMutableArray *seatsBtnsArray) {
        NSLog(@"%zd个选中按钮",seatsBtnsArray.count);
        
    }];
    
    [self.view addSubview:selectionView1];
    
}

@end
