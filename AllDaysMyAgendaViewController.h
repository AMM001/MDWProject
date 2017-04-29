//
//  AllDaysMyAgendaViewController.h
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuTableViewController.h"
#import "SessionDetailsViewController.h"
#import "MDWNetworkManager.h"
#import "ViewsProtocol.h"

@interface AllDaysMyAgendaViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ViewsProtocol>

@property UIActivityIndicatorView * indicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (weak, nonatomic) IBOutlet UITableView *AllDaysTable;
@property NSMutableArray * allSessions;



@end
