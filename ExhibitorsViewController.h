//
//  ExhibitorsViewController.h
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuTableViewController.h"
#import "MDWNetworkManager.h"

@interface ExhibitorsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;


@property (strong, nonatomic) IBOutlet UITableView *ExhibitorsTable;

@property NSMutableArray *exhibitors;
@end
