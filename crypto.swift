import Foundation
import CryptoKit

@main
struct CryptoLoadTestApp {
    static func main() {
        print("开始 CryptoKit 测试...")
        print("任务：连续生成 1,000,000 个 SymmetricKey (.bits256)")

        let startTime = CFAbsoluteTimeGetCurrent()

        var checksum: UInt64 = 0


        for i in 1...1_000_000 {
            let key = SymmetricKey(size: .bits256)

            let data = key.withUnsafeBytes { $0.load(as: UInt64.self) }
            checksum ^= data

            if i % 200_000 == 0 {
                print("已生成 \(i) 个密钥...")
            }
        }

        // 记录结束时间
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

        print("--------------------------------")
        print("测试完成！")
        print("总耗时: \(String(format: "%.2f", timeElapsed)) 秒")
        print("--------------------------------")
    }
}
