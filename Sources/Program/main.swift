import KituraKit
import KituraContracts
import Dispatch

public struct Order: Codable {
    public let id: Int
    public let name: String
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

let order = Order(id: 1234, name: "myorder")

let client = KituraKit(baseURL: "http://john:pwd1@localhost:8080")!
print("client: \(client)")

let group = DispatchGroup()
group.enter()

// avoid deadlocks by not using .main queue here
DispatchQueue.global().async {
    print("Submitting POST to server...")
    client.post("/orders", data: order) { (order: Order?, error: RequestError?) in
        print("order: \(order!)")
        group.leave()
    }
    print("Completed submitting async request...")
}

// wait ...
group.wait()


// DispatchQueue.main.sync {
//     print("Submitting POST to server...")
//     client.post("/orders", data: order) { (order: Order?, error: RequestError?) in
//         print("order: \(order!)")
//     }
//     print("Completed submitting async request...")
// }



print("Hello there!")