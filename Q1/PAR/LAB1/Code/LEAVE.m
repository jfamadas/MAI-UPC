classdef LEAVE 
    properties
        Block % Defines the block to which te operator Leave is applied.
        Arm % Defines the arm to which the operator leave is applied.
        Add % Add List of the operator.
        Del % Delete List of the operator.
        Prec % Precandidates List of the operator.
        Id % String Id of a Leave object.
    end
    methods (Static)
        function obj = LEAVE(block,arm,n,maxcolumnsnum) %Function to create a Leave object.
            if (n<=maxcolumnsnum) %Check whether the number of columns is correct. If it isn't don't create the object.
                obj.Block = block;
                obj.Arm = arm;
                obj.Add = {ONTABLE(block) EMPTYARM(arm) USEDCOLSNUM(n+1)};
                obj.Del = {HOLDING(block,arm) USEDCOLSNUM(n)};
                obj.Prec = {HOLDING(block,arm) USEDCOLSNUM(n)};
                obj.Id = ['LEAVE(' block.Name ',' arm ')'];
            else
                error('Too many columns')
            end
        end
    end
   end