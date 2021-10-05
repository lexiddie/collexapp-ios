//
//  SavedController.swift
//  collexapp
//
//  Created by Lex on 15/8/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import HorizonCalendar

class SavedController: UIViewController {

    
    required init() {
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    lazy var calendarView = CalendarView(initialContent: makeContent())
    lazy var calendar = Calendar.current
    lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.locale = calendar.locale
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    var width: CGFloat = UIScreen.main.bounds.width
    
//    private var calendarSelection: CalendarSelection?
    private var selectedDay: Day?
    
    private var selectedIndex: Int = 0

    private let numberFormatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialView()
    }

    private func initialView() {
//        let view = SavedView(frame: self.view.frame)
//        self.view = view
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.left.right.lessThanOrEqualTo(self.view)
            make.height.equalTo(330)
        }
    }
    
    
    func makeContent() -> CalendarViewContent {
      fatalError("Must be implemented by a subclass.")
    }
}


final class DayLabel: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        var textColor: UIColor
        var backgroundColor: UIColor
    }
    
    struct ViewModel: Equatable {
        let day: Day
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()
        let width = (UIScreen.main.bounds.width / 14) - 5
        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = width
        return label
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        view.text = "\(viewModel.day.day)"
    }

}

final class DayRangeIndicatorView: UIView {
    
    // MARK: Lifecycle
    
    init(indicatorColor: UIColor) {
        self.indicatorColor = indicatorColor
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(indicatorColor.cgColor)
        
        if traitCollection.layoutDirection == .rightToLeft {
            transform = .init(scaleX: -1, y: 1)
        } else {
            transform = .identity
        }
        
        // Get frames of day rows in the range
        var dayRowFrames = [CGRect]()
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            if dayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = dayFrame.minY
                dayRowFrames.append(dayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
            }
        }
        
        // Draw rounded rectangles for each day row
        for dayRowFrame in dayRowFrames {
            let cornerRadius = dayRowFrame.height / 2
            let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: cornerRadius)
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
    
    // MARK: Private
    
    private let indicatorColor: UIColor
    
}

// MARK: CalendarItemViewRepresentable

extension DayRangeIndicatorView: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        var indicatorColor = UIColor.blue.withAlphaComponent(0.15)
    }
    
    struct ViewModel: Equatable {
        let framesOfDaysToHighlight: [CGRect]
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> DayRangeIndicatorView
    {
        DayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = viewModel.framesOfDaysToHighlight
    }
    
}

final class DayView: UIView {
    
    // MARK: Lifecycle
    
    init(invariantViewProperties: InvariantViewProperties) {
        dayLabel = UILabel()
        dayLabel.font = invariantViewProperties.font
        dayLabel.textAlignment = invariantViewProperties.textAlignment
        dayLabel.textColor = invariantViewProperties.textColor
        
        super.init(frame: .zero)
        
        addSubview(dayLabel)
        
        layer.borderColor = invariantViewProperties.selectedColor.cgColor
        layer.borderWidth = invariantViewProperties.isSelectedStyle ? 2 : 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    var dayText: String {
        get { dayLabel.text ?? "" }
        set { dayLabel.text = newValue }
    }
    
    var dayAccessibilityText: String?
    
    var isHighlighted = false {
        didSet {
            updateHighlightIndicator()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.frame = bounds
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
    
    // MARK: Private
    
    private let dayLabel: UILabel
    
    private func updateHighlightIndicator() {
        backgroundColor = isHighlighted ? UIColor.black.withAlphaComponent(0.1) : .clear
    }
    
}

// MARK: UIAccessibility

extension DayView {
    
    override var isAccessibilityElement: Bool {
        get { true }
        set { }
    }
    
    override var accessibilityLabel: String? {
        get { dayAccessibilityText ?? dayText }
        set { }
    }
    
}

// MARK: CalendarItemViewRepresentable

extension DayView: CalendarItemViewRepresentable {
    
    struct InvariantViewProperties: Hashable {
        var font = UIFont.systemFont(ofSize: 18)
        var textAlignment = NSTextAlignment.center
        var textColor: UIColor
        var isSelectedStyle: Bool
        var selectedColor = UIColor.blue
    }
    
    struct ViewModel: Equatable {
        let dayText: String
        let dayAccessibilityText: String?
    }
    
    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> DayView {
        DayView(invariantViewProperties: invariantViewProperties)
    }
    
    static func setViewModel(_ viewModel: ViewModel, on view: DayView) {
        view.dayText = viewModel.dayText
        view.dayAccessibilityText = viewModel.dayAccessibilityText
    }
    
}
