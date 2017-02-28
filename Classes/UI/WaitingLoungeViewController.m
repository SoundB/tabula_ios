//
//  WaitingLoungeViewController.m
//  Tabula
//
//  Created by JINS-MACBOOK on 2017. 2. 28..
//  Copyright © 2017년 sungjin0219.park@kt.com. All rights reserved.
//

#import "WaitingLoungeViewController.h"
#import "UIInterface.h"
#import "Util.h"

@interface WaitingLoungeViewController ()

@property (strong, nonatomic) NSMutableArray *roomList;

@property (strong, nonatomic) UITableView *tableView;

@property(nonatomic, strong) SRWebSocket *web_socket;

@end

@implementation WaitingLoungeViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"대기실";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *logo = [UIImage imageNamed:@"img_logo"];
    float heightScale = logo.size.height / logo.size.width;
    
    UIImage *resizeLogo = [UIIF imageWithImage:logo scaledToSize:CGSizeMake([UIIF width] / 3.5f, [UIIF width] / 3.5f * heightScale)];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:resizeLogo];
    
    self.navigationItem.titleView = logoView;
    
    UIBarButtonItem *addRoomButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRoomAction:)];
    self.navigationItem.rightBarButtonItems = @[addRoomButtonItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIIF width], [UIIF height] - 44 - 20)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 59, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    
    [self connect];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)willEnterForeground:(NSNotification*)noti{
    
    NSLog(@"web_socket.readyState %ld", (long)self.web_socket.readyState);
    
    if(self.web_socket.readyState == SR_CLOSED){
        NSLog(@"reconnect");
        [self connect];
    }
}

#pragma mark - Functions

- (void)connect{
    
    self.web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://10.201.2.138:8765"]]];
    [self.web_socket setDelegate:self];
    [self.web_socket open];
}

- (void)addRoomAction:(UIBarButtonItem *)sender{
    
    NSLog(@"addRoomAction ");
}

- (void)requestRoomList{
    
    NSDictionary *request = @{
                              @"scene"      : @"lounge",
                              @"command"    : @"roomList",
                              @"id"         : [Util getUserName]
                              };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *requestJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [self.web_socket sendString:requestJson error:nil];
    }
    
}

- (void)registerForId:(int)connectKey{
    
    NSDictionary *request = @{
                              @"command"       : @"registerId",
                              @"connectKey" : [NSNumber numberWithInt:connectKey],
                              @"id"         : [Util getUserName]
                              };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *requestJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [self.web_socket sendString:requestJson error:nil];
    }
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.roomList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"roomListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSMutableDictionary *data = self.roomList[indexPath.row];
    
    cell.textLabel.text = data[@"title"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIIF RGB:255 :255 :255 :1.f];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *data = self.roomList[indexPath.row];
    
//    ToonViewerController *detalVc = [[ToonViewerController alloc] init];
//    detalVc.parentPageURL = self.pageURL;
//    detalVc.title = data[@"title"];
//    detalVc.pageURL = data[@"link"];
//    detalVc.toonDetalDataArray = self.toonDetalDataArray;
//    detalVc.index = (int)indexPath.row;
//    detalVc.siteCode = self.siteCode;
//    
//    [self.navigationController pushViewController:detalVc animated:YES];
    
}

#pragma mark - SRWebSocket delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"webSocketDidOpen");
    [self requestRoomList];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
    NSLog(@"didReceiveMessage: %@", [message description]);
    
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if ([@"roomList" isEqualToString:response[@"command"]]) {
        self.roomList = response[@"result"];
        [self.tableView reloadData];
//        [self registerForId:[response[@"result"][@"connect_key"] intValue]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.textView.text = [self.textView.text stringByAppendingFormat:@"\n%@", response[@"command"]];
    });
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean{
    
    NSLog(@"didCloseWithCode [%li]", (long)code);
}
@end
