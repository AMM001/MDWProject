//
//  SpeakerViewController.h
//  MDW
//
//  Created by JETS on 4/18/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuTableViewController.h"
#import "MDWNetworkManager.h"

@interface SpeakerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) IBOutlet UITableView *speakersTableView;

@property NSMutableArray *speakers;

@end
