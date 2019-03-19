//
//  ViewController_Image.swift
//  ImageRecognition_CVProject
//
//  Created by AbdulHadi Al-Ajmi on 11/12/18.
//  Copyright © 2018 AbdulHadi Al-Ajmi. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController_Image: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ivPic: UIImageView!
    @IBOutlet weak var tvTxt: UITextView!
    @IBOutlet weak var buUp: UIButton!
    var imagePicker : UIImagePickerController!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Backgournd.png")!)
        
        buUp.layer.cornerRadius = 10.0
        buUp.layer.masksToBounds = true
        
        ivPic.layer.cornerRadius = 20.0
        ivPic.layer.masksToBounds = true
        
        tvTxt.layer.cornerRadius = 10.0
        tvTxt.layer.masksToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary //.camera
        // Do any additional setup after loading the view.
    }


    @IBAction func butUpload(_ sender: Any) {
         present(imagePicker, animated: true, completion: nil)
    }
    
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        ivPic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil) 
        pictureIdentifyML(image: (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
    
        
    }
    
    func pictureIdentifyML (image: UIImage){
        guard let model = try? VNCoreMLModel(for:Resnet50().model) else{
            fatalError(" Connot load ML model")
        }
        
        let request = VNCoreMLRequest(model: model){
            [ weak self] request, error in
            
            guard let results = request.results as? [VNClassificationObservation], let firstResult = results.first else{
                fatalError(" Connot get result from VNCoreMLRequest")
            }
            
            DispatchQueue.main.async {
                self?.tvTxt.text = "Accuracy: \( Int(firstResult.confidence * 100))% \nObject: \((firstResult.identifier))"
            }
        }
        
        guard let ciImage = CIImage(image: image) else{
            fatalError(" canoot convet to CIImage")
        }
        
        let imageHnadler = VNImageRequestHandler(ciImage: ciImage)
        
        DispatchQueue.global(qos: .userInteractive).async {
            do{
                try imageHnadler.perform([request])
            }catch{
                print("Error \(error)")
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
