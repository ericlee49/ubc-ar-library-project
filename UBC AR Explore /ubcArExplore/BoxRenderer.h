//
//  Created by Eric Lee on 2017-07-04.
//  Copyright © 2017 Erics App House. All rights reserved.

#import <easyar/vector.oc.h>
#import <easyar/matrix.oc.h>

@interface BoxRenderer : NSObject

- (void)init_;
- (void)render:(easyar_Matrix44F *)projectionMatrix cameraview:(easyar_Matrix44F *)cameraview size:(easyar_Vec2F *)size;

@end
