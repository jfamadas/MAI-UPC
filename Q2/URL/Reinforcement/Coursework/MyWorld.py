import numpy as np


def initialize():
    field = np.zeros((3, 3))

    # Define initial state
    s0 = field.copy()
    s0[2, 0] = 1  # Player 1
    s0[2, 2] = 2  # Player 2

    # Generate all possible states
    S = []
    for i in range(field.shape[0]):
        for j in range(field.shape[1]):
            s_ = field.copy()
            s_[i, j] = 1
            for k in range(field.shape[0]):
                for l in range(field.shape[1]):
                    s = s_.copy()
                    if s[k, l] != 1:
                        s[k, l] = 2
                        S.append(s)

    # Extra state for when both players reach the PRIZE
    S.append(np.array([[0, 2, 0], [0, 0, 0], [0, 0, 0]]))

    # Actions
    A = ['up', 'down', 'left', 'right', 'stay']

    return s0, np.array(S,dtype=int), A
