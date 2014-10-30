YQParse
=======

Parse iOS SDK based on REST API


---
## What is YQParse
YQParse is another Parse iOS SDK totally based on REST API. YQParse let you interact Parse.com with a HTTP request, including creating [Parse.com](https://parse.com/) is a complete mobile app platform. It focus on creating unique & engaging apps on any platform. It take care of everything else your app needs, from the core of your app to analytics and push notifications. 

> Check out [Parse.com](https://parse.com/).

---
## When and why YQParse is used
For the most time, you don't need to use it. You just go to and download the official Parse iOS SDK. You probably need YQParse, only when you need to build your own static SDK which requires a backend.

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
To start to use YQParse, you must fist initizlie it with your api id and REST api key.You can find them in your APIs settings on the your Parse account.

> Note: Parse provides different api keys. Don't copy the wrong one. We need api id and REST api key.

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
### The YQParseObject


### Saving Objects
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

### Retrieving Objects


---
## Queries 



---
## 


---

## Contact & Maintainers

Yi Qin

- http://github.com/yiqin
- http://twitter.com/YiQin1
- http://yiqin.info