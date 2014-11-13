//
//  OrderingViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/11/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "OrderingViewController.h"
#import "globals.h"

@interface OrderingViewController ()

@end

@implementation OrderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *post = [NSString stringWithFormat:@"chef=%@&date=%@&menu=%@&usermail=%@",_chef,_date,_menu,_userMail];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[globals getPostOrderIP]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn) {
        [self goToNextScene];
    } else {
        [self performSegueWithIdentifier:@"orderingFailure" sender:self];
    }



    
    [self performSelector:@selector(goToNextScene) withObject:nil afterDelay:5.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goToNextScene{
    NSLog(@"GoToNextScene Called..!");
    [self performSegueWithIdentifier:@"orderingSuccess" sender:self];
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
