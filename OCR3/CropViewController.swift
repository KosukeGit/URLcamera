//
//  CropViewController.swift
//  URLCamera
//
//  Created by x13089xx on 2015/12/01.
//  Copyright (c) 2015年 Kosuke Nakamura. All rights reserved.
//

import UIKit
import CoreImage

/**
* 撮った写真をトリミングするクラス
*/
class CropViewController: UIViewController,G8TesseractDelegate, UITextFieldDelegate {
  
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet var cropText: UITextField!
    let CameraData = NSUserDefaults.standardUserDefaults()  // 設定呼び出し
    let countStart1 = NSUserDefaults.standardUserDefaults()
    var pubImage : UIImage!
    var text :String = ""
    
    /**
    * 最初に呼び出されるメソッド
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // textFiel の情報を受け取るための delegate を設定
        cropText.delegate = self
        
        let countStart = countStart1.integerForKey("countStart1Key")  // countStart1の設定呼び出す
        
        if countStart == 1 {
            let myInputImage: AnyObject? = CameraData.objectForKey("Phote")  // 撮った画像呼び出し
        }else {
            let myInputImage = UIImage(data: CameraData.objectForKey("Phote") as! NSData)  // 撮った画像呼び出し
        }
    }
    
    /**
    * トリミングボタンイベントメソッド
    */
    @IBAction func cropButtontaped(sender: AnyObject) {
        
        let myInputImage :UIImage! = UIImage(data: CameraData.objectForKey("Phote") as! NSData)  // 撮った画像呼び出し
        //var outputImage = clipImage(myInputImage, y: (self.view.frame.height/1.16)-60, height: 60)
        var outputImage = clipImage(myInputImage, y: self.view.frame.height, height: self.view.frame.height/2)
        
        
//        // CIFilterを生成。nameにどんなを処理するのか記入
//        var myCropFilter = CIFilter(name: "CICrop")
//        
//        // myScaleFilterに必要なパラメータを渡していく
//        // myInputImageをInputImageとして渡す
//        myCropFilter.setValue(myInputImage, forKey: kCIInputImageKey)
//        
//        // 画像のトリミングする部分の座標とサイズを渡す
//        myCropFilter.setValue(CIVector(
//            x: 0,
//            y: (self.view.frame.height/1.16)-60,
//            z: self.view.frame.width*5,
//            w: 60
//            ), forKey: "inputRectangle")
//        
//        // フィルターを通した画像をアウトプット
//        var myOutputImage : CIImage = myCropFilter.outputImage
//        
//        // 再びUIViewにセット
//        imageView.image = UIImage(CIImage: myOutputImage)
//        pubImage = UIImage(CIImage: myOutputImage)
//
        
        imageView.image = outputImage
        // 再描画
        imageView.setNeedsDisplay()
    }
    
    @IBAction func TesseButtontouched(sender: AnyObject) {
        var image :UIImage!
        //var text :String = ""
        
        image = imageView.image
        //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        var Tesse = Tesseract()
        text = Tesse.analyze(image)  // 文字認識関数
        self.cropText.text = text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())  // 余分な改行を削除
    }
    
    /**
     * トリミングメソッド
     */
    func clipImage(image: UIImage, y: CGFloat, height: CGFloat) -> UIImage {
        //var imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, self.view.frame.height, image.size.width, self.view.frame.height/2))
        var imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, y, image.size.width, height))
        var cropImage = UIImage(CGImage: imageRef)
        return cropImage!
    }
    
    @IBAction func GetText(sender: UITextField) {
        //label.text = sender.text
    }
    /**
     * Backボタン
     */
    @IBAction func touchedBack(sender: AnyObject) {
    }
    
    /*
     * Goボタン(Safari飛ぶ)
     */
    @IBAction func touchedGo(sender: AnyObject) {
        let url = NSURL(string: "http://" + "\(text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet()))")  // 先頭に必ず http:// をつける！！（NSURLはURLの省略不可）
                                       // http:// の文字認識精度が低いから読み取る時は www.〜 から読み込む！
                                       // NSURLで文字読み込むとラッピングされるから読み込む時はアンラップする
        
        //let url = NSURL(string: "http://www.apple.com/jp/")
        //println("\(url)")  // 確認用
        
        if UIApplication.sharedApplication().canOpenURL(url!){  // urlをアンラップして読み込めるか確認
            UIApplication.sharedApplication().openURL(url!)
            label.text = "success!"  // 成功
        }else {
            label.text = "error!"  // 失敗（URLが間違っている）
        }
    }
}










