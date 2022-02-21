classdef ONTABLE
    properties 
        Block % Block that is on the table.
        Id % String identifier of the ONTABLE object.
    end
    methods (Static)
        function obj = ONTABLE(block) % Function that creates an ONTABLE object.
            obj.Block = block;
            obj.Id = ['ONTABLE(' block.Name '),'];
        end
        function operator = ADD(block,StateVec,n,maxcolumnsnum)
            %Function that obtains the operator candidates for a On Table
            %predicate.
            operator = {};
            if (sum(strcmp(StateVec.Id,EMPTYARM('Right').Id))==1 && sum(strcmp(StateVec.Id,HOLDING(block,'Right').Id))==0)
                    % Check that all the predicates of the add list
                    % of the operator are in the list of predicates of the
                    % state (StateVec) and that none of the predicates of
                    % the delete list are there. If so, accept the operator
                    % as a candidate.
                operator = [operator {LEAVE(block,'Right',n-1,maxcolumnsnum)}];
            end
            if (sum(strcmp(StateVec.Id,EMPTYARM('Left').Id))==1 && sum(strcmp(StateVec.Id,HOLDING(block,'Left').Id))==0 && block.Weight == 1)
                operator = [operator {LEAVE(block,'Left',n-1,maxcolumnsnum)}];
            end 
        end
        function boolCheck = CHECK(ontable,Environment,StateVec)
            %Function that checks whether an On object is consistent
            %with the predicate list of the State (StateVec) taking into
            %account the blocks existent in environment
            boolCheck = 0;
            if (sum(strcmp(StateVec.Id,HOLDING(ontable.Block,'Left').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(ontable.Block,'Right').Id))==1) % If the block is on tabl, it can't be held by any arm.
                boolCheck = 1;
            end
            for i = 1:size(Environment,2)
                if(sum(strcmp(StateVec.Id,ON(ontable.Block,Environment(i)).Id))==1) %If the block is on table, it can't be on top of any other block.
                    boolCheck = 1;
                    break;
                end
            end    
        end
    end
end