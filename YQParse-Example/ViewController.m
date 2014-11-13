//
//  ViewController.m
//  YQParse-Example
//
//  Created by yiqin on 9/30/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "ViewController.h"
#import "YQParse.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *dimensions = @{
                                 @"priceRange": @"1000-1500",
                                 @"source": @"cragslist",
                                 @"dataType": @"weekday"
                                 };
    
    [YQParseAnalytics trackEvent:@"search" dimensions:dimensions];
    
    
    
    YQParseObject *gameScore = [YQParseObject objectWithClassName:@"GameScore"];
    [gameScore setValue:@1337 forKey:@"score"];
    [gameScore setValue:@"Sean Plott" forKey:@"playerName"];
    [gameScore setValue:@NO forKey:@"cheatMode"];
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"succeed");
        }
    }];
    
    /*
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"M2haZaceBp" block:^(YQParseObject *object, NSError *error) {
        if (!error) {
            NSLog(@"succeed. Return data: %@", [object objectForKey:@"playerName"]);
        }
    }];
    */
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"GameScore"];
    [query whereKey:@"playerName" equalTo:@"Sean Plott"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (YQParseObject *object in objects) {
                NSLog(@"objectId - %@", object.objectId);
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
