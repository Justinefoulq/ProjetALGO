import XCTest
@testable import Art

final class ArtTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Art().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
