import SwiftSoup

public class BasicHTML: HTML {
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
            
            markdown += "\n\n"
            
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
        } else if node.nodeName() == "code" {
            markdown += "`"
            for child in node.getChildNodes() {
                try convertNode(child)
            }
            markdown += "`"
            return
        } else if node.nodeName() == "pre", node.childNodeSize() >= 1 {
            if hasSpacedParagraph {
                markdown += "\n\n"
            } else {
                hasSpacedParagraph = true
            }

            let codeNode = node.childNode(0)
            
            if codeNode.nodeName() == "code" {
                markdown += "```"
                
                // Try and get the language from the code block

                if let codeClass = try? codeNode.attr("class"),
                   let match = try? #/lang.*-(\w+)/#.firstMatch(in: codeClass) {
                    // match.output.1 is equal to the second capture group.
                    let language = match.output.1
                    markdown += language + "\n"
                } else {
                    // Add the ending newline that we need to format this correctly.
                    markdown += "\n"
                }
                
                for child in codeNode.getChildNodes() {
                    try convertNode(child)
                }
                markdown += "\n```"
                return
            }
        } else if node.nodeName() == "figcaption" {
            markdown += "\n\n"
            for child in node.getChildNodes() {
                try convertNode(child)
            }
            markdown += "\n\n"
        } else if node.nodeName() == "img" {
            markdown += "!["
            let alt = try node.attr("alt")
            markdown += alt
            markdown += "]("
            let src = try node.attr("src")
            markdown += src
            markdown += ")"
        } else if node.nodeName() == "div" {
            if hasSpacedParagraph {
                markdown += "\n\n"
            } else {
                hasSpacedParagraph = true
            }
        }

        if node.nodeName() == "#text" && node.description != " " {
            markdown += node.description
        }
        

        for node in node.getChildNodes() {
            try convertNode(node)
        }
    }

}
