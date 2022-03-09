import UIKit
import AVFoundation

enum CameraError: Error {
    case invalidDeviceInput(alert: AlertItem = AlertItem.invalidDeviceInput)
    case invalidScannedValue(alert: AlertItem = AlertItem.invalidScannedValue)
    case notScannedYet(alert: AlertItem = AlertItem.notScannedYet)
}

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didFind(error: CameraError)
}

final class ScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?

    weak var scannerDelegate: ScannerVCDelegate?
    
    private var haveAccess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let layer = previewLayer else {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }

        layer.frame = view.layer.bounds
    }
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }

        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        haveAccess = true
        captureSession.startRunning()
    }

    func startScan() {
        if !captureSession.isRunning && haveAccess {
            captureSession.startRunning()
        }
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first,
              let readableObject = object as? AVMetadataMachineReadableCodeObject,
              let barcode = readableObject.stringValue else {
            scannerDelegate?.didFind(error: .invalidScannedValue())
            return
        }

        captureSession.stopRunning()
        scannerDelegate?.didFind(barcode: barcode)
    }
}
