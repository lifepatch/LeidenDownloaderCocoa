//
//  TileImageDownloadOperation.h
//  LeidenDownloader
//
//  Created by xcorex on 8/13/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileImageDownloadOperation : NSOperation {
    @private
    NSString * url;
}

- (id) initWIthUrl: (NSString *) p_url;

@end
