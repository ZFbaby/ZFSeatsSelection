//
//  ZFSeatSelectionView.m
//  ZFSeatSelection
//
//  Created by qq 316917975  on 16/7/9.
//  gitHub地址：https://github.com/ZFbaby
//  后面还会增加多种样式（格瓦拉，淘票票，微票儿）实现UI可定制效果及开场动画样式，请关注更新！记得点星哦！！！

#import "ZFSeatSelectionView.h"
#import "ZFSeatsModel.h"
#import "ZFSeatButton.h"
#import "ZFHallLogoView.h"
#import "ZFCenterLineView.h"
#import "ZFRowIndexView.h"
#import "ZFIndicatorView.h"
#import "ZFAppLogoView.h"
#import "UIView+Extension.h"
#import "ZFSeatsView.h"
#import "ZFSeatSelectionConfig.h"

@interface ZFSeatSelectionView ()<UIScrollViewDelegate>
/**seatScrollView*/
@property (nonatomic, weak) UIScrollView *seatScrollView;
/**已经选择的按钮数组*/
@property (nonatomic, strong) NSMutableArray *selecetedSeats;
/**按钮父控件*/
@property (nonatomic, weak) ZFSeatsView *seatView;
/**影院logo*/
@property (nonatomic, weak) UIView *hallLogo;
/**中线*/
@property (nonatomic, weak) UIView *centerLine;
/**索引条*/
@property (nonatomic, weak) UIView *rowindexView;
/**maoyanLogo*/
@property (nonatomic, weak) ZFAppLogoView *maoyanLogo;
/**指示框*/
@property (nonatomic, weak) ZFIndicatorView *indicator;

@property (nonatomic,copy) void (^actionBlock)(NSMutableArray *, NSMutableDictionary *, NSString *);

@end


@implementation ZFSeatSelectionView

-(instancetype)initWithFrame:(CGRect)frame
                  SeatsArray:(NSMutableArray *)seatsArray
                    HallName:(NSString *)hallName
          seatBtnActionBlock:(void (^)(NSMutableArray *, NSMutableDictionary *, NSString *))actionBlock{
    
    if (self = [super initWithFrame:frame]) {//初始化操作
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                               green:245.0/255.0
                                                blue:245.0/255.0 alpha:1];
        self.actionBlock = actionBlock;
        [self initScrollView];
        [self initappLogo];
        [self initSeatsView:seatsArray];
        [self initindicator:seatsArray];
        [self initRowIndexView:seatsArray];
        [self initcenterLine:seatsArray];
        [self inithallLogo:hallName];
        [self  startAnimation];//开场动画
    }
    return self;
}

-(NSMutableArray *)selecetedSeats{
    if (!_selecetedSeats) {

        _selecetedSeats = [NSMutableArray array];
    }
    return _selecetedSeats;
}
-(void)startAnimation{
    
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
      
                         CGRect zoomRect = [self _zoomRectInView:self.seatScrollView
                                       forScale:ZFseastNomarW_H / self.seatView.seatBtnHeight
                                     withCenter:CGPointMake(self.seatView.seatViewWidth / 2, 0)];
       
                         [self.seatScrollView zoomToRect:zoomRect
                               animated:NO];
    } completion:nil];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.seatView;
}
-(void)initScrollView{
    UIScrollView *seatScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.seatScrollView = seatScrollView;
    self.seatScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.seatScrollView.delegate = self;
    self.seatScrollView.showsHorizontalScrollIndicator = NO;
    self.seatScrollView.showsVerticalScrollIndicator = NO;
    self.seatScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.seatScrollView];
}
-(void)initappLogo{
    ZFAppLogoView *maoyanLogo = [[ZFAppLogoView alloc]init];
    maoyanLogo.backgroundColor = [UIColor groupTableViewBackgroundColor];
    maoyanLogo.y = self.height - ZFseastsRowMargin;
    maoyanLogo.width = ZFAppLogoW;
    maoyanLogo.height = ZFseastsRowMargin;
    maoyanLogo.centerX = self.width * 0.5;
    self.maoyanLogo = maoyanLogo;
    [self.seatScrollView insertSubview:maoyanLogo atIndex:0];
}
-(void)initRowIndexView:(NSMutableArray *)seatsArray{
    ZFRowIndexView *rowindexView = [[ZFRowIndexView alloc]init];
    rowindexView.indexsArray = seatsArray;
    rowindexView.width = 13;
    rowindexView.height = self.seatView.height + 2 * ZFseastMinW_H;
    rowindexView.y =  - ZFSmallMargin;
    rowindexView.x = self.seatScrollView.contentOffset.x + ZFseastMinW_H;
    self.rowindexView = rowindexView;
    [self.seatScrollView addSubview:rowindexView];
}
-(void)initcenterLine:(NSMutableArray *)seatsArray{
    ZFCenterLineView *centerLine = [[ZFCenterLineView alloc]init];
    centerLine.backgroundColor = [UIColor clearColor];
    centerLine.width = 1;
    centerLine.height = seatsArray.count * ZFseastNomarW_H + 2 * ZFSmallMargin ;
    self.centerLine = centerLine;
    self.centerLine.centerX = self.seatView.centerX;
    self.centerLine.y = self.seatScrollView.contentOffset.y + ZFCenterLineY;
    [self.seatScrollView addSubview:self.centerLine];
}
-(void)inithallLogo:(NSString *)HallName{
    ZFHallLogoView *logoView = [[ZFHallLogoView alloc]init];
    self.hallLogo = logoView;
    logoView.hallName = HallName;
    logoView.width = ZFHallLogoW;
    logoView.height = 20;
    self.hallLogo.centerX = self.seatView.centerX;
    self.hallLogo.y = self.seatScrollView.contentOffset.y;
    [self.seatScrollView addSubview:self.hallLogo];
}

-(void)initSeatsView:(NSMutableArray *)seatsArray{
   __weak typeof(self) weakSelf = self;
    ZFSeatsView *seatView = [[ZFSeatsView alloc]initWithSeatsArray:seatsArray
                                                     maxNomarWidth:self.width
                                                seatBtnActionBlock:^(ZFSeatButton *seatBtn, NSMutableDictionary *allAvailableSeats) {
        [weakSelf.indicator updateMiniImageView];
        NSString *errorStr = nil;
        if (seatBtn.selected) {
            [weakSelf.selecetedSeats addObject:seatBtn];
            if (weakSelf.selecetedSeats.count > ZFMaxSelectedSeatsCount) {
                seatBtn.selected = !seatBtn.selected;
                [weakSelf.selecetedSeats removeObject:seatBtn];
                errorStr = ZFExceededMaximumError;
            }
        }else{
            if ([weakSelf.selecetedSeats containsObject:seatBtn]) {
                [weakSelf.selecetedSeats removeObject:seatBtn];
                if (weakSelf.actionBlock) weakSelf.actionBlock(weakSelf.selecetedSeats,allAvailableSeats,errorStr);
                return ;
            }
        }
        if (weakSelf.actionBlock) weakSelf.actionBlock(weakSelf.selecetedSeats,allAvailableSeats,errorStr);
        if (weakSelf.seatScrollView.maximumZoomScale - weakSelf.seatScrollView.zoomScale < 0.1) return;//设置座位放大
        CGFloat maximumZoomScale = weakSelf.seatScrollView.maximumZoomScale;
        CGRect zoomRect = [weakSelf _zoomRectInView:weakSelf.seatScrollView forScale:maximumZoomScale withCenter:CGPointMake(seatBtn.centerX, seatBtn.centerY)];
        [weakSelf.seatScrollView zoomToRect:zoomRect animated:YES];
    }];
    self.seatView = seatView;
    seatView.frame = CGRectMake(0, 0,seatView.seatViewWidth, seatView.seatViewHeight);
    [self.seatScrollView insertSubview:seatView atIndex:0];
    self.seatScrollView.maximumZoomScale = ZFseastMaxW_H / seatView.seatBtnWidth;
    self.seatScrollView.contentInset = UIEdgeInsetsMake(ZFseastsColMargin,
                                                        (self.width - seatView.seatViewWidth)/2,
                                                        ZFseastsColMargin,
                                                        (self.width - seatView.seatViewWidth)/2);
}
-(void)initindicator:(NSMutableArray *)seatsArray{
    
    CGFloat Ratio = 2;
    ZFSeatsModel *seatsModel = seatsArray.firstObject;
    NSUInteger cloCount = [seatsModel.columns count];
    if (cloCount % 2) cloCount += 1;
    CGFloat ZFMiniMeIndicatorMaxHeight = self.height / 6;//设置最大高度
    CGFloat MaxWidth = (self.width - 2 * ZFseastsRowMargin) * 0.5;
    CGFloat currentMiniBtnW_H = MaxWidth / cloCount;
    CGFloat MaxHeight = currentMiniBtnW_H * seatsArray.count;
    
    if (MaxHeight >= ZFMiniMeIndicatorMaxHeight ) {
        currentMiniBtnW_H = ZFMiniMeIndicatorMaxHeight / seatsArray.count;
        MaxWidth = currentMiniBtnW_H * cloCount;
        MaxHeight = ZFMiniMeIndicatorMaxHeight;
        Ratio = (self.width - 2 * ZFseastsRowMargin) / MaxWidth;
    }
    
    ZFIndicatorView *indicator = [[ZFIndicatorView alloc]initWithView:self.seatView
                                                            withRatio:Ratio
                                                       withScrollView:self.seatScrollView];
    indicator.x = 3;
    indicator.y = 3 * 3;
    indicator.width = MaxWidth;
    indicator.height = MaxHeight;
    self.indicator = indicator;
    [self addSubview:indicator];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 更新applogo
    if (scrollView.contentOffset.y <= scrollView.contentSize.height - self.height +ZFseastsColMargin + 15) {
        self.maoyanLogo.y = CGRectGetMaxY(self.seatView.frame) + 35;
        self.maoyanLogo.centerX = self.seatView.centerX;
    }else{
        self.maoyanLogo.centerX = self.seatView.centerX;
        self.maoyanLogo.y = scrollView.contentOffset.y + self.height - self.maoyanLogo.height;
    }
    //更新hallLogo
    self.hallLogo.y = scrollView.contentOffset.y;
    
    //更新中线
    self.centerLine.height = CGRectGetMaxY(self.seatView.frame) + 2 * ZFSmallMargin;
    
    if (scrollView.contentOffset.y < - ZFseastsColMargin ) {
        self.centerLine.y = self.seatView.y - ZFseastsColMargin + ZFCenterLineY;
    }else{
        self.centerLine.y = scrollView.contentOffset.y + ZFCenterLineY;
        self.centerLine.height = CGRectGetMaxY(self.seatView.frame) - scrollView.contentOffset.y - 2 * ZFCenterLineY + ZFseastsColMargin;
    }
    // 更新索引条
    self.rowindexView.x = scrollView.contentOffset.x + ZFseastMinW_H;
    
    
    //更新indicator大小位置
    [self.indicator updateMiniIndicator];
    if (!self.indicator.hidden || self.seatScrollView.isZoomBouncing)return;
    self.indicator.alpha = 1;
    self.indicator.hidden = NO;
    
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self.indicator selector:@selector(indicatorHidden) object:nil];
    self.centerLine.centerX = self.seatView.centerX;
    self.rowindexView.height = self.seatView.height + 2 * ZFSmallMargin;
    self.hallLogo.centerX = self.seatView.centerX;
    self.maoyanLogo.centerX = self.seatView.centerX;
    [self.indicator updateMiniIndicator];
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
     
    self.hallLogo.centerX = self.seatView.centerX;
    self.hallLogo.y = scrollView.contentOffset.y;
    self.centerLine.centerX = self.seatView.centerX;
    self.centerLine.y = scrollView.contentOffset.y + ZFCenterLineY;
    self.maoyanLogo.centerX = self.seatView.centerX;
    [self.indicator updateMiniIndicator];
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self.indicator selector:@selector(indicatorHidden) object:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.indicator performSelector:@selector(indicatorHidden) withObject:nil afterDelay:2];
    
}

- (CGRect)_zoomRectInView:(UIView *)view forScale:(CGFloat)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = view.bounds.size.height / scale;
    zoomRect.size.width = view.bounds.size.width / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

@end
