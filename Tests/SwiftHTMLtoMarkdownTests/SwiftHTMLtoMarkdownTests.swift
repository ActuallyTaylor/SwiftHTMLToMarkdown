import XCTest
@testable import SwiftHTMLtoMarkdown

final class SwiftHTMLtoMarkdownTests: XCTestCase {
    func testMastodonHTML() throws {
        let raw = """
        <p>This is a big test of mastodon markdown</p><p><a href="https://aus.social/tags/hashtagtest" class="mention hashtag" rel="tag">#<span>hashtagtest</span></a></p><p><span class="h-card"><a href="https://aus.social/@mannytesting" class="u-url mention">@<span>mannytesting</span></a></span></p><p>:dumpster_fire:</p><p><a href="https://actuallytaylor.com/manny/test/test/test" target="_blank" rel="nofollow noopener noreferrer"><span class="invisible">https://</span><span class="ellipsis">actuallytaylor.com/manny/test/</span><span class="invisible">test/test</span></a></p>
        """
        let correctOutput = """
        This is a big test of mastodon markdown

        [#hashtagtest](https://aus.social/tags/hashtagtest)

        [@mannytesting](https://aus.social/@mannytesting)

        :dumpster_fire:

        [actuallytaylor.com/manny/test/…](https://actuallytaylor.com/manny/test/test/test)
        """
        var document = MastodonHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        XCTAssertTrue(markdown == correctOutput)
    }
    
    func testMastodonHTMLSingleLine() throws {
        let raw = "This is a test"
        let correctOutput = "This is a test"
        var document = MastodonHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        XCTAssertTrue(markdown == correctOutput)
    }
    func testBasicHTML() throws {
        let raw = """
        <h1>Heading level 1</h1><h2>Heading level 2</h2>
        <h3>Heading level 3</h3>
        <h4>Heading level 4</h4>
        <h5>Heading level 5</h5>
        <h6>Heading level 6</h6>
        <p>I just love <strong>bold text</strong>.</p>
        
        <p>Love<strong>is</strong>bold</p>
        
        <p>Italicized text is the <em>cat's meow</em>.</p>
        <p>A<em>cat</em>meow</p>
        
        <p>This text is <em><strong>really important</strong></em>.</p>
        """
        let correctOutput = """
        # Heading level 1
        
        ## Heading level 2
        
        ### Heading level 3
        
        #### Heading level 4
        
        ##### Heading level 5
        
        ###### Heading level 6
        
        I just love **bold text**.
        
        Love**is**bold
        
        Italicized text is the *cat's meow*.
        
        A*cat*meow
        
        This text is ***really important***.
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        XCTAssertTrue(markdown == correctOutput)
    }

}
