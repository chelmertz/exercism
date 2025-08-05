def find_anagrams(word, candidates):
    lower_ = word.lower()
    hashed_ = sorted(lower_)
    res = []
    for x in candidates:
        lower_x = x.lower()
        if lower_x != lower_ and sorted(lower_x) == hashed_:
            res.append(x)
    return res