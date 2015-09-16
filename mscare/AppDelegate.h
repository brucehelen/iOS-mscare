//
//  AppDelegate.h
//  mscare
//
//  Created by MissionHealth on 15/8/25.
//  Copyright (c) 2015年 kangmei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKSlideMenu3DController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 *  侧滑
 */
@property (strong, nonatomic)  HKSlideMenu3DController *slideMenuVC;

+ (AppDelegate *)mainDelegate;

@end

