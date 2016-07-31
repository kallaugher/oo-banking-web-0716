class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    self.sender = sender
    self.receiver = receiver
    self.status = "pending"
    self.amount = amount
  end

  def valid?
    new_sender_balance = self.sender.balance - self.amount
    self.sender.valid? && self.receiver.valid? && new_sender_balance > 0
  end

  def execute_transaction

    if self.status == "pending" && self.valid?
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.status = "reversed"
      sender.balance += self.amount
      receiver.balance -= self.amount
    end
  end
end
