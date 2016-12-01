//
//  ZFSeatButton.m
//  
//
//  Created by qq 316917975   on 16/1/27.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import "ZFSeatButton.h"
#import "UIView+Extension.h"
#import "ZFSeatSelectionConfig.h"
@implementation ZFSeatButton
-(void)setHighlighted:(BOOL)highlighted{}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnScale = ZFSeatBtnScale;
    CGFloat btnX = (self.width - self.width * btnScale) * 0.5;
    CGFloat btnY = (self.height - self.height * btnScale) * 0.5;
    CGFloat btnW = self.width * btnScale;
    CGFloat btnH = self.height * btnScale;
    self.imageView.frame = CGRectMake(btnX, btnY, btnW, btnH);
}
-(BOOL)isSeatAvailable{
    return [self.seatmodel.st isEqualToString:@"N"];
}
@end
