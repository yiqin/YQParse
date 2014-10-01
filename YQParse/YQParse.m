//
//  YQParse.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParse.h"

@interface YQParse ()

@property(nonatomic, strong) NSString *applicationId;
@property(nonatomic, strong) NSString *restApiKey;

@end

@implementation YQParse

+ (instancetype)sharedManager
{
    static YQParse *sharedYQParse = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedYQParse = [[self alloc] init];
    });
    return sharedYQParse;
}

- (instancetype)init
{
    if (self = [super init]) {
        _applicationId = @"";
        _restApiKey = @"";
    }
    return self;
}

+ (void)setApplicationId:(NSString*)applicationId restApiKey:(NSString*)restApiKey
{
    YQParse *shared = [YQParse sharedManager];
    shared.applicationId = applicationId;
    shared.restApiKey = restApiKey;
}

+ (NSString*)getApplicationId
{
    YQParse *shared = [YQParse sharedManager];
    return shared.applicationId;
}

+ (NSString*)getRestApiKey
{
    YQParse *shared = [YQParse sharedManager];
    return shared.restApiKey;
}

@end
