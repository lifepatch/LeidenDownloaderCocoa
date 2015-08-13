//
//  TileImageDownloadOperation.m
//  LeidenDownloader
//
//  Created by xcorex on 8/13/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import "TileImageDownloadOperation.h"

@implementation TileImageDownloadOperation


- (id) initWIthUrl: (NSString *) p_url {
    self = [super init];
    if (self) {
        url = p_url;
    }
    return self;
}

- (void) saveImageFromUrl: (NSString *) p_url {
    NSLog(@"TileImageDownloadOperation %@", p_url);
    url = [NSString stringWithString:p_url];
    usleep(1000);
    NSLog(@"done");

}


- (void) main {
    [self saveImageFromUrl:url];
}

@end
