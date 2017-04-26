//
//  ContactViewController.m
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ContactViewController.h"
#import "AttendeeDTO.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    NSData *userDate=[[NSUserDefaults standardUserDefaults] objectForKey:@"attendeeObject"];
    AttendeeDTO *attendee=[NSKeyedUnarchiver unarchiveObjectWithData:userDate];
    
    [_emailLabel setText:attendee.email];
    _emailLabel.adjustsFontSizeToFitWidth=YES;
    [_mobileLabel setText:attendee.mobiles[0]];
    
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSData *userDate=[[NSUserDefaults standardUserDefaults] objectForKey:@"attendeeObject"];
    AttendeeDTO *attendee=[NSKeyedUnarchiver unarchiveObjectWithData:userDate];
    NSString *code=[attendee code];
    if (code == 0) return;
    
    ZXMultiFormatWriter *writer = [[ZXMultiFormatWriter alloc] init];
    ZXBitMatrix *result = [writer encode:code
                                  format:kBarcodeFormatQRCode
                                   width:self.qrImage.frame.size.width
                                  height:self.qrImage.frame.size.width
                                   error:nil];
    
    if (result) {
        ZXImage *image = [ZXImage imageWithMatrix:result];
        self.qrImage.image = [UIImage imageWithCGImage:image.cgimage];
    }
    else {
        self.qrImage.image = nil;
    }
}



@end
