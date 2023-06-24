import SwiftSoup

public protocol HTML {
    var rawHTML: String { get set }
    var document: Document? { get set }
    var rawText: String { get set }
    var markdown: String { get set }
    
    /// A default initalizer
    init()
    /// Initialize a Mastodon HTML instance
    /// - Parameter rawHTML: The Raw HTML from Mastodon
    init(rawHTML: String)
    
    /// Parse the document. This must be called before any other function in the document.
    mutating func parse() throws
    
    /// Retrieve the HTML document as a Markdown formatted string
    /// - Returns: A markdown formatted string of the document.
    mutating func asMarkdown() throws -> String
    
    /// Converts the given node into valid Markdown by appending it onto the ``HTML/markdown`` property.
    /// - Parameter node: The node to convert
    mutating func convertNode(_ node: Node) throws
}

public extension HTML {
    init(rawHTML: String) {
        self.init()
        self.rawHTML = rawHTML
    }
    
    mutating func parse() throws {
        let doc = try SwiftSoup.parse(rawHTML)
        document = doc
        rawText = try doc.text()
    }
    
    mutating func asMarkdown() throws -> String {
        guard let document else {
            throw ConversionError.documentNotInitialized
        }

        markdown = ""

        guard let body: Node = document.body() else {
            return "Document Not Initialized"
        }
        try convertNode(body)

        return markdown
    }
}
