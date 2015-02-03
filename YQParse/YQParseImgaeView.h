//
//  YQParseImgaeView.h
//  Leaftagger-Demo
//
//  Created by yiqin on 9/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQParseConstants.h"
#import "YQParseRequestOperationManager.h"

/*!
 Nothing happens here. No need to use this method now.
 */
@interface YQParseImgaeView : UIImageView

@property(nonatomic, strong) NSString *objectId;
@property(nonatomic, strong) NSString *parseClassName;

- (void)loadImageInBackground;

@end
