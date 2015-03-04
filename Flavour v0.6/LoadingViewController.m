//
//  LoadingViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 9/22/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "LoadingViewController.h"
#import "TableViewController.h"
#import "chefObject.h"
#import "globals.h"

@interface LoadingViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.fullChefList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fullChefList = [[NSMutableArray alloc] init];
    
    [self attemptConnection];
}

-(void) attemptConnection
{
    NSString *serverIp = [globals getChefsIp:_comuna];
    NSLog(@"serverIp:%@",serverIp);
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:serverIp]];
    NSLog(@"request:%@",request);
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"PREPARING SEGUE");
    
    if ([[segue identifier] isEqualToString:@"loadingSuccess"]) {
        
        TableViewController *tableViewController =  segue.destinationViewController;
        
        tableViewController.fullChefList = [NSMutableArray arrayWithArray:_fullChefList];
    }
    else if([[segue identifier] isEqualToString:@"loadingFailure"]) {
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked retry
    if (buttonIndex == 0) {
        [self attemptConnection];
    }
}

//Conection methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error de conexión" delegate:self cancelButtonTitle:@"Reintentar" otherButtonTitles:nil, nil];
    [alert show];
    //[self performSegueWithIdentifier:@"loadingFailure" sender:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert from JSON
    NSError *myError = nil;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    if(res != nil)
    {
        for(NSDictionary *chefDict in res)
        {
            chefObject *chef = [[chefObject alloc] initWithDictionary:chefDict];
            [self.fullChefList addObject:chef];
        }
        //self.fullChefList = [NSMutableArray arrayWithArray:res];
       // NSLog(@"RESPONSE===%@",res);
    }
    [self performSegueWithIdentifier:@"loadingSuccess" sender:self];
}

@end
