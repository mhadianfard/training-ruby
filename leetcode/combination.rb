require 'set'

# Class to hold combination locks, keep track of moves and parents, and calculate next moves.
#
class Combination

  attr_reader :code, :moves, :parent

  def initialize(code, parent = nil, moves = 0)
    @parent = parent
    @code = code
    @moves = moves
  end

  # Will compute and return a set of new Combinations representing all possible next moves.
  # @return Array
  #
  def get_next_moves
    children = Array.new()
    new_move = @moves + 1
    @code.length.times  do |i|
      move_up = Combination.new(next_code(i, :up), self, new_move)
      move_down = Combination.new(next_code(i, :down), self, new_move)
      children.push(move_down, move_up)
    end
    children
  end

  # Convenience method to quickly check the target
  # @param target string
  # @return boolean
  #
  def is?(target)
    @code == target
  end

  # Debug method to print current code and next moves
  #
  def print
    next_codes = get_next_moves.map {|c| c.code}
    puts "Code: #{@code}\t Next Moves: #{next_codes.inspect}"
  end

  # Will return an array of Combinations starting with the current,
  # all the way to the starting combination
  # @return Array
  #
  def get_playback
    playback = Array.new
    parent = self
    until parent.nil? do
      playback.push parent
      parent = parent.parent
    end
    playback
  end

  private
    # Helper method to provide one next move, given digit to change and direction to change
    # @param digit_to_change int, index of the digit in current code to change
    # @param direction_to_change :up|:down, decrease or increase digit (and supporting wrapping)
    # @return string, new code
    #
    def next_code(digit_to_change, direction_to_change)
      new_code = @code.clone
      old_digit = new_code[digit_to_change].to_i
      if direction_to_change == :up
        # rotate up to decrease
        new_digit = (old_digit == 0 ? 9 : old_digit - 1)
      end

      if direction_to_change == :down
        # rotate down to increase
        new_digit = (old_digit == 9 ? 0 : old_digit + 1)
      end

      new_code[digit_to_change] = new_digit.to_s
      new_code
    end
end

# Will start at the target towards "0000", and test a maximum of moves_limit
# if blocked by deadends, will return true, otherwise false.
# @param deadends Set<string>
# @param target string
# @param moves_limit int
# @return boolean
#
def is_target_blocked?(deadends, target, moves_limit)
  queue = Queue.new
  checked = Set.new
  start = Combination.new(target)
  queue << start
  moves = 0

  until queue.empty? || moves > moves_limit do
    current_combination = queue.pop
    moves = current_combination.moves
    if checked.include? current_combination.code
      # puts "Already checked #{current_combination.code}"

    elsif deadends.include? current_combination.code
      # puts "Hit a deadend at #{current_combination.code}"

    elsif current_combination.is? "0000"
      return false

    else
      checked.add current_combination.code
      current_combination.get_next_moves.each {|combo| queue << combo}
    end
  end
  queue.empty?
end

# Will iterate through all possible combinations starting at "0000" towards the target
# using a BFS algorithm. Will first check multiple moves in the reverse direction (from target to start)
# to check for possible deadends.
#
# @param deadends Array<string>
# @param target string
# @return int -1 if no path to target, otherwise number of moves to target
#
def open_lock(deadends, target)
  queue = Queue.new
  checked = Set.new
  deadends = deadends.to_s
  start = Combination.new("0000")
  queue << start

  unless is_target_blocked?(deadends, target, 1)
    # puts "Target: #{target}"
    # puts "Deadends: #{deadends.inspect}"
    # puts
    until queue.empty? do
      current_combination = queue.pop
      # puts "Checking code: #{current_combination.code}"

      if checked.include? current_combination.code
        # puts "Already checked #{current_combination.code}"

      elsif deadends.include? current_combination.code
        # puts "Hit a deadend at #{current_combination.code}"

      elsif current_combination.is? target
        # playback = current_combination.get_playback.reverse
        # puts "Found combination in #{current_combination.moves} moves."
        # puts "\tPlayback: #{(playback.map {|c| c.code}).join(' -> ')}"
        # puts
        return current_combination.moves

      else
        checked.add current_combination.code
        current_combination.get_next_moves.each {|combo| queue << combo}
      end
    end
  end
  # puts "Can't crack the code!"
  # puts
  -1
end

# open_lock(["0201","0101","0102","1212","2002"], "0202")
# open_lock([8888], "0009")
# open_lock(["8887","8889","8878","8898","8788","8988","7888","9888"], "8888")
# open_lock(["0000"], "8888")
# open_lock(["2663","7363","2311","8379","9055","0185","5250","2534","4197","1940","4551","5166","9904","1259","3930","7429","6117","1842","6544","1976","8241","8433","9614","9561","1928","4730","8660","7036","9008","2132","1479","6943","5551","3975","3396","7423","3404","8428","3100","7309","8641","4014","3851","2194","7987","6565","6721","8584","7144","4587","9259","2664","9882","6002","7244","3472","1667","2084","3993","9940","2734","3075","6145","7772","3284","9481","2194","3990","6307","8925","3358","3980","6850","4361","3102","0541","7084","1767","3693","4513","7833","5181","5954","1283","0414","3661","2615","0114","5616","6679","2475","7564","7184","4389","7860","3964","3752","4476","9622","8862","7185","3709","9115","8230","0255","8755","4522","4186","2664","8789","6132","8375","1850","9777","3624","1025","5941","1604","0954","0641","7910","7807","0483","3616","1411","4587","5386","2258","0807","7362","7559","1397","2166","3574","6056","2702","4258","9914","3546","3367","1551","5791","5763","2354","4568","4316","5755","4516","0278","7413","2906","6914","0392","6854","6336","3559","9596","7579","1445","1646","7395","4359","8801","5487","4553","1144","2754","8675","3082","6056","9580","2903","6941","2944","9160","3749","3064","4588","9808","2539","6390","6953","0051","9972","5911","0671","4810","3896","9486","8412","9286","4067","7349","9938","0658","7719","6027","2519","9184","0033","5781","5867","1083","3262","7983","5441","7150","8944","8543","0252","2296","4780","0060","1408","4610","8213","5111","9817","1465","0787","5145","5780","0398","4089","5997","1837","2693","3769","5491","8576","1435","4610","3575","7778","7882","0995","2530","4080","9121","2883","2288","4038","4696","3088","9969","0319","3695","9068","2996","3706","4514","1997","9416","8519","7593","6144","9204","7276","7454","1911","7241","6848","3437","2575","0182","1035","9870","3126","1444","7577","7107","6910","1786","3762","6602","4867","8127","7572","3987","2933","1822","7119","2904","2312","8021","4550","5577","9951","8320","1090","3133","9068","5969","0148","4633","2948","3739","2202","8040","1023","0743","0785","7750","1560","5829","4422","8909","0425","5764","1665","8510","7969","1355","2054","7243","9763","6613","9556","3754","5298","7151","4893","0650","3156","8354","5402","5330","2933","7797","5211","9946","6790","6243","6905","1043","5964","9680","9755","4808","4042","5408","5167","0102","3095","3845","2437","4943","6936","5030","5733","0928","4513","7545","2749","8234","5167","6357","6007","4828","2466","8060","9782","6031","0396","5459","6029","8861","8122","2535","2950","4952","2103","9757","9438","0120","6905","4829","2355","3907","8874","1844","9059","3222","9640","9944","9949","3588","6333","8251","0870","5978","7930","5092","3374","0878","0812","2045","0371","3388","1263","0707","8966","5442","7232","6605","0994","3081","7716","1164","8876","1361","8576","2624","1209","5535","6751","9688","0944","7083","9524","9135","6330","7792","1964","7744","0367","1488","4668","7170","6968","0798","6768","0303","1811","5270","3137","0502","2239","3746","8902","1447","6048","3822","6007","8217","0430","1387","3421","9992","0204","1422","4696","1302","3162","5705","3889","5290","7864","3786","9341","3398","6967","3572","6372","6602","1678","4576","1164","2920","6201","7129","7526","6517","4989","2443","1106","5277","7082","3656","5817","8557","0457","2939","2257","3986","7223","2786","0423","7834","0571","0189","1861","2937","8069","6279","5643","2147","1970","7323","4413"], "1064")
# open_lock(["8430","5911","4486","7174","9772","0731","9550","3449","4437","3837","1870","5798","9583","9512","5686","5131","0736","3051","2141","2989","6368","2004","1012","8736","0363","3589","8568","6457","3467","1967","1055","6637","1951","0575","4603","2606","0710","4169","7009","6554","6128","2876","8151","4423","0727","8130","3571","4801","8968","6084","3156","3087","0594","9811","3902","4690","6468","2743","8560","9064","4231","6056","2551","8556","2541","5460","5657","1151","5123","3521","2200","9333","9685","4871","9138","5807","2191","2601","1792","3470","9096","0185","0367","6862","1757","6904","4485","7973","7201","2571","3829","0868","4632","6975","2026","3463","2341","4647","3680","3282","3761","4410","3397","3357","4038","6505","1655","3812","3558","4759","1112","8836","5348","9113","1627","3249","0537","4227","7952","8855","3592","2054","3175","6665","4088","9959","3809","7379","6949","8063","3686","8078","0925","5167","2075","4665","2628","8242","9831","1397","5547","9449","6512","6083","9682","2215","3236","2457","6211","5536","8674","2647","9752","5433","0186","5904","1526","5347","1387","3153","1353","6069","9995","9496","0003","3400","1692","6870","4445","3063","0708","3278","6961","3063","0249","0375","1763","1804","4695","6493","7573","9977","1108","0856","5631","4799","4164","0844","2600","1785","1587","4510","9012","7497","4923","2560","0338","3839","5624","1980","1514","4634","2855","7012","3626","7032","6145","5663","4395","0724","4711","1573","6904","8100","2649","3890","8110","8067","1460","0186","6098","2459","6991","9372","8539","8418","7944","0499","9276","1525","1281","8738","5054","7869","6599","8018","7530","2327","3681","5248","4291","7300","8854","2591","8744","3052","6369","3669","8501","8455","5726","1211","8793","6889","9315","0738","6805","5980","7485","2333","0140","4708","9558","9026","4349","5978","4989","5238","3217","5938","9660","5858","2118","7657","5896","3195","8997","1688","2863","9356","4208","5438","2642","4138","7466","6154","0926","2556","9574","4497","9633","0585","1390","5093","3047","0430","7482","0750","6229","8714","4765","0941","1780","6262","0925","5631","9167","0885","7713","5576","3775","9652","0733","7467","5301","9365","7978","4736","3309","6965","4703","5897","8460","9619","0572","6297","7701","7554","8669","5426","6474","5540","5038","3880","1657","7574","1108","4369","7782","9742","5301","6984","3158","2869","0599","2147","6962","9722","3597","9015","3115","9051","8269","6967","5392","4401","6579","8997","8933","9297","0151","8820","3297","6723","1755","1163","8896","7122","4859","5504","0857","4682","8177","8702","9167","9410","0130","2789","7492","5938","3012","4137","3414","2245","4292","6945","5446","6614","2977","8640","9242","7603","8349","9420","0538","4222","0599","8459","8738","4764","6717","7575","5965","9816","9975","4994","2612","0344","6450","9088","4898","6379","4127","1574","9044","0434","5928","6679","1753","8940","7563","0545","4575","6407","6213","8327","3978","9187","2996","1956","8819","9591","7802","4747","9094","0179","0806","2509","4026","4850","2495","3945","4994","5971","3401","0218","6584","7688","6138","7047","9456","0173","1406","1564","3055","8725","4835","4737","6279","5291","0145","0002","1263","9518","1251","8224","6779","4113","8680","2946","1685","2057","9520","4099","7785","1134","2152","4719","6038","1599","6750","9273","7755","3134","2345","8208","5750","5850","2019","0350","9013","6911","6095","6843","3157","9049","0801","2739","9691","3511"], "2248")