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
    
    YQParseObject *gameScore = [YQParseObject objectWithClassName:@"GameScore"];
    [gameScore setValue:@1337 forKey:@"score"];
    [gameScore setValue:@"Sean Plott" forKey:@"playerName"];
    [gameScore setValue:@NO forKey:@"cheatMode"];
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"succeed");
        }
    }];
    
    YQParseQuery *query = [YQParseQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"M2haZaceBp" block:^(YQParseObject *object, NSError *error) {
        if (!error) {
            NSLog(@"succeed. Return data: %@", [object objectForKey:@"playerName"]);
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
