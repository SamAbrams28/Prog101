x <- c(1.0, 3.4, 9.8, 3.9, 7.3, 8.2, 3.8, 2.2, 1.9, 6.9)
# How long are the output vectors for each of the following expressions?
length(x)
# 1 output
atan(x)
# 10 outputs (n)
x^2
# 10 outputs (n)
max(x)
# 1 output

# LETTERS is a built-in vector containing the letters of the alphabet,
# capitalized.
# Use slice indexing to pull out the first 10 letters of the alphabet.
LETTERS[1:10]
# Use non-contiguous indexing to pull out the 5th, 10th, and 15th letters.
LETTERS[c(5, 10, 15)]
# Convert the last ten letters of the alphabet to lower case.
tolower(LETTERS)
