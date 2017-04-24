//
//  LoginViewController.h
//  MDW
//
//  Created by JETS on 4/18/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sendr;


- (IBAction)registerAction:(id)sender;


@end
