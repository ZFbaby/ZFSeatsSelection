//
//  ZFIndicatorView.h
//  
//
//  Created by qq 316917975  on 16/1/29.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import <UIKit/UIKit.h>

@interface ZFIndicatorView : UIView

/** 初始化快捷方法 */
-(instancetype)initWithView:(UIView *)mapView withRatio:(CGFloat)ratio withScrollView:(UIScrollView *)myScrollview;

/** 滚动时更新 */
- (void)updateMiniIndicator;

/** 更新座位选中的图片 */
-(void)updateMiniImageView;

/** 隐藏 */
-(void)indicatorHidden;
@end
