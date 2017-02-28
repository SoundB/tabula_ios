//
//  AppDelegate.h
//  WebSocket
//
//  Created by JINS-MACBOOK on 2017. 2. 21..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)startApplication;

- (void)saveContext;


@end

