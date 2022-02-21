import numpy as np
from time import sleep, time


def main():
    '''
    MAIN FUNCTION OF THE ALGORITHM
    (The game starts printing with a 1.5s delay between actions at trial number 'start_print', by default is 20,000).
    '''
    # Boolean for restarting a new trial
    RESTART = True
    trials = 0
    winners = []
    start_print = 20000

    # Q initialization for each player
    Q1 = 0.01 * np.ones((len(S), len(A), len(A)))  # State x Action_Player1 x Action_Player2
    Q2 = 0.01 * np.ones((len(S), len(A), len(A)))  # State x Action_Player1 x Action_Player2
    Q = {0: Q1, 1: Q2}

    # State-action counter for each player
    C1 = np.zeros((len(S), len(A)))  # Counter of the times in state 's' the other player has done 'a'.
    C2 = np.zeros((len(S), len(A)))  # Counter of the times in state 's' the other player has done 'a'.
    C = {0: C1, 1: C2}

    # State counter
    N = np.zeros(len(S))  # Counter of the times in state 's'

    # Initialize epsilon
    epsilon = 1.0
    discount = 1.0
    alpha = 0.1

    while True:
        if RESTART:  # Restart a new trial
            # State initialization
            s = initial_state
            if trials >= start_print:
                t2 = time() - t1
                # player1_prize = (winners.count(1) + winners.count(3)) / len(winners)
                # player2_prize = (winners.count(2) + winners.count(3)) / len(winners)
                print(s.astype(int))
                sleep(1.5)

            # Find initial state identifier
            for i in range(len(S)):
                if (s == S[i]).all():
                    s_id = i
                    break

            # Set the new epsilon
            epsilon = min(max(np.divide(1000, trials), 0.1), 1)  # Start in 1 and decreases until 0.01
            RESTART = False

        # Pick the action for each player
        a_current = np.zeros(len(players_global))
        for player in players_global:
            a_current[player] = select_action(s_id, player, Q, C, N, epsilon)

        # Perform action
        s_next, r = perform_action(a_current, s_id)

        # Find next state identifier
        for i in range(len(S)):
            if (s_next == S[i]).all():
                s_next_id = i
                break

        # Update parameters
        V1, V2 = evaluate_V(s_next_id, Q, C, N)

        a_current = a_current.astype(int)
        Q1[s_id, a_current[0], a_current[1]] = (1 - alpha) * Q1[s_id, a_current[0], a_current[1]] + alpha * (
                    r[0] + discount * V1)
        Q2[s_id, a_current[0], a_current[1]] = (1 - alpha) * Q2[s_id, a_current[0], a_current[1]] + alpha * (
                    r[1] + discount * V2)
        Q = {0: Q1, 1: Q2}

        C1[s_id, a_current[1]] += 1
        C2[s_id, a_current[0]] += 1
        C = {0: C1, 1: C2}

        N[s_id] += 1

        # New state
        s_id = s_next_id

        # Count episodes of the trial
        # episodes[trials] += 1

        if trials >= start_print:
            print(s_next.astype(int))
            sleep(1.5)


        if (r == 1).any() or (r == both_reward).any():
            RESTART = True
            trials += 1
            if r[0] == both_reward and r[1] == both_reward:
                winners.append(3)  # If both players win
                # print('TRIAL ' + str(trials) + ' END:  BOTH PLAYERS WIN.')
            elif r[0] == 1:
                winners.append(1)
                # print('TRIAL ' + str(trials) + ' END:  PLAYER 1 WINS.')
            elif r[1] == 1:
                winners.append(2)
                # print('TRIAL ' + str(trials) + ' END:  PLAYER 2 WINS.')


def evaluate_V(s_id, Q, C, N):
    '''
    Evaluates the value of a state, used when updating Q

    :param s_id: State ID
    :param Q: Q matrix
    :param C: Counter of the actions performed in this state
    :param N: Counter of the number of times the state has been visited

    :return: Values of the state from the point of view of player1 (V1) and player2 (V2)
    '''

    Q1_state = Q[0][s_id, :, :]  # Get the Q of the required player and for the current state
    Q2_state = Q[1][s_id, :, :]  # Get the Q of the required player and for the current state
    C1_state = C[0][s_id, :]  # Get the C of the required player and for the current state
    C2_state = C[1][s_id, :]  # Get the C of the required player and for the current state
    N_state = np.max((N[s_id], 1e-5))  # This is to avoid errors the first time a state is visited

    V1 = np.zeros(len(idxA))
    V2 = np.zeros(len(idxA))

    for a in idxA:
        V1[a] = np.sum(np.multiply(C1_state / N_state, Q1_state[a, :]))
        V2[a] = np.sum(np.multiply(C2_state / N_state, Q2_state[:, a]))

    return np.max(V1), np.max(V2)


def select_action(s_id, player, Q, C, N, epsilon):
    '''
    Selects the action to perform

    :param s_id: State ID
    :param player: Player that is selecting the action
    :param Q: Q matrix
    :param C: Counter of the actions performed in this state
    :param N: Counter of the number of times the state has been visited
    :param epsilon: Probability of random action

    :return: Action to perform
    '''
    Q_state = Q[player][s_id, :, :]  # Get the Q of the required player and for the current state
    C_state = C[player][s_id, :]  # Get the C of the required player and for the current state
    N_state = np.max((N[s_id], 1e-5))  # This is to avoid errors the first time a state is visited
    a_value = np.zeros(len(idxA))

    if np.random.rand() < epsilon:
        return np.random.choice(idxA)

    for a in idxA:
        if player == 0:  # If it is the first player we check each action of the first dimension
            a_value[a] = np.sum(np.multiply(C_state / N_state, Q_state[a, :]))
        elif player == 1:  # If it is the second player we check each acton of the second dimension
            a_value[a] = np.sum(np.multiply(C_state / N_state, Q_state[:, a]))

    return idxA[np.argmax(a_value)]


def perform_action(actions, state_id):
    '''
    (ENVIRONMENT FUNCTION) Modifies the environment when the actions are performed

    :param actions: Actions performed
    :param state_id: State ID

    :return: Next state, Reward for each agent
    '''

    r = np.zeros(len(players_global))

    # Get players position in the state
    position = np.zeros((len(players_global), 2))
    for player in players_global:
        position[player, :] = np.argwhere(
            S[state_id] == player + 1)  # It is player+1 because the player 0 is represented as a 1 in the map

    # Compute new positions as a function of the action
    position_new = np.zeros((len(players_global), 2))
    for player in players_global:
        a = actions[player]

        # Check the action of the player
        if a == 0:  # Movement = 'UP'
            if position[player, 0] == 0:
                # If in the top, can't move
                position_new[player, :] = position[player, :]
            elif (position[player, :] == [2, 0]).all() or (position[player, :] == [2, 2]).all():
                # If trying to go through a special wall, 50% chance of going through
                if np.random.randint(2) == 0:
                    position_new[player, :] = position[player, :]
                else:
                    position_new[player, :] = position[player, :] + [-1, 0]
            else:
                # Normal movement
                position_new[player, :] = position[player, :] + [-1, 0]

        elif a == 1:  # Movement = 'DOWN'
            if position[player, 0] == np.shape(S)[1] - 1:
                # If in the bottom, can't move
                position_new[player, :] = position[player, :]
            elif (position[player, :] == [1, 0]).all() or (position[player, :] == [1, 2]).all():
                # If trying to go through a special wall, 50% chance of going through
                if np.random.randint(2) == 0:
                    position_new[player, :] = position[player, :]
                else:
                    position_new[player, :] = position[player, :] + [1, 0]
            else:
                # Normal movement
                position_new[player, :] = position[player, :] + [1, 0]

        elif a == 2:  # Movement = 'LEFT'
            if position[player, 1] == 0:
                # If in the leftmost, can't move
                position_new[player, :] = position[player, :]
            else:
                # Normal movement
                position_new[player, :] = position[player, :] + [0, -1]

        elif a == 3:  # Movement = 'RIGHT'
            if position[player, 1] == np.shape(S)[2] - 1:
                # If in the rightmost, can't move
                position_new[player, :] = position[player, :]
            else:
                # Normal movement
                position_new[player, :] = position[player, :] + [0, 1]

        elif a == 4:  # Movement = 'STAY'
            position_new[player, :] = position[player, :]

    if (position_new[0, :] == position_new[1, :]).all() and (position_new[0, :] != [0, 1]).any():
        # If both players try to go to the same position AND IT IS NOT THE REWARD POSITION, only one can do it
        if (position_new[0, :] == position[0, :]).all() or (position_new[0, :] == position[0, :]).all():
            # If one of the conflict players is not trying to move, then the other can not move neither.
            position_new = position
        elif np.random.randint(2) == 0:
            position_new[1, :] = position[1, :]  # Player 0 moves
        else:
            position_new[0, :] = position[0, :]  # Player 1 moves

    # Compute the new state and set the reward
    s_next = np.zeros(S[0].shape)
    for i in range(len(players_global)):
        s_next[int(position_new[i, 0]), int(
            position_new[i, 1])] = i + 1  # It is i+1 because the player 0 is represented by a 1

        if (position_new[i, :] == [0, 1]).all():
            # REWARD POSITION
            r[i] = 1
        else:
            r[i] = step_reward

    if r[0] == r[1] == 1:
        r = both_reward * r

    return s_next, r


def initialize():
    '''
    (ENVIRONMENT FUNCTION) Initializes the environment.

    :return: Initial State, Set of all states, Set of all actions
    '''
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

    return s0, np.array(S, dtype=int), A


both_reward = 5      # Reward that each player receive if BOTH reach the reward square (Tuning).
step_reward = -0.5  # Reward that each player receive in every turn unless they get the reward square.
players_global = [0, 1]

initial_state, S, A = initialize()

# Transforms the actions into numbers
idxA = np.arange(len(A))
t1 = time()

# Run the code
main()

print('final')
