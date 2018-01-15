# Playing cards

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
