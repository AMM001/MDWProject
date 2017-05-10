//
//  ProfileViewController.h
//  MDW
//
//  Created by JETS on 4/18/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDWNetworkManager.h"


@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *personNameProfile;
@property (weak, nonatomic) IBOutlet UILabel *personTitleProfile;


@end
