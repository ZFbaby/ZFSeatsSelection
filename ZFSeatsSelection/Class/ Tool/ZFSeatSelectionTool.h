//
//  ZFSeatSelectionTool.h
//  ZFSeatsSelection
//
//  Created by ZFBaby on 16/11/28.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import <Foundation/Foundation.h>
#import "ZFSeatButton.h"
#import "ZFSeatsModel.h"
#import "ZFSeatModel.h"
@interface ZFSeatSelectionTool : NSObject

/**验证座位是否落单*/
+(BOOL)verifySelectedSeatsWithSeatsDic:(NSMutableDictionary *)allAvailableSeats seatsArray:(NSArray *)seatsArray;
+(NSArray *)getNearBySeatsInSameRowForSeat:(ZFSeatButton *)seat withAllAvailableSeats:(NSMutableDictionary *)allAvailableSeats;
+(BOOL)isSeat:(ZFSeatButton *)s1 nearBySeatWithoutRoad:(ZFSeatButton *)s2;
@end
