//
//  SessionDetailsViewController.h
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionDTO.h"
#import "DateConverter.h"
#import "DateConverter.h"
#import "MDWNetworkManager.h"
#import "SpeakerDetailsViewController.h"

@interface SessionDetailsViewController : UIViewController{
    SpeakerDTO *speaker ;
}
@property (weak, nonatomic) IBOutlet UIView *speakerSubView;

@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet UILabel *sessionDate;
@property (weak, nonatomic) IBOutlet UILabel *sessionLocation;
@property (weak, nonatomic) IBOutlet UIImageView *sessionState;
@property (weak, nonatomic) IBOutlet UIWebView *sessionDescription;
@property (weak, nonatomic) IBOutlet UILabel *sessionStartEndDate;
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UIImageView *speakerImage;


@property UIActivityIndicatorView * indicator;

- (IBAction)registerationButton:(id)sender;
-(void) updateSessionStatus:(int)status;
-(void)showAlertWithMessage:(NSString *)message;

@property SessionDTO *session;
@end
