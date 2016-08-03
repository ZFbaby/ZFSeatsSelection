//
//  ZFCenterLineView.m
//  
//
//  Created by qq 316917975  on 16/1/28.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//

#import "ZFCenterLineView.h"
#import "UIView+Extension.h"
@interface ZFCenterLineView ()

@property (weak, nonatomic) UIButton *centerLineBtn;

@end

@implementation ZFCenterLineView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self initCenterLineBtn];
        
    }
    return self;
}
-(void)initCenterLineBtn{
    UIButton * centerLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerLineBtn setTitle:@"银幕中央" forState:UIControlStateNormal];
    centerLineBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    [centerLineBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    centerLineBtn.userInteractionEnabled = NO;
    self.centerLineBtn = centerLineBtn;
    centerLineBtn.layer.masksToBounds = YES;
    centerLineBtn.layer.borderWidth = 0.5;
    centerLineBtn.layer.cornerRadius = 5;
    centerLineBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    centerLineBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self addSubview:centerLineBtn];
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.centerLineBtn.width = 50;
    self.centerLineBtn.height = 15;
    self.centerLineBtn.y = -15;
    self.centerLineBtn.centerX = self.width * 0.5;
}
-(void)setHeight:(CGFloat)height{
    
    [super setHeight:height];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    CGFloat lengths[] = {6,3};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.bounds.size.height);
    CGContextStrokePath(context);
}


@end
