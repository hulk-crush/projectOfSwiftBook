import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "ru.swiftbook",  attributes: .concurrent)

let timer = DispatchSource.makeTimerSource(queue: queue)

timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))
timer.setEventHandler {
    print("Hello!")
}

timer.setCancelHandler {
    print("Timer is cancelled")
}

timer.resume()

