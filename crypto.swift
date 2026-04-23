import CryptoKit // 必须导入 CryptoKit
import SwiftUI

@main
struct CryptoTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var status = "准备就绪"
    @State private var progress = 0
    @State private var timeElapsed = ""
    
    // 定义测试次数
    let loopCount = 1_000_000
    
    var body: some View {
        VStack(spacing: 20) {
            Text("CryptoKit 压力测试")
                .font(.largeTitle)
                .bold()
            
            Text(status)
                .font(.headline)
                .foregroundColor(.secondary)
            
            ProgressView(value: Double(progress), total: Double(loopCount))
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
            Text("已生成: \(progress) / \(loopCount)")
                .font(.system(.body, design: .monospaced))
            
            if !timeElapsed.isEmpty {
                Text("耗时: \(timeElapsed)")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            
            Button(action: startStressTest) {
                Text("开始 100 万次生成测试")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(progress > 0 && progress < loopCount)
        }
        .padding()
    }
    
    func startStressTest() {
        status = "正在运行..."
        progress = 0
        timeElapsed = ""
        
        // 使用 DispatchQueue 防止阻塞主线程 UI
        DispatchQueue.global(qos: .userInitiated).async {
            let startTime = CFAbsoluteTimeGetCurrent()
            
            for i in 1...loopCount {
                // 核心代码：连续生成 256 位密钥
                _ = SymmetricKey(size: .bits256)
                
                // 每 10000 次更新一下 UI (避免 UI 刷新太频繁导致卡顿)
                if i % 10000 == 0 {
                    DispatchQueue.main.async {
                        self.progress = i
                    }
                }
            }
            
            let endTime = CFAbsoluteTimeGetCurrent()
            let total = endTime - startTime
            
            DispatchQueue.main.async {
                self.progress = loopCount
                self.status = "测试完成"
                self.timeElapsed = String(format: "%.4f 秒", total)
            }
        }
    }
}
