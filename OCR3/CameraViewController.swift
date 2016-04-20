//
//  ViewController.swift
//  URLCamera
//
//  Created by x13089xx on 2015/11/24.
//  Copyright (c) 2015年 Kosuke Nakamura. All rights reserved.
//

import UIKit
import AVFoundation

/**
* カメラ起動時のクラス(実機でないと動かない)
*/
class CameraViewController: UIViewController {
    
    let CameraData = NSUserDefaults.standardUserDefaults()  // 設定保存
    let countStart1 = NSUserDefaults.standardUserDefaults()
    var count: Int = 0
    
    // セッション
    var mySession : AVCaptureSession!
    // デバイス
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット
    var myImageOutput : AVCaptureStillImageOutput!
    
    /**
    * 最初に呼び出されるメソッド
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let countStart = countStart1.integerForKey("countStart1Key")  // countStart1の設定呼び出す
        
        // 初回起動設定
        if count == countStart {
            count = countStart + 1
            countStart1.setInteger(count, forKey: "countStart1Key")  // 設定保存する
        }else {
            count = countStart + 1
            countStart1.setInteger(count, forKey: "countStart1Key")  // 設定保存する
        }
        
        // セッションの作成
        mySession = AVCaptureSession()
        // デバイス一覧の取得
        let devices = AVCaptureDevice.devices()
        // バックカメラをmyDeviceに格納
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as! AVCaptureDevice
            }
        }
        
        // バックカメラからVideoInputを取得
        let videoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as! AVCaptureDeviceInput
        // セッションに追加
        mySession.addInput(videoInput)
        // 出力先を生成
        myImageOutput = AVCaptureStillImageOutput()
        // セッションに追加
        mySession.addOutput(myImageOutput)
        
        // 画像を表示するレイヤーを生成
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as! AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        // Viewに追加
        self.view.layer.addSublayer(myVideoLayer)
        // セッション開始
        mySession.startRunning()
        
        
        // シャッターボタン
        // UIボタンを作成
        //let myButton = UIButton(frame: CGRectMake(0, self.view.frame.height-70, self.view.frame.width, self.view.frame.height-70))
        let myButton = UIButton(frame: CGRectMake(0, 0, 70, 70))
        myButton.backgroundColor = UIColor.whiteColor();
        myButton.layer.masksToBounds = true
        //myButton.setTitle("撮影ボタン", forState: .Normal)
        myButton.layer.cornerRadius = 35.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2/*+135*/, y:self.view.bounds.height/2+250)
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        
        // 戻るボタン
        // ボタンを生成する
        let backButton: UIButton = UIButton(frame: CGRectMake(0, 0, 50, 50))
        backButton.backgroundColor = UIColor.blueColor();
        backButton.layer.masksToBounds = true
        backButton.setTitle("戻る", forState: .Normal)
        //タップした状態のテキスト
        backButton.setTitle("戻る", forState: .Highlighted)
        backButton.layer.cornerRadius = 25.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2-120 , y:self.view.bounds.height/2-250)
        backButton.addTarget(self, action: "onClickMyButton2:", forControlEvents: .TouchUpInside)
        
        
        
        // 線描画
        // view作成(描画の範囲)
        let size = CGSize(width: 500, height: 700)
        let view:UIView = UIView(frame: CGRect(origin: CGPointZero, size: size))
        UIGraphicsBeginImageContextWithOptions(size, false, 0);  // 描画開始
        
        // 矩形(塗りつぶし)描画
        // 左側
        let roundCorner = UIRectCorner.TopLeft | UIRectCorner.BottomRight;
        let roundSize = CGSizeMake(1.0, 1.0);
        let path_square = UIBezierPath(roundedRect: CGRectMake(0, 0, (self.view.frame.width/2)-30, self.view.frame.height), byRoundingCorners: roundCorner, cornerRadii: roundSize)  // (x始点, y始点, x終点, y終点,)
        
        // 右側
        let roundCorner2 = UIRectCorner.TopLeft | UIRectCorner.BottomRight;
        let roundSize2 = CGSizeMake(1.0, 1.0);
        let path_square2 = UIBezierPath(roundedRect: CGRectMake((self.view.frame.width/2)+30, 0, self.view.frame.width, self.view.frame.height), byRoundingCorners: roundCorner2, cornerRadii: roundSize2)
        
        //UIColor.grayColor().setFill();
        UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7).setFill();
        path_square.fill();
        path_square2.fill();
        
        // viewに反映
        view.layer.contents = UIGraphicsGetImageFromCurrentImageContext().CGImage
        UIGraphicsEndImageContext()
        
        
        
        // 矩形、UIボタンをViewに追加
        self.view.addSubview(view)
        self.view.addSubview(myButton)
    }
    
    /**
    * カメラボタンイベント
    */
    func onClickMyButton(sender: UIButton){
        // ビデオ出力に接続
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得
        self.myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            
            // 取得したImageのDataBufferをJpegに変換
            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            
            // JpegからUIIMageを作成
            let myImage : UIImage = UIImage(data: myImageData)!
            
            var image:UIImage = myImage
            var binari = TestOpenCV.BinarizationWithImage(image)

            // アルバムに追加(写真保存)
            //UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
            
            // 画像保存
            var imageData = UIImagePNGRepresentation(binari as UIImage) //imageをPNGに変換(NSData)
            self.CameraData.setObject(imageData, forKey: "Phote")  // 画像を保存
            self.CameraData.synchronize()  // 同期処理
        })
        let targetViewController = self.storyboard!.instantiateViewControllerWithIdentifier( "crop" ) as! UIViewController
        self.presentViewController( targetViewController, animated: true, completion: nil)
    }
    
    func close(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
    * メモリ管理メソッド
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




















