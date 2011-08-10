//
//  FontysAppAppDelegate.h
//  FontysApp
//
//  Created by Ruud Puts on 8/10/11.
//  Copyright 2011 Fontys Hogeschool ICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontysAppAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
