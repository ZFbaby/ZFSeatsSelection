//
//  ZFIndicatorView.h
//  
//
//  Created by qq 316917975  on 16/1/29.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//

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
