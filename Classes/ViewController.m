//
//  ViewController.m
//  WebSocket
//
//  Created by JINS-MACBOOK on 2017. 2. 21..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import "ViewController.h"
#import "UIInterface.h"
#import "AppDelegate.h"
#import "Util.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.view.backgroundColor = [UIIF RGB:184 :34 :0 :1.f];
    
    UIImage *logo = [UIImage imageNamed:@"img_logo"];
    float heightScale = logo.size.height / logo.size.width;
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_logo"]];
    logoView.frame = CGRectMake(0, 0, [UIIF width] / 2, [UIIF width] / 2 * heightScale);
    logoView.center = self.view.center;
    
    [self.view addSubview:logoView];
    
    [NSThread sleepForTimeInterval:1.f];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self usernameCheck];

    });
}

-(void)usernameCheck{
    
    [[UIInterface instance] inputUserNameActionSheet:self title:@"사용자명" message:@"이름 또는 별명을 입력하세요" confirm:^(UIAlertAction *action, UITextField *namefield) {
        
        NSLog(@":::: namefield.text : %@", namefield.text);
        
        if (!namefield.text
            || [namefield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
            
            [self usernameCheck];
            
        }else{
            [Util setUserName:namefield.text];
            
            AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate startApplication];
        }
        
    } completion:^{
        //
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
