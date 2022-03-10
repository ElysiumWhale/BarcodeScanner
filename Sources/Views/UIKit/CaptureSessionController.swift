import AVFoundation

protocol CaptureSessionController: AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession { get }
    var metaDataOutput: AVCaptureMetadataOutput { get }
    var hasAccess: Bool { get set }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection)
}

extension CaptureSessionController {
    func setupCaptureSession(for types: [CodeType]) -> Result<AVCaptureVideoPreviewLayer, CameraError> {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              captureSession.canAddInput(videoInput) else {
                  return .failure(.invalidDeviceInput(alert: .noPermission))
              }

        captureSession.addInput(videoInput)

        guard captureSession.canAddOutput(metaDataOutput) else {
            return .failure(.invalidDeviceInput())
        }

        metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metaDataOutput.metadataObjectTypes = types
        captureSession.addOutput(metaDataOutput)

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill

        hasAccess = true
        captureSession.startRunning()

        return .success(previewLayer)
    }
}
