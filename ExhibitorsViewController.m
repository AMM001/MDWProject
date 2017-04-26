//
//  ExhibitorsViewController.m
//  MDW
//
//  Created by JETS on 4/24/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ExhibitorsViewController.h"

@interface ExhibitorsViewController ()

@end

@implementation ExhibitorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _exhibitors = [[NSMutableArray alloc] init];
    
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    [_ExhibitorsTable setDelegate:self];
    [_ExhibitorsTable setDataSource:self];
   // self.ExhibitorsTable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [MDWNetworkManager fetchExhibitorsData:_exhibitors :_ExhibitorsTable];
    

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_exhibitors count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:2];
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:3];
    
    
//    nameLabel.text = @"ExihibtorName";
//    imageView.image=[UIImage imageNamed:@"exihiptors.png"];
    ExhibitorDTO* ex = [_exhibitors objectAtIndex:indexPath.row];
    nameLabel.text = [ex companyName];
 
    
    if([[_exhibitors objectAtIndex:indexPath.row] imageData] == nil){
        
        if([[_exhibitors objectAtIndex:indexPath.row] imageURL] == nil){
            
            imageView.image=[UIImage imageNamed:@"exihiptors.png"];
            
        }else{
            
            [MDWNetworkManager fetchImageWithURL:[[_exhibitors objectAtIndex:indexPath.row] imageURL]
                                     UIImageView:imageView
                                    setForObject:[_exhibitors objectAtIndex:indexPath.row] ];
        }
        
    }else{
        
        UIImage * img = [[UIImage alloc] initWithData:[[_exhibitors objectAtIndex:indexPath.row] imageData]];
        imageView.image = img;
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[[_exhibitors objectAtIndex:indexPath.row]companyUrl]]];
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
