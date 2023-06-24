import Foundation

/// An error that is presented during conversion
public enum ConversionError: LocalizedError {
    case documentNotInitialized
    case bodyNotPresent
    
    public var errorDescription: String? {
        switch self {
        case .documentNotInitialized:
            return "The document was not properly initialized"
        case .bodyNotPresent:
            return "The document body was not available"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .documentNotInitialized:
            return "Make sure you are properly calling .parse()"
        case .bodyNotPresent:
            return "Makes sure you are using a proper HTML document."
        }
    }
}
