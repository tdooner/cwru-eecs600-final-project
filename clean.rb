require 'json'

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


f = File.open(ARGV[0],"rb").read()
f = f.encode("UTF-8",{:undef=>:replace,:replace=>" "}).split("\n").to_a
# Remove all series of extended whitespace
f = f.map{|x| x.chomp.gsub( /\s{2,}/, "" ) }
# Remove all extended equal signs, because those don't separate anything meaningful.
f = f.map{|x| x.gsub( /(=){2,}/, "") }
# Remove all things in "clean" array.
f = f.map{|x| clean.inject(x){|x, delete_str| x = x.gsub(delete_str, ""); } }
# Clean any words which begin with a dash (since it's an artifact of the cleaning)
f = f.map{|x| x.gsub( /-([a-zA-Z]+)/, '\1' ) }
# Remove all empty lines
f = f.keep_if{|x| not x.chomp.empty?}

# Now let's find the lines that separate the file into sections.
sections = []
f = f.map do |x| 
    if x.match(/^[A-Z ]+$/)
        sections << [x,[]]
    else
        begin
            sections.last.last << x
        rescue
        end
    end
end

puts Hash[sections].to_json
