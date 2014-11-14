//
//  YQQuery.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YQParseObject.h"

@interface YQParseQuery : NSObject

+ (instancetype)queryWithClassName:(NSString*)parseClassName;

@property(nonatomic, strong) NSString *parseClassName;
@property(nonatomic, strong) NSMutableDictionary *parameters;

@property(nonatomic, strong) NSDictionary *responseJSON;        // save the data here.

- (void)getObjectInBackgroundWithId:(NSString*)objectId block:(void (^)(YQParseObject *object, NSError *error))block;

- (void)findObjectsInBackgroundWithBlock:(void(^)(NSArray *objects, NSError *error))block;

- (void)whereKey:(NSString*)constraintKey equalTo:(id)constraintValue;
- (void)whereKey:(NSString *)constraintKey containedIn:(NSArray *)constraintValue;



@end
