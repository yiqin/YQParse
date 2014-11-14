//
//  YQQuery.m
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "YQParseQuery.h"
#import "YQParseConstants.h"

@interface YQParseQuery ()

@property(nonatomic, strong)NSMutableDictionary *where;

@end

@implementation YQParseQuery

+ (instancetype)queryWithClassName:(NSString *)parseClassName
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
        
        self.where = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)getObjectInBackgroundWithId:(NSString *)objectId block:(void(^)(YQParseObject *, NSError *))block
{
    YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@", kYQBaseURL_classes, self.parseClassName, objectId];
    NSDictionary *parameters = @{};
    
    [manage GET:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        self.responseJSON = responseObject;
        YQParseObject *object = [YQParseObject objectWithClassName:self.parseClassName];
        [object parsingObjectFromPFObjectJSON:responseObject];
        
        block(object, nil);
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
        
    }];
}

- (void)findObjectsInBackgroundWithBlock:(void (^)(NSArray *, NSError *))block
{
    YQParseRequestOperationManager *manage = [YQParseRequestOperationManager manager];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", kYQBaseURL_classes, self.parseClassName];
    NSDictionary *parameters = self.parameters;
    
    // Default order 
    [self.parameters setValue:@"-createdAt" forKey:@"order"];
    
    [manage GET:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        self.responseJSON = responseObject;
        NSArray *results = [responseObject objectForKey:@"results"];
        NSMutableArray *responseArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *resultJSON in results) {
            YQParseObject *object = [YQParseObject objectWithClassName:self.parseClassName];
            [object parsingObjectFromPFObjectJSON:resultJSON];
            [responseArray addObject:object];
        }
        
        block(responseArray, nil);
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
        
    }];
}

- (void)whereKey:(NSString *)constraintKey equalTo:(id)constraintValue
{
    if ([constraintValue isKindOfClass:[NSString class]]) {
        [self.where setValue:constraintValue forKey:constraintKey];
    }
    else if ([constraintValue isKindOfClass:[NSDictionary class]]) {
        [self.where setValue:constraintValue forKey:constraintKey];
    }
    else {
        YQParseObject *object = (YQParseObject *)constraintValue;
        [self.where setValue:object.pointerRelation forKey:constraintKey];
    }

    [self.parameters removeObjectForKey:constraintKey];  // Why removeObject???
    [self.parameters setValue:self.where forKey:@"where"];
}

- (void)whereKey:(NSString *)constraintKey containedIn:(NSArray *)constraintValue
{
    NSDictionary *keyContraint = @{@"$in":constraintValue};
    [self.where setValue:keyContraint forKey:constraintKey];
    [self.parameters setValue:self.where forKey:@"where"];
}

@end
