
import Foundation

public func currentDate() -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    if let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedYesterday = dateFormatter.string(from: yesterday)
        return formattedYesterday
    } else {
        return "Cant recive Date"
    }
}
