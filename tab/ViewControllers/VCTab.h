//
//  VCTab.h
//  tab
//
//  Created by e on 1/23/14.
//  Copyright (c) 2014 e. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Nav) {
	NavAll,
	NavFav,
	NavGet
};

@class VCAll;
@class VCFav;
@class VCGet;
@interface VCTab : UIViewController

@property (strong, nonatomic) UINavigationController *nav;
@property Nav navnow;

@property (strong, nonatomic) VCAll *vcall;
@property (strong, nonatomic) VCFav *vcfav;
@property (strong, nonatomic) VCGet *vcget;

@end
