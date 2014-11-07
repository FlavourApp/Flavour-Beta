//
//  DetailViewController.m
//  chefTestV2
//
//  Created by Demian Schkolnik on 8/31/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "DetailViewController.h"
#import "DateTableViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *dates;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *fullName = [[[_chef objectForKey:@"name"] stringByAppendingString:@" "] stringByAppendingString:[_chef objectForKey:@"lastname"]];
    _TitleLabel.text = fullName;
    
    _DescriptionLabel.text = [_chef objectForKey:@"description"];
    
    self.dates = [[NSMutableArray alloc] init];
    
    //This is used for images loaded from url.organi
    NSURL *url = [NSURL URLWithString:[_chef objectForKey:@"pictureUrl"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _CookImage.image = [UIImage imageWithData:data];
    
//    NSURL *url2 = [NSURL URLWithString:_DetailModal[3]];
//    NSData *data2 = [NSData dataWithContentsOfURL:url2];
    _FoodImage.image = [UIImage imageWithData:data];
    
    //_CookImage.image = [UIImage imageNamed:_DetailModal[2]];
    //_FoodImage.image = [UIImage imageNamed:_DetailModal[3]];
    
    self.navigationItem.title = fullName;
    
    self.responseData = [NSMutableData data];
    
    int chefId = (int)([self.chef objectForKey:@"chefId"]);
    NSLog(@"chefId:%d",chefId);
    
    //TODO: REMOVE THIS FIX!
    chefId = 1;
    NSString *URL = [ NSString stringWithFormat:@"http://192.168.1.32:8000/flavour/dates?chefId=%d", chefId ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"PREPARING SEGUE");
    
    if ([[segue identifier] isEqualToString:@"goToDateTable"]) {
        NSLog(@"PREPARING SEGUE2");
        DateTableViewController *dateTableViewController = [segue destinationViewController];
        NSLog(@"PREPARING SEGUE3");
        dateTableViewController.Title = [NSMutableArray arrayWithArray:self.dates];
        NSLog(@"PREPARING SEGUE3");
    }
    else if([[segue identifier] isEqualToString:@"loadingFailure"]) {
        
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
    [self performSegueWithIdentifier:@"loadingFailure" sender:self];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert from JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        NSString *keyAsString = (NSString *)key;

        if([keyAsString  isEqual: @"dates"])
        {
            self.dates = [NSMutableArray arrayWithArray:value];
            for (NSString* str in self.dates) {
                NSLog(@"str:%@", str);
            }
        }
        //NSLog(@"value: %@", valueAsArray);
    }
    
    // extract specific value...
    //NSArray *results = [res objectForKey:@"results"];
    /*
     for (NSDictionary *result in results) {
     NSString *icon = [result objectForKey:@"icon"];
     NSLog(@"icon: %@", icon);
     }
     */
    
}



@end
