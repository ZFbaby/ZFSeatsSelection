//
//  ZFSeatButton.h
//  
//
//  Created by qq 316917975   on 16/1/27.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import <UIKit/UIKit.h>
#import "ZFSeatsModel.h"

@interface ZFSeatButton : UIButton

/**座位模型*/
@property (nonatomic, strong) ZFSeatModel *seatmodel;

/**座位模型组*/
@property (nonatomic, strong) ZFSeatsModel *seatsmodel;

/**座位绑定索引，用于判断独坐*/
@property (nonatomic,assign) NSInteger seatIndex;

/**验证座位是否可选*/
-(BOOL)isSeatAvailable;
@end
