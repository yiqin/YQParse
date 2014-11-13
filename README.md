YQParse
=======

Parse iOS SDK based on REST API


---
## What is YQParse
YQParse is another Parse iOS SDK totally based on REST API. YQParse let you interact Parse.com with a HTTP request, including creating [Parse.com](https://parse.com/) is a complete mobile app platform. It focus on creating unique & engaging apps on any platform. It take care of everything else your app needs, from the core of your app to analytics and push notifications. 

> Check out [Parse.com](https://parse.com/).

---
## When and why to YQParse
For the most time, you don't need to use it. You just go to and download the [official Parse iOS SDK](https://parse.com/apps/quickstart#parse_data/mobile/ios/native/existing). You probably need YQParse, only when you need to build your own static SDK which requires a backend.

YQParse was first created at [MHacks IV](http://mhacks-iv.challengepost.com/) to support [Leaftagger](http://www.leaftagger.com/), which was a powerful framework to get feedback from users directly in the native iOS app. It ultimately enables developers to iterate and launch product quicker. Building a backend using Rails and Django on Heroku takes too much effect. So I chosed Parse.com and built YQParse.

---
## Requirements
- Xcode 5+
- iOS 7.0+

---

## Installation
You can simply drag the `YQParse` folser into your Xcode project.

---
## Initializing the SDK
To start to use YQParse, you must fist initizlie it with your API ID and REST API key.You can find them in your APIs settings on the your Parse account.

> Note: Parse provides different api keys. Don't copy the wrong one. We need API ID and REST API key.

Open up your `AppDelegate.m` file and add the following import to the top of the file:
```Objective-C
#import "YQParse.h"
```
Inside the `application:didFinishLaunchingWithOptions:`, we add
```Objective-C
// Set your api key and REST api key here.
[YQParse setApplicationId:@"RQ2gEXLcAxtOe0ZWOB57IaPERHOGfM9GopPH6brQ"
               restApiKey:@"uDcMX5Ce12M4yB2EpRUGeihAsPus7devAj7qskDB"];
```

---
## Objects
#### The YQParseObject
Storing data on Parse is built around the `YQParseObject`. It's quite similar to `PFObject`. YQParseObject also has almost the same method.

> Check out [PFObject Docs](https://parse.com/docs/ios_guide#top/iOS).


#### Saving Objects
The interface is similar to a `NSMutableDictionary`, plus the `saveInBackground` method:
```Objective-C
YQParseObject *gameScore = [YQParseObject objectWithClassName:@"GameScore"];
[gameScore setValue:@1337 forKey:@"score"];
[gameScore setValue:@"Sean Plott" forKey:@"playerName"];
[gameScore setValue:@NO forKey:@"cheatMode"];
[gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
        NSLog(@"succeed");
    }
    
}];
```

#### Retrieving Objects
Retrieve the whole `YQParseObject` using a `YQParseQuery` with the `objectId`. 
```Objective-C
YQParseQuery *query = [YQParseQuery queryWithClassName:@"GameScore"];
[query getObjectInBackgroundWithId:@"M2haZaceBp" block:^(YQParseObject *object, NSError *error) {
    if (!error) {
        NSLog(@"succeed. Return data: %@", [object objectForKey:@"playerName"]);
    }
}];
```

---
## Queries 

#### Basic Queries
`YQParseQuery` let you to retrieve a list of objects rather than just a single object. The general pattern is to create a `YQParseQuery`, put conditions on it, and then retrieve a `NSArray` of matching `YQParseObject` using either `findObjectsInBackgroundWithBlock:`
```Objective-C
YQParseQuery *query = [YQParseQuery queryWithClassName:@"GameScore"];
[query whereKey:@"playerName" equalTo:@"Sean Plott"];
[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
        for (YQParseObject *object in objects) {
            NSLog(@"objectId - %@", object.objectId);
        }
    }
}];
```

---
## Images
Parse.com allow us to easily stroe images by converting them to `NSData` and then using `PFFile`. In Parse.com official SDK, we can use `PFImageView`. We don't use `PFImageView` here. I find that Parse.com would return the url of any file in the response data when it's using REST API. After we get that url, we will load the image with GET HTTP request. 

#### Load Images
This is a quick example about how to load images.
```Objective-C
#import "LeaftaggerObject.h"

@interface LeaftaggerPage : LeaftaggerObject

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImageView *screenshotImageView;

@end

.
.
.

- (void)setImageURL:(NSURL *)imageURL
{
    if (imageURL) {
        _imageURL =imageURL;
        [self updateFirstPageData];
        
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:imageURL];
        
        YQHTTPRequestOperation *requestOperation = [[YQHTTPRequestOperation alloc] initWithRequest:urlRequest];
        requestOperation.responseSerializer = [YQImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(YQHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Load image successfully.");
            self.screenshotImageView = [[UIImageView alloc] initWithImage:responseObject];

        } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);

        }];
        [requestOperation start];
    }
}
```

---
## Analytics


#### App-Open Analytics
YQParseAnaltyics allows you to track your application being launched.

```Objective-C
[YQParseAnalytics trackAppOpened];
```

#### Custom Analytics
YQParseAnalytics also allows you to track free-form events, with a handful of string keys and values.
```Objective-C
NSDictionary *dimensions = @{
                             @"priceRange": @"1000-1500",
                             @"source": @"cragslist",
                             @"dataType": @"weekday"
                             };

[YQParseAnalytics trackEvent:@"search" dimensions:dimensions];
```

---

## Contact & Maintainers

Yi Qin

- http://github.com/yiqin
- http://twitter.com/YiQin1
- http://yiqin.info
