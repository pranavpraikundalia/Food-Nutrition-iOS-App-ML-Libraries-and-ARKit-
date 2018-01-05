//
//  ViewController.swift
//  MLAR
//
//  Created by Hardik Shah on 11/19/17.
//  Copyright © 2017 Hardik Shah. All rights reserved.
//


import UIKit
import AVKit
import Vision
import SceneKit
import ARKit
var flag="0"
class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, ARSCNViewDelegate {
    
    @IBOutlet weak var Button: UIButton!
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        
        
        //        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
        
        setupIdentifierConfidenceLabel()
        //previewLayer.addSublayer(Button)
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //        print("Camera was able to capture a frame:", Date())
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            //perhaps check the err
            
            //            print(finishedReq.results)
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
                
                if  firstObservation.identifier == "iPod"{
                    let alert = UIAlertController(title: "Object Found", message: firstObservation.identifier+"Found!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            flag=firstObservation.identifier
                            self.performSegue(withIdentifier: "SecondViewController", sender: self)
                            break
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                        
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            }
            
            /*guard let results_barcode = finishedReq.results as? [VNBarcodeObservation] else { return }
            
            guard let BarcodeObservation = results_barcode.first else { return }
            
            print(BarcodeObservation.payloadStringValue as Any, BarcodeObservation.confidence)
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(String(describing: BarcodeObservation.payloadStringValue)) \(BarcodeObservation.confidence * 100)"
            }*/
        }
        if flag=="0"{
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "SecondViewController") {
            
            let SecondViewController = (segue.destination as! SecondViewController)
            SecondViewController.object = flag
        }
    }
    
   
    
}



