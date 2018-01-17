# Playing cards

## Motivation
Most playing cards' decks (poker, italian, spanish, ...) have the same underlying structure: that of an ordered vector. This makes playing card decks a very good example for teaching object oriented programming.

Provided a card game can be understood as _one deck + some rules_, inheritance can be used to create sub-classes for simple card games.

## Example of use

### Load a deck
```
%% Create poker deck
pDeck = Deck('decks\poker\poker_deck.mat');

%% See properties
disp(pDeck);
```

### Get human-friendly names of cards
Each card is univocally identified by an integer. The GetName(id) method returns the human-friendly name of the card.
```
%% See the name of the cards identified as 4 and 17
pDeck.GetName([4, 17]);

% Returns: {'4-Spades', '4-Hearts'}
```

### Use the deck
```
%% Shuffle the deck
pDeck.Shuffle();

%% Draw the two first cards
drawnCards = pDeck.Draw(2);

% Returns, for instance: {'4-Clubs', 'K-Hearts'}
```
