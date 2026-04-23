import Foundation
import CryptoKit
import XCTest

final class CryptoLoadTest: XCTestCase {
    func testGenerateMillionKeys() {
        print("🚀 开始压力测试：连续生成 1,000,000 个 SymmetricKey...")
        let startTime = CFAbsoluteTimeGetCurrent()
        for i in 1...1_000_000 {
            let key = SymmetricKey(size: .bits256)
            if i % 100_000 == 0 {
                print("🔄 已生成 \(i) 个密钥... (示例密钥哈希: \(key.hashValue))")
            }
        }
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        // 打印最终结果
        print("✅ 测试完成！")
        print("⏱️ 总耗时: \(timeElapsed) 秒")
        print("⚡ 平均速度: \(1_000_000 / timeElapsed) 次/秒")
    }
}
CryptoLoadTest.defaultTestSuite.run()
