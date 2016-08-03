//
//  ZFSeatSelectionView.h
//  ZFSeatSelection
//
//  Created by qq 316917975  on 16/7/9.
//
//

#import <UIKit/UIKit.h>

@interface ZFSeatSelectionView : UIView

/**frame 初始化必需设置你的frame  seatsArray座位数组    hallName影厅名称   actionBlock按钮点击回调－>传回就是选中的按钮数组*/

-(instancetype)initWithFrame:(CGRect)frame SeatsArray:(NSMutableArray *)seatsArray HallName:(NSString *)hallName seatBtnActionBlock:(void(^)(id x))actionBlock;

@end
