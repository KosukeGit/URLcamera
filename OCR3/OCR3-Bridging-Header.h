//
//  Header.h
//  OCR3
//
//  Created by k13052kk on 2015/12/03.
//  Copyright (c) 2015年 k13052kk. All rights reserved.
//

#ifndef OCR3_Header_h
#define OCR3_Header_h

#import "G8Tesseract.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestOpenCV : NSObject
+(UIImage *)BinarizationWithImage:(UIImage *)image;


@end


#endif
