//
//  RGBViewController2.swift
//  OCR3
//
//  Created by k13052kk on 2015/12/08.
//  Copyright (c) 2015年 k13052kk. All rights reserved.
//

import Foundation
//CGPointに含まれる色データをUIImageから取得して返す
class RGBViewController2 : UIViewController{
//    func getPixelColorFromUIImage(myUIImage:UIImage, pos: CGPoint) -> UIColor {
//    
//        //ピクセルデータ取得してバイナリ化
//        var pixelData = CGDataProviderCopyData(CGImageGetDataProvider(myUIImage.CGImage))
//        var data: UnsafePointer = CFDataGetBytePtr(pixelData)
//    
//        //RGBおよびアルファ値を取得します
//        var pixelInfo: Int = ((Int(myUIImage.size.width) * Int(pos.y)) + Int(pos.x)) * 4
//        var r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
//        var g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
//        var b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
//        var a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
//    
//        return UIColor(red: r, green: g, blue: b, alpha: a)
//    }
}