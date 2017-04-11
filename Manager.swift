import UIKit


class Manager {
	
	static let sharedInstance = Manager()
	
	fileprivate func queryStringComponents(items: [String:Any?]) -> String {
		var component = URLComponents()
		component.queryItems = items
		.filter({$1 != nil})
		.map { return queryItem(key: $0, value: String(describing: $1!)) }
		if let encodedQuery = component.query {
			return encodedQuery
		} else {
			return ""
		}
	}
	
	fileprivate func queryItem(key: String, value: Any) -> URLQueryItem {
		var allowedCharacters = CharacterSet.urlQueryAllowed
		allowedCharacters.remove(charactersIn: "+&")
		return URLQueryItem(
		name: key.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!,
		value: String(describing: value).addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
		)
	}
	
}