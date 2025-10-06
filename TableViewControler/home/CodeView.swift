import Foundation

protocol CodeView {
    func setupCosntraints()
    func setupAddView()
    func setupView()
}

extension CodeView {
    func setupView() {
        setupAddView()
        setupCosntraints()
    }
}
