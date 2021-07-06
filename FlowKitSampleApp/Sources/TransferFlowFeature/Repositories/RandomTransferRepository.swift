import Dispatch

final class RandomTransferRepository { }

extension RandomTransferRepository: TransferRepository {
    func createTransfer(country: Country, amount: Int, tariff: Tariff, completion: @escaping (Transfer) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let transfer = Transfer(identifier: Int.random(in: 0..<1000),
                                    country: country,
                                    amount: amount,
                                    tariff: tariff)
            completion(transfer)
        }
    }
}
