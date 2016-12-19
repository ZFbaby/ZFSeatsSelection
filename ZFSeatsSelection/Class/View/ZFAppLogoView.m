//
//  ZFAppLogoView.m
//  
//
//  Created by qq 316917975  on 16/1/30.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import "ZFAppLogoView.h"
#import "UIView+Extension.h"
@implementation ZFAppLogoView


- (void)drawRect:(CGRect)rect {
    
    UIImage *appLogo = [UIImage imageNamed:@"maoyan_logo"];//这里更换你applogo图标
    
    [appLogo drawInRect:rect];
}


@end
