//
//  ZFSeatsView.h
//  ZFSeatSelection
//
//  Created by qq 316917975  on 16/7/9.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import <UIKit/UIKit.h>
#import "ZFSeatButton.h"
@interface ZFSeatsView : UIView

/** 按钮宽度 */
@property (nonatomic,assign) CGFloat seatBtnWidth;

/** 按钮高度 */
@property (nonatomic,assign) CGFloat seatBtnHeight;

/** 座位图宽度 */
@property (nonatomic,assign) CGFloat seatViewWidth;

/** 座位图高度 */
@property (nonatomic,assign) CGFloat seatViewHeight;

/**  seatsArray座位数组 maxW默认最大座位父控件的宽度 actionBlock按钮点击回调－>传回是当前选中的按钮和全部可选的座位*/

-(instancetype)initWithSeatsArray:(NSMutableArray *)seatsArray
                    maxNomarWidth:(CGFloat)maxW
               seatBtnActionBlock:(void(^)(ZFSeatButton *seatBtn,NSMutableDictionary *allAvailableSeats))actionBlock;

@end
