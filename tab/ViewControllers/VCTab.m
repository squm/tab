//
//  VCTab.m
//  tab
//
//  Created by e on 1/23/14.
//  Copyright (c) 2014 e. All rights reserved.
//

#import "VCTab.h"
#import "VCFav.h"
#import "VCAll.h"
#import "VCGet.h"
#import "VCNav.h"

@interface VCTab () {
	__weak IBOutlet UILabel *labelW;
	__weak IBOutlet UILabel *labelC;
	__weak IBOutlet UILabel *labelE;
	__weak IBOutlet UILabel *labelTab;
	__weak IBOutlet UIView *viewVC;
}

- (IBAction)clickWest:(id)sender;
- (IBAction)clickCenter:(id)sender;
- (IBAction)clickEast:(id)sender;
- (IBAction)clickVariant:(id)sender;

@end

@implementation VCTab {
	BOOL isSimple;
}

@synthesize navnow;
@synthesize vcall, vcfav, vcget;

- (id)
initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}
- (void)
didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (void)
viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	[self loadHier];
}
- (void)
loadHier {
	vcfav = [VCFav new];
	vcall = [VCAll new];
	vcget = [VCGet new];

	VCNav *const vcnav = [VCNav new];
	UINavigationController *const nav =
	[[UINavigationController alloc] initWithRootViewController:vcnav];

	self.nav = nav;

	nav.navigationBarHidden = YES;

	self.nav.viewControllers = @[vcall];
	navnow = NavAll;

	[self vcShow:self.nav];
	[self genLabel];
}
- (void)
vcShow:(UIViewController *const)vc {
	[self addChildViewController:vc];
//	vc.view.frame = CGRectMake(20, 20, 280, 280);
	vc.view.frame = (CGRect) {
		.origin = { 0, 0 },
		.size = viewVC.frame.size
	};
	[viewVC addSubview:vc.view];
//	[self.view addSubview:vc.view];
	[vc didMoveToParentViewController:self];
}
- (void)
genLabel {
	switch (navnow) {
		case NavFav:
			labelW.text = @"All";
			labelC.text = @"Fav";
			labelE.text = @"Get";
			break;
		case NavAll:
			labelW.text = @"Fav";
			labelC.text = @"All";
			labelE.text = @"Get";
			break;
		case NavGet:
			labelW.text = @"All";
			labelC.text = @"Get";
			labelE.text = @"Fav";
			break;
		default:
			NSAssert(NO, @"VCTab genLabel");
	}
	
	if (isSimple) {
		labelTab.text = @"Tab: variant 1";
	}
	else {
		labelTab.text = @"Tab: variant 2";
	}
}
- (IBAction)
clickWest:(id)sender {
	NSLog(@"VCTab clickWest");

	NSArray *hier;

	if (isSimple) {
		goto simple;
	}

	if (0);
	else if (navnow == NavFav) {
		// a f g (all fav get)
		navnow = NavAll;

		hier = @[vcall, vcfav];
		self.nav.viewControllers = hier;
		hier = @[vcall];
	}
	else if (navnow == NavAll) {
		// f a g (fav all get)
		navnow = NavFav;

		hier = @[vcfav, vcall];
		self.nav.viewControllers = hier;
		hier = @[vcfav];
	}
	else if (navnow == NavGet) {
		// a g f (all get fav)
		navnow = NavAll;

		hier = @[vcall, vcget];
		self.nav.viewControllers = hier;
		hier = @[vcall];
	}

	goto endif;
simple:
	if (0);
	else if (navnow == NavFav) {
		// a f g (all fav get)
		navnow = NavAll;
		hier = @[vcall];
	}
	else if (navnow == NavAll) {
		// f a g (fav all get)
		navnow = NavFav;
		hier = @[vcall, vcfav];
	}
	else if (navnow == NavGet) {
		// a g f (all get fav)
		navnow = NavAll;
		hier = @[vcall];
	}
endif:
	[self.nav setViewControllers:hier animated:YES];
	[self genLabel];
}
- (IBAction)
clickCenter:(id)sender {
	NSLog(@"VCTab clickCenter");
}
- (IBAction)
clickEast:(id)sender {
	NSLog(@"VCTab clickEast");

	NSArray *hier;

	if (isSimple) {
		goto simple;
	}

	if (0);
	else if (navnow == NavFav) {
		// a f g (all fav get)
		navnow = NavGet;
 		hier = @[vcfav, vcget];
	}
	else if (navnow == NavAll) {
		// f a g (fav all get)
		navnow = NavGet;
 		hier = @[vcall, vcget];
	}
	else if (navnow == NavGet) {
		// a g f (all get fav)
		navnow = NavFav;

 		hier = @[vcget];
		self.nav.viewControllers = hier;
 		hier = @[vcfav];
	}

	goto endif;
simple:
	if (0);
	else if (navnow == NavFav) {
		// a f g (all fav get)
		navnow = NavGet;
 		hier = @[vcall, vcfav, vcget];
	}
	else if (navnow == NavAll) {
		// f a g (fav all get)
		navnow = NavGet;
 		hier = @[vcall, vcfav, vcget];
	}
	else if (navnow == NavGet) {
		// a g f (all get fav)
		navnow = NavFav;
 		hier = @[vcall, vcfav];
	}
endif:
	[self.nav setViewControllers:hier animated:YES];
	[self genLabel];
}
- (IBAction)
clickVariant:(id)sender {
	NSLog(@"VCTav clickVariant");
	isSimple = !isSimple;
	navnow = NavAll;
	[self.nav setViewControllers:@[vcall] animated:YES];
	[self genLabel];
}

@end