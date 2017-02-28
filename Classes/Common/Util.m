//
//  Util.m
//  Yomu
//
//  Created by JINS-MACBOOK on 2017. 1. 13..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString*)buildVersion {
    return  [Util str:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
}

+(float)osVer {
    
    static float __fos = 0;
    if (__fos) {
        return __fos;
    }
    
    NSString *osv = [[UIDevice currentDevice] systemVersion];
    __fos = osv.floatValue;
    return __fos;
}

+(NSString*)str:(NSString*)str {
    if (str==nil) {
        return @"";
    }
    if ( ![[str class] isSubclassOfClass:[NSString class]]) {
        if ([[str class] isSubclassOfClass:[NSNumber class]]) {
            return [(NSNumber*)str stringValue];
        }
        return @"";
    }
    return [NSString stringWithString:str];
}

+ (NSString *)deviceDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)deviceDate:(NSString*)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString*) getUserName{
    
    NSString *valueString = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    
    return valueString;
}

+ (void) setUserName:(NSString*)valueString
{
    
    [[NSUserDefaults standardUserDefaults] setObject:valueString forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*) getLatestVersion{
    
    NSString *valueString = [[NSUserDefaults standardUserDefaults] objectForKey:@"LatestVersion"];
    
    return valueString;
}

+ (void) setLatestVersion:(NSString*)valueString
{
    
    [[NSUserDefaults standardUserDefaults] setObject:valueString forKey:@"LatestVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
