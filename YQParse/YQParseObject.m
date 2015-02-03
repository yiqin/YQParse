//
//  YQObject.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseObject.h"

@interface YQParseObject ()

@end

@implementation YQParseObject

+ (instancetype)objectWithClassName:(NSString *)parseClassName
{
    return [[self alloc] initWithClassName:parseClassName];
}

- (instancetype)initWithClassName:(NSString *)parseClassName
{
    self = [super init];
    if (self) {
        self.parseClassName = parseClassName;
        self.parameters = [[NSMutableDictionary alloc] init];
        self.responseJSON = [[NSDictionary alloc] init];
        self.pointerRelation = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[YQParseObject class]]) {
        YQParseObject *object = (YQParseObject *)value;        
        [self.parameters setValue:object.pointerRelation forKey:key];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        if ([key isEqualToString:@"objectId"] || [key isEqualToString:@"createdAt"] || [key isEqualToString:@"updatedAt"]) {
            return;
        }
        [self.parameters setValue:value forKey:key];
    }
    else {
        [self.parameters setValue:value forKey:key];
    }
}

- (NSString*)objectForKey:(NSString *)key
{
    NSString *string = [[NSString alloc] init];
    
    if (self.responseJSON) {
        string = [self.responseJSON objectForKey:key];
    }
    else {
        return nil;
    }
    
    return string;
}

- (void)saveInBackground
{
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
}

- (void)saveInBackgroundWithBlock:(void(^)(BOOL, NSError *))block
{
    YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
    [manage.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYQBaseURL_classes, self.parseClassName];
    NSDictionary *parameters = self.parameters;
    
    [manage POST:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        [self parsingObjectFromPFObjectJSON:responseObject];
        
        block(YES, nil);
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        block(NO, error);
        
    }];
}

- (void)parsingObjectFromPFObjectJSON:(NSDictionary*)PFObjectJSON
{
    self.objectId = [PFObjectJSON objectForKey:@"objectId"];
    self.createdAt = [PFObjectJSON objectForKey:@"createdAt"];
    self.updatedAt = ([PFObjectJSON objectForKey:@"createdAt"]) ? [PFObjectJSON objectForKey:@"createdAt"] : self.createdAt;
    self.responseJSON = PFObjectJSON;
}

- (void)setObjectId:(NSString *)objectId
{
    _objectId = objectId;
    
    // when ObjectId is changed, update self.pointerRelation
    self.pointerRelation = @{@"__type":@"Pointer",
                             @"className":self.parseClassName,
                             @"objectId":objectId};
}

@end
