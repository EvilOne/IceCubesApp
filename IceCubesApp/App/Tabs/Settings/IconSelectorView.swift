import DesignSystem
import SwiftUI

struct IconSelectorView: View {
  enum Icon: Int, CaseIterable, Identifiable {
    var id: String {
      "\(rawValue)"
    }

    init(string: String) {
      if string == Icon.primary.appIconName {
        self = .primary
      } else {
        self = .init(rawValue: Int(String(string.replacing("AppIconAlternate", with: "")))!)!
      }
    }

    case primary = 0
    case alt1, alt2, alt3, alt4, alt5, alt6, alt7, alt8
    case alt9, alt10, alt11, alt12, alt13, alt14
    case alt15, alt16, alt17, alt18, alt19, alt20, alt21
    case alt22, alt23, alt24, alt25
    case alt26, alt27, alt28
    case alt29, alt30, alt31, alt32
    case alt33

    var appIconName: String {
      switch self {
      case .primary:
        return "AppIcon"
      default:
        return "AppIconAlternate\(rawValue)"
      }
    }

    var iconName: String {
      "icon\(rawValue)"
    }
  }

  struct IconSelector: Identifiable {
    var id = UUID()
    let title: String
    let icons: [Icon]

    static let items = [
      IconSelector(title: "Official icons", icons: [.primary, .alt1, .alt2, .alt3, .alt4, .alt5, .alt6, .alt7, .alt8,
                                                     .alt9, .alt10, .alt11, .alt12, .alt13, .alt14,
                                                     .alt15, .alt16, .alt17, .alt18, .alt19, .alt25]),
      IconSelector(title: "Icons by Albert Kinng", icons: [.alt20, .alt21, .alt22, .alt23, .alt24]),
      IconSelector(title: "Icons by Dan van Moll", icons: [.alt26, .alt27, .alt28]),
      IconSelector(title: "Icons by @te6-in (GitHub)", icons: [.alt29, .alt30, .alt31, .alt32]),
      IconSelector(title: "Icon by W. Kovács Ágnes (@wildgica)", icons: [.alt33]),
    ]
  }

  @EnvironmentObject private var theme: Theme
  @State private var currentIcon = UIApplication.shared.alternateIconName ?? Icon.primary.appIconName

  private let columns = [GridItem(.adaptive(minimum: 125, maximum: 1024))]

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(IconSelector.items) { item in
          Section {
            makeIconGridView(icons: item.icons)
          } header: {
            Text(item.title)
              .font(.scaledHeadline)
          }
        }
      }
      .padding(6)
      .navigationTitle("settings.app.icon.navigation-title")
    }
    .background(theme.primaryBackgroundColor)
  }

  private func makeIconGridView(icons: [Icon]) -> some View {
    LazyVGrid(columns: columns, spacing: 6) {
      ForEach(icons) { icon in
        Button {
          currentIcon = icon.appIconName
          if icon.rawValue == Icon.primary.rawValue {
            UIApplication.shared.setAlternateIconName(nil)
          } else {
            UIApplication.shared.setAlternateIconName(icon.appIconName)
          }
        } label: {
          ZStack(alignment: .bottomTrailing) {
            Image(uiImage: .init(named: icon.iconName) ?? .init())
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(minHeight: 125, maxHeight: 1024)
              .cornerRadius(6)
              .shadow(radius: 3)
            if icon.appIconName == currentIcon {
              Image(systemName: "checkmark.seal.fill")
                .padding(4)
                .tint(.green)
            }
          }
        }
      }
    }
  }
}
