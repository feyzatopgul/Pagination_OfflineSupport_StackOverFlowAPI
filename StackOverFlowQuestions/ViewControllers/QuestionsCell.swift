//
//  QuestionsCell.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/15/22.
//

import UIKit

class QuestionsCell: UITableViewCell {
    
    let questionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)
        //questionLabel.sizeToFit()
        questionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            questionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
