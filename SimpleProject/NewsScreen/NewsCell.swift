//
//  NewsCell.swift
//  SimpleProject
//
//  Created by Stepan Borisov on 12.03.24.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desriptionLabel: UILabel!
    //    override func awakeFromNib() {
 //       super.awakeFromNib()
        // Initialization code
 //   }

 //   override func setSelected(_ selected: Bool, animated: Bool) {
 //       super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
  //  }
    func configure(with post: NewsModel) {
        authorLabel.text = post.author
        desriptionLabel.text = post.description
        titleLabel.text = post.title
    }
    

}
