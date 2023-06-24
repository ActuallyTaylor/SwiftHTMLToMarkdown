import XCTest
@testable import SwiftHTMLtoMarkdown

final class SwiftHTMLtoMarkdownTests: XCTestCase {
    func testExample() throws {
        let raw = """
        <p>This is a big test of mastodon markdown</p><p><a href="https://aus.social/tags/hashtagtest" class="mention hashtag" rel="tag">#<span>hashtagtest</span></a></p><p><span class="h-card"><a href="https://aus.social/@mannytesting" class="u-url mention">@<span>mannytesting</span></a></span></p><p>:dumpster_fire:</p><p><a href="https://actuallytaylor.com/manny/test/test/test" target="_blank" rel="nofollow noopener noreferrer"><span class="invisible">https://</span><span class="ellipsis">actuallytaylor.com/manny/test/</span><span class="invisible">test/test</span></a></p>
        """
        let document = MastodonHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print("OUTPUT")
        print(markdown)
    }
}
