//
//  ProfileViewController.m
//  MDW
//
//  Created by JETS on 4/18/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ProfileViewController.h"
#import "MDWNetworkManager.h"
#import "AttendeeDTO.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Fetch Attendee Data
    
    [MDWNetworkManager fetchAttendeeData];
    
    NSData *userDate=[[NSUserDefaults standardUserDefaults] objectForKey:@"attendeeObject"];
    AttendeeDTO *attendee=[NSKeyedUnarchiver unarchiveObjectWithData:userDate];
    NSString *name=[NSString stringWithFormat:@"%@ %@ %@",attendee.firstName,attendee.middleName,attendee.lastName];
    
    [_personNameProfile setText:name];
    _personNameProfile.adjustsFontSizeToFitWidth=YES;
    
    
    [_personTitleProfile setText:[attendee title]];
    _personTitleProfile.adjustsFontSizeToFitWidth=YES;
    
    
    _imageProfile.layer.borderColor=[[UIColor orangeColor]CGColor];
    _imageProfile.layer.borderWidth=3;
    _imageProfile.image=[UIImage imageNamed:[attendee imageURL]];
    

   // UIImage * img = [[UIImage alloc] initWithData:[attendee imageData]];
    //_imageProfile.image = img;
    
    
    /////////////////////////
    if([attendee imageData] == nil){
        
        if([attendee imageURL] == nil){
            
            _imageProfile.image=[UIImage imageNamed:@"speaker.png"];
            
        }else{
            
            [MDWNetworkManager fetchImageWithURL:[attendee imageURL]
                                     UIImageView:_imageProfile
                                    setForObject:attendee.imageData];
        }
        
    }else{
        
        UIImage * img = [[UIImage alloc] initWithData:[attendee imageData]];
        _imageProfile.image = img;
    }


////////////////////////////////


    printf("%s",[name UTF8String]);


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
