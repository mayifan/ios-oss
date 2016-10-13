import KsApi
import Library
import Prelude
import UIKit

internal final class PledgeTitleCell: UITableViewCell, ValueCell {

  @IBOutlet private weak var pledgeTitleLabel: UILabel!
  @IBOutlet private weak var separatorView: UIView!

  func configureWith(value project: Project) {
    self.contentView.backgroundColor = Library.backgroundColor(forCategoryId: project.category.rootId)
    self.pledgeTitleLabel.textColor = discoveryPrimaryColor(forCategoryId: project.category.rootId)
    self.separatorView.backgroundColor = strokeColor(forCategoryId: project.category.rootId)

    switch (project.personalization.isBacking, project.state) {
    case (true?, .live):
      self.pledgeTitleLabel.font = .ksr_headline(size: 16)
      self.pledgeTitleLabel.text = localizedString(
        key: "Manage_your_pledge", defaultValue: "Manage your pledge")
    case (_, .live):
      self.pledgeTitleLabel.font = .ksr_headline(size: 17)
      self.pledgeTitleLabel.text = localizedString(
        key: "Back_this_project_below", defaultValue: "Back this project below")
    default:
      self.pledgeTitleLabel.font = .ksr_headline(size: 16)
      self.pledgeTitleLabel.text = Strings.You_backed_this_project()
    }
  }

  internal override func bindStyles() {
    super.bindStyles()

    self
      |> baseTableViewCellStyle()
      |> (UITableViewCell.lens.contentView • UIView.lens.layoutMargins) %~ { margins in
        .init(top: Styles.grid(3), left: margins.left * 2, bottom: Styles.grid(2), right: margins.right * 2)
    }

    self.pledgeTitleLabel
      |> UILabel.lens.numberOfLines .~ 0

  }
}