classdef HOLDING
    properties
        Block % Block Identifier
        Arm % Defines the arm holding Block
        Id % String Identifier of a Holding object.
    end
    methods (Static)
        function obj = HOLDING(block,arm)
            obj.Block = block;
            obj.Arm = arm;
            obj.Id = ['HOLDING(' block.Name ',' arm '),'];
        end
        function operator = ADD(block,arm,Environment,StateVec,n,maxcolumnsnum)
            %Function that obtains the operator candidates for a Holding
            %predicate.
            k = size(Environment,2); 
            operator = {};
            if  (strcmp(arm,'Left') == 1) % The preconditions depend on the arm holding a block.
                arm2= 'Right';
                            
                if(n<maxcolumnsnum && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ONTABLE(block).Id))==0 && block.Weight == 1) % Check that all the predicates of the add list
                    % of the operator are in the list of predicates of the
                    % state (StateVec) and that none of the predicates of
                    % the delete list are there. If so, accept the operator
                    % as a candidate.
                    operator = [operator {PICKUP(block,arm,n+1)}];
                end
                if(sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(block,arm2).Id))==0 && sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && block.Weight == 1)
                    operator = [operator {SWAP(arm2,block)}];
                end
                
                for i = 1:k
                    BottomBlock = Environment(i);
                    if (strcmp(Environment(i).Name,block.Name)==0 && block.Weight == 1 && sum(strcmp(StateVec.Id,CLEAR(BottomBlock).Id))==1 && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ON(block,BottomBlock).Id))==0)
                        operator = [operator {UNSTACK(block,BottomBlock,arm)}];
                    end
                end
            else %Do the same for the right arm.
                arm2 = 'Left';
                 if(n<maxcolumnsnum && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ONTABLE(block).Id))==0)
                    operator = [operator {PICKUP(block,arm,n+1)}];
                end
                if(sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(block,arm2).Id))==0 && sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && block.Weight == 1)
                    operator = [operator {SWAP(arm2,block)}];
                end
                
                for i = 1:k
                    BottomBlock = Environment(i);
                    if (strcmp(Environment(i).Name,block.Name)==0 && block.Weight <= BottomBlock.Weight && sum(strcmp(StateVec.Id,CLEAR(BottomBlock).Id))==1 && sum(strcmp(StateVec.Id,EMPTYARM(arm).Id))==0 && sum(strcmp(StateVec.Id,ON(block,BottomBlock).Id))==0)
                        operator = [operator {UNSTACK(block,BottomBlock,arm)}];
                    end
                end
            end

            
        end
        function boolCheck = CHECK(holding,Environment,StateVec)
            %Function that checks whether a holding object is consistent
            %with the predicate list of the State (StateVec) taking into
            %account the blocks existent in environment
            boolCheck = 0;
            if (sum(strcmp(StateVec.Id,CLEAR(holding.Block).Id))==0) %If the block is not clear, it can't be held by an arm.
                boolCheck = 1;
            end
            if (strcmp(holding.Arm, 'Left') == 1 && holding.Block.Weight > 1)
                boolCheck = 1;
            end
            if (sum(strcmp(StateVec.Id,EMPTYARM(holding.Arm).Id))==1) %An arm can't be holding a block and be empty at the same time
                boolCheck = 1;
            end
            for i = 1: size(Environment,2)
                if (sum(strcmp(StateVec.Id,ON(Environment(i),holding.Block).Id))==1 || sum(strcmp(StateVec.Id,ON(holding.Block,Environment(i)).Id))==1) %A block being held can't be on any other block or have a block on top.
                    boolCheck = 1;
                    break;
                end
                if (strcmp(Environment(i).Name,holding.Block.Name)==0 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),holding.Arm).Id))==1) %The arm can't be holding any other block.
                    boolCheck = 1;
                end
            end
        end
    end
end
