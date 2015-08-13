//
//  TileDownloadOperation.m
//  LeidenDownloader
//
//  Created by xcorex on 8/12/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import "ImageMapDownloadOperation.h"


@implementation ImageMapConfig


@end

@implementation ImageMapDownloadOperation


- (id) initWithUrl:(NSString *) url {
    self = [super init];
    if (self) {
        map_config = [[ImageMapConfig alloc]  init];
        map_config.map_url = [[NSString alloc] initWithString:url];
        queue = [[NSOperationQueue alloc] init];
        [queue setMaxConcurrentOperationCount:2];
        NSLog(@"init imagemapdownload %@", url);
    }
    return self;
}

- (void) obtainMapUID {
    
    NSURL * t_url = [[NSURL alloc] initWithString:map_config.map_url];

    raw_html =  [NSString stringWithContentsOfURL:t_url encoding:NSUTF8StringEncoding error:nil];
    
    NSString            *pattern  = @"<div class=\"detailresult\" id=\"id_(.+?)\">";
    
    NSRegularExpression *regex    = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    NSTextCheckingResult *textCheckingResult = [regex firstMatchInString:raw_html
                                                                 options:0
                                                                   range:NSMakeRange(0, raw_html.length)                          ];
    
    NSRange matchRange = [textCheckingResult rangeAtIndex:1];
    
    map_config.map_uid = [raw_html substringWithRange:matchRange];
    
    
}



- (void) setMapParameterFromXML {
    
    NSString * xml_url = @"http://media-kitlv.nl/index.php?option=com_memorixbeeld&amp;view=record&amp;format=topviewxml&amp;tstart=0&amp;id=";
    
    NSString * xml_url_full = [xml_url stringByAppendingString:map_config.map_uid];
    
    NSLog(@" xml url %@", xml_url_full);
    
    NSString * xml_raw = [NSString stringWithContentsOfURL:[NSURL URLWithString:xml_url_full] encoding:NSUTF8StringEncoding error:nil];
    
    
    
    NSXMLDocument *xml_map = [[NSXMLDocument alloc] initWithXMLString:xml_raw options:0 error:nil];
    
//    <viewer>
//    <config>...</config>
//    <topviews>
//    <topview id="a63d92e9-5046-a07c-b749-4cb9b75f0b6b">
//    <tjpinfo>
//    <filepath>ec717e07-e672-90b6-ef22-5b812a973727.tjp</filepath>
//    <width>937</width>
//    <height>1287</height>
//    <tilewidth>256</tilewidth>
//    <tileheight>256</tileheight>
//    <ratio>2</ratio>
//    <numfiles>33</numfiles>
//    <mimetype>image/jpeg</mimetype>
//    <layers>
//    <layer no="1" starttile="1" cols="1" rows="1" scalefactor="8" width="118" height="161"/>
//    <layer no="2" starttile="2" cols="1" rows="2" scalefactor="4" width="235" height="322"/>
//    <layer no="3" starttile="4" cols="2" rows="3" scalefactor="2" width="469" height="644"/>
//    <layer no="4" starttile="10" cols="4" rows="6" scalefactor="1" width="937" height="1287"/>
//    </layers>

    NSXMLElement *configNode = [xml_map  nodesForXPath:@"/viewer[1]/config[1]" error:nil][0];
    map_config.map_tile_url = [[configNode elementsForName:@"tileurl"][0] objectValue];

    
    NSXMLElement *tjpNode = [xml_map  nodesForXPath:@"/viewer[1]/topviews[1]/topview[1]/tjpinfo[1]" error:nil][0];
    map_config.map_file_path = [[tjpNode elementsForName:@"filepath"][0] objectValue];
    map_config.tile_width = (int) [[[tjpNode elementsForName:@"tilewidth"][0] objectValue] integerValue ];
    map_config.tile_height = (int) [[[tjpNode elementsForName:@"tileheight"][0] objectValue] integerValue];

    
    NSArray * layers = [tjpNode nodesForXPath:@"layers/layer" error:nil];
    NSXMLElement * last_layer = [layers lastObject];
    map_config.cols = (int) [[[last_layer attributeForName:@"cols"] objectValue] integerValue];
    map_config.rows = (int) [[[last_layer attributeForName:@"rows"] objectValue] integerValue];
    map_config.img_width = (int) [[[last_layer attributeForName:@"width"] objectValue] integerValue];
    map_config.img_height = (int) [[[last_layer attributeForName:@"height"] objectValue] integerValue];
    map_config.starttile = (int) [[[last_layer attributeForName:@"starttile"] objectValue] integerValue];

    //map_tile_url  = [[nodes elementsForName:@"tileurl"][0] objectValue];
    
    NSLog(@"map_file_path %@ map_config.tile_height %i", map_config.map_file_path, map_config.tile_height);
    
    
    map_config.map_image_url = [[[NSString alloc] initWithString:map_config.map_tile_url] stringByAppendingString:map_config.map_file_path];
    
//  NSArray *topViews = [nodes children];
//    
//    for (NSXMLElement * config in topViews) {
//        if ([[config name] isEqualToString:@"tilewidth"]){
//            map_config.tile_width = (int)[[config objectValue] integerValue];
//        }else if ([[config name] isEqualToString:@"tileheight"]){
//            map_config.tile_height = (int)[[config objectValue] integerValue];
//        }
//    }

}

//downloadImageTileList(image_url_full, image_tile_starttile, image_tile_cols, image_tile_rows, xml_first_topview_id)

- (void) downloadImageTileList {
    
    int t_starttile = map_config.starttile;
    int t_rows = map_config.rows;
    int t_cols = map_config.cols;
    int t_base = 0;
    
    
    NSLog(@"starttile: %i rows: %i cols: %i", map_config.starttile, map_config.rows, map_config.cols);
    
    for (int row = 0; row < t_rows;  row++) {
        t_base = t_starttile + (row * t_cols);
        for (int col = 0; col < t_cols;  col++) {
            //NSLog(@"downloading %@&%i", map_config.map_image_url, t_base + col);            
            //NSString * t_tileurl = [map_config.map_image_url stringByAppendingString:[[t_base + col] ]]
            
            @autoreleasepool {
                NSString * t_tileurl = [NSString stringWithFormat:@"%@&%i",map_config.map_image_url, (t_base + col)];
                TileImageDownloadOperation * t_tiledownload = [[TileImageDownloadOperation alloc] initWIthUrl:t_tileurl];
                [queue addOperation:t_tiledownload];
            }
            
        }
    }
    
    
    [queue waitUntilAllOperationsAreFinished];
    
    NSLog(@"job finished");

}

- (void) main {
    
    [self obtainMapUID];
    
    [self setMapParameterFromXML];
    
    [self downloadImageTileList];
    
    NSLog(@"%@", map_config.map_image_url);

}



@end
