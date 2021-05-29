//
//  ViewController.swift
//  SeeFood
//
//  Created by JLCS on 5/28/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup image picker
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    // MARK: - Private Helpers
    private func detect(image: CIImage) {
        do {
            let model = try VNCoreMLModel(for: Inceptionv3().model)
            
            let request = VNCoreMLRequest(model: model) { req, error in
                guard let results = req.results as? [VNClassificationObservation] else {
                    fatalError("Model failed to process image")
                }
                
                // Hotdog/Not Hotdog
                if let firstResult = results.first {
                    if firstResult.identifier.contains("hotdog") {
                        self.navigationItem.title = "Hotdog!"
                    } else {
                        self.navigationItem.title = "Not Hotdog!"
                    }
                }
                
//                if let firstResult = results.first {
//                    self.navigationItem.title = firstResult.identifier.capitalized
//                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            
            do {
                try handler.perform([request])
            } catch {
                print("Error handler.perform request: \(error.localizedDescription)")
            }

        } catch {
            print("Error initializing VNCoreMLModel Inceptionv3: \(error.localizedDescription)")
        }
    }
    
    // MARK: - IBActions
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}


// MARK: - UIImage Picker Controller Delegate & UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[.originalImage] as? UIImage else {
            return
        }
        
        imageView.image = userPickedImage
        
        guard let ciimage = CIImage(image: userPickedImage) else {
            fatalError("Could not convert to CIImage")
        }
        
        detect(image: ciimage)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

