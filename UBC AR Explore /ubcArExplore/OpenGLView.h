//
//  OpenGLView.h
//  UBC-AR-Explore
//
//  Created by Eric Lee on 2017-07-04.
//  Copyright © 2017 Erics App House. All rights reserved.
//

#import <GLKit/GLKView.h>

@interface OpenGLView : GLKView

- (void)start;
- (void)stop;
- (void)resize:(CGRect)frame orientation:(UIInterfaceOrientation)orientation;
- (void)setOrientation:(UIInterfaceOrientation)orientation;

@end
