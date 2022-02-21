classdef ON
    properties 
        Top% Top block.
        Bot% Bottom block.
        Id % String Id of the ON object.
    end
    methods (Static)
        function obj = ON(top,bot)
            obj.Top = top;
            obj.Bot = bot;
            obj.Id = ['ON(' top.Name ',' bot.Name '),'];
        end
        function operator = ADD(top,bot,StateVec)
            %Function that obtains the operator candidates for an On
            %predicate.
            operator = {};
            if(sum(strcmp(StateVec.Id,EMPTYARM('Right').Id))==1 && sum(strcmp(StateVec.Id,CLEAR(bot).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(top,'Right').Id))==0)% Check that all the predicates of the add list
                    % of the operator are in the list of predicates of the
                    % state (StateVec) and that none of the predicates of
                    % the delete list are there. If so, accept the operator
                    % as a candidate.
                operator = [operator {STACK(top,bot,'Right')}];
            end
            if (sum(strcmp(StateVec.Id,EMPTYARM('Left').Id))==1 && sum(strcmp(StateVec.Id,CLEAR(bot).Id))==0 && sum(strcmp(StateVec.Id,HOLDING(top,'Left').Id))==0 && top.Weight == 1)
                operator = [operator {STACK(top,bot,'Left')}];
            end
            
        end
        function boolCheck = CHECK(on,Environment,StateVec)
            %Function that checks whether an On object is consistent
            %with the predicate list of the State (StateVec) taking into
            %account the blocks existent in environment
            boolCheck = 0;
            if (sum(strcmp(StateVec.Id,ONTABLE(on.Top).Id))==1) %The top block can't be on table as well.
                boolCheck = 1;
            end
            if (sum(strcmp(StateVec.Id,CLEAR(on.Bot).Id))== 1) %The bottom block can't be clear.
                boolCheck = 1;
            end
            if (on.Top.Weight > on.Bot.Weight) %The bottom block can't be lighter than the top one.
                boolCheck = 1;
            end
            if(sum(strcmp(StateVec.Id,HOLDING(on.Top,'Left').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(on.Top,'Right').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(on.Bot,'Left').Id))==1 || sum(strcmp(StateVec.Id,HOLDING(on.Bot,'Right').Id))==1)
                %None of the blocks can't be held by any arm.
                boolCheck = 1;
            end
            for i = 1:size(Environment,2)
                NewBlock = Environment(i);
                if (sum(strcmp(StateVec.Id,ON(NewBlock,on.Bot).Id))== 1 && strcmp(NewBlock.Name,on.Top.Name)== 0) %There can't be any other block on top of the bottom block
                    boolCheck = 1;
                    break;
                end
                if (sum(strcmp(StateVec.Id,ON(on.Top,NewBlock).Id))== 1 && strcmp(NewBlock.Name,on.Bot.Name)== 0) %There can't be and any other block under the top block.
                    boolCheck = 1;
                    break;
                end
                 
            end
        end
    end
end