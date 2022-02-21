function [add,del,prec] = COMPARE(pred,AddList,DelList,PrecList)
%Function usedto check if the predicate pred belongs to the Add List, Delete
%List or Precondition List of an operator
%add, del, prec are booleans.
            add = 0;
            del = 0;
            prec = 0;
            for k = 1:size(AddList,2); 
                if (strcmp(pred,AddList{k}.Id))%Compare the string Id of each element in the AddList and the predicate pred
                    add = 1;
                    break;
                end
            end
            for k = 1:size(DelList,2)
                if strcmp(pred,DelList{k}.Id)%Compare the string Id of each element in the Delete List and the predicate pred
                    del = 1;
                    break;
                end
            end
            for k = 1:size(PrecList,2)
                if strcmp(pred,PrecList{k}.Id)%Compare the string Id of each element in the Precondition List and the predicate pred
                    prec = 1;
                    break;
                end
            end
return;            
end