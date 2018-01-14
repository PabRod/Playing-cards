classdef Deck < handle
    %DECK Class representing a playing cards' deck
    %   Most playing cards' decks (poker, italian, spanish, ...)
    %   have the same underlying structure.
    
    properties
        orderVector; % TODO: Move to private
        
        ranks;
        suits;
        nJokers;
        
        nCards;
    end
    
    methods
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
            obj.orderVector = 1:obj.nCards;
        end
        
        %% Accessors
        function rank = GetRank(obj, card_id)
            ranks_index = rem(card_id, numel(obj.ranks));
            ranks_index(ranks_index == 0) = numel(obj.ranks);
            
            rank = obj.ranks{ranks_index};
        end
        
        function suit = GetSuit(obj, card_id)
            suits_index = ceil(card_id./numel(obj.ranks));
            suit = obj.suits{suits_index};
        end
        
        function name = GetName(obj, card_id)            
            rank = obj.GetRank(card_id);
            suit = obj.GetSuit(card_id);

            name = strcat(rank, '-', suit);
        end
        
        %% Methods
        function Shuffle(obj)
            %SHUFFLE Random shuffle
            obj.orderVector = randperm(obj.nCards);
        end
        
        %TODO: Draw
        %TODO: Deal
        %TODO: Add/Remove
        %TODO: Plot
        
    end
end

