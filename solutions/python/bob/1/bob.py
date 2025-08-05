import re

def response(hey_bob):
    if hey_bob.strip() == '':
        return 'Fine. Be that way!'

    is_question = hey_bob.strip().endswith('?')
    at_least_one_char = re.match(r'.*[a-zA-Z].*', hey_bob)
    
    if hey_bob == hey_bob.upper() and at_least_one_char:
        if is_question:
            return 'Calm down, I know what I\'m doing!'
        return 'Whoa, chill out!'

    if is_question:
        return 'Sure.'

    return 'Whatever.'