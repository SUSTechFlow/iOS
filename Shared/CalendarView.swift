//
//  CalendarView.swift
//  SUSTech Flow
//
//  Created by Alan on 2021/1/19.
//

import SwiftUI
import KVKCalendar
import EventKit

struct CalendarDisplayView: UIViewRepresentable {
    
    
    var token: String?
    var selectDate: Date?
    var toggleDetail: (Event) -> ()
    
    public init(token: String?, selectDate: Date?, toggleDetail: @escaping (Event) -> ()) {
        self.token = token
        self.selectDate = selectDate
        self.toggleDetail = toggleDetail
    }
    
    private var calendar: CalendarView = {
        var style = Style()
        if UIDevice.current.userInterfaceIdiom == .phone {
            style.month.isHiddenSeparator = true
            style.timeline.widthTime = 40
            style.timeline.offsetTimeX = 2
            style.timeline.offsetLineLeft = 2
        } else {
            style.timeline.widthEventViewer = 500
        }
        style.followInSystemTheme = true
        style.timeline.offsetTimeY = 80
        style.timeline.offsetEvent = 3
        style.timeline.currentLineHourWidth = 40
        style.allDay.isPinned = true
        style.startWeekDay = .monday
        style.timeSystem = .twelve
        style.headerScroll.heightHeaderWeek = 80
        
        style.locale = Locale.current
        style.timezone = TimeZone.current
        
        return CalendarView(frame: UIScreen.main.bounds, style: style)
    }()
    
    func makeUIView(context: UIViewRepresentableContext<CalendarDisplayView>) -> CalendarView {
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        calendar.scrollTo(self.selectDate ?? Date())
        calendar.reloadData()
        return calendar
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<CalendarDisplayView>) {
        
    }
    
    func makeCoordinator() -> CalendarDisplayView.Coordinator {
        Coordinator(self, token: token, selectDate: selectDate, toggleDetail: toggleDetail)
    }
    
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        func eventsForCalendar(systemEvents: [EKEvent]) -> [Event] {
            return []
        }
        
        private var view: CalendarDisplayView
        
        var token: String?
        var selectDate: Date?
        var toggleDetail: (Event) -> ()
        private var events = [Event]()
        @State var open = true
        
        init(_ view: CalendarDisplayView, token: String?, selectDate: Date?, toggleDetail: @escaping (Event) -> ()) {
            self.view = view
            self.token = token
            self.selectDate = selectDate
            self.toggleDetail = toggleDetail
            super.init()
            
            loadEvents { (events) in
                self.events = events
                self.view.calendar.reloadData()
            }
        }
        
        func eventsForCalendar() -> [Event] {
            return events
        }
        
        func didSelectDate(_ date: Date?, type: CalendarType, frame: CGRect?) {
            selectDate = date ?? Date()
            loadEvents { (events) in
                self.events = events
                self.view.calendar.reloadData()
            }
        }
        
        func didSelectEvent(_ event: Event, type: CalendarType, frame: CGRect?) {
            switch type {
            case .day:
                toggleDetail(event)
                break
            default:
                break
            }
        }
        
        func loadEvents(completion: ([Event]) -> Void) {
            
            let events = [Event]()
            
            //            let response = [] // TODO: fetch data
            //
            //            for (idx, item) in response.enumerated() {
            //
            //                var event = Event()
            //                // ...
            //                events.append(event)
            //            }
            completion(events)
        }
    }
    
}

extension UIViewController {
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
struct MyCalendarView: View {
    var body: some View {
        CalendarDisplayView(token: "x", selectDate: Date()) { (x) in
            print(x)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarView()
    }
}
