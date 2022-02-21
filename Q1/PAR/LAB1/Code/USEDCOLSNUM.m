classdef USEDCOLSNUM
    properties
        Num %Number of columns of the predicate.
        Id %String Identifier of the Used Columns Number Predicate.
    end
    methods  (Static)
        function obj = USEDCOLSNUM(num)
            obj.Num = num;
            obj.Id = ['USEDCOLSNUM' num2str(num)];
        end
    end
end
           