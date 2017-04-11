import UIKit
import SwiftKVC

class DSDataModel : Object {
    var mapping : [String : String] { return [:] }
    func getPropertyType(propertyName: String) -> Any.Type? {
        let mirror = Mirror(reflecting: self)
        let children = mirror.children
        if let index = children.index(where: { tuple in tuple.label == propertyName }) {
            let child = children[index]
            let anotherMirror = Mirror(reflecting: child.value)
            if let castedValue = child.value as? OptionalProtocol {
                return castedValue.wrappedType()
            } else {
                return anotherMirror.subjectType
            }
        }
        return nil
    }

    func getArrayType(propertyName : String) -> Any.Type? {
        let type = getPropertyType(propertyName: propertyName)!
        let arrayTypeString = String(describing: type)
        let startIndex = arrayTypeString.index(arrayTypeString.startIndex, offsetBy: 6)
        let endIndex = arrayTypeString.index(arrayTypeString.endIndex, offsetBy: -1)
        let substring = arrayTypeString.substring(with: startIndex..<endIndex)
        let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let finalType: Any.Type? = NSClassFromString("\(appName).\(substring)")
        return finalType
    }

    required init(dictionary : [String : Any]) {
        for (propertyName, dictionaryKey) in self.mapping {
            if let type = getPropertyType(propertyName: propertyName) {
                if let pulledValue = dictionary[dictionaryKey] as? [String : Any], let conformingType = type as? DSDataModel.Type {
                    self[propertyName] = conformingType.init(dictionary: pulledValue)
                } else if let pulledValue = dictionary[dictionaryKey] as? [[String : Any]], let containedType = getArrayType(propertyName: propertyName), let conformingType = containedType as? DSDataModel.Type {
                    let results = pulledValue.map { object in
                        return conformingType.init(dictionary: object)
                    }
                    self[propertyName] = results
                }
                else if let pulledValue = dictionary[dictionaryKey] {
                    self[propertyName] = pulledValue
                }
            }
        }
    }

    func unwrap(any:Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional { return any }
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }

    func convertToDictionary() -> [String : Any] {
        var results = [String:Any]()
        for (propertyName, dictionaryKey) in self.mapping {
            if let value = self[propertyName], !(unwrap(any: value) is NSNull) {
                if let castedValue = value as? DSDataModel {
                    results[dictionaryKey] = castedValue.convertToDictionary()
                } else if let castedValue = value as? NSArray {
                    var dictionaries = [Any]()
                    for (_, element) in castedValue.enumerated() {
                        if let castedObject = element as? DSDataModel {
                            dictionaries.append(castedObject.convertToDictionary())
                        } else {
                            dictionaries.append(element as Any)
                        }
                    }
                    results[dictionaryKey] = dictionaries
                } else {
                    results[dictionaryKey] = value
                }
            }
        }
        return results
    }
}

protocol OptionalProtocol {
    func wrappedType() -> Any.Type
}

extension Optional : OptionalProtocol {
    func wrappedType() -> Any.Type {
        return Wrapped.self
    }
}