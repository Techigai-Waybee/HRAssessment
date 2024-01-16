import Foundation
import UIKit

enum HRFonts: String {
    case poppins_semiBold = "Poppins-SemiBold"
    case poppins_regular = "Poppins-Regular"
}

extension HRFonts {
    static var navigationTitleFont: UIFont {
        HRFonts.poppins_semiBold.withSize(16)
    }
}

extension HRFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        //return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        switch UIApplication.shared.screenWidth {
            case let x where x < 415 :
                // For iPhones
                return UIFont(name: rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
            
            default :
                //For iPads
                return UIFont(name: rawValue, size: fontSize * 1.7) ?? UIFont.systemFont(ofSize: fontSize * 1.7)
        }
    }
    
    func withDefaultSize() -> UIFont {
        return UIFont(name: rawValue, size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }
    
    func withFixedSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    static var fontSizeMultiplier : Double {
        switch UIApplication.shared.screenWidth {
        case let x where x < 415 :
            // For iPhones
            return 1
            
        default :
            //For iPads
            return 1.7
        }
    }
}

extension UIApplication {
    
#if os(iOS)
    var screenOrientation: UIInterfaceOrientation {
        keyWindow?
            .windowScene?
            .interfaceOrientation ?? .unknown
    }
#endif

    var screenWidth: CGFloat {
        
#if os(iOS)
        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.width
        } else {
            return UIScreen.main.bounds.size.height
        }
#elseif os(tvOS)
        return UIScreen.main.bounds.size.width
#endif
    }
    
    var screenHeight: CGFloat {
#if os(iOS)
        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.height
        } else {
            return UIScreen.main.bounds.size.width
        }
#elseif os(tvOS)
        return UIScreen.main.bounds.size.height
#endif
    }
}
