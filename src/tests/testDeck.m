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

% Check that, by default, the deck is ordered
expected_order = 1:54;
assert(sum(expected_order == pDeck.orderVector(1:54)) == 54);

% Check that only order changes after shuffling
pDeck.Shuffle();
assert(sum(expected_order == pDeck.orderVector(1:54)) < 54);
assert(pDeck.nCards == 54);
assert(pDeck.rCards == 54);

% Check that order and number of remaining cards change after shuffling
pDeck.Draw(2);
pDeck.Shuffle();
assert(pDeck.nCards == 54);
assert(pDeck.rCards == 52);
assert(sum(expected_order(1:52) == pDeck.orderVector(1:52)) < 52);


%% Draw
pDeck = Deck(path_poker);

% Check that it draws as expected
[drawnCards_names, drawCards_ids] = pDeck.Draw(3);

expected_names = {'1-Spades', '2-Spades', '3-Spades'};
expected_ids = [1, 2, 3];
assert(sum(expected_ids == drawCards_ids) == 3);
for i = 1:3
    assert(strcmp(expected_names{i}, drawnCards_names{i}));
end

% Check how the number of cards changes after drawing
assert(pDeck.nCards == 54);
assert(pDeck.rCards == 51);

% Check error messages
try
    pDeck.Draw(100);
    assert(false, 'Exception failed to be thrown');
catch me
    expectedError = 'Deck:Draw:OutOfCards';
    assert(strcmp(me.identifier, expectedError));
end

%% PlotOrder
pDeck = Deck(path_poker);

% Just check if it works
try
    pDeck.PlotOrder();
    close gcf;
catch me
    assert(false, 'Something went wrong with PlotOrder');
end