import SwiftSoup

/// Handle's conversion from Mastodon HTML into markdown. This is a severe subset of Markdown so it is very limited.
public class MastodonHTML: HTML {
    public var rawHTML: String
    public var document: Document?
    public var rawText: String = ""
    public var markdown: String = ""
    
    public required init() {
        rawHTML = "Document not initialized correctly"
    }

    /// Converts the given node into valid Markdown by appending it onto the ``MastodonHTML/markdown`` property.
    /// - Parameter node: The node to convert
    public func convertNode(_ node: Node) throws {
        if let className = try? node.attr("class") {
            if className == "invisible" {
                return
            }
            
            if className == "ellipsis" {
                // We need to append an ellipses to the end of this class
                for child in node.getChildNodes() {
                    try convertNode(child)
                }
                
                markdown += "…"
                return
            }
        }

        if node.nodeName() == "p" {
            if !markdown.isEmpty { // Ignore anything at the beginning of the document
                markdown += "\n\n"
            }
        } else if node.nodeName() == "br" {
            if !markdown.isEmpty { // Ignore anything at the beginning of the document
                markdown += "\n"
            }
        } else if node.nodeName() == "a" {
            markdown += "["
            for child in node.getChildNodes() {
                try convertNode(child)
            }
            markdown += "]"
            
            let href = try node.attr("href")
            markdown += "(\(href))"
            return
        } else if node.nodeName() == "#text" {
            markdown += node.description.trimmingCharacters(in: .newlines)
        }

        for node in node.getChildNodes() {
            try convertNode(node)
        }
    }
}
