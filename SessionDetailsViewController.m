//
//  SessionDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SessionDetailsViewController.h"

@interface SessionDetailsViewController ()

@end

@implementation SessionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sessionName.text=_session.name;
    _sessionDate.text=[DateConverter dateStringFromDate:_session.date];
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:_session.startDate],
                       [DateConverter stringFromDate:_session.endDate]];
    
    _sessionStartEndDate.text = date;
    _sessionLocation.text=_session.location;
    [_sessionDescription loadHTMLString:_session.sessionDescription baseURL:nil];
    
    if(_session.status==0){
    
        [_sessionState setImage:[UIImage imageNamed:@"sessionnotadded.png"]];
    }
    else if(_session.status==1){
        
        [_sessionState setImage:[UIImage imageNamed:@"sessionpending.png"]];
    }else if(_session.status==2){
        
        [_sessionState setImage:[UIImage imageNamed:@"sessionapproved.png"]];
    }

    
    
    
    if ([_session.speakers count]>0) {
        
        _speakerName.text=[[_session.speakers objectAtIndex:0]firstName];
    }
    
   
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
