import SwiftSoup

class BasicHTML: HTML {
    public var rawHTML: String
    public var document: Document?
    public var rawText: String = ""
    public var markdown: String = ""
    var hasSpacedParagraph: Bool = false
    
    public required init() {
        rawHTML = "Document not initialized correctly"
    }

    /// Converts the given node into valid Markdown by appending it onto the ``MastodonHTML/markdown`` property.
    /// - Parameter node: The node to convert
    public func convertNode(_ node: Node) throws {
        if node.nodeName().starts(with: "h") {
            guard let last = node.nodeName().last else {
                return
            }
            guard let level = Int(String(last)) else {
                return
            }
            
            for _ in 0..<level {
                markdown += "#"
            }
            
            markdown += " "
            
            for node in node.getChildNodes() {
                try convertNode(node)
            }
            
            markdown += "\n\n"
            
            return
        } else if node.nodeName() == "p" {
            if hasSpacedParagraph {
                markdown += "\n\n"
            } else {
                hasSpacedParagraph = true
            }
        } else if node.nodeName() == "br" {
            if hasSpacedParagraph {
                markdown += "\n"
            } else {
                hasSpacedParagraph = true
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
        } else if node.nodeName() == "strong" {
            markdown += "**"
            for child in node.getChildNodes() {
                try convertNode(child)
            }
            markdown += "**"
            return
        } else if node.nodeName() == "em" {
            markdown += "*"
            for child in node.getChildNodes() {
                try convertNode(child)
            }
            markdown += "*"
            return
        }

        if node.nodeName() == "#text" && node.description != " " {
            markdown += node.description
        }

        for node in node.getChildNodes() {
            try convertNode(node)
        }
    }

}
