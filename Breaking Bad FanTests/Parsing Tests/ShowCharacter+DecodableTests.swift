//
//  ShowCharacter+DecodableTests.swift
//  Breaking Bad FanTests
//
//  Created by Marc Aupont on 4/23/21.
//

import XCTest
@testable import Breaking_Bad_Fan

class ShowCharacter_DecodableTests: XCTestCase {

    func testDecodeShowCharacterWithValidJSON() {
        guard let json = type(of: self).jsonObject(fromfileNamed: "character") else {
            return XCTFail()
        }
        guard let character = try? type(of: self).jsonDecoder.decode(ShowCharacter.self, from: json) else {
            return XCTFail()
        }
        
        XCTAssertEqual(character.id, 1)
        XCTAssertEqual(character.name, "Walter White")
        XCTAssertEqual(character.birthday, "09-07-1958")
        XCTAssertEqual(character.occupation.count, 2)
        XCTAssertEqual(character.imageURL, URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg"))
        XCTAssertEqual(character.status, "Presumed dead")
        XCTAssertEqual(character.nickname, "Heisenberg")
        XCTAssertEqual(character.seasons.count, 5)
        XCTAssertEqual(character.realName, "Bryan Cranston")
    }
    
    func testDecodeThrowsWithInvalidJSON() {
        guard let json = type(of: self).jsonObject(fromfileNamed: "empty") else {
            return XCTFail()
        }
        XCTAssertThrowsError(try type(of: self).jsonDecoder.decode(ShowCharacter.self, from: json))
    }

}
