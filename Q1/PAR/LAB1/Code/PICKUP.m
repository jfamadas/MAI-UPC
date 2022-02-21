classdef PICKUP
    properties
        Block % Block to which the PickUp operator will be applied.
        Arm % Arm to which the PickUp opertor will be applied.
        Add % Add List of the Operator.
        Del % Delete list of the Operator.
        Prec % Precondition List of the Operator.
        Id % String Identifier of the Pick Up object.
    end
    methods (Static)
        function obj = PICKUP(block,arm,n) %Function to create a PickUp object.
                obj.Block = block;
                obj.Arm = arm;
                obj.Id = ['PICKUP(' block.Name ',' arm ')'];
                if (strcmp(arm,'LEFT'))
                    obj.Add = {HOLDING(block,arm) USEDCOLSNUM(n-1)};
                    obj.Del = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                    obj.Prec = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                else
                    obj.Add = {HOLDING(block,arm) USEDCOLSNUM(n-1)};
                    obj.Del = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                    obj.Prec = {EMPTYARM(arm) ONTABLE(block) USEDCOLSNUM(n)};
                end
        end
    end
end