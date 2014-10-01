//
//  YQParseRequestOperationManager.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseRequestOperationManager.h"
#import "YQParse.h"

@implementation YQParseRequestOperationManager

+ (instancetype)manager
{
    return [[self alloc] initWithBaseURL:nil];
}

- (instancetype)init
{
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [YQJSONRequestSerializer serializer];
        self.responseSerializer = [YQJSONResponseSerializer serializer];
        
        [self.requestSerializer setValue:[YQParse getApplicationId] forHTTPHeaderField:@"X-Parse-Application-Id"];
        [self.requestSerializer setValue:[YQParse getRestApiKey] forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    }
    return self;
}

@end
