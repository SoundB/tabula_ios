//
//  UIInterface.h
//  Yomu
//
//  Created by JINS-MACBOOK on 2017. 1. 10..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface UIInterface : NSObject

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UILabel *progressLabel;

+ (UIInterface *)instance;

-(void)showLoadingIndicator:(void (^)(BOOL finished))completion;
-(void)showLoadingIndicatorWithBackgroundColor:(UIColor*)backgroundColor completion:(void (^)(BOOL finished))completion;
-(void)hideLoadingIndicator:(void (^)(BOOL finished))completion;
-(void)hideLoadingIndicator:(NSString*)msg completion:(void (^)(BOOL finished))completion;

-(void)startLoadingProgressIndicator:(void (^)(BOOL finished))completion;
-(void)updateLoadingProgressIndicator:(float)current total:(float)total;
-(void)endLoadingProgressIndicator:(void (^)(BOOL finished))completion;
-(void)endLoadingProgressIndicator:(NSString*)msg completion:(void (^)(BOOL finished))completion;

-(void)toast:(NSString*)msg completion:(void (^)(BOOL finished))completion;
-(UIAlertController*)inputUserNameActionSheet:(id)target
                                  title:(NSString*)title
                                message:(NSString*)message
                                confirm:(void (^)(UIAlertAction *action, UITextField *textField))confirm
                             completion:(void (^)(void))completion;
-(UIAlertController*)confirmActionSheet:(id)target
                                  title:(NSString*)title
                                message:(NSString*)message
                                confirm:(void (^)(UIAlertAction *action))confirm
                                 cancel:(void (^)(UIAlertAction *action))cancel
                             completion:(void (^)(void))completion;

@end

@interface UIIF : NSObject

+ (UIIF *)instance;

#pragma mark -
+(float)width;
+(float)width:(UIView*)view;
+(float)height;
+(float)height:(UIView*)view;
+(float)bottom:(float)pos;
+(float)right:(float)pos;
+(float)rightL:(float)pos;
+(float)left:(float)left right:(float)right;
+(float)centerX:(float)width;
+(float)centerXL:(float)width;
+(float)centerY:(float)height;
+(float)scale:(float)pos;
+(float)addX:(float)pos;
+(float)addY:(float)pos;
+(float)endPointX:(UIView*)view;
+(float)endPointY:(UIView*)view;
+(CGRect)scaleRect:(CGRect)frame;
+(BOOL)is35inch;
+(int)f35t40:(int)value;
+(CGRect)screenFrame;
+(int)statusHeight;
+(int)statusExtHeight;
+(int)f35t40withStatusBar:(int)value;
+ (CGRect)screenFramewithStatusBar;
+(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)targetSize;
+(UIImage*)croppedImage:(UIImage *)srcImg  cropRect:(CGRect)cropRect;
+(UIColor *) RGB:(int)red :(int)green :(int)blue :(float)alpha;
+(void)drawTopSeparator:(UIView*)target padding:(UIEdgeInsets)padding color:(UIColor*)color;
+(void)drawBottomSeparator:(UIView*)target padding:(UIEdgeInsets)padding color:(UIColor*)color;

@end
