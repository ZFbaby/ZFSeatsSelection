//
//  ZFSeatsView.h
//  ZFSeatSelection
//
//  Created by qq 316917975  on 16/7/9.
//
//

#import <UIKit/UIKit.h>

@interface ZFSeatsView : UIView

/** 按钮宽度 */
@property (nonatomic,assign) CGFloat seatBtnWidth;

/** 按钮高度 */
@property (nonatomic,assign) CGFloat seatBtnHeight;

/** 座位图宽度 */
@property (nonatomic,assign) CGFloat seatViewWidth;

/** 座位图高度 */
@property (nonatomic,assign) CGFloat seatViewHeight;

/**  seatsArray座位数组 maxW默认最大座位父控件的宽度 actionBlock按钮点击回调－>传回是当前选中的按钮*/

-(instancetype)initWithSeatsArray:(NSMutableArray *)seatsArray maxNomarWidth:(CGFloat)maxW seatBtnActionBlock:(void(^)(id x))actionBlock;

@end
