classdef BLOCK
    properties
        Name %String identifier of the block
        Weight %Weight of the block
    end
    methods (Static)
        function obj = BLOCK(str) %function to create a block object. str should be of the type x***. Then obj.Name = x and obj.weight = 3
            obj.Name = str(1);
            obj.Weight = size(str(2:end),2);
        end
    end
end
        