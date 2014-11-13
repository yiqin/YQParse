//
//  YQParseAnalytics.h
//  YQParse-Example
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQParseConstants.h"
#import "YQParseRequestOperationManager.h"

/*!
 REST API Analytics
 */
@interface YQParseAnalytics : NSObject

/// App-Oepn Analytics
+(void) trackAppOpened;

/// Custom Analytics
+(void) trackEvent:(NSString *)event dimensions:(NSDictionary *)dimensions;

@end
