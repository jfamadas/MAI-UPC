classdef STATE
    properties
        Predicates %List of predicate objects of the state
        Id %List of predicate identifiers of the state
        OrdId %String identifier of the state that consists on the concatenation of all predicate id's in alphabetical order.
    end
    methods (Static)
        function obj = STATE(Pred) %Function that creates a State object.
            %Pred is a cell that contains all current predicate classes of the
            %state. 
            obj.Predicates = Pred;
            obj.Id = {};
            n = size(Pred,2);
            for i = 1:n
                obj.Id =[obj.Id {Pred{i}.Id}];
            end
            cell = sort(obj.Id);
            obj.OrdId = [cell{:}];
        end
    end
end