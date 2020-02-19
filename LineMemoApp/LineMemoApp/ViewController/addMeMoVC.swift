//
//  addMeMoVC.swift
//  LineMemoApp
//
//  Created by apple on 2020/02/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Photos

protocol SendDataDelegate {
    func sendData(data: String)
}

class addMeMoVC: UIViewController {
    
    var imagePicker = UIImagePickerController()
    var delegate: SendDataDelegate?
    
    @IBOutlet weak var addTitle: UITextView!
    @IBOutlet weak var addImage: UIImageView?
    @IBOutlet weak var line : UIProgressView!
    @IBOutlet weak var addContent: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let alert = UIAlertController(title: "Do you have MeMo Done?", message: "please complete add MeMo.", preferredStyle: UIAlertController.Style.alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil )
    let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
    
    var checkText = false
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        print("addMemo")
        
        self.addTitle.delegate = self
        self.addContent.delegate = self
        
        self.line.progress = 0.0
        
        self.addImage!.isUserInteractionEnabled = true
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageviewPressed(_:)))
        self.addImage!.addGestureRecognizer(tapGesture)
        
        self.reloadInputViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        var tempMeMo = LIMeMo()
        
        let dateFormatter: DateFormatter = {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            
            return formatter
        }()
        
        //날짜 계산
        tempMeMo.MeMoDate = dateFormatter.string(from: Date())
        tempMeMo.MeMoTitle = addTitle.text
        tempMeMo.MeMoContent = addContent.text
        
        let imageData: Data? = self.addImage!.image!.pngData()
        
        if self.addImage!.image != nil {
            tempMeMo.MeMoImage.append(self.addImage!.image!)
            print("check!")
        }
        LiMeMoList.shared.memoList.append(tempMeMo)
        
        delegate?.sendData(data: "Done")
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        if addTitle.text == "제목을 입력하세요." || addContent.text == "내용을 입력하세요." {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func pressDoneBtn(_ sender: Any) {
        
        //메모가 다 울리지 않았을 경우 어떻게 할 것인가?
        
        if addTitle.text == "제목을 입력하세요." || addContent.text == "내용을 입력하세요." || self.addImage!.image == nil {
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            var tempMeMo = LIMeMo()
            
            let dateFormatter: DateFormatter = {
                let formatter: DateFormatter = DateFormatter()
                formatter.dateFormat = "yyyy년 MM월 dd일"
                
                return formatter
            }()
            
            //날짜 계산
            tempMeMo.MeMoDate = dateFormatter.string(from: Date())
            tempMeMo.MeMoTitle = addTitle.text
            tempMeMo.MeMoContent = addContent.text
            
            let imageData: Data? = self.addImage!.image!.pngData()
            
            if self.addImage!.image != nil {
                tempMeMo.MeMoImage.append(self.addImage!.image!)
                print("check!")
            }
            LiMeMoList.shared.memoList.append(tempMeMo)
            
            delegate?.sendData(data: "Done")
            
            //present(MainVC(), animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func imageviewPressed(_ sender: UITapGestureRecognizer) {
        
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}

extension addMeMoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openLibrary(){
        //uiimagePoicker
        print("this is openLibrary")
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(self.imagePicker, animated: true)
    }
    
    func openCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: false)
        } else {
            print("camera not allowed")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("get imagePickerController")
        
        UIImagePickerController.InfoKey.editedImage
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage { // 수정된 이미지가 있을 경우
            self.addImage!.image = possibleImage
        }
        
        picker.dismiss(animated: true) // 그리고 picker를 닫아준다.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
}

extension addMeMoVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if self.addTitle.text == "제목을 입력하세요." && self.addContent.text != ""{
            self.addTitle.text = ""
            self.addTitle.textColor = UIColor.black
            checkText = !checkText
        } else if addTitle.text == "" {
            self.addTitle.text = "제목을 입력하세요."
            self.addTitle.textColor = UIColor.lightGray
        }
        
        if self.addContent.text == "내용을 입력하세요." && self.addTitle.text != "" {
            self.addContent.text = ""
            self.addContent.textColor = UIColor.black
        } else if addContent.text == "" {
            self.addContent.text = "내용을 입력하세요."
            self.addContent.textColor = UIColor.lightGray
        }
        //saveButton.isEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.addTitle.text == "" {
            self.addTitle.text = "제목을 입력하세요."
            self.addTitle.textColor = UIColor.lightGray
        }
        if self.addContent.text == "" {
            self.addContent.text = "내용을 입력하세요."
            self.addContent.textColor = UIColor.lightGray
        }
        
        //updateSaveButtonState()
    }
    
}
