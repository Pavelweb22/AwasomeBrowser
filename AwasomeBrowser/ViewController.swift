//
//  ViewController.swift
//  AwasomeBrowser
//
//  Created by Павел Яковенко on 25.05.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
   
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePage = "https://www.apple.com/ru/"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        webView.load(request)

        webView.allowsBackForwardNavigationGestures = true // позволяет с помощью свайпа возвращаться вперед или назад
        textField.text = homePage
        textField.delegate = self
        webView.navigationDelegate = self
    }

    @IBAction func backButton(_ sender: Any) {
        if back.isEnabled {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButton(_ sender: Any) {
        if forward.isEnabled {
            webView.goForward()
        }
    }
}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // позволяет вернуть данные из текстовой строки
        let userText = textField.text
        let url = URL(string: userText!)
        let request = URLRequest(url: url!)
        webView.load(request)
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        textField.text = webView.url?.absoluteString
        
        back.isEnabled = webView.canGoBack
        forward.isEnabled = webView.canGoForward
    }
}

