//
//  BasicHTMLTests.swift
//  
//
//  Created by Taylor Lineman on 8/23/23.
//

import Foundation
import Testing
@testable import SwiftHTMLtoMarkdown

final class BasicHTMLTests {
    
    @Test
    func all() throws {
        let raw = """
        <h1>Heading level 1</h1>
        <h2>Heading level 2</h2>
        <h3>Heading level 3</h3>
        <h4>Heading level 4</h4>
        <h5>Heading level 5</h5>
        <h6>Heading level 6</h6>
        <p>I just love <strong>bold text</strong>.</p>
        
        <p>Love<strong>is</strong>bold</p>
        
        <p>Italicized text is the <em>cat's meow</em>.</p>
        <p>A<em>cats</em>meow</p>
        
        <p>This text is <em><strong>really important</strong></em>.</p>
        
        <ul>
        <li>This is the first list item</li>
        <li>This is the second list item</li>
        </ul>
        
        <p>This is some code <code>Hello World!</code></p>
        
        <pre><code><span class="hljs-attribute">Hello World</span></code></pre>
        
        <pre><code class="lang-swift"><span class="hljs-attribute">Hello World</span></code></pre>
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
        
        A*cats*meow
        
        This text is ***really important***.
        - This is the first list item
        - This is the second list item
        
        This is some code `Hello World!`
        
        ```
        Hello World
        ```
        
        ```swift
        Hello World
        ```
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func headerLevelOne() throws {
        let raw = "<h1>Heading level 1</h1>"
        let correctOutput = """
        # Heading level 1
        

        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }
    
    @Test
    func headerLevelTwo() throws {
        let raw = "<h2>Heading level 2</h2>"
        let correctOutput = """
        ## Heading level 2

        
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func headerLevelThree() throws {
        let raw = "<h3>Heading level 3</h3>"
        let correctOutput = """
        ### Heading level 3

        
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func headerLevelFour() throws {
        let raw = "<h4>Heading level 4</h4>"
        let correctOutput = """
        #### Heading level 4

        
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func headerLevelFive() throws {
        let raw = "<h5>Heading level 5</h5>"
        let correctOutput = """
        ##### Heading level 5

        
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func headerLevelSix() throws {
        let raw = "<h6>Heading level 6</h6>"
        let correctOutput = """
        ###### Heading level 6

        
        """
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func paragraph() throws {
        let raw = "<p>Paragraphs are pretty fun</p>"
        let correctOutput = "Paragraphs are pretty fun"
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func bold() throws {
        let raw = "<p>I just love <strong>bold text</strong>.</p>"
        let correctOutput = "I just love **bold text**."
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }
    
    @Test
    func boldWithNoLeadingOrTrailingSpaces() throws {
        let raw = "<p>Love<strong>is</strong>bold</p>"
        let correctOutput = "Love**is**bold"
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func italicized() throws {
        let raw = "<p>Italicized text is the <em>cat's meow</em>.</p>"
        let correctOutput = "Italicized text is the *cat's meow*."
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func italicizedWithNoLeadingOrTrailingSpaces() throws {
        let raw = "<p>A<em>cats</em>meow</p>"
        let correctOutput = "A*cats*meow"
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func italicizedBoldText() throws {
        let raw = "<p>This text is <em><strong>really important</strong></em>.</p>"
        let correctOutput = "This text is ***really important***."
        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func fencedCodeBlockWithLanguage() throws {
        let raw = """
        <pre><code class="lang-swift"><span class="hljs-attribute">Hello World</span></code></pre>
        """
        
        let correctOutput = """
        ```swift
        Hello World
        ```
        """

        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func fencedCodeBlockWithoutLanguage() throws {
        let raw = """
        <pre><code><span class="hljs-attribute">Hello World</span></code></pre>
        """
        
        let correctOutput = """
        ```
        Hello World
        ```
        """

        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func code() throws {
        let raw = "<p>This is some code <code>Hello World!</code></p>"
        
        let correctOutput = "This is some code `Hello World!`"

        var document = BasicHTML(rawHTML: raw)
        try document.parse()
        
        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }

    @Test
    func unorderedLists() throws {
        let raw = "<ul><li>List item 1</li><li>List item 2</li></ul>"

        let correctOutput = """
        
        - List item 1
        - List item 2
        """

        var document = BasicHTML(rawHTML: raw)
        try document.parse()

        let markdown = try document.asMarkdown()
        print(markdown)
        #expect(markdown == correctOutput)
    }
}
