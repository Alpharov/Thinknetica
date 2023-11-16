alphabet_vowels = {}

vowels = ["a", "e", "i", "o", "u"]
("a".."z").each_with_index do |letter, index|
	if vowels.include?(letter)
		alphabet_vowels[letter] = index + 1
	end
end

puts alphabet_vowels