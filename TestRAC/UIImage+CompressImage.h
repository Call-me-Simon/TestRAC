//
//  UIImage+CompressImage.h
//  TestRAC
//
//  Created by Simon on 2018/1/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CompressImage)

/**
 *  图片的压缩方法
 *
 *  @param sourceImage   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+ (UIImage *)IMGCompressed:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
