//
//  InstalledViewController.h
//  Lime
//
//  Created by ArtikusHG on 4/30/19.
//  Copyright © 2019 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMDPKGParser.h"
#import "LMPackageParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface InstalledViewController : UITableViewController

@property (nonatomic, retain) LMPackageParser *parser;
@property (nonatomic, retain) NSArray *sortedPackages;

@end

NS_ASSUME_NONNULL_END
