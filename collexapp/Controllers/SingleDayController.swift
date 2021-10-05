//
//  SingleDayController.swift
//  collexapp
//
//  Created by Lex on 9/3/21.
//  Copyright © 2021 Lex. All rights reserved.
//

import UIKit
import HorizonCalendar

class SingleDayController: SavedController {

    // MARK: Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Single Day Selection"
        
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self = self else { return }
            
            self.selectedDay = day
            self.calendarView.setContent(self.makeContent())
        }
    }
    
    override func makeContent() -> CalendarViewContent {
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
        
        let selectedDay = self.selectedDay
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
            
            .withInterMonthSpacing(24)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
            
            .withDayItemModelProvider { [weak self] day in
                let textColor: UIColor
                if #available(iOS 13.0, *) {
                    textColor = .label
                } else {
                    textColor = .black
                }
                
                let dayAccessibilityText: String?
                if let date = self?.calendar.date(from: day.components) {
                    dayAccessibilityText = self?.dayDateFormatter.string(from: date)
                } else {
                    dayAccessibilityText = nil
                }
                
                return CalendarItemModel<DayView>(
                    invariantViewProperties: .init(textColor: textColor, isSelectedStyle: day == selectedDay),
                    viewModel: .init(dayText: "\(day.day)", dayAccessibilityText: dayAccessibilityText))
            }
    }
    
    // MARK: Private
    
    private var selectedDay: Day?

}
