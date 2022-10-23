//
//  DetailsViewController.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/15/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var question:Question?
    var imageLoader = ImageLoader.shared
    
    var titleTitle = UILabel()
    var titleLabel = UILabel ()
    var tagTitle = UILabel()
    var tagsLabel = UILabel()
    var ownerTitle = UILabel()
    var ownerLabel = UILabel()
    var dateTitle = UILabel()
    var dateLabel = UILabel()
    var viewsTitle = UILabel()
    var viewCountLabel = UILabel()
    var answersTitle = UILabel()
    var answerCountLabel = UILabel()
    var profileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        configureLabels()
        adjustImageView(profileImageView)
        
        titleTitle.text = "Question"
        titleLabel.text = question?.title
        
        tagTitle.text = "Tags:"
        let tags = question?.tags.joined(separator: ", ")
        tagsLabel.text = tags
        
        ownerTitle.text = "Asked by:"
        ownerLabel.text = question?.owner?.name
        
        dateTitle.text = "Date:"
        if let time = question?.date {
            let epochTime = TimeInterval(time) / 1000
            let date = Date(timeIntervalSince1970: epochTime)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate
        } else {
            dateLabel.text = ""
        }
        
        viewsTitle.text = "Number of views:"
        viewCountLabel.text = "\(question?.viewCount ?? 0)"
        
        answersTitle.text = "Number of answers:"
        answerCountLabel.text = "\(question?.answerCount ?? 0)"
        
    }
    func addSubViews() {
        view.addSubview(titleTitle)
        view.addSubview(titleLabel)
        view.addSubview(tagTitle)
        view.addSubview(tagsLabel)
        view.addSubview(ownerTitle)
        view.addSubview(ownerLabel)
        view.addSubview(dateTitle)
        view.addSubview(dateLabel)
        view.addSubview(viewsTitle)
        view.addSubview(viewCountLabel)
        view.addSubview(answersTitle)
        view.addSubview(answerCountLabel)
        view.addSubview(profileImageView)
    }
    func styleLabel(_ label: UILabel, _ alignment: NSTextAlignment, _ fontSize: CGFloat, _ fontWeight: UIFont.Weight, _ textColor: UIColor,
                    _ numberOfLines: Int) {
        
        label.textAlignment = alignment
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.numberOfLines = numberOfLines
        label.textColor = textColor
        
    }

    func adjustImageView(_ imageView: UIImageView) {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let imageData = question?.owner?.image {
            DispatchQueue.main.async {
                imageView.image = UIImage(data: imageData)
            }
        } else {
            if let imageUrl = question?.owner?.imageUrl {
                imageLoader.loadImage(urlString: imageUrl) { image in
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
        imageView.topAnchor.constraint(equalTo: ownerTitle.bottomAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    func adjustConstraints(_ label: UILabel,
                           _ topAnchor: NSLayoutYAxisAnchor,
                           _ topConst: CGFloat,
                           _ leadingAnchor: NSLayoutXAxisAnchor,
                           _ leadingConst: CGFloat,
                           _ trailingAnchor: NSLayoutXAxisAnchor,
                           _ trailingConst: CGFloat) {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: topConst),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst)
 
        ])
    }
    
    func configureLabels() {
        
        styleLabel(titleTitle, .center, 25, .semibold, .orange, 0)
        styleLabel(titleLabel, .left, 20, .regular, .black, 0)
        styleLabel(tagTitle, .left, 20, .semibold, .orange, 0)
        styleLabel(tagsLabel, .left, 20, .regular, .darkGray, 0)
        styleLabel(ownerTitle, .left, 20, .semibold, .orange, 0)
        styleLabel(ownerLabel, .left, 20, .regular, .darkGray, 0)
        styleLabel(dateTitle, .left, 20, .semibold, .orange, 0)
        styleLabel(dateLabel, .left, 20, .regular, .darkGray, 0)
        styleLabel(viewsTitle, .left, 20, .semibold, .orange, 0)
        styleLabel(viewCountLabel, .left, 20, .regular, .darkGray, 0)
        styleLabel(answersTitle, .left, 20, .semibold, .orange, 0)
        styleLabel(answerCountLabel, .left, 20, .regular, .darkGray, 0)
        
        adjustConstraints(titleTitle, view.topAnchor, 100,  view.leadingAnchor, 20, view.trailingAnchor, -20)
        adjustConstraints(titleLabel, titleTitle.bottomAnchor, 30, view.leadingAnchor, 20, view.trailingAnchor, -20)
        adjustConstraints(ownerTitle, titleLabel.bottomAnchor, 30, view.leadingAnchor, 20, view.trailingAnchor, -20)
        adjustConstraints(ownerLabel, ownerTitle.bottomAnchor, 100,  profileImageView.trailingAnchor, 10, view.trailingAnchor, -20)
        adjustConstraints(dateTitle, profileImageView.bottomAnchor, 30,  view.leadingAnchor, 20, dateLabel.leadingAnchor, 0)
        adjustConstraints(dateLabel, profileImageView.bottomAnchor, 30, dateTitle.trailingAnchor, 0, view.trailingAnchor, -20)
        adjustConstraints(viewsTitle, dateTitle.bottomAnchor, 30,  view.leadingAnchor, 20, viewCountLabel.leadingAnchor, 0)
        adjustConstraints(viewCountLabel, dateTitle.bottomAnchor, 30, viewsTitle.trailingAnchor, 0, view.trailingAnchor, -20)
        adjustConstraints(answersTitle, viewsTitle.bottomAnchor, 30,  view.leadingAnchor, 20, answerCountLabel.leadingAnchor, 0)
        adjustConstraints(answerCountLabel, viewsTitle.bottomAnchor, 30, answersTitle.trailingAnchor, 0, view.trailingAnchor, -20)
        adjustConstraints(tagTitle, answersTitle.bottomAnchor, 30, view.leadingAnchor, 20, tagsLabel.leadingAnchor, 0)
        adjustConstraints(tagsLabel, answerCountLabel.bottomAnchor, 30, tagTitle.trailingAnchor, 0, view.trailingAnchor, -20)
    }
}
