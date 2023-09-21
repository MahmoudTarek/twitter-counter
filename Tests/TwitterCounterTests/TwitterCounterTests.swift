import XCTest
@testable import TwitterCounter

final class TwitterCounterTests: XCTestCase {
    
    var controller: PTwitterCounterController?
    
    override func setUp() {
        controller = TwitterCounterController(tweetService: TweetServiceMock())
    }
    
    func testButtonEnabled() {
        controller?.updateCharactersCount("")
        XCTAssertEqual(controller?.shouldEnableBtns(), false)
        controller?.updateCharactersCount("Tweet")
        XCTAssertEqual(controller?.shouldEnableBtns(), true)
    }
    
    func testCharactersTypedContent() {
        XCTAssertEqual(controller?.getCharactersTypedContent(), "0 / 280")
        controller?.updateCharactersCount("This is a tweet!")
        XCTAssertEqual(controller?.getCharactersTypedContent(), "16 / 280")
        
        controller?.updateCharactersCount("This is a tweet! 🤓😎")
        
        XCTAssertEqual(controller?.getCharactersTypedContent(), "21 / 280")
        
        controller?.updateCharactersCount("😎")
        XCTAssertEqual(controller?.getCharactersTypedContent(), "2 / 280")
    }
    
    func testCharactersRemainingContent() {
        XCTAssertEqual(controller?.getCharactersRemainingContent(), "280")
        controller?.updateCharactersCount("This is a tweet!")
        XCTAssertEqual(controller?.getCharactersRemainingContent(), "264")
        
        controller?.updateCharactersCount("This is a tweet! 🤓😎")
        
        XCTAssertEqual(controller?.getCharactersRemainingContent(), "259")
        
        controller?.updateCharactersCount("😎")
        XCTAssertEqual(controller?.getCharactersRemainingContent(), "278")
    }
}
