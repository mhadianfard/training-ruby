def stock_picker(prices)

  sorted_prices = prices.clone.sort
  sorted_buy_index = 0
  sorted_sell_index = prices.count - 1

  buy_day, sell_day = 0, 0
  # puts "Original: #{prices.inspect}"
  # puts "Sorted: #{sorted_prices.inspect}"
  until (buy_day < sell_day)
    buy_price = sorted_prices[sorted_buy_index]
    sell_price = sorted_prices[sorted_sell_index]

    buy_day = prices.find_index(buy_price)
    sell_day = prices.find_index(sell_price)
    # puts "Testing buy day #{buy_day} & sell day #{sell_day}"

    if (sorted_buy_index + 1 >= sorted_prices.code_size) || (sorted_sell_index - 1 <= 0)
      puts "no more comparisons"
      # @todo: 1 other loop should be possible
      break
    end

    # Narrow by one day for max profit
    next_best_buy = sorted_prices[sorted_buy_index + 1]
    next_best_sell = sorted_prices[sorted_sell_index - 1]
    profit_at_next_best_buy = (sell_price - next_best_buy)
    profit_at_next_best_sell = (next_best_sell - buy_price)
    if profit_at_next_best_buy > profit_at_next_best_sell
      sorted_buy_index += 1
    else
      sorted_sell_index -= 1
    end
  end

  [buy_day, sell_day]
end

prices = [17,3,6,9,15,8,6,1,10]
days = stock_picker(prices)
profit = prices[days[1]] - prices[days[0]]
puts "Best days to Buy/Sell: #{days.inspect}"
puts "Max profit of $#{profit}."

