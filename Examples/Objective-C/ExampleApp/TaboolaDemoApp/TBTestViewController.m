//
//  TBTestViewController.m
//  TaboolaDemoApp
//

#import "TBTestViewController.h"
#import "TBChangeInfoViewController.h"

@implementation TBTestViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //load tabolaView
    self.taboolaView.delegate = self;
    self.taboolaView.ownerViewController = self;
    self.taboolaView.targetType = @"mix";
    NSDictionary *lPageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/2/ref", @"referrer", nil];
    [self.taboolaView setOptionalPageCommands:lPageDictionary];
    NSDictionary *lModeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"mix", @"target_type", nil];
    [self.taboolaView setOptionalModeCommands:lModeDictionary];
    self.taboolaView.autoResizeHeight = YES;
}

#pragma mark - Rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - TaboolaView delegate
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic{
    NSLog(@"Start load request on first screen: %@ isOrganic? %@", pURLString, isOrganic ? @"YES":@"NO");
    if (isOrganic) {
        NSLog(@"organic items should open as native app pages.");
    }
    return YES;
}

#pragma mark - UI
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Actions

- (IBAction)refreshButtonPressed:(id)sender{
    [self.taboolaView refresh];
}

- (IBAction)loadAgainButtonPressed:(id)sender{
    
    TBChangeInfoViewController *infoViewController = [[TBChangeInfoViewController alloc] initWithNibName:@"TBChangeInfoViewController" bundle:nil];
    infoViewController.callback = ^(NSMutableDictionary *widgetAttributes) {
        self.taboolaView.mode       = widgetAttributes[@"mode"];
        self.taboolaView.publisher  = widgetAttributes[@"publisher"];
        self.taboolaView.pageType   = widgetAttributes[@"pageType"];
        self.taboolaView.pageUrl    = widgetAttributes[@"pageURL"];
        self.taboolaView.placement  = widgetAttributes[@"placement"];
        [self.taboolaView fetchContent];
        
        NSLog(@"mode = %@, publisher = %@, pageType = %@, pageURL = %@, placement = %@", widgetAttributes[@"mode"], widgetAttributes[@"publisher"], widgetAttributes[@"pageType"], widgetAttributes[@"pageURL"], widgetAttributes[@"placement"]);
    };
    UINavigationController *navigationViewController = [[UINavigationController alloc]initWithRootViewController:infoViewController];
    navigationViewController.navigationBar.hidden = YES;
    [self.navigationController presentViewController:navigationViewController animated:YES completion:nil];
}

@end
