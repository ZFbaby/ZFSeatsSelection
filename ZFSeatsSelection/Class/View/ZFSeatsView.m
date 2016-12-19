//
//  ZFSeatsView.m
//  ZFSeatSelection
//
//  Created by qq 316917975  on 16/7/9.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import "ZFSeatsView.h"

#import "ZFSeatSelectionConfig.h"

@interface ZFSeatsView ()

@property (nonatomic,copy) void (^actionBlock)(ZFSeatButton *seatBtn,NSMutableDictionary *allAvailableSeats);

@property (nonatomic,strong) NSMutableDictionary *allAvailableSeats;//所有可选的座位

@end

@implementation ZFSeatsView

-(NSMutableDictionary *)allAvailableSeats{
    if (!_allAvailableSeats) {
        _allAvailableSeats = [NSMutableDictionary dictionary];
    }
    return _allAvailableSeats;
}

-(instancetype)initWithSeatsArray:(NSMutableArray *)seatsArray
                    maxNomarWidth:(CGFloat)maxW
               seatBtnActionBlock:(void (^)(ZFSeatButton *, NSMutableDictionary *))actionBlock{
    
    if (self = [super init]) {
        
        self.actionBlock = actionBlock;
        
        ZFSeatsModel *seatsModel = seatsArray.firstObject;
        
        NSUInteger cloCount = [seatsModel.columns count];
        
        if (cloCount % 2) cloCount += 1;//偶数列数加1 防止中线压住座位
        
        CGFloat seatViewW = maxW - 2 * ZFseastsRowMargin;
        
        CGFloat seatBtnW = seatViewW / cloCount;
        
        if (seatBtnW > ZFseastMinW_H) {
            seatBtnW = ZFseastMinW_H;
            seatViewW = cloCount * ZFseastMinW_H;
        }
        //初始化就回调算出按钮和自身的宽高
        CGFloat seatBtnH = seatBtnW;
        self.seatBtnWidth = seatBtnW;
        self.seatBtnHeight = seatBtnH;
        self.seatViewWidth = seatViewW;
        self.seatViewHeight = [seatsArray count] * seatBtnH;
        //初始化座位
        [self initSeatBtns:seatsArray];
    }
    return self;
}

-(void)initSeatBtns:(NSMutableArray *)seatsArray{
    //给可以用的座位绑定索引用来判断是否座位落单
     static NSInteger seatIndex = 0;
    [seatsArray enumerateObjectsUsingBlock:^(ZFSeatsModel *seatsModel, NSUInteger idx, BOOL *stop) {
        
        for (int i = 0; i < seatsModel.columns.count; i++) {
            seatIndex++;
            ZFSeatModel *seatModel = seatsModel.columns[i];
            ZFSeatButton *seatBtn = [ZFSeatButton buttonWithType:UIButtonTypeCustom];
            seatBtn.seatmodel = seatModel;
            seatBtn.seatsmodel = seatsModel;
            if ([seatModel.st isEqualToString:@"N"]) {
                [seatBtn setImage:[UIImage imageNamed:@"kexuan"] forState:UIControlStateNormal];//这里更改座位图标
                [seatBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
                seatBtn.seatIndex = seatIndex;
                [self.allAvailableSeats setObject:seatBtn forKey:[@(seatIndex) stringValue]];
            }else if ([seatModel.st isEqualToString:@"E"]){
                continue;
            }else{
                [seatBtn setImage:[UIImage imageNamed:@"yishou"] forState:UIControlStateNormal];
                seatBtn.userInteractionEnabled = NO;
            }
            [seatBtn addTarget:self action:@selector(seatBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:seatBtn];
            
        }
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[ZFSeatButton class]]) {
            ZFSeatButton *seatBtn = (ZFSeatButton *)view;
            NSInteger Col = [seatBtn.seatsmodel.columns indexOfObject:seatBtn.seatmodel];//座位列
            NSInteger Row = [seatBtn.seatsmodel.rowNum integerValue] - 1;//座位行
            seatBtn.frame = CGRectMake(Col * self.seatBtnHeight,Row * self.seatBtnHeight, self.seatBtnWidth, self.seatBtnHeight);
        }
    }

}
-(void)seatBtnAction:(ZFSeatButton *)seatbtn{
    seatbtn.selected = !seatbtn.selected;
    if (seatbtn.selected) {
        seatbtn.seatmodel.st = @"LK";//设置为选中
    }else{
        seatbtn.seatmodel.st = @"N";//设置为可选
    }
   if (self.actionBlock) self.actionBlock(seatbtn,self.allAvailableSeats);
}


@end
