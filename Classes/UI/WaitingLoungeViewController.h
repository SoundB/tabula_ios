//
//  WaitingLoungeViewController.h
//  Tabula
//
//  Created by JINS-MACBOOK on 2017. 2. 28..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"

@interface WaitingLoungeViewController : UIViewController <SRWebSocketDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    SRWebSocket *socket;
}

@end
