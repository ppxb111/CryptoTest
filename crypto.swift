import Foundation
import CryptoKit

public func runCrypto() -> String {
    let startTime = CFAbsoluteTimeGetCurrent()
    var checksum: UInt64 = 0
    for i in 1...1_000_000 {
        let key = SymmetricKey(size: .bits256)
        let data = key.withUnsafeBytes { $0.load(as: UInt64.self) }
        checksum ^= data
    }
    let elapsed = CFAbsoluteTimeGetCurrent() - startTime
    let result = "完成 100万 密钥生成\n耗时: \(String(format: "%.2f", elapsed)) 秒"
    NSLog(result)
    return result
}
