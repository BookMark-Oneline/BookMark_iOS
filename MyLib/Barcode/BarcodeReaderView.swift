//
//  BarcodeReaderView.swift
//  BookMark
//
//  Created by BoMin on 2023/01/10.
//

import UIKit
import AVFoundation

enum ReaderStatus {
    case success(_ code: String?)
    case fail
    case stop(_ isButtonTap: Bool)
}

protocol BarcodeReaderViewDelegate: AnyObject {
    func readerComplete(status: ReaderStatus)
}

class BarcodeReaderView: UIView {
    weak var delegate: BarcodeReaderViewDelegate?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var centerGuideLineView: UIView?
    
    var captureSession: AVCaptureSession?
    
    var isRunning: Bool {
        guard let captureSession = self.captureSession else {
            return false
        }

        return captureSession.isRunning
    }

    // 입력 데이터 형태 : (미정, 바코드 종류 모름)
    let metadataObjectTypes: [AVMetadataObject.ObjectType] = [.upce, .code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .aztec, .pdf417, .itf14, .dataMatrix, .interleaved2of5, .qr]

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initialSetupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialSetupView()
    }
    
    private func initialSetupView() {
        self.clipsToBounds = true
        // 캡처 세션 불러옴
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        guard let captureSession = self.captureSession else {
            self.fail()
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            self.fail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = self.metadataObjectTypes
        } else {
            self.fail()
            return
        }
        self.setPreviewLayer()
        self.setDimView()
    }

    private func setPreviewLayer() {
        guard let captureSession = self.captureSession else {
            return
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.layer.bounds

        self.layer.addSublayer(previewLayer)

        self.previewLayer = previewLayer
    }
    
    private func setDimView() {
// MARK: - ToDo - DimView 좌표...
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.layer.frame.width, height: self.layer.frame.height), cornerRadius: 0)
        let shapePath = UIBezierPath(rect: CGRect(x: 50, y: self.layer.frame.height / 2 - 75, width: self.layer.frame.width - 100, height: 150))

        path.append(shapePath)
        path.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor

        self.layer.addSublayer(fillLayer)
    }

}

extension BarcodeReaderView {
    func start() {
        DispatchQueue.global().async {
            self.captureSession?.startRunning()
        }
    }
    
    func stop(isButtonTap: Bool) {
        self.captureSession?.stopRunning()
        
        self.delegate?.readerComplete(status: .stop(isButtonTap))
    }
    
    func fail() {
        self.delegate?.readerComplete(status: .fail)
        self.captureSession = nil
    }
    
    func found(code: String) {
        self.delegate?.readerComplete(status: .success(code))
    }
}

extension BarcodeReaderView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        stop(isButtonTap: false)
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                let stringValue = readableObject.stringValue else {
                return
            }

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
}
