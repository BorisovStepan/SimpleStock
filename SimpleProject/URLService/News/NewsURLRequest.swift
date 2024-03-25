
import Foundation

final class NetworkServiceNews {
    
    func loadData(completion: @escaping([NewsModel]) -> ()) {
        guard let url = URL(string: "https://api.polygon.io/v2/reference/news?limit=20&apiKey=qBLt0ai9OAXWTBSZpcudvIyjvoFzKZtK") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error  in
            if let jsonData = data {
                do {
                    let newNews = try JSONDecoder().decode(NewsArticle.self, from: jsonData)
                    let news = newNews.results.map { return NewsModel(title: $0.title, author: $0.author, description: $0.description, url: $0.article_url)}
                    completion(news)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
