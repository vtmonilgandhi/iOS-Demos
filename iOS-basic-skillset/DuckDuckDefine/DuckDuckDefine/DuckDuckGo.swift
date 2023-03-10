/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Alamofire
import Foundation

// Type: response category, i.e. A (article), D (disambiguation), C (category), N (name), E (exclusive), or nothing.
enum ResultType: String, Codable {
    case article = "A"
    case disambiguation = "D"
    case category = "C"
    case name = "N"
    case exclusive = "E"
}

struct Definition: Codable {
    let title: String
    let description: String
    let resultType: ResultType
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case title = "Heading"
        case description = "AbstractText"
        case resultType = "Type"
        case imageURL = "Image"
    }
}

extension Definition {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let description = try container.decode(String.self, forKey: .description)
        let resultType = try container.decode(ResultType.self, forKey: .resultType)
        let imageURL = try container.decode(URL.self, forKey: .imageURL)

        self.init(title: title, description: description, resultType: resultType, imageURL: imageURL)
    }
}

final class DuckDuckGo {
    func performSearch(for term: String, completion: @escaping (Definition?) -> Void) {
        let parameters: Parameters = [
            "q": term, "format": "json", "pretty": 1,
            "no_html": 1, "skip_disambig": 1,
        ]

        Alamofire.request("https://api.duckduckgo.com", method: .get, parameters: parameters).responseData { response in
            if response.result.isFailure {
                completion(nil)
                return
            }

            guard let jsonData = response.result.value else {
                completion(nil)
                return
            }

            let decoder = JSONDecoder()
            let definition = try? decoder.decode(Definition.self, from: jsonData)

            if let definition = definition, definition.resultType == .article {
                completion(definition)
            } else {
                completion(nil)
            }
        }
    }
}
