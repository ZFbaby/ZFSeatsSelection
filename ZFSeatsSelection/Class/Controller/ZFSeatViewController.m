//
//  ZFSeatViewController.m
//  
//
//  Created by qq 316917975  on 16/1/27.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！
#import "ZFSeatViewController.h"
#import "MJExtension.h"
#import "ZFSeatsModel.h"
#import "ZFSeatSelectionView.h"
#import "MBProgressHUD.h"
#import "ZFSeatSelectionTool.h"

@interface ZFSeatViewController ()
/**按钮数组*/
@property (nonatomic, strong) NSMutableArray *selecetedSeats;

@property (nonatomic,strong) NSMutableDictionary *allAvailableSeats;//所有可选的座位

@property (nonatomic,strong) NSMutableArray *seatsModelArray;
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
    __weak typeof(self) weakSelf = self;
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
        weakSelf.seatsModelArray = seatsModelArray;

        //数据回来初始化选座模块
        [weakSelf initSelectionView:seatsModelArray];
        
        [weakSelf setupSureBtn];
    });
    
}
//创建选座模块
-(void)initSelectionView:(NSMutableArray *)seatsModelArray{
    __weak typeof(self) weakSelf = self;
    ZFSeatSelectionView *selectionView = [[ZFSeatSelectionView alloc]initWithFrame:CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width, 400)
                                                                        SeatsArray:seatsModelArray
                                                                          HallName:@"七号杜比全景声4K厅"
                                                                seatBtnActionBlock:^(NSMutableArray *selecetedSeats, NSMutableDictionary *allAvailableSeats, NSString *errorStr) {
        NSLog(@"=====%zd个选中按钮===========%zd个可选座位==========errorStr====%@=========",selecetedSeats.count,allAvailableSeats.count,errorStr);
        if (errorStr) {
            //错误信息
            [self showMessage:errorStr];
        }else{
            //储存选好的座位及全部可选座位
            weakSelf.allAvailableSeats = allAvailableSeats;
            weakSelf.selecetedSeats = selecetedSeats;
        }
    }];
    
    [self.view addSubview:selectionView];
}



-(void)setupSureBtn{

    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定选座" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundColor:[UIColor yellowColor]];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.frame = CGRectMake(200, 550, 100, 50);
    [self.view addSubview:sureBtn];
}

-(void)sureBtnAction{
    if (!self.selecetedSeats.count) {
         [self showMessage:@"您还为选座"];
        return;
    }
    //验证是否落单
    if (![ZFSeatSelectionTool verifySelectedSeatsWithSeatsDic:self.allAvailableSeats seatsArray:self.seatsModelArray]) {
        [self showMessage:@"落单"];
    }else{
        [self showMessage:@"选座成功"];
    }
}
-(void)showMessage:(NSString *)message{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}


@end
