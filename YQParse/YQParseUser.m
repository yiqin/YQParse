//
//  YQUser.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseUser.h"

@implementation YQParseUser

+ (instancetype)user
{
    return [[self alloc] initWithClassName:@"User"];
}

- (instancetype)initWithClassName:(NSString *)parseClassName
{
    self = [super initWithClassName:parseClassName];
    if (self) {
        self.isAuthenticated = NO;
    }
    return self;
}

- (void)validateWithSessionToken:(NSString *)sessionToken block:(void (^)(YQParseUser *, NSError *))block
{
    YQParseRequestOperationManager *manager = [YQParseRequestOperationManager manager];
    [manager.requestSerializer setValue:sessionToken forHTTPHeaderField:@"X-Parse-Session-Token"];
    
    [manager GET:kYQBaseURL_SessionToken parameters:nil success:^(YQHTTPRequestOperation *operation, id responseObject) {
        
        self.isAuthenticated =YES;
        self.username = [responseObject objectForKey:@"username"];
        self.email = [responseObject objectForKey:@"email"];
        
        [self parsingObjectFromPFObjectJSON:responseObject];
        
        block(self, nil);
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
    
}


@end
