//
//  ViewController.h
//  MDW
//
//  Created by marko on 4/12/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "MDWNetworkManager.h"
#import "SessionDTO.h"
#import "AttendeeDTO.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *SpeakersTableView;

@property NSMutableArray *speakers;
@property NSMutableArray *sessions;

@end

