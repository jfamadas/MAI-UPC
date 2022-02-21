classdef SWAP 
    properties
        Block %Block to which the swap operator will be applied.
        Arm %Arm to which the swap operator will be applied. Swap(Left,Block) means that the block swaps from the left arm to the right arm.
        Add %Add List of the operator.
        Del %Delete List of the operator.
        Prec %Precondition List of the operator.
        Id %String Identifier of the swap operator.
    end
    methods (Static)
        function obj = SWAP(arm,block) %Function that creates a swap object.
            obj.Id = ['SWAP(' block.Name ',' arm ')'];
            obj.Arm = arm;
            obj.Block = block;
            if (strcmp(arm,'Left')==1)
                arm2 = 'Right';
                obj.Prec = {EMPTYARM(arm2), HOLDING(block,arm)};
            else
                arm2 = 'Left';
                obj.Prec = {EMPTYARM(arm2), HOLDING(block,arm)};%, LIGHTBLOCK(block)};
            end
            obj.Add = {HOLDING(block,arm2) EMPTYARM(arm)};
            obj.Del = {HOLDING(block,arm) EMPTYARM(arm2)};
        end
    end
end
            