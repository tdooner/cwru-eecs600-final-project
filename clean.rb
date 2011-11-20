class String
    # Returns substrings that begin with the first character.
    # ==== Examples
    #   "test".left_substrings   # => ["t", "te", "tes", "test"]
    def left_substrings
        self.chars.to_a.length.times.map{|x| self[0..x]}
    end
end
clean = "DeIdentified".left_substrings
clean << "--De-Identified--".left_substrings
clean << "-Identified--".left_substrings
clean << "--DeIdentified--".left_substrings
clean << ["Identified"]
clean = clean.flatten.keep_if{|x| x.length > 3}.sort{|x,y| y.length <=> x.length}


f = File.open(ARGV[0]).readlines.to_a
# Remove all series of extended whitespace
f = f.map{|x| x.chomp.gsub( /\s{2,}/, "" ) }
# Remove all things in "clean" array.
f = f.map{|x| clean.inject(x){|x, delete_str| x = x.gsub(delete_str, ""); } }
# Remove all empty lines
f = f.keep_if{|x| not x.chomp.empty?}
puts f.join("||")
