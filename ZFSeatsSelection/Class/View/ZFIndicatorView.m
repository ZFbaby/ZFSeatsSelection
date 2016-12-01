//
//  ZFIndicatorView.m
//  
//
//  Created by qq 316917975  on 16/1/29.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import "ZFIndicatorView.h"
#import "UIView+Extension.h"
#import "ZFSeatSelectionConfig.h"
@interface ZFIndicatorView ()

/**viewRatio*/
@property (nonatomic, assign) CGFloat viewRatio;

/**miniMe*/
@property (nonatomic, weak) UIView *miniMe;

/**miniImageView*/
@property (nonatomic, weak) UIImageView *miniImageView;

/**logoImageView*/
@property (nonatomic, weak) UIImageView *logoImageView;

/**miniMe*/
@property (nonatomic, weak) UIView *miniIndicator;

/**mapView*/
@property (nonatomic, weak) UIView *mapView;

/**myScrollview*/
@property (nonatomic, weak) UIScrollView *myScrollview;
@end

@implementation ZFIndicatorView

-(instancetype)initWithView:(UIView *)mapView withRatio:(CGFloat)ratio withScrollView:(UIScrollView *)myScrollview{
    if (self = [super init]) {
        self.viewRatio = ratio;
        self.mapView = mapView;
        self.myScrollview = myScrollview;
        self.userInteractionEnabled = NO;
        [self initUI];
    }
    return self;
}
-(void)initUI{
    UIView *miniMe = [[UIView alloc]init];
    self.miniMe = miniMe;
    [self addSubview:miniMe];
    miniMe.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"screenBg"]];//这里更换你影厅图标
    
    self.logoImageView = logoImageView;
    [miniMe addSubview:logoImageView];
    
    UIImageView *miniImageView = [[UIImageView alloc]initWithImage:[self captureScreen:self.mapView]];
    miniImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:miniImageView];
    self.miniImageView = miniImageView;
    
    UIView *miniIndicator = [[UIView alloc]init];
    miniIndicator.layer.borderWidth = 1;
    miniIndicator.layer.borderColor = [UIColor redColor].CGColor;
    self.miniIndicator = miniIndicator;
    [self addSubview:miniIndicator];
}

- (void)updateMiniIndicator{
    
    [self setNeedsLayout];
    
}
-(void)updateMiniImageView{
    
    self.miniImageView.image = [self captureScreen:_mapView];
}

-(void)indicatorHidden{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
-(UIImage*)captureScreen:(UIView*) viewToCapture{
    
    CGRect rect = [viewToCapture bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0.0f);
    [viewToCapture.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

    self.miniMe.frame = CGRectMake(-3, - 3 * 3, self.width + 2 * 3,self.height + 4 * 3);
    
    self.logoImageView.frame = CGRectMake(2 * 3, 3, self.width - 4 * 3, 3);
    
    self.miniImageView.frame = CGRectMake(0, 0,self.width, self.height );
    //设置线框的高宽
    //下面代码还有很多需要优化的地方,座位少的时候还是有点定位不准，等有时间了再来收拾它😄
    self.miniIndicator.x = (self.myScrollview.contentOffset.x * self.width)  / self.myScrollview.contentSize.width;
    self.miniIndicator.y = (self.myScrollview.contentOffset.y * self.height) / self.myScrollview.contentSize.height;
    
    if (self.miniIndicator.height == self.height && self.miniIndicator.width == self.width) {
        self.miniIndicator.x = 0;
        self.miniIndicator.y = 0;
    }
    if (self.mapView.width < self.myScrollview.width) {
        self.miniIndicator.x = 0;
        self.miniIndicator.width = self.width;
    }else{
        
        self.miniIndicator.width = (self.width * (self.myScrollview.width - self.myScrollview.contentInset.right)/ self.mapView.width);
        if (self.myScrollview.contentOffset.x < 0) {
            self.miniIndicator.width =  self.miniIndicator.width - ABS(self.myScrollview.contentOffset.x * self.width) / self.myScrollview.contentSize.width;
            self.miniIndicator.x = 0;
            
        }
        if (self.myScrollview.contentOffset.x > self.myScrollview.contentSize.width - ZFScreenW + self.myScrollview.contentInset.right) {
            self.miniIndicator.width =  self.miniIndicator.width - (self.myScrollview.contentOffset.x - (self.myScrollview.contentSize.width - ZFScreenW + self.myScrollview.contentInset.right))* self.width / self.myScrollview.contentSize.width;
        }
        
    }
    
    if (self.mapView.height <= self.myScrollview.height - ZFseastsColMargin) {
        self.miniIndicator.y = 0;
        self.miniIndicator.height = self.height;
    }else{
        self.miniIndicator.height = self.height * (self.myScrollview.height - ZFseastsColMargin) / self.mapView.height;
        if (self.myScrollview.contentOffset.y < 0) {
            self.miniIndicator.y = 0;
            self.miniIndicator.height =  self.miniIndicator.height - ABS(self.myScrollview.contentOffset.y * self.height) / self.myScrollview.contentSize.height;
        }
        if (self.myScrollview.contentOffset.y > self.mapView.height - self.myScrollview.height + ZFseastsColMargin) {
            self.miniIndicator.height =  self.miniIndicator.height -(self.myScrollview.contentOffset.y - (self.mapView.height - self.myScrollview.height + ZFseastsColMargin)) * self.height / self.myScrollview.contentSize.height;
        }
    }

}


@end
