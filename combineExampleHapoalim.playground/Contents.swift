import SwiftUI
import Combine


// Using Publisher and Subscriber - example

class Wizard {
    var grade: Int
    
    init(grade: Int) {
        self.grade = grade
    }
}

extension Notification.Name {
    static var graduated: Notification.Name {
        return .init(rawValue: "com.gutty1.notification.name.graduated")
    }
}

let merlin = Wizard(grade: 5)

//let graduationPublisher = NotificationCenter.Publisher(center: .default, name: .graduated, object: merlin)
//
//let gradeSubscriber = Subscribers.Assign(object: merlin, keyPath: \.grade)
//
//let converter = Publishers.Map(upstream: graduationPublisher) { note in
//    return note.userInfo?["NewGrade"] as? Int ?? 0
//}
//
//converter.subscribe(gradeSubscriber)


 
// Chained Publishers - Like Array

let cancellable = NotificationCenter.default.publisher(for: .graduated, object: merlin)
    .compactMap { note in
        return note.userInfo?["NewGrade"] as? Int
}
.filter { $0 >= 5 }
//.prefix(3)
.assign(to: \.grade, on: merlin)

print("\(merlin.grade)")

NotificationCenter.default.post(name: .graduated, object: merlin, userInfo: ["NewGrade": 6])

print("\(merlin.grade)")
