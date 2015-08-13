//
//  AppDelegate.h
//  LeidenDownloader
//
//  Created by xcorex on 8/10/15.
//  Copyright (c) 2015 xcorex. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TileDownloadOperation.h"
#import "ImageMapDownloadOperation.h"

@interface AppDelegate : NSViewController <NSApplicationDelegate, NSTableViewDataSource> {
    @private
    NSMutableArray * imageListUrl;
    NSOperationQueue * mapqueue;
}

@property (weak) IBOutlet NSTextField *txtUrl;
@property (weak) IBOutlet NSButton *btnGet;
@property (weak) IBOutlet NSTableView *tableUrl;


- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex;


- (void)testFunc:(NSNotification *)notification;

- (IBAction)btnGetClicked:(id)sender;
- (IBAction)btnDumpClicked:(id)sender;

@end

