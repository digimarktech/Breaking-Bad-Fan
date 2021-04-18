//
//  InfinitePageView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/18/21.
//

import SwiftUI

/// A  custom view to represent a `UIPageViewController`.
///
/// This `UIPageViewController` is infinite by default which allows the user to continously swipe in either direction to view the content.
struct InfinitePageView<Page: View>: UIViewControllerRepresentable {
    
    /// The views to display in the `InfinitePageView`.
    var pages: [Page]
    
    /// A two-way binding that  represents the `currentPage`.
    @Binding var currentPage: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let currentViewController = context.coordinator.controllers[currentPage]
        pageViewController.setViewControllers([currentViewController], direction: .forward, animated: false)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, pages: pages)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: InfinitePageView
        var controllers: [UIViewController]

        init(parent: InfinitePageView, pages: [Page]) {
            self.parent = parent
            self.controllers = pages.map({
                let hostingController = UIHostingController(rootView: $0)
                hostingController.view.backgroundColor = .clear
                return hostingController
            })
            let pageControl = UIPageControl.appearance()
            pageControl.currentPageIndicatorTintColor = .black
            pageControl.pageIndicatorTintColor = .lightGray
        }
        
        func presentationIndex(for pageViewController: UIPageViewController) -> Int {
            return parent.currentPage
        }
        
        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return controllers.count
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers[controllers.count-1]
            }
            
            let previousIndex = index - 1
            return controllers[previousIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            let nextIndex = index + 1
            if nextIndex == controllers.count {
                
                return controllers.first
            }
            
            return controllers[nextIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let currentViewController = pageViewController.viewControllers?.first,
                let currentIndex = controllers.firstIndex(of: currentViewController)
            {
                parent.currentPage = currentIndex
            }
        }
    }
}

struct InfinitePageView_Previews: PreviewProvider {
    @State static private var currentPage = 0
    static var previews: some View {
        InfinitePageView(pages: [
            Color(.systemRed),
            Color(.systemGreen),
            Color(.systemBlue)
        ], currentPage: $currentPage)
        
    }
}
