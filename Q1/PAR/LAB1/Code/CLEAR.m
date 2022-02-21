classdef CLEAR
    properties
        Block %Block Identifier
        Id %String Identifier of a clear predicate.
    end
    methods (Static)
        function obj = CLEAR(Block) % Function that creates a Clear object.
            if nargin==1 %Check that there is an input to the function.
                obj.Block = Block;
                obj.Id = ['CLEAR(' Block.Name '),']; %Identifier of the type CLEAR(X)
            else
                error('Invalid Block')
            end
        return
        end
        function operator = ADD(cclear,Environment,StateVec) 
        % Function that generates all the possible operators to reach the cclear predicate (which is a Clear object) taking into account the blocks and their state(Statevec).
        % operator is a cell of operator objects.
            k = size(Environment,2);
            operator = {};
            for i = 1:k
                TopBlock = Environment(i);
                %Check that all predicates on the Add List of the oprator are on the StateVector and
                % that none of the statements of the delete list of the
                % operator are one the StateVec. Do it for all blocks in the
                % environment
                if (TopBlock.Name ~= cclear.Block.Name && TopBlock.Weight <= cclear.Block.Weight &&  sum(strcmp(StateVec.Id,HOLDING(TopBlock,'Right').Id))==1 &&  sum(strcmp(StateVec.Id,EMPTYARM('Right').Id))==0 &&  sum(strcmp(StateVec.Id,ON(TopBlock,cclear.Block).Id))==0)

                    operator = [operator {UNSTACK(Environment(i),cclear.Block,'Right')}]; % The clear predicate is due to the action of an Unstack operator done with the right arm.
                end
                if (TopBlock.Name ~= cclear.Block.Name && TopBlock.Weight == 1 && sum(strcmp(StateVec.Id,HOLDING(TopBlock,'Left').Id))==1 &&  sum(strcmp(StateVec.Id,EMPTYARM('Left').Id))==0 &&  sum(strcmp(StateVec.Id,ON(TopBlock,cclear.Block).Id))==0)
                        operator = [operator {UNSTACK(Environment(i),cclear.Block,'Left')}]; % The clear predicate is due to the action of an Unstack operator done with the left arm.
                end
            end
        end
        function boolCheck = CHECK(cclear,Environment,StateVec)
            % Function that checks if there are inconsistencies between a
            % clear object (cclear) and the rest of the predicates of the
            % state vector.
            boolCheck = 0;
            for i = 1:size(Environment,2)
                if(sum(strcmp(StateVec.Id,ON(Environment(i),cclear.Block).Id))== 1) %If there is an ON(x,Clear.Block) predicate in the state, then the block can't be clear.
                    boolCheck = 1;
                    break;
                end
            end
        end
    end
end
