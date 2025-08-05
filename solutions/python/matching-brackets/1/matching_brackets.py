def is_paired(input_string):
    opens='[{('
    closes=']})'
    stack = []
    for x in input_string:
        if x in closes:
            if len(stack) == 0:
                return False
            last_opened = stack.pop()
            if closes.index(x) != opens.index(last_opened):
                return False
        elif x in opens:
            stack.append(x)
    return len(stack) == 0