import Foundation

extension String {
    func toCurrency(locale: Locale = Locale.current, currencySymbol: String? = nil) -> String? {
        guard let doubleValue = Double(self) else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        if let symbol = currencySymbol {
            formatter.currencySymbol = symbol
        }
        
        return formatter.string(from: NSNumber(value: doubleValue))
    }
}
