//
//  TBSecondViewController.h
//  TaboolaDemoApp


#import <UIKit/UIKit.h>
#import <TaboolaSDK/TaboolaView.h>

@interface TBSecondViewController : UIViewController <TaboolaViewDelegate>{
	IBOutlet TaboolaView *mTaboolaView;
	IBOutlet UIWebView *mWebView;
	IBOutlet UIScrollView *mScrollView;
	IBOutlet UILabel *mTextLabel;
}

@end
