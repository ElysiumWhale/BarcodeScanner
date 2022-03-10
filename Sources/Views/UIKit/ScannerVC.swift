import UIKit
import AVFoundation

typealias CodeType = AVMetadataObject.ObjectType

protocol ScannerVCDelegate: AnyObject {
    func didFind(barcode: String)
    func didFind(error: CameraError)
}

final class ScannerVC: UIViewController, CaptureSessionController {
    let captureSession = AVCaptureSession()

    var previewLayer: AVCaptureVideoPreviewLayer?
    var hasAccess: Bool = false

    private(set) var metaDataOutput = AVCaptureMetadataOutput()

    private(set) weak var scannerDelegate: ScannerVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        switch setupCaptureSession(for: []) {
            case .success(let preview):
                previewLayer = preview
                view.layer.addSublayer(preview)
            case .failure(let error):
                scannerDelegate?.didFind(error: error)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        previewLayer?.frame = view.layer.bounds
    }

    func startScan(with types: [CodeType]) {
        if hasAccess {
            metaDataOutput.metadataObjectTypes = types
        }

        if !captureSession.isRunning && hasAccess {
            captureSession.startRunning()
        }
    }
}

extension ScannerVC {
    func withDelegate(_ delegate: ScannerVCDelegate) -> Self {
        scannerDelegate = delegate
        return self
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
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
