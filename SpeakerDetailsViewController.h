//
//  SpeakerDetailsViewController.h
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakerDTO.h"
#import "MDWNetworkManager.h"

@interface SpeakerDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *speakerName;
@property (weak, nonatomic) IBOutlet UILabel *speakerTitle;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UIImageView *speakerImage;
@property (weak, nonatomic) IBOutlet UITextView *speakerBiography;

@property SpeakerDTO *speaker;

@end
