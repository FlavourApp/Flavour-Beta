//
//  TestsViewController.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 1/13/15.
//  Copyright (c) 2015 Schkolnik. All rights reserved.
//

#import "TestsViewController.h"

@interface TestsViewController ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation TestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.responseData = [NSMutableData data];
    [self createPaymentAndProcess];
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

-(void)createPaymentAndProcess{

    
    NSString *body = @"Pure de papas";
    NSString *chefId = @"2";
    NSString *payer_email = @"demianschkolnik@gmail.com";
    NSString *dateId = @"2";
    NSString *menuId = @"2";
    
    NSString *postString = [NSString stringWithFormat:@"&body=%@",body];
    postString = [NSString stringWithFormat:@"%@&payer_email=%@", postString,payer_email];
    postString = [NSString stringWithFormat:@"%@&chefId=%@", postString,chefId];
    postString = [NSString stringWithFormat:@"%@&dateId=%@", postString,dateId];
    postString = [NSString stringWithFormat:@"%@&menuId=%@", postString,menuId];
    
    NSLog(@"postString:%@",postString);
   
     NSMutableURLRequest *aNSMutableURLRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[globals getPostOrderIP]]];
    
      [aNSMutableURLRequest setHTTPMethod:@"POST"];
    [aNSMutableURLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSURLConnection alloc] initWithRequest:aNSMutableURLRequest delegate:self];
    
}

- (void)processPayment:(NSURL *)myURL {
    if (![[UIApplication sharedApplication] canOpenURL:myURL]) {
        // No está instalado khipu.
        //[self.overlayUIView setHidden:YES];
        // Guardamos la URL con la información del pago.
        // Esta información se utiliza cuando nuestra aplicación es invocada por khipu luego de su instalación.
        [[NSUserDefaults standardUserDefaults] setURL:myURL forKey:@"pendingURL"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // Le avisamos al usuario que es necesario instalar khipu.
        [[[UIAlertView alloc] initWithTitle:nil message:@"Debes instalar khipu" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    [[UIApplication sharedApplication] openURL:myURL];
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
        NSURL *myURL = [NSURL URLWithString:[res valueForKey:@"mobile-url"]];
        NSLog(@"mobileUrl:%@", [res valueForKey:@"mobile-url"]);
        [self processPayment:myURL];
    }
}

@end
