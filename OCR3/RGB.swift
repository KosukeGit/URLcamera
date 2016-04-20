
//
//  RGB.swift
//  OCR3
//
//  Created by k13052kk on 2015/12/21.
//  Copyright (c) 2015年 k13052kk. All rights reserved.
//

import Foundation

class RGB{
    func getPixelColorFromUIImage(myImage:UIImage) -> Int {
        
        //ピクセルデータ取得してバイナリ化
        var pixelData = CGDataProviderCopyData(CGImageGetDataProvider(myImage.CGImage))
        var data: UnsafePointer = CFDataGetBytePtr(pixelData)
        
        let w = myImage.size.width
        let h = myImage.size.height
        
        var ans = 0
        var count = 0
        
        //RGBおよびアルファ値を取得します
        for(var i=0;i<=Int(w);i++){
            for(var j=0;j<=Int(h);j++){
                var pixelInfo: Int = ((Int(myImage.size.width) * Int(j)) + Int(i)) * 4
                var r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
                var g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
                var b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
                var a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
                count = count + Int(r)
            }
            if count==0{
                println(i)
            }
        }
        
        
        return count
    }
}
