//
//  YQParse.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YQParseObject.h"
#import "YQParseQuery.h"
#import "YQParseUser.h"
#import "YQParseImgaeView.h"
#import "YQParseRequestOperationManager.h"

@interface YQParse : NSObject

+ (void)setApplicationId:(NSString*)applicationId restApiKey:(NSString*)restApiKey;
+ (NSString*)getApplicationId;
+ (NSString*)getRestApiKey;

@end
