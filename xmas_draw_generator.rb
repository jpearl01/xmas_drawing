#!/usr/bin/env ruby

names = %w(josh verity andrew mary nina rj emily brad)

@last_year = Hash[ 
              "josh"   => "brad", 
              "verity" => "mary", 
              "andrew" => "nina",  
              "mary"   => "rj", 
              "nina"   => "emily", 
              "rj"     => "josh", 
              "emily"  => "andrew", 
              "brad"   => "verity"
             ]


#Returns an array of one (yes, I know ridiculous)
def match_name(original_name_array, current_buyer)

  name_array = original_name_array.map do |e| e.dup end

  if name_array.size == 1 
    if name_array[0] == current_buyer
      return false
    elsif (name_array[0] != current_buyer) && (name_array[0] != @last_year[current_buyer])
      return name_array
    elsif (name_array[0] == @last_year[current_buyer])
      return false
    end
  end
    
  if (name_array.size == 2) 
      if (name_array.count(current_buyer) == 1)
        name_array.delete(current_buyer)
        if name_array[0] != @last_year[current_buyer]
          return name_array
        else
          return false
        end
      else
        return name_array.sample(1)
      end
  end

  if name_array.size > 2
    (0..200).each do |n|
      samp = name_array.sample(1)
      if (samp[0] == current_buyer) || (samp[0] == @last_year[current_buyer])
        next
      else
        return samp
        last
      end
    end
  end

end



@done = 0
@new_names= Hash.new


(1..100).each do |c|

  @pool = names.map do |e| e.dup end
  break if @done == 1
  
  names.each do |n|
    match = match_name(@pool, n)
    if (match == false) 
      break
    end
    if match.nil?
      puts "match is nil"
      puts n
      puts @pool.size
      break
    end
    @new_names[n] = match[0]
    @pool.delete(match[0])
    if  @pool.size ==0 
      @done = 1
    end
  end 
end

@new_names.each_key do |p|
  reciever = @new_names[p]
  puts p + " has " + reciever + " to buy for this year."
  puts '|||'
end
