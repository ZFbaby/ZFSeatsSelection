//
//  ZFAppLogoView.m
//  
//
//  Created by qq 316917975  on 16/1/30.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//

#import "ZFAppLogoView.h"
#import "UIView+Extension.h"
@implementation ZFAppLogoView


- (void)drawRect:(CGRect)rect {
    
    UIImage *appLogo = [UIImage imageNamed:@"maoyan_logo"];//这里更换你applogo图标
    
    [appLogo drawInRect:rect];
}


@end
