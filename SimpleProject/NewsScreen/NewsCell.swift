import UIKit

final class NewsCell: UITableViewCell {

    @IBOutlet weak private var authorLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var desriptionLabel: UILabel!

    func configure(with post: NewsModel) {
        authorLabel.text = post.author
        desriptionLabel.text = post.description
        titleLabel.text = post.title
    }
}
