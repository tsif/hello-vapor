@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    
    func testIndex() throws {
    
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "/blabla", afterResponse: { res in
            XCTAssertEqual(res.status, .notFound)
        })
    }
    
    func testString() throws {
        
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)
        
        let string: String = "hello world"
        XCTAssertTrue(string == "hello vapor")
    }
}
