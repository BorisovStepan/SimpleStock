
import Foundation

private  var posts: [Post] = []

private func lodData() {
    guard let url = URL(string: "https://api.polygon.io/v2/reference/news?limit=20&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    URLSession.shared.dataTask(with: request) { responseData, response, error  in
        if let error = error {
            print(error.localizedDescription)
        } else if let jsonData = responseData {
            let posts = try? JSONDecoder().decode([Post].self, from: jsonData)
        }
    }.resume()
    
}
