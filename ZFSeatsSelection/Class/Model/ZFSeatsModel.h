//
//  ZFSeatsModel.h
//  ZFSeatSelection
//
//  Created by © 2016年 qq 316917975  on 16/7/12.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import <Foundation/Foundation.h>
#import "ZFSeatModel.h"
@interface ZFSeatsModel : NSObject

/**座位数组*/
@property (nonatomic, strong) NSArray *columns;

/**座位真实行，用于显示座位行号*/
@property (nonatomic, copy) NSString *rowId;

/**座位屏幕行，用于算座位frame*/
@property (nonatomic, copy) NSNumber *rowNum;
@end
