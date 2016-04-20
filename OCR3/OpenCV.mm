//
//  OpenCV.m
//  OCR3
//
//  Created by k13052kk on 2015/12/03.
//  Copyright (c) 2015年 k13052kk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "OpenCV-Bridging-Header.h"

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCV

+(UIImage *)BinarizationWithImage:(UIImage *)image{
    
    //UIImageをcv::Matに変換
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    //白黒画像に変換
    cv::Mat matGray;
    cv::cvtColor(mat, matGray, CV_BGR2GRAY);
    //UIImage *Gray = MatToUIImage(matGray);
    
    //２値化処理
    cv::Mat Threhold;
    cv::Mat Threhold2;
    cv::Mat canny;
    cv::Mat laplacian;
    cv::Mat sharp;
    
    //cv::threshold(matGray, Threhold, 0, 255,cv::THRESH_TOZERO|cv::THRESH_OTSU);
    cv::threshold(matGray, Threhold, 0, 255,cv::THRESH_TRUNC|cv::THRESH_OTSU);
    cv::threshold(Threhold, Threhold2, 0, 255, cv::THRESH_BINARY|cv::THRESH_OTSU);
    //cv::adaptiveThreshold(matGray, Threhold, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C, cv::THRESH_BINARY, 7, 8);
    //cv::Canny(Threhold2, canny, 50, 200);
    cv::Laplacian(Threhold2, laplacian, CV_32F,3);
    convertScaleAbs(Threhold2,laplacian,1,0);
    
    //cv::MatをUIImageに変換
    UIImage *BinariImg = MatToUIImage(laplacian);
    return BinariImg;
}

@end
