//
//  UIInterface.m
//  Yomu
//
//  Created by JINS-MACBOOK on 2017. 1. 10..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import "UIInterface.h"
#import "AppDelegate.h"
#import "Util.h"

@interface UIInterface ()

@end

@implementation UIInterface

+ (UIInterface *)instance  {
    static UIInterface *instance = nil;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[UIInterface alloc] init];
        }
    }
    return instance;
}

-(UIInterface *)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(void)memoryDealloc{
    
    [self.activityIndicatorView stopAnimating];
    
    [self.progressLabel removeFromSuperview];
    [self.activityIndicatorView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    
    self.progressLabel = nil;
    self.activityIndicatorView = nil;
    self.loadingView = nil;
    
}

-(void)shortTapAction:(UITapGestureRecognizer*)sender{
    
    [self memoryDealloc];
    
}

-(void)showLoadingIndicator:(void (^)(BOOL finished))completion{
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.loadingView = [[UIView alloc] initWithFrame:appDelegate.window.frame];
    self.loadingView.backgroundColor = [UIIF RGB:0 :0 :0 :0.4];
    
    UITapGestureRecognizer *shortTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shortTapAction:)];
    shortTap.numberOfTapsRequired       = 1;
    shortTap.numberOfTouchesRequired    = 1;
    [self.loadingView addGestureRecognizer:shortTap];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView.center = self.loadingView.center;
    self.activityIndicatorView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.activityIndicatorView.layer.shadowOffset = CGSizeMake(0, 0);
    self.activityIndicatorView.layer.shadowOpacity = 1;
    self.activityIndicatorView.layer.shadowRadius = 6;
    
    [self.loadingView addSubview:self.activityIndicatorView];
    [appDelegate.window addSubview:self.loadingView];
    
    [appDelegate.window bringSubviewToFront:self.loadingView];
    [appDelegate.window bringSubviewToFront:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    [NSThread sleepForTimeInterval:0.1f];
    completion(YES);
    
}

-(void)showLoadingIndicatorWithBackgroundColor:(UIColor*)backgroundColor completion:(void (^)(BOOL finished))completion{
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.loadingView = [[UIView alloc] initWithFrame:appDelegate.window.frame];
    self.loadingView.backgroundColor = backgroundColor;
    
    UITapGestureRecognizer *shortTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shortTapAction:)];
    shortTap.numberOfTapsRequired       = 1;
    shortTap.numberOfTouchesRequired    = 1;
    [self.loadingView addGestureRecognizer:shortTap];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView.center = self.loadingView.center;
    self.activityIndicatorView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.activityIndicatorView.layer.shadowOffset = CGSizeMake(0, 0);
    self.activityIndicatorView.layer.shadowOpacity = 1;
    self.activityIndicatorView.layer.shadowRadius = 3;
    
    [self.loadingView addSubview:self.activityIndicatorView];
    [appDelegate.window addSubview:self.loadingView];
    
    [appDelegate.window bringSubviewToFront:self.loadingView];
    [appDelegate.window bringSubviewToFront:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    [NSThread sleepForTimeInterval:0.1f];
    completion(YES);
    
}

-(void)hideLoadingIndicator:(void (^)(BOOL finished))completion{
    
    [self hideLoadingIndicator:nil completion:completion];
}

-(void)hideLoadingIndicator:(NSString*)msg completion:(void (^)(BOOL finished))completion{
    
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    [self.activityIndicatorView removeFromSuperview];
    [self.progressLabel removeFromSuperview];
    
    self.activityIndicatorView = nil;
    self.progressLabel = nil;
    
    if (msg) {
        
        UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIIF width], [UIIF width])];
        toastLabel.textColor = [UIColor whiteColor];
        toastLabel.text = msg;
        toastLabel.font = [UIFont boldSystemFontOfSize:17.f];
        toastLabel.textAlignment = NSTextAlignmentCenter;
        toastLabel.attributedText = [self attributedText:toastLabel];
        toastLabel.layer.opacity = 0.2f;
        [toastLabel sizeToFit];
        toastLabel.center = self.loadingView.center;
        toastLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        toastLabel.layer.shadowOffset = CGSizeMake(0, 0);
        toastLabel.layer.shadowOpacity = 1;
        toastLabel.layer.shadowRadius = 6;
        
        [self.loadingView addSubview:toastLabel];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            toastLabel.layer.opacity = 1.f;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f delay:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                toastLabel.layer.opacity = 0.f;
                
            } completion:^(BOOL finished) {
                
                [self.loadingView removeFromSuperview];
                self.loadingView = nil;
                
                completion(YES);
            }];
        }];
        
    }else{
        
        [self.loadingView removeFromSuperview];
        
        completion(YES);
        
    }
}

-(void)startLoadingProgressIndicator:(void (^)(BOOL finished))completion{
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.loadingView = [[UIView alloc] initWithFrame:appDelegate.window.frame];
    self.loadingView.backgroundColor = [UIIF RGB:0 :0 :0 :0.4];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView.center = CGPointMake(self.loadingView.center.x, self.loadingView.center.y - 20);
    self.activityIndicatorView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.activityIndicatorView.layer.shadowOffset = CGSizeMake(0, 0);
    self.activityIndicatorView.layer.shadowOpacity = 1;
    self.activityIndicatorView.layer.shadowRadius = 6;
    
    self.progressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.progressLabel.textColor = [UIColor whiteColor];
    [self.progressLabel sizeToFit];
    self.progressLabel.center = CGPointMake(self.loadingView.center.x, self.loadingView.center.y + ([UIIF height:self.activityIndicatorView] / 2) + 20);
    
    [self.loadingView addSubview:self.activityIndicatorView];
    [self.loadingView addSubview:self.progressLabel];
    [appDelegate.window addSubview:self.loadingView];
    
    [appDelegate.window bringSubviewToFront:self.loadingView];
    [appDelegate.window bringSubviewToFront:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    [NSThread sleepForTimeInterval:0.1f];
    completion(YES);
    
}

-(void)updateLoadingProgressIndicator:(float)current total:(float)total{

    self.progressLabel.text = [NSString stringWithFormat:@"%d / %d", (int)current, (int)total];
    [self.progressLabel sizeToFit];
    self.progressLabel.center = CGPointMake(self.loadingView.center.x, self.activityIndicatorView.center.y + ([UIIF height:self.activityIndicatorView] / 2) + 20);
    NSLog(@"self.progressLabel.text %@", self.progressLabel.text);
    
}

-(void)endLoadingProgressIndicator:(void (^)(BOOL finished))completion{
    
    [self endLoadingProgressIndicator:nil completion:completion];
}

-(void)endLoadingProgressIndicator:(NSString*)msg completion:(void (^)(BOOL finished))completion{
    
    UITapGestureRecognizer *shortTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shortTapAction:)];
    shortTap.numberOfTapsRequired       = 1;
    shortTap.numberOfTouchesRequired    = 1;
    [self.loadingView addGestureRecognizer:shortTap];

    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    [self.progressLabel removeFromSuperview];
    
    self.activityIndicatorView = nil;
    self.progressLabel = nil;
    
    if (msg) {
        
        UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIIF width], [UIIF width])];
        toastLabel.textColor = [UIColor whiteColor];
        toastLabel.text = msg;
        toastLabel.font = [UIFont boldSystemFontOfSize:17.f];
        toastLabel.textAlignment = NSTextAlignmentCenter;
        toastLabel.attributedText = [self attributedText:toastLabel];
        toastLabel.layer.opacity = 0.2f;
        [toastLabel sizeToFit];
        toastLabel.center = self.loadingView.center;
        toastLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        toastLabel.layer.shadowOffset = CGSizeMake(0, 0);
        toastLabel.layer.shadowOpacity = 1;
        toastLabel.layer.shadowRadius = 6;
        
        [self.loadingView addSubview:toastLabel];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            toastLabel.layer.opacity = 1.f;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f delay:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                toastLabel.layer.opacity = 0.f;
                
            } completion:^(BOOL finished) {
                
                [self.loadingView removeFromSuperview];
                self.loadingView = nil;
                
                completion(YES);
            }];
        }];
        
    }else{
        
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
        
        completion(YES);
        
    }
    
}

-(void)toast:(NSString*)msg completion:(void (^)(BOOL finished))completion{
    
    [self memoryDealloc];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectZero];
    self.loadingView.backgroundColor = [UIIF RGB:0 :0 :0 :0.f];
    self.loadingView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *shortTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shortTapAction:)];
    shortTap.numberOfTapsRequired       = 1;
    shortTap.numberOfTouchesRequired    = 1;
    [self.loadingView addGestureRecognizer:shortTap];
    
    [appDelegate.window addSubview:self.loadingView];
    
    if (msg) {
        
        UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIIF width], [UIIF width])];
        toastLabel.textColor = [UIColor whiteColor];
        toastLabel.numberOfLines = 2;
        toastLabel.text = msg;
        toastLabel.font = [UIFont boldSystemFontOfSize:17.f];
        toastLabel.textAlignment = NSTextAlignmentCenter;
        toastLabel.attributedText = [self attributedText:toastLabel];
        toastLabel.layer.opacity = 0.2f;
        [toastLabel sizeToFit];
        toastLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        toastLabel.layer.shadowOffset = CGSizeMake(0, 0);
        toastLabel.layer.shadowOpacity = 1;
        toastLabel.layer.shadowRadius = 6;
        
        [self.loadingView addSubview:toastLabel];
        
        self.loadingView.frame = CGRectMake(0, 0, [UIIF width], toastLabel.frame.size.height * 1.5);
        toastLabel.center = self.loadingView.center;
        self.loadingView.center = appDelegate.window.center;
        
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionLayoutSubviews  animations:^{
            
            toastLabel.layer.opacity = 1.f;
            self.loadingView.backgroundColor = [UIIF RGB:0 :0 :0 :0.3f];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2f delay:1.f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionLayoutSubviews animations:^{
                
                toastLabel.layer.opacity = 0.f;
                self.loadingView.backgroundColor = [UIIF RGB:0 :0 :0 :0.f];
                
            } completion:^(BOOL finished) {
                
                [toastLabel removeFromSuperview];
                [self.loadingView removeFromSuperview];
                
                completion(YES);
            }];
        }];
        
    }else{
        
        [self.loadingView removeFromSuperview];
        completion(YES);
        
    }
}

-(UIAlertController*)inputUserNameActionSheet:(id)target
                                  title:(NSString*)title
                                message:(NSString*)message
                                confirm:(void (^)(UIAlertAction *action, UITextField *textField))confirm
                             completion:(void (^)(void))completion{
    
    UIAlertController *view = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [view addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"..입력";
        textField.textColor = [UIColor blueColor];
        textField.text = [Util getUserName];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"확인"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * _Nonnull action) {
                                   
                                   NSArray *textfields = view.textFields;
                                   UITextField *namefield = textfields[0];
                                   
                                   confirm(action, namefield);
                               }];
    
    [view addAction:okAction];
    [target presentViewController:view animated:YES completion:completion];
    
    return view;
}

-(UIAlertController*)confirmActionSheet:(id)target
                                  title:(NSString*)title
                                message:(NSString*)message
                                confirm:(void (^)(UIAlertAction *action))confirm
                                 cancel:(void (^)(UIAlertAction *action))cancel
                             completion:(void (^)(void))completion{
    
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"확인"
                               style:UIAlertActionStyleDefault
                               handler:confirm];
    UIAlertAction* cancelAction = [UIAlertAction
                                   actionWithTitle:@"취소"
                                   style:UIAlertActionStyleDestructive
                                   handler:cancel];
    
    [view addAction:okAction];
    [view addAction:cancelAction];
    [target presentViewController:view animated:YES completion:completion];
    
    return view;
}

-(NSAttributedString*)attributedText:(UILabel*)label{
    NSAttributedString *attrtext = [[NSAttributedString alloc]
                                    initWithString:label.text
                                    attributes:@{
                                                 NSStrokeWidthAttributeName: @-1.f,
                                                 NSStrokeColorAttributeName:[UIColor blackColor],
                                                 NSForegroundColorAttributeName:label.textColor
                                                 }
                                    ];
    
    return attrtext;
}

@end

@implementation UIIF

+ (UIIF *)instance  {
    static UIIF *instance = nil;
    
    @synchronized(self) {
        if(!instance) {
            instance = [[UIIF alloc] init];
        }
    }
    return instance;
}

-(UIIF *)init {
    if (self = [super init]) {
        
    }
    return self;
}

+(float)width {
    static float width = 0;
    if (width==0) {
        CGRect rect = [UIScreen mainScreen].bounds;
        width =  MIN(rect.size.height, rect.size.width);
    }
    return width;
}

+(float)width:(UIView*)view {
    return view.frame.size.width;
}

+(float)height {
    static float height = 0;
    if (height==0) {
        CGRect rect = [UIScreen mainScreen].bounds;
        height =  MAX(rect.size.height, rect.size.width);
    }
    return height;
}

+(float)height:(UIView*)view {
    return view.frame.size.height;
}

+(float)bottom:(float)pos {
    return [UIIF height] - pos;
}

+(float)left:(float)left right:(float)right {
    return [UIIF width] - left - right;
}

+(float)right:(float)pos {
    return [UIIF width] - pos;
}

+(float)rightL:(float)pos {
    return [UIIF height] - pos;
}

+(float)centerX:(float)width {
    return ([UIIF width] - width)/2;
}

+(float)centerXL:(float)width {
    return ([UIIF height] - width)/2;
}

+(float)centerY:(float)height {
    return ([UIIF height] - height)/2;
}

+(float)scale:(float)pos {
    return pos*[UIIF width]/320.0;
}

+(float)addX:(float)pos {
    return pos+[UIIF width]-320.0;
}

+(float)addY:(float)pos {
    return [UIIF f35t40:pos] + [UIIF height] - [UIIF f35t40:480];
}

+(float)endPointX:(UIView*)view {
    return view.frame.origin.x + view.frame.size.width;
}

+(float)endPointY:(UIView*)view {
    return view.frame.origin.y + view.frame.size.height;
}

+(CGRect)scaleRect:(CGRect)frame {
    float scale = [UIIF width]/320.0;
    frame.origin.x      *=  scale;
    frame.origin.y      *=  scale;
    frame.size.width    *=  scale;
    frame.size.height   *=  scale;
    return frame;
}

+(BOOL)is35inch {
    return ([UIIF height] <= 480);
}

+(int)f35t40:(int)value {
    if ([UIIF height] > 480){
        value += 88;
    }
    return value;
}

+(int)f35t40withStatusBar:(int)value {
    return [self f35t40:value] - [UIIF statusExtHeight];
}

+(CGRect)screenFrame {
    return CGRectMake(0, 0, [UIIF width], [UIIF height]-20);
}

+(CGRect)screenFramewithStatusBar {
    float height = [UIIF height]-20-[UIIF statusExtHeight];
    return CGRectMake(0, 0, [UIIF width], height);
}

+(int)statusHeight {
    return 20;
    //    return ([Util osVer] >= 7.0f)?20:0;
}

// 증가된 상태바의 높이.
+(int)statusExtHeight {
    int statusHeight = MIN([UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width) - 20;
    
    if (statusHeight < 0)
        statusHeight = 0;
    
    return statusHeight;
}

+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)targetSize {
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    CGContextRef bitmap;
    
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
}

+ (UIImage *)croppedImage:(UIImage *)srcImg  cropRect:(CGRect)cropRect {
    
    CGRect imageRect = CGRectMake(cropRect.origin.x*srcImg.scale,
                                  cropRect.origin.y*srcImg.scale,
                                  cropRect.size.width*srcImg.scale,
                                  cropRect.size.height*srcImg.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([srcImg CGImage], imageRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:srcImg.scale
                                    orientation:srcImg.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

+ (UIColor *) RGB:(int)red :(int)green :(int)blue :(float)alpha {
    return [UIColor colorWithRed:((float)red / 255.f) green:((float)green / 255.f) blue:((float)blue / 255.f) alpha:alpha];
}

+ (void)drawTopSeparator:(UIView*)target padding:(UIEdgeInsets)padding color:(UIColor*)color{
    
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(padding.left, padding.top - padding.bottom, target.frame.size.width - padding.right - padding.left, 0.5f);
    border.backgroundColor = color.CGColor;
    [target.layer addSublayer:border];
    
}

+ (void)drawBottomSeparator:(UIView*)target padding:(UIEdgeInsets)padding color:(UIColor*)color{
    
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(padding.left, target.frame.size.height - 0.5f + padding.top - padding.bottom, target.frame.size.width - padding.right - padding.left, 0.5f);
    border.backgroundColor = color.CGColor;
    [target.layer addSublayer:border];
    
}


@end
