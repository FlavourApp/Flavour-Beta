//
//  AppDelegate.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/5/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "AppDelegate.h"
#import "SuccessViewController.h"
#import "OrderingViewController.h"
#import "globals.h"
#import "StartViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"Hemos sido invocados con: %@",url.scheme);
    NSLog(@"Description:%@",url.description);
    if ([url.scheme isEqualToString:@"khipuinstalled"]) {
        // khipu no estaba instalada al momento de ser requerido. Al terminar su instalación revisa si existe alguna aplicación que haya registrado el esquema khipuinstalled
        
        // Recuperamos la URL del cobro que aún no se ha podido procesar
        NSURL *myURL = [[NSUserDefaults standardUserDefaults] URLForKey:@"pendingURL"];
        if (!myURL) {
            // En caso que la url ya no exista, respondemos que nuestra aplicación no es la que va a responder a esta invocación
            return NO;
        }else{
            // dado que tenemos la URL del cobro pendiente, realizamos nuevamente la llamada, y esta vez será capturada por khipu
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pendingURL"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[UIApplication sharedApplication] openURL:myURL];
        }
        return YES;
    }else if ([url.scheme isEqualToString:@"flavour"]) {
        // khipu nos ha invocado, con el resultado del cobro
        
        NSString *message = @"";
        
        if ([url.description containsString:@"success"]){
            //pago completado!
            SuccessViewController *successViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController"];
            [(UINavigationController *)self.window.rootViewController pushViewController:successViewController animated:NO];
        }else{
            //error en el pago
            message = @"El servicio de pago informó que no se ha realizado el pago. Por favor intenta más tarde";
            [[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            
            StartViewController *startViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"StartViewController"];
            [(UINavigationController *)self.window.rootViewController pushViewController:startViewController animated:NO];
        }
        return YES;
    }
    
    return NO;
}



@end
