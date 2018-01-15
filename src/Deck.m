classdef Deck < handle
    %DECK Class representing a playing cards' deck
    %   Most playing cards' decks (poker, italian, spanish, ...)
    %   have the same underlying structure.
    
    properties(GetAccess = public, SetAccess = private)
        orderVector;
        
        ranks; % Ace, 2, 3, ...
        suits; % Spades, Hearts, ...
        
        nJokers; % Number of jokers
        nCards; % Total number of cards
    end
    
    methods(Access = public)
        
        %% Constructor
        function obj = Deck(file)
            %DECK Main constructor
            %   Example: pokerDeck = Deck('decks/poker.mat');
            
            % Load the file containing the deck's properties
            load(file, 'ranks', 'suits', 'nJokers');
            obj.ranks = ranks; % Ace, Two, Three, ...
            obj.suits = suits; % Spades, Hearts, ...
            obj.nJokers = nJokers; % Number of jokers in this deck
            
            % Count the number of cards
            obj.nCards = numel(obj.ranks)*numel(obj.suits) + obj.nJokers;
            
            % Represent each card by an integer
            [rows, cols] = obj.Dimensions();
            vector = NaN(1, rows*cols); % If jokers are present, nCards ~= rows*cols. Some spaces might be filled by NaNs
            vector(1:obj.nCards) = 1:obj.nCards;
            obj.orderVector = reshape(vector, rows, cols);
        end
        
        %% Accessors
        function rank = GetRank(obj, card_id)
            %GETRANK Returns the rank of the card(s) identified by the
            %card_id(s)
            
            % Use modular arithmetics to identify the rank using only the
            % id
            ranks_index = rem(card_id, numel(obj.ranks));
            ranks_index(ranks_index == 0) = numel(obj.ranks);
            
            % Extract the information
            rank = cell(1, numel(ranks_index));
            for i = 1:numel(ranks_index) % The loop allows card_id to ve a vector
                if card_id(i) <= obj.nCards - obj.nJokers
                    rank{i} = obj.ranks{ranks_index(i)};
                else
                    rank{i} = '';
                end
            end
        end
        
        function suit = GetSuit(obj, card_id)
            %GETSUIT Returns the suit of the card(s) identified by the
            %card_id(s)
            
            % Use modular arithmetics to identify the suit using only the
            % id
            suits_index = ceil(card_id./numel(obj.ranks));
            
            % Extract the information
            suit = cell(1, numel(suits_index));
            for i = 1:numel(suits_index) % The loop allows card_id to ve a vector
                if card_id(i) <= obj.nCards - obj.nJokers
                    suit{i} = obj.suits{suits_index(i)};
                else
                    suit{i} = 'Joker';
                end
            end
        end
        
        function name = GetName(obj, card_id)
            %GETSUIT Returns the name of the card(s) identified by the
            %card_id(s), in a human-readable fashion
            
            rank = obj.GetRank(card_id);
            suit = obj.GetSuit(card_id);

            name = strcat(rank, '-', suit);
        end
        
        %% Methods
        function Shuffle(obj)
            %SHUFFLE Random shuffle
            [rows, cols] = Dimensions(obj);
            vector = NaN(1, rows*cols);
            vector(1:obj.nCards) = randperm(obj.nCards);
            obj.orderVector = reshape(vector, rows, cols);
        end
        
        function [rows, cols] = Dimensions(obj)
            %DIMENSIONS returns the dimensions of the deck
            
            % Ace, two, ... represent the row
            rows = numel(obj.ranks);
            
            % Spades, hearts, ... represent the column
            cols = numel(obj.suits) + ceil(obj.nJokers./numel(obj.ranks));
        end
        
        function [names, ids] = Draw(obj, n)
            %DRAW Draw n cards from the deck
            
            % Avoid trying to draw more cards than the number available
            n_remaining_cards = sum(~isnan(obj.orderVector(:)));
            if n > n_remaining_cards
                error('The number of remaining cards is: %i', n_remaining_cards);
            end
            
            % Draw the cards
            ids = obj.orderVector(1:n); % Card identifier
            names = obj.GetName(ids); % Card human-friendly name
            
            % Remove the drawn cards from the deck
            obj.orderVector(1:n) = NaN; % Remove
            obj.orderVector(1:obj.nCards - n) = obj.orderVector(n+1:end); % Shift
            obj.orderVector(obj.nCards - n + 1:end) = NaN;
        end
        
        %TODO: Deal
        %TODO: Add/Remove
        %TODO: Plot
        
    end
end

