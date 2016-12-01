//
//  ZFSeatSelectionTool.m
//  ZFSeatsSelection
//
//  Created by ZFBaby on 16/11/28.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import "ZFSeatSelectionTool.h"

@implementation ZFSeatSelectionTool
#pragma mark - 判断座位旁边是否留下单个位置

//=======================================
+(BOOL)verifySelectedSeatsWithSeatsDic:(NSMutableDictionary *)allAvailableSeats seatsArray:(NSArray *)seatsArray{
    NSArray *seatBtnsArr = [allAvailableSeats allValues];
    if ([seatBtnsArr count] > 0) {
        for (ZFSeatButton *currentBtn in seatBtnsArr) {
            
            if([currentBtn isSeatAvailable]){
                NSInteger idx = currentBtn.seatIndex;
                
                ZFSeatButton *preBtn =  [allAvailableSeats objectForKey:[NSString stringWithFormat:@"%zd", idx - 1]];
                ZFSeatButton *nextBtn = [allAvailableSeats objectForKey:[NSString stringWithFormat:@"%zd", idx + 1]];


                BOOL isPreOK = preBtn != nil &&
                [preBtn.seatsmodel.rowId isEqualToString:currentBtn.seatsmodel.rowId] &&
                [preBtn isSeatAvailable];//判断是否在同一列，且状态为可选
                
                BOOL isNextOK = nextBtn != nil &&
                [nextBtn.seatsmodel.rowId isEqualToString:currentBtn.seatsmodel.rowId]&&
                [nextBtn isSeatAvailable];
                
                
                NSInteger preBtnCol = [preBtn.seatsmodel.columns indexOfObject:preBtn.seatmodel];//上一个座位屏幕列
                NSInteger currentBtnCol = [currentBtn.seatsmodel.columns indexOfObject:currentBtn.seatmodel];//当前座位屏幕列
                NSInteger nextBtnCol = [nextBtn.seatsmodel.columns indexOfObject:nextBtn.seatmodel];//下一个座位屏幕列
                
                if (isPreOK) {
                    isPreOK =  ABS(currentBtnCol - preBtnCol) == 1;
                    
                }
                if (isNextOK) {
                    isNextOK = ABS(currentBtnCol - nextBtnCol) == 1;
                    
                }
                
                if (!isPreOK && !isNextOK) {
                    NSArray *nearBySeats = [self getNearBySeatsInSameRowForSeat:currentBtn withAllAvailableSeats:allAvailableSeats];
                    
                    
                    if ([nearBySeats count] == 2 ||[nearBySeats count] == 1) {
                        continue;
                    }
                    
                    if ([nearBySeats count] == 3) {
                        NSInteger idx = [nearBySeats indexOfObject:currentBtn];
                        
                        if (idx == 0 && ![nearBySeats[2] isSeatAvailable]) {
                            continue;
                        }else if(idx == 2 && ![nearBySeats[0] isSeatAvailable]) {
                            continue;
                        }
                    }
                    
                    if ([nearBySeats count] == 4) {
                        NSInteger idx = [nearBySeats indexOfObject:currentBtn];
                        
                        if (idx == 0 && ![nearBySeats[3] isSeatAvailable]) {
                            continue;
                        }else if(idx == 3 && ![nearBySeats[0] isSeatAvailable]) {
                            continue;
                        }
                    }
                    
                    if ([nearBySeats count] == 5) {
                        NSInteger idx = [nearBySeats indexOfObject:currentBtn];
                        
                        if (idx == 0 && ![nearBySeats[4] isSeatAvailable]) {
                            continue;
                        }else if(idx == 4 && ![nearBySeats[0] isSeatAvailable]) {
                            continue;
                        }
                    }
                    
                    for (int i = 0; i < seatsArray.count; i++) {
                        ZFSeatsModel *seatsModel = seatsArray[i];
                        for (ZFSeatModel *s in seatsModel.columns) {
                            if((preBtn && [preBtn.seatmodel.seatNo isEqualToString:s.seatNo]) ||
                               (nextBtn && [nextBtn.seatmodel.seatNo isEqualToString:s.seatNo])    ) {
                                return NO;
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    return YES;
}

+(NSArray *)getNearBySeatsInSameRowForSeat:(ZFSeatButton *)seat withAllAvailableSeats:(NSMutableDictionary *)allAvailableSeats{
    NSMutableArray *result = [NSMutableArray array];
    [result addObject:seat];
    
    NSInteger idx = seat.seatIndex - 1;
    
    //左边
    ZFSeatButton *tmp= [allAvailableSeats objectForKey:[NSString stringWithFormat:@"%zd", idx]];
    while([self isSeat:tmp nearBySeatWithoutRoad:seat]){
        [result insertObject:tmp atIndex:0];
        idx--;
        tmp = [allAvailableSeats objectForKey:[NSString stringWithFormat:@"%zd", idx]];
    }
    
    idx = seat.seatIndex + 1;
    //右边
    tmp= [allAvailableSeats objectForKey:[NSString stringWithFormat:@"%zd", idx]];
    while([self isSeat:tmp nearBySeatWithoutRoad:seat]){
        [result addObject:tmp];
        idx++;
        tmp = [allAvailableSeats objectForKey:[NSString stringWithFormat:@"%zd", idx]];
    }
    
    
    return result;
}

+(BOOL)isSeat:(ZFSeatButton *)s1 nearBySeatWithoutRoad:(ZFSeatButton *)s2{
    NSInteger s1Col = [s1.seatsmodel.columns indexOfObject:s1.seatmodel];//当前座位列
    NSInteger s2Col = [s2.seatsmodel.columns indexOfObject:s2.seatmodel];//下一个座位列
    return     s1 != nil &&
    [s1.seatsmodel.rowId isEqualToString:s2.seatsmodel.rowId] &&
    ABS(s1Col - s2Col) == ABS([s1.seatmodel.columnId intValue] - [s2.seatmodel.columnId intValue]) ;
}

@end
