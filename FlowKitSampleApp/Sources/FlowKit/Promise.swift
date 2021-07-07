public struct Promise<Output> {
    public typealias Completion = (Output) -> Void

    private let work: (@escaping Completion) -> Void

    public init(work: @escaping (@escaping Completion) -> Void) {
        self.work = work
    }

    public static func promise(_ value: Output) -> Self {
        return Self { $0(value) }
    }

    public static func promise(_ handler: @escaping (@escaping (Output) -> Void) -> Void) -> Self {
        return Self { completion in handler { completion($0) } }
    }

    public static func nothing() -> Self {
        return Self { _ in }
    }

    public func then<NewOutput>(_ builder: @escaping (Output) -> Promise<NewOutput>) -> Promise<NewOutput> {
        return Promise<NewOutput> { completion in
            complete { builder($0).complete(using: completion) }
        }
    }

    public func complete(using completion: @escaping Completion) {
        work { completion($0) }
    }
}