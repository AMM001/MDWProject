//
//  SpeakerDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SpeakerDetailsViewController.h"

@interface SpeakerDetailsViewController ()

@end
@implementation SpeakerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableString *fullName = [NSMutableString new];
    [fullName appendString:_speaker.firstName];
    [fullName appendString:@" "];
    [fullName appendString:_speaker.middleName];
    [fullName appendString:@" "];
    [fullName appendString:_speaker.lastName];
    
    
    _speakerName.text=fullName;
    _speakerTitle.text=_speaker.title;
    _companyName.text=_speaker.companyName;
    _speakerBiography.text=_speaker.biography;
    

    if([_speaker imageData]==nil){
        
        if(_speaker.imageURL == nil){
            _speakerImage.image=[UIImage imageNamed:@"speaker.png"];
            
        }else{
        
            [MDWNetworkManager fetchImageWithURL:[_speaker imageURL]
                                     UIImageView:_speakerImage
  
                                    setForObject:_speaker ];
        }
    
    }
    
    else{
    
        UIImage * img = [[UIImage alloc] initWithData:[_speaker imageData]];
        _speakerImage.image=img;
        
    }
    
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
