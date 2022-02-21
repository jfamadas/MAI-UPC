classdef STACK
    properties
        Top %Top block to which the stack operator will be applied.
        Bot %Bottom block to which the stack operator will be applied.
        Arm %Arm to which the stack operator will be applied.
        Add %Add list of the operator.
        Del %Delete list of the operator.
        Prec %Precondition list of the operator.
        Id %String Identifier of the Stack object.
    end
    methods (Static)
        function obj = STACK(top,bot,arm) %Function that creates an stack object.
                obj.Id = ['STACK(' top.Name ',' bot.Name ',' arm ')'];
                obj.Top = top;
                obj.Bot = bot;
                obj.Arm = arm;
                obj.Add = {ON(top,bot) EMPTYARM(arm)};
                obj.Del = {CLEAR(bot) HOLDING(top,arm)};
                obj.Prec = {CLEAR(bot) HOLDING(top,arm)};% HEAVY(bot,top)};

        end
    end
end