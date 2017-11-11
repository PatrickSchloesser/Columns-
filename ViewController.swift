//
//  ViewController.swift
//  Column Quest Alpha
//
//  Created by Henry Jacobs on 11/1/17.
//  Copyright © 2017 Henry Jacobs. All rights reserved.
//

import UIKit
//import EasyImagy
import MathSwift
import MobileCoreServices
import QuartzCore
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var cameraButtonView = UIButton()
    let imagePicker = UIImagePickerController()
    var imageTaken = UIImage()
    var imagePicked = UIImageView()
    
    var doMath = Math()
    //@IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var cameraButtonView = UIButton(frame: CGRect(x: 0.0, y: 467, width: self.view.frame.width, height: 100.0))
        cameraButtonView.setTitle("Open Camera", for: .normal)
        cameraButtonView.backgroundColor = .green
        cameraButtonView.addTarget(self, action: #selector(openCameraButton(sender:)), for: .touchUpInside)
        self.view.addSubview(cameraButtonView)
        
        var libButtonView = UIButton(frame: CGRect(x: 0.0, y: 567, width: self.view.frame.width, height: 100.0))
        libButtonView.setTitle("Open Photo Library", for: .normal)
        libButtonView.backgroundColor = .red
        libButtonView.addTarget(self, action: #selector(openPhotoLibraryButton(sender:)), for: .touchUpInside)
        self.view.addSubview(libButtonView)
        
         imagePicked = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 50))
        view.addSubview(imagePicked)
        
        
        checkPermission()
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        checkPermission()
        //imageView.layer.cornerRadius = imageView.frame.size.width/2
        //imageView.layer.masksToBounds = true
    }
    
    var newMedia: Bool?
    @IBAction func captureImageButtonPressed(_ sender: Any) {
        //let imageName : String = "dolphin"
        //randomImageView.image = UIImage.init(named:imageName)
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
    
    
    @IBAction func openCameraButton(sender: AnyObject) {
         print("button tapped")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
  
        }
        
    }

    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //var imagePicker = UIImagePickerController()


     internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

//        let theInfo : NSDictionary = info as NSDictionary
//        let image = theInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("image")
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }

    @IBAction func saveButt(sender: AnyObject) {
        var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)

        var alert = UIAlertView(title: "Wow",
                                message: "Your image has been saved to Photo Library!",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
}


