//
//  globals.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/12/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "globals.h"

@implementation globals

+(NSString*) getIp
{
    return @"http://54.69.134.41:80";
}

+(NSString*) getChefsIp
{
    return [[self getIp] stringByAppendingString:@"/data/chefs?comuna=las%20condes"];
}

+(NSString*) getChefsIp:(NSString*)comuna
{
    NSString* UrlString = [NSString stringWithFormat:@"/data/chefs?comuna=%@",comuna];
    NSString* escapedUrlString =
    [UrlString stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    return [[self getIp] stringByAppendingString:escapedUrlString];
}

+(NSString *) getIPMenusForChef:(NSString*)chefId
{
    return [[self getIp] stringByAppendingString:
            [NSString stringWithFormat:@"/data/menus?chefId=%@", chefId]];
}

+(NSString *) getIPDatesForChef:(NSString*)chefId
{
    return [[self getIp] stringByAppendingString:
            [NSString stringWithFormat:@"/data/dates?chefId=%@", chefId]];
}

+(NSString *) getIPImagesForUrl:(NSString*)localUrl
{
    return [[self getIp] stringByAppendingString:
            [@"/media" stringByAppendingString:localUrl]];
}

+(NSString *) getPostOrderIP
{
    return [[self getIp] stringByAppendingString:@"/createPayment/"];
}

+(NSString *) getPostPaymentIp
{
    return [[self getIp] stringByAppendingString:@"/postPayment/"];
}

+(NSString *) getComunasIp
{
    return [[self getIp] stringByAppendingString:@"/data/comunas/"];
}

@end
