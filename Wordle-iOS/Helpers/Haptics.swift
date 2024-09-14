//
//  Haptics.swift
//  Wordle-iOS
//
//  Created by Matúš Mištrik on 15/09/2024.
//

import UIKit

public final class Haptics {

    private init() { }

    public static func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }

    public static func select() {
        UISelectionFeedbackGenerator().selectionChanged()
    }

    public static func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }

}
