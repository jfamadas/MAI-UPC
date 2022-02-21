classdef UNSTACK
    properties
        Top %Top block to which the unstack operator applies.
        Bot %Bottom block to which the unstack operator applies.
        Arm %Arm to which the unstack operator applies.
        Add %Add List of the operator.
        Del %Delete List of the operator.
        Prec %Precondition List of the operator.
        Id %String Identifier of the operator.
    end
    methods (Static)
        function obj = UNSTACK(top,bot,arm) %Function that creates an unstack object.
                obj.Id = ['UNSTACK(' top.Name ',' bot.Name ',' arm ')'];
                obj.Top = top;
                obj.Bot = bot;
                obj.Arm = arm;
                if (strcmp(arm,'Left')==1)
                    obj.Add = {HOLDING(top,arm) CLEAR(bot)};
                    obj.Del = {EMPTYARM(arm) ON(top,bot)};
                    obj.Prec = {EMPTYARM(arm) ON(top,bot) CLEAR(top)};
                else
                    obj.Add = {HOLDING(top,arm) CLEAR(bot)};
                    obj.Del = {EMPTYARM(arm) ON(top,bot)};
                    obj.Prec = {EMPTYARM(arm) ON(top,bot) CLEAR(top)};
                end
        end
    end
end