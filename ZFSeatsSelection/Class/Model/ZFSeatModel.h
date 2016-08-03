//
//  ZFSeatModel.h
//  ZFSeatSelection
//
//  Created by © 2016年 qq 316917975  on 16/7/12.
//
//

#import <Foundation/Foundation.h>
#import "ZFSeatModel.h"
@interface ZFSeatModel : NSObject

/**座位真实列，用于算座位的frame*/
@property (nonatomic, copy) NSString *columnId;

/**座位号码*/
@property (nonatomic, copy) NSString *seatNo;

/**座位状态 N/表示可以购票 LK／座位已售出 E/表示过道 */
@property (nonatomic, copy) NSString *st;
@end
