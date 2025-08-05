def get_rounds(number):
    """

     :param number: int - current round number.
     :return: list - current round and the two that follow.
    """

    return [number, number + 1, number + 2]


def concatenate_rounds(rounds_1, rounds_2):
    """

    :param rounds_1: list - first rounds played.
    :param rounds_2: list - second set of rounds played.
    :return: list - all rounds played.
    """

    return [*rounds_1, *rounds_2]


def list_contains_round(rounds, number):
    """

    :param rounds: list - rounds played.
    :param number: int - round number.
    :return:  bool - was the round played?
    """

    return number in rounds


def card_average(hand):
    """

    :param hand: list - cards in hand.
    :return:  float - average value of the cards in the hand.
    """

    return sum(hand)/len(hand)


def approx_average_is_average(hand):
    """

    :param hand: list - cards in hand.
    :return: bool - is approximate average the same as true average?
    """

    assert len(hand) & 1 # per instructions, hand should contain odd number of cards
    avg = card_average(hand)
    return avg == sorted(hand)[int(len(hand)/2)] or avg == (hand[0] + hand[-1])/2


def average_even_is_average_odd(hand):
    """

    :param hand: list - cards in hand.
    :return: bool - are even and odd averages equal?
    """

    odds = []
    even = []
    for index, value in enumerate(hand):
        if index & 1:
            odds.append(value)
        else:
            even.append(value)
    return card_average(odds) == card_average(even)


def maybe_double_last(hand):
    """

    :param hand: list - cards in hand.
    :return: list - hand with Jacks (if present) value doubled.
    """

    last = hand[-1]
    return hand if last != 11 else [*hand[0:-1], 22]
