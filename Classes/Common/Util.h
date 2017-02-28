//
//  Util.h
//  Yomu
//
//  Created by JINS-MACBOOK on 2017. 1. 13..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject

+ (NSString*)buildVersion;
+ (float)osVer;

+ (NSString*)str:(NSString*)str;
+ (NSString*)deviceDate;
+ (NSString *)deviceDate:(NSString*)format;

+ (NSString*) getUserName;
+ (void) setUserName:(NSString*)userName;
+ (NSString*) getLatestVersion;
+ (void) setLatestVersion:(NSString*)valueString;

@end
