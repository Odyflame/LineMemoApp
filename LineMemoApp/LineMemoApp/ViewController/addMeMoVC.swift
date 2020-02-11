//
//  addMeMoVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class addMeMoVC: ViewController {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var addTitle: UITextView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var line : UIProgressView!
    @IBOutlet weak var addContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.line.progress = 0.0
        
        self.addImage.isUserInteractionEnabled = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageviewPressed(_:)))
        self.addImage.addGestureRecognizer(tapGesture)
        
        self.addTitle.isUserInteractionEnabled = true
        
        self.reloadInputViews()
    }
}

extension addMeMoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func imageviewPressed(_ sender: UITapGestureRecognizer){
        //uiimagePoicker
        print("this is tapgesture")
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        
        self.present(self.imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        
        UIImagePickerController.InfoKey.editedImage
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // 수정된 이미지가 있을 경우
            self.addImage.image = possibleImage
        }
        
        picker.dismiss(animated: true) // 그리고 picker를 닫아준다.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
}

