% Tests parameters
path_poker = '../decks/poker/poker_deck.mat';
path_spanish = '../decks/spanish/spanish_deck.mat';
path_dutch = '../decks/dutch/dutch_deck.mat';

% Constructors
%% Construct poker deck
pDeck = Deck(path_poker);

assert(pDeck.nCards == 54);
assert(pDeck.nJokers == 2);

%% Construct spanish deck
sDeck = Deck(path_spanish);

assert(sDeck.nCards == 40);
assert(sDeck.nJokers == 0);

%% Construct dutch deck
dDeck = Deck(path_dutch);

assert(dDeck.nCards == 54);
assert(dDeck.nJokers == 2);

% Methods
%% Shuffle
pDeck = Deck(path_poker);

expected_order = 1:54;
assert(sum(expected_order == pDeck.orderVector(1:54)) == 54);

pDeck.Shuffle();
assert(sum(expected_order == pDeck.orderVector(1:54)) < 54);

%% Draw
pDeck = Deck(path_poker);
[drawnCards_names, drawCards_ids] = pDeck.Draw(3);

expected_names = {'1-Spades', '2-Spades', '3-Spades'};
expected_ids = [1, 2, 3];

assert(sum(expected_ids == drawCards_ids) == 3);
for i = 1:3
    assert(strcmp(expected_names{i}, drawnCards_names{i}));
end
