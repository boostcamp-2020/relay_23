//
//  Translater.swift
//  MLKit-codelab
//
//  Created by ParkJaeHyun on 2020/08/14.
//  Copyright © 2020 Google Inc. All rights reserved.
//
import Foundation
import AVFoundation
import MLKitTextRecognition
import MLKitVision
import MLKit
import UIKit

private class UIUtilities2 {
    // MARK: - Public
    public static func addRectangle(_ rectangle: CGRect, to view: UIView, color: UIColor) {
      let rectangleView = UIView(frame: rectangle)
      rectangleView.layer.cornerRadius = Constants.rectangleViewCornerRadius
      rectangleView.alpha = Constants.rectangleViewAlpha
      rectangleView.backgroundColor = UIColor(white: 100, alpha: 1.0)
      view.addSubview(rectangleView)
    }
}
// MARK: - Constants
private enum Constants {
    static let circleViewAlpha: CGFloat = 0.7
    static let rectangleViewAlpha: CGFloat = 0.3
    static let shapeViewAlpha: CGFloat = 0.3
    static let rectangleViewCornerRadius: CGFloat = 10.0
}

class Translater {
    var imageView: UIImageView? = nil
    var image: UIImage? = nil
    
    private lazy var textRecognizer = TextRecognizer.textRecognizer()
    private var annotationOverlayView = UIView()

    public var getTranslatedImage: ((UIImage?) -> Void)?
    private lazy var completeTranslationBlock: (() -> Void)? = {
        if let imageView = self.imageView, let image = self.image {
            DispatchQueue.main.async {
                self.setupAnnotationOverlayView(withBgImage: image)
                
                UIGraphicsBeginImageContext(self.annotationOverlayView.bounds.size)
                self.annotationOverlayView.drawHierarchy(in: self.annotationOverlayView.bounds, afterScreenUpdates: true)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()

                if let imageData = newImage?.pngData() {
                    self.getTranslatedImage?(UIImage.init(data: imageData) ?? nil)
                }
            }
        }
    }
    
    public func setup(image: UIImage) {
        self.imageView = UIImageView(image: image)
        self.image = image
        
        self.imageView?.addSubview(self.annotationOverlayView)

        self.annotationOverlayView.frame = self.imageView!.frame
        self.annotationOverlayView.bounds = self.imageView!.bounds
    }
    
    /// 캡처할 annotationOverlayView의 백그라운드에 원본 이미지를 추가합니다.
    private func setupAnnotationOverlayView(withBgImage: UIImage) {
        let bgImageView = UIImageView(image: withBgImage)
        bgImageView.frame = self.annotationOverlayView.frame
        bgImageView.bounds = self.annotationOverlayView.bounds
        bgImageView.layer.zPosition = -1
        bgImageView.contentMode = .scaleAspectFit
        self.annotationOverlayView.addSubview(bgImageView)
    }
    
    public func start() {
        runTextRecognition(with: imageView!.image!)
    }
    
    private func transformMatrix() -> CGAffineTransform {
        guard let image = imageView!.image else { return CGAffineTransform() }
        let imageViewWidth = imageView!.frame.size.width
        let imageViewHeight = imageView!.frame.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let imageViewAspectRatio = imageViewWidth / imageViewHeight
        let imageAspectRatio = imageWidth / imageHeight
        let scale = (imageViewAspectRatio > imageAspectRatio)
                ? imageViewHeight / imageHeight : imageViewWidth / imageWidth
        
        let scaledImageWidth = imageWidth * scale
        let scaledImageHeight = imageHeight * scale
        let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
        let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
        
        var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }
}

extension Translater {
    private struct ImageDisplay {
        let file: String
        let name: String
    }
    
    fileprivate enum Constants {
        static let lineWidth: CGFloat = 3.0
        static let lineColor = UIColor.yellow.cgColor
        static let fillColor = UIColor.clear.cgColor
        static let smallDotRadius: CGFloat = 5.0
        static let largeDotRadius: CGFloat = 10.0
        static let detectionNoResultsMessage = "No results returned."
    }
    
    func runTextRecognition(with image: UIImage) {
        let visionImage = VisionImage(image: image)
        
        textRecognizer.process(visionImage) { features, error in
            self.processResult(from: features, error: error)
        }
    }
    
    func processResult(from text: Text?, error: Error?) {
        removeDetectionAnnotations()
        
        guard error == nil, let text = text else {
            let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
            print("Text recognizer failed with error: \(errorString)")
            return
        }
        
        var completedBlock: [String] = []
        for block in text.blocks {
            addTranslated(textBlock: block) { translatedText in
                completedBlock.append(translatedText)
                if completedBlock.count == text.blocks.count {
                    self.completeTranslationBlock?()
                }
            }
        }
    }
    
    private func addTranslated(textBlock: TextBlock, _ completion: @escaping ((String) -> ())) {
        let transform = self.transformMatrix()
        
        drawFrame(textBlock.frame, in: .white, transform: transform)
        
        let transformedRect = textBlock.frame.applying(transform)
        let label = UILabel(frame: transformedRect)
        
        print("before translating block.text: \(textBlock.text)")
        let trimmedText = String(textBlock.text.map { $0 == "\n" ? " " : $0 })
        
        TranslationAPI.shared.translate(text: trimmedText, to: "ko", from: "en") { resultText in
            DispatchQueue.main.async {
                label.text = resultText
                completion(resultText)
                print("after translated label.text: \(resultText)")
            }
        }
        
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = textBlock.text.split(separator: "\n").count + 1
        self.annotationOverlayView.addSubview(label)
    }
    
    private func viewToImage(view: UIView) -> UIImage {
        return UIGraphicsImageRenderer(size: view.bounds.size).image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
}

// 결과에 영향을 직접적으로 미치는 부분 (UI)
extension Translater {
    /// Removes the detection annotations from the annotation overlay view.
    private func removeDetectionAnnotations() {
        for annotationView in annotationOverlayView.subviews {
            annotationView.removeFromSuperview()
        }
    }
    
    private func drawFrame(_ frame: CGRect, in color: UIColor, transform: CGAffineTransform) {
        var transformedRect = frame.applying(transform)
        transformedRect = CGRect(x: transformedRect.minX - 5, y: transformedRect.minY - 5, width: transformedRect.width + 10, height: transformedRect.height + 10)
        UIUtilities2.addRectangle(
            transformedRect,
            to: self.annotationOverlayView,
            color: color
        )
    }
}
