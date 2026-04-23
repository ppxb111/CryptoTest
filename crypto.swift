import Foundation
import CryptoKit

print("开始 CryptoKit 测试...")
print("连续生成 1,000,000 个 SymmetricKey (.bits256)")
let startTime = CFAbsoluteTimeGetCurrent()

var checksum: UInt64 = 0

for i in 1...1_000_000 {
    let key = SymmetricKey(size: .bits256)

    let data = key.withUnsafeBytes { $0.load(as: UInt64.self) }
    checksum ^= data
    if i % 100_000 == 0 {
        print("进度: \(i)/1,000,000 完成")
    }
}

let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

print("测试完成")
print("耗时: \(String(format: "%.2f", timeElapsed)) 秒")
