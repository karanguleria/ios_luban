//
//  WinAndPrizeVC.swift
//  Luban
//
//  Created by Ganesh Sharma on 03/06/20.
//

import UIKit

class WinAndPrizeVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = submitBtn.frame.height / 2
            submitBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tF_reciept: UITextField!
    @IBOutlet weak var attachmentView: UIView!{
        didSet{
            attachmentView.layer.cornerRadius = attachmentView.frame.height / 2
            attachmentView.clipsToBounds = true
            attachmentView.layer.borderWidth = 1
            attachmentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var beforePhotoView: UIView!
    @IBOutlet weak var afterPhotoView: UIView!
    @IBOutlet weak var img_after3: UIImageView!
    @IBOutlet weak var img_after2: UIImageView!
    @IBOutlet weak var img_after1: UIImageView!
    @IBOutlet weak var tf_afterPhoto: UITextField!{
        didSet{
//            tf_afterPhoto.layer.cornerRadius = tf_afterPhoto.frame.height / 2
//            tf_afterPhoto.clipsToBounds = true
//            tf_afterPhoto.layer.borderWidth = 1
//            tf_afterPhoto.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    @IBOutlet weak var img_before3: UIImageView!
    @IBOutlet weak var img_before2: UIImageView!
    @IBOutlet weak var img_before1: UIImageView!
    @IBOutlet weak var tf_beforePhoto: UITextField!{
        didSet{
//            tf_beforePhoto.layer.cornerRadius = tf_beforePhoto.frame.height / 2
//            tf_beforePhoto.clipsToBounds = true
//            tf_beforePhoto.layer.borderWidth = 1
//            tf_beforePhoto.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    @IBOutlet weak var tf_email: UITextField!{
        didSet{
            tf_email.layer.cornerRadius = tf_email.frame.height / 2
            tf_email.clipsToBounds = true
            tf_email.layer.borderWidth = 1
            tf_email.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    @IBOutlet weak var tf_phone: UITextField!{
        didSet{
            tf_phone.layer.cornerRadius = tf_phone.frame.height / 2
            tf_phone.clipsToBounds = true
            tf_phone.layer.borderWidth = 1
            tf_phone.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    @IBOutlet weak var tf_address: UITextField!{
        didSet{
            tf_address.layer.cornerRadius = tf_address.frame.height / 2
            tf_address.clipsToBounds = true
            tf_address.layer.borderWidth = 1
            tf_address.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    @IBOutlet weak var tf_name: UITextField!{
        didSet{
            tf_name.layer.cornerRadius = tf_name.frame.height / 2
            tf_name.clipsToBounds = true
            tf_name.layer.borderWidth = 1
            tf_name.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    
    var beforeImage = [UIImage]()
    var afterImage = [UIImage]()
    var invoice:UIImage?
    var beforeBool = false
    var afterBool = false
    var invoiceImageBool = false
    var imageController = UIImagePickerController()
    
    fileprivate var uploadWinServiceManager = UploadWinServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageController.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(beforeImage1(tapGestureRecognizer:)))
        img_before1.isUserInteractionEnabled = true
        img_before1.addGestureRecognizer(tapGesture1)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(beforeImage2(tapGestureRecognizer:)))
        img_before2.isUserInteractionEnabled = true
        img_before2.addGestureRecognizer(tapGesture2)
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(beforeImage3(tapGestureRecognizer:)))
        img_before3.isUserInteractionEnabled = true
        img_before3.addGestureRecognizer(tapGesture3)
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(afterImage1(tapGestureRecognizer:)))
        img_after1.isUserInteractionEnabled = true
        img_after1.addGestureRecognizer(tapGesture4)
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(afterImage2(tapGestureRecognizer:)))
        img_after2.isUserInteractionEnabled = true
        img_after2.addGestureRecognizer(tapGesture5)
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(afterImage3(tapGestureRecognizer:)))
        img_after3.isUserInteractionEnabled = true
        img_after3.addGestureRecognizer(tapGesture6)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- View life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if beforeImage.count != 0{
            if beforeImage.count == 3{
                self.img_before1.image = self.beforeImage[0]
                self.img_before2.image = self.beforeImage[1]
                self.img_before3.image = self.beforeImage[2]
            }else if beforeImage.count == 2{
                self.img_before1.image = self.beforeImage[0]
                self.img_before2.image = self.beforeImage[1]
            }else{
                self.img_before1.image = self.beforeImage[0]
            }
        }
        if afterImage.count != 0{
            if afterImage.count == 3{
                self.img_after1.image = self.afterImage[0]
                self.img_after2.image = self.afterImage[1]
                self.img_after3.image = self.afterImage[2]
            }else if afterImage.count == 2{
                self.img_after1.image = self.afterImage[0]
                self.img_after2.image = self.afterImage[1]
            }else{
                self.img_after1.image = self.afterImage[0]
            }
        }
        
    }
    
    @objc func beforeImage1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.beforeBool = true
        self.afterBool = false
        self.invoiceImageBool = false
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
        // Your action
    }
    @objc func beforeImage2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.beforeBool = true
        self.afterBool = false
        self.invoiceImageBool = false
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)

        // Your action
    }
    @objc func beforeImage3(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.beforeBool = true
        self.afterBool = false
        self.invoiceImageBool = false
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)

        // Your action
    }
    @objc func afterImage1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.afterBool = true
        self.beforeBool = false
        self.invoiceImageBool = false
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)

        // Your action
    }
    @objc func afterImage2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.afterBool = true
        self.beforeBool = false
        self.invoiceImageBool = false
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)

        // Your action
    }
    @objc func afterImage3(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.afterBool = true
        self.beforeBool = false
        self.invoiceImageBool = false
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)

        // Your action
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scrollView.endEditing(true)
    }
    
    //MARK:- Actions
    @IBAction func cartTapped(_ sender: Any) {
        
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        guard let name = tf_name.text, let email = tf_email.text,let phone = tf_phone.text, let address = tf_address.text else{
            return
        }
        if name != "", email != "", phone != "", address != ""{
            guard let inv = self.invoice else {
                return
            }
            uploadWinServiceManager.UploadAndWinApiRequest(name: name, address: address, email: email, phone: phone, image_Before: self.beforeImage, image_after: self.afterImage, image_invoice: inv) { (response, error) in
                if error != nil{
                    Proxy.shared.displayStatusCodeAlert(error ?? "", title: "Error")
                } else {
                    self.rootWithDrawer(identifier: "TabBarVC")
                    Proxy.shared.displayStatusCodeAlert("Thanks for submitting we will get back to you soon!", title: "Success")
                    
                }
            }
        } else {
            Proxy.shared.displayStatusCodeAlert("Please enter the given fields.", title: "Error")
        }
    }
    @IBAction func attachmentTapped(_ sender: Any) {
        self.afterBool = false
        self.beforeBool = false
        self.invoiceImageBool = true
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    @IBAction func menuTapped(_ sender: Any) {
        KAppDelegate.sideMenuVC.openLeft()
    }
}
extension WinAndPrizeVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            if invoiceImageBool == true {
                self.invoice = image
                self.tF_reciept.text = "Attached"
            } else if beforeBool == true {
                if beforeImage.count < 3{
                    self.beforeImage.append(image)
                } else {
                }
            } else if afterBool == true {
                if afterImage.count < 3{
                    self.afterImage.append(image)
                } else {
                }
            }
        } else {
        }
        imageController.dismiss()
        self.viewWillAppear(true)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imageController.dismiss()
    }
}
