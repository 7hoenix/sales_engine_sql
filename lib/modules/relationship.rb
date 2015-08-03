module Relationships
  @relationships = {}

  def items()
    self
  end


  ## dumped methods
  # def paid_invoices
  #   Set.new(invoices) - Set.new(zero_revenue_invoices)
  # end

  # def zero_revenue_invoices
  #   transactions_by_invoice_id.each_with_object([]) do |(key, values)
  #failures|
  #     failures << key if values.all? {|charge| charge.result == "failed"}
  #   end
  # end

  # invoice_items_for(date).reject do |ii|
  #   zero_revenue_invoices.include?(ii.invoice_id)
  # end


  ### dumped tests
  #   def test_it_knows_invoices_with_zero_succeeding_transactions
  #   merchant = @se.merchant_repository.find_by_id(34)
  #   transactions = merchant.transactions

  #   expected = [13]
  #   actual = merchant.zero_revenue_invoices

  #   assert_equal expected, actual
  # end



end