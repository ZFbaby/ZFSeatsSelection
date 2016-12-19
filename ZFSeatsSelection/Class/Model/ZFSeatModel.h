//
//  ZFSeatModel.h
//  ZFSeatSelection
//
//  Created by © 2016年 qq 316917975  on 16/7/12.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！
#import <Foundation/Foundation.h>
#import "ZFSeatModel.h"
@interface ZFSeatModel : NSObject

/**座位真实列，用于显示当前座位列号*/
@property (nonatomic, copy) NSString *columnId;

/**座位编号*/
@property (nonatomic, copy) NSString *seatNo;

/**座位状态 N/表示可以购票 LK／座位已售出 E/表示过道 */
@property (nonatomic, copy) NSString *st;
@end
