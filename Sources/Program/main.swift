import KituraKit
import KituraContracts
import Dispatch

// A simple codable structure to test with
public struct Order: Codable {
    public let id: Int
    public let name: String
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

// Create an instance of Order
let order = Order(id: 1234, name: "myorder")

// Create KituraKit client
let client = KituraKit(baseURL: "http://john:pwd1@localhost:8080")!
print("client: \(client)")

let group = DispatchGroup()
group.enter()

// Send test request to server (sever must be running locally)
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

// group.enter()

// // Send test request to server (sever must be running locally)
// DispatchQueue.global().async {
//     print("Submitting POST to server...")
//     client.post("/orders", data: order) { (authUser: AuthUser, order: Order?, error: RequestError?) in
//         print("order: \(order!)")
//         group.leave()
//     }
//     print("Completed submitting async request...")
// }

// // wait ...
// group.wait()

print("Finished!")