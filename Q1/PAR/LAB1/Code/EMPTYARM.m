classdef EMPTYARM
    properties 
        Arm %Defines which arm is empty.
        Id %String Identifier of the object.
    end
    methods (Static)
        function obj = EMPTYARM(arm) %Function that returns an EMPTYARM object, obj.
            obj.Arm = arm;
            obj.Id = ['EMPTYARM(' arm '),'];
        end
        function operator = ADD(arm,Environment,StateVec,n,maxcolumnsnum)
        % Function that generates all the possible operators to reach an EmptyArm predicate taking into account the blocks and their state(Statevec).
        % operator is a cell of operator objects.
            k = size(Environment,2); 
            operator = {};
            if  (strcmp(arm,'Left')==1)  %Check which arm is empty.
                arm2= 'Right';
            else
                arm2 = 'Left';
            end
            if (strcmp(arm,'Right')==1)
                for i = 1:k
                    if(sum(strcmp(StateVec.Id,ONTABLE(Environment(i)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0) %Check that all the predicates on the
                        %add list of the operator exist in StateVec and
                        %that none of he delete list does. If so, accept
                        %the operatr as a candidate.
                        operator = [operator {LEAVE(Environment(i),arm,n-1,maxcolumnsnum)}];
                    end
                    for j = 1:k
                        if (j~=i && sum(strcmp(StateVec.Id,ON(Environment(i),Environment(j)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,CLEAR(Environment(j)).Id))==0)
                            operator = [operator {STACK(Environment(i),Environment(j),arm)}];
                        end
                    end
                    if (sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm2).Id)==1) &&  sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && Environment(i).Weight == 1)
                        operator = [operator {SWAP(arm,Environment(i))}];
                    end
                end
            end
            if (strcmp(arm,'Left')==1) %Do the same if it is the left arm, taking into account it can only lift vblocks of weight ==1.
                for i = 1:k
                    if(sum(strcmp(StateVec.Id,ONTABLE(Environment(i)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 && Environment(i).Weight == 1)
                        operator = [operator {LEAVE(Environment(i),arm,n-1,maxcolumnsnum)}];
                    end
                    for j = 1:k
                        if (j~=i && sum(strcmp(StateVec.Id,ON(Environment(i),Environment(j)).Id))==1 && sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,CLEAR(Environment(j)).Id))==0 && Environment(i).Weight == 1)
                            operator = [operator {STACK(Environment(i),Environment(j),arm)}];
                        end
                    end
                    if (sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm2).Id)==1) &&  sum(strcmp(StateVec.Id,HOLDING(Environment(i),arm).Id))==0 &&  sum(strcmp(StateVec.Id,EMPTYARM(arm2).Id))==0 && Environment(i).Weight == 1)
                        operator = [operator {SWAP(arm,Environment(i))}];
                    end
                end
            end
        end
        
        function boolCheck = CHECK(emptyarm,Environment,StateVec)
            %Function that checks whether an emptyarm predicate is
            %consistent with the predicate list of StateVec, taking into
            %account the blocks existant in environment.
            boolCheck = 0;
            for i = 1:size(Environment,2)
                if (sum(strcmp(StateVec.Id,HOLDING(Environment(i),emptyarm.Arm).Id))== 1) %If the arm is holding something, it can't be empty.
                    boolCheck = 1;
                    break;
                end
            end
        end
    end
end