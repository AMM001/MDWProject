//
//  SessionDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SessionDetailsViewController.h"
#import "DBHandler.h"
#import "SpeakerDTO.h"
@interface SessionDetailsViewController ()

@end

@implementation SessionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /////render html SessionName//////
    DBHandler *mydb = [DBHandler getDB];
    SpeakerDTO *speaker = [mydb getSpeakerById:[[[_session speakers] firstObject] id]];
    _sessionName.text=_session.name;
    NSAttributedString *renderedSessionName=[[NSAttributedString alloc]initWithData:[_session.name
                                                                                     dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}documentAttributes:nil error:nil];
    _sessionName.attributedText=renderedSessionName;
   

    _sessionDate.text=[DateConverter dateStringFromDate:_session.date];
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:_session.startDate],
                       [DateConverter stringFromDate:_session.endDate]];
    if([[_session speakers] firstObject]!=nil){
        NSMutableString *fullName = [NSMutableString new];
        [fullName appendString:speaker.firstName];
        [fullName appendString:@" "];
        [fullName appendString:speaker.middleName];
        [fullName appendString:@" "];
        [fullName appendString:speaker.lastName];
        
        
        _speakerName.text = fullName;
        
        
        
        if([speaker imageData] == nil){
            
            if([speaker imageURL] == nil){
                
                _speakerImage.image=[UIImage imageNamed:@"speaker.png"];
                
            }else{
                
                [MDWNetworkManager fetchImageWithURL:[speaker imageURL]
                                         UIImageView:_speakerImage
                                        setForObject:speaker ];
            }
            
        }else{
            
            UIImage * img = [[UIImage alloc] initWithData:[speaker imageData]];
            _speakerImage.image = img;
        }
    }
    // _speakerImage.image = [UIImage imageWithData:[speaker imageData]];
    
    
    
    
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
        
      //  _speakerName.text=[[_session.speakers objectAtIndex:0]firstName];
    }
    
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    [_indicator setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)registerationButton:(id)sender {
    
    [_indicator startAnimating];
    
    NSURLSessionDataTask *dataTask = [[MDWNetworkManager getAFURLSessionManager] dataTaskWithRequest:[ServiceUrls requestRegisterToSessionWithID:[_session id] enforce:@"false" status:[_session status]] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error : %@", error);
            
            [_indicator startAnimating];
            [self showAlertWithMessage:@"please check connection !"];
        }else{
            
            if([[responseObject objectForKey:@"status"] isEqualToString:@"view.success"]){
                NSDictionary *result = [responseObject objectForKey:@"result"];
                
                //if oldSession != 0 then the user is already registered in another session at the same time
                
                if ([[result objectForKey:@"oldSessionId"] intValue] == 0) {
                    
                    
                    
                    // update status in DB
                    [self updateSessionStatus:[[result objectForKey:@"status"] intValue]];
                    [_indicator stopAnimating];
                    
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"You are already registered in another session at the same time" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *replaceAction = [UIAlertAction actionWithTitle:@"Replace" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
                        
                        NSLog(@"enforce request<><>");
                        // new request with enforce = true ;
                        NSURLSessionDataTask *dataTask = [[MDWNetworkManager getAFURLSessionManager] dataTaskWithRequest:[ServiceUrls requestRegisterToSessionWithID:[_session id] enforce:@"true" status:[_session status]] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                            
                            if (error) {
                                NSLog(@"Error : %@", error);
                                [self showAlertWithMessage:@"please check connection !"];
                            }else{
                                
                                if([[responseObject objectForKey:@"status"] isEqualToString:@"view.success"]){
                                    
                                    NSDictionary *result = [responseObject objectForKey:@"result"];
                                    
                                    
                                    // [_session setStatus: [[result objectForKey:@"status"] intValue]];
                                    
                                    // update status in DB and star view
                                    [self updateSessionStatus:[[result objectForKey:@"status"] intValue]];
                                    [_indicator stopAnimating];
                                }else{
                                    
                                    [_indicator stopAnimating];
                                    [self showAlertWithMessage:[responseObject objectForKey:@"result"]];
                                    
                                }
                            }
                            
                        }];
                        
                        [dataTask resume];
                        
                    }];
                    
                    UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:nil];
                    
                    [alert addAction:replaceAction];
                    [alert addAction:ignoreAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
        }
        
    }];
    
    [dataTask resume];
    
}

/* method update session in UI and DB */
-(void) updateSessionStatus:(int)status{
    
    [[MDWNetworkManager getDBHandler] updateSession:_session Status:status];
    
    //update UI
    
    if(_session.status==0){
        
        [_sessionState setImage:[UIImage imageNamed:@"sessionnotadded.png"]];
    }
    else if(_session.status==1){
        
        [_sessionState setImage:[UIImage imageNamed:@"sessionpending.png"]];
    }else if(_session.status==2){
        
        [_sessionState setImage:[UIImage imageNamed:@"sessionapproved.png"]];
    }
}

-(void)showAlertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil
                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
