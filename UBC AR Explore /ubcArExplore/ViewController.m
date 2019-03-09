//
//  ViewController.m
//  UBC-AR-Explore
//
//  Created by Eric Lee on 2017-07-04.
//  Copyright © 2017 Erics App House. All rights reserved.
//

#import "ViewController.h"

#import "OpenGLView.h"

#import <ubcArExplore-Swift.h>

@implementation ViewController {
    OpenGLView *glView;
}

- (void)loadView {
    self->glView = [[OpenGLView alloc] initWithFrame:CGRectZero];
    self.view = self->glView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicatorView.frame = CGRectMake(0, 0, 22, 22);
    activityIndicatorView.color = [UIColor whiteColor];
    [activityIndicatorView startAnimating];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Loading...";
    titleLabel.font = [UIFont fontWithName:@"Arial" size:20.0];
    titleLabel.textColor = [UIColor whiteColor];
    
    CGSize fittingSize = [titleLabel sizeThatFits:CGSizeMake(200.0f, activityIndicatorView.frame.size.height)];
    titleLabel.frame = CGRectMake(activityIndicatorView.frame.origin.x + activityIndicatorView.frame.size.width + 8,
                                  activityIndicatorView.frame.origin.y,
                                  fittingSize.width,
                                  fittingSize.height);
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-(activityIndicatorView.frame.size.width + 8 + titleLabel.frame.size.width)/2,
                                                                 -(activityIndicatorView.frame.size.height)/2,
                                                                 activityIndicatorView.frame.size.width + 8 + titleLabel.frame.size.width,
                                                                 activityIndicatorView.frame.size.height)];
    [titleView addSubview:activityIndicatorView];
    [titleView addSubview:titleLabel];
    
    self.navigationItem.titleView = titleView;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self->glView setOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    [self initializeResourcesButton];
    
    UIBarButtonItem *backItem = UIBarButtonItem.alloc.init;
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    [self->glView start];
    self.navigationItem.titleView = nil;
    self.navigationItem.title = @"Begin Scanning";
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self->glView resize:self.view.bounds orientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self->glView setOrientation:toInterfaceOrientation];
}



// MARK: Resource Button View
UIButton *button = nil;

-(void)initializeResourcesButton{
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // Button Action:
    [button addTarget:self action:@selector(getResourcesAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Button characteristics:
    [button setTitle:@"Get Resource(s)" forState:UIControlStateNormal];
    [button setTitleColor:(UIColor.whiteColor) forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [[button layer]setCornerRadius:5];
    //[button setBackgroundColor:[UIColor grayColor]];
    [button setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:33.0f/255.0f blue:69.0f/255.0f alpha:1.0f]];
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = UIColor.whiteColor.CGColor;
    
    [self.view addSubview:button];
    
    
    // Button constraints (x, y position):
    [[[button centerXAnchor] constraintEqualToAnchor:[[self view] centerXAnchor]] setActive:TRUE];
    [[[button bottomAnchor] constraintEqualToAnchor:[[self view]bottomAnchor] constant:-25] setActive:TRUE];
    [[[button heightAnchor] constraintEqualToConstant:60] setActive:TRUE];
    [[[button widthAnchor] constraintEqualToConstant:200] setActive:TRUE];
    
    
}


- (void)getResourcesAction{
    //[self openResourceCollection];
    if ([targetID isEqual: @"0"]) {
        [self messageAlert];
    } else {
        [self openResourceCollection];
    }
    
}


// MARK: Message Alert View

- (void)messageAlert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Target Detected" message:@"Please Try Scanning Again" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// MARK: Open Resource Collection View

- (void)openResourceCollection{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    ResourceViewController *vc = [[ResourceViewController alloc] initWithCollectionViewLayout:layout];
    
    vc.targetIDForResource = targetID;
    [self.navigationController pushViewController:vc animated:YES];
        
}



@end
