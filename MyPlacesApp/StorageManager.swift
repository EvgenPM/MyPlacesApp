

import RealmSwift

let realm = try! Realm()
class StorageManager {
    static func saveObject(_place: Place) {
        try! realm.write {
            realm.add(_place)
        }
    }
}
