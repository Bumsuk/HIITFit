import Foundation
import AudioToolbox
import UIKit

public class MyVibrate {
    
    static var nHapticType = 0
    
    // 아주 기본적인 진동 처리
    // https://www.hackingwithswift.com/example-code/system/how-to-make-the-device-vibrate
    public static func vibrate_normal() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    // 햅틱 피드백 진동 처리(다양한 case)
    // https://www.hackingwithswift.com/example-code/uikit/how-to-generate-haptic-feedback-with-uifeedbackgenerator
    public static func vibrate_haptic_feedback() {
        print("Running nHapticType : \(nHapticType)")
        
        switch nHapticType {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            nHapticType = 0
        }
        
    }
    
    
}
