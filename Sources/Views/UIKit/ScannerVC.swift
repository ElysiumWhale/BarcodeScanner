import UIKit
import AVFoundation

enum CameraError: Error {
    case invalidDeviceInput(alert: AlertItem = AlertItem.invalidDeviceInput)
    case invalidScannedValue(alert: AlertItem = AlertItem.invalidScannedValue)
    case notScannedYet(alert: AlertItem = AlertItem.notScannedYet)

    var alertTitle: String {
        switch self {
            case .invalidDeviceInput(let alert),
                 .invalidScannedValue(let alert),
                 .notScannedYet(let alert):
                return alert.title
        }
    }
}

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didFind(error: CameraError)
}

final class ScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?

    weak var scannerDelegate: ScannerVCDelegate?

    private var hasAccess: Bool = false

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

    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              captureSession.canAddInput(videoInput) else {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }

        captureSession.addInput(videoInput)
        let metaDataOutput = AVCaptureMetadataOutput()

        guard captureSession.canAddOutput(metaDataOutput) else {
            scannerDelegate?.didFind(error: .invalidDeviceInput())
            return
        }

        captureSession.addOutput(metaDataOutput)
        metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metaDataOutput.metadataObjectTypes = [.ean8, .ean13]

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)

        hasAccess = true
        captureSession.startRunning()
    }

    func startScan() {
        if !captureSession.isRunning && hasAccess {
            captureSession.startRunning()
        }
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
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
