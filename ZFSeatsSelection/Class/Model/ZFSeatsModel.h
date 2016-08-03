//
//  ZFSeatsModel.h
//  ZFSeatSelection
//
//  Created by © 2016年 qq 316917975  on 16/7/12.
//
//

#import <Foundation/Foundation.h>
#import "ZFSeatModel.h"
@interface ZFSeatsModel : NSObject

/**座位数组*/
@property (nonatomic, strong) NSArray *columns;

/**座位真实行*/
@property (nonatomic, copy) NSString *rowId;

/**座位当前行，用于算座位frame*/
@property (nonatomic, copy) NSNumber *rowNum;
@end
