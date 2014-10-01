//
//  YQUser.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseObject.h"

@interface YQParseUser : YQParseObject

@property(nonatomic, strong) NSString *sessionToken;
@property(nonatomic) BOOL isAuthenticated;

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *email;

+ (instancetype) user;

// No need;
// - (void)signUpInBackgroundWithBlock:(void(^)(BOOL succeeded, NSError *error))block;

- (void)validateWithSessionToken:(NSString*)sessionToken block:(void (^)(YQParseUser *user, NSError *error))block;

@end
