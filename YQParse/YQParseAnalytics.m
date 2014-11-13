//
//  YQParseAnalytics.m
//  YQParse-Example
//
//  Created by yiqin on 11/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseAnalytics.h"

@implementation YQParseAnalytics


/*!
 App-Open
 */
+ (void)trackAppOpened
{
    [YQParseAnalytics trackEvent:@"AppOpened" dimensions:nil];
}

+ (void)trackEvent:(NSString *)event dimensions:(NSDictionary *)dimensions
{
    YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
    [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYQBaseURL_events, event];
    NSDictionary *parameters = [[NSDictionary alloc] init];
    if (dimensions) {
        parameters = @{@"dimensions": dimensions};
    }
    else {
        
    }
    
    [manage POST:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Track successfully.");
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Track fail.");
        
    }];
}

@end
