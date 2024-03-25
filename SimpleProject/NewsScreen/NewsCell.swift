import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desriptionLabel: UILabel!

    func configure(with post: NewsModel) {
        authorLabel.text = post.author
        desriptionLabel.text = post.description
        titleLabel.text = post.title
    }
}
