import FlowKit

final class TransferFlowStepResultTransformer { }

extension TransferFlowStepResultTransformer: StepResultTransformer {
    func transform(stepResult: TransferFlowStepResult, with state: TransferFlowState) -> Promise<TransferFlowStep> {
        switch stepResult {
        case .amount(let amount):
            if amount < 100 {
                return .promise(.invalidAmount)
            } else {
                return .promise(.tariffs)
            }
        case .tariffs:
            return .promise(.confirmation)
        case .confirmation(.continue, _):
            return .promise(.success)
        case .confirmation(.editAmount, _):
            return .promise(.amount)
        case .confirmation(.editTariff, _):
            return .promise(.tariffs)
        default:
            return .nothing()
        }
    }
}
