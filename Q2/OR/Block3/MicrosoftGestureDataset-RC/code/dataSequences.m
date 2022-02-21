classdef dataSequences
    properties
        X
        Y
    end
    methods
      function obj = dataSequences(x,y)
         if nargin > 0
            obj.X = x;
            obj.Y = y;
         end
      end
    end
end