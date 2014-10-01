//
//  YQObject.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQParseConstants.h"
#import "YQParseRequestOperationManager.h"

@interface YQParseObject : NSObject

+ (instancetype)objectWithClassName:(NSString*)parseClassName;
- (instancetype)initWithClassName:(NSString *)parseClassName;

- (void)setValue:(id)value forKey:(NSString *)key;
- (NSString *)objectForKey:(NSString*)key;

// strong-> copy
@property(nonatomic, strong) NSString *parseClassName;
@property(nonatomic, strong) NSMutableDictionary *parameters;

- (void)parsingObjectFromPFObjectJSON:(NSDictionary*)PFObjectJSON;
@property(nonatomic, strong) NSString *objectId;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, strong) NSDate *updatedAt;

@property(nonatomic, strong) NSDictionary *responseJSON;        // save the data here.
@property(nonatomic, strong) NSDictionary *pointerRelation;     //  Not Setup yet.

- (void)saveInBackground;
- (void)saveInBackgroundWithBlock:(void(^)(BOOL succeeded, NSError *error))block;

@end
