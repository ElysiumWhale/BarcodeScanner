import Foundation

enum Defaults {
    enum Keys: String {
        case selectedCodeTypes
    }

    static var defaults: UserDefaults {
        .standard
    }

    static func set<T: Codable>(value: T, for key: Keys) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key.rawValue)
        } catch let decodeError as NSError {
            assertionFailure("Decoder error: \(decodeError.localizedDescription)")
            return
        }
    }

    static func get<T: Codable>(for key: Keys) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }
}
