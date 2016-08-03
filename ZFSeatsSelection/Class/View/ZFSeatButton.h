//
//  ZFSeatButton.h
//  
//
//  Created by qq 316917975   on 16/1/27.
//  Copyright © 2016年 qq 316917975 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFSeatsModel.h"

@interface ZFSeatButton : UIButton

/**座位模型*/
@property (nonatomic, strong) ZFSeatModel *seatmodel;

/**座位模型组*/
@property (nonatomic, strong) ZFSeatsModel *seatsmodel;

@end
