function [endflag,Environment,plans,visitedstates,totalvisitedstates,sinitial,sgoal]=NLPRegression(inputfile,outputfile,readlines)
%Function that finds the plan to go from the initial state to the goal
%state.
%End flag identifies the desired plan within plans matrix (that stores all
%plans consdered).
%Visited states stores all accepted states by the algorithm
totalvisitedstates = 0;
fileID = fopen(inputfile,'r');
fileID2 = fopen(outputfile,'w');
[maxcolumnsnum,Environment,initialstate,finalstate]=ReadFile(fileID,readlines);
fclose(fileID);
k = size(Environment,2);
endflag = 0;
sfinal = STATE(finalstate); %Generate the initial and goal state objects.
sinitial = STATE(initialstate);
sgoal = sfinal;
visitedstates = {sfinal}; %Cell that contains all accepted states.
oldstates = {sfinal};%Cell that contains the states generated during the last step.
newstates = {}; %Cell that will contain the states generated in the new step.
oldplanM = {'Final State'};
newplanM = {};
plans = {'Final State'}; %Plan{i} stores the plan to go from visitedstates{i} to sgoal.

while (endflag==0 && size(oldstates,2)>0) %Iterate until the initial tate is found or no other candidates are available.
    for d = 1:size(oldstates,2)
        sfinal = oldstates{d}; %select the candidate state
        for w = 1:size(sfinal.Predicates,2)
            if(strcmp(class(sfinal.Predicates{w}),'USEDCOLSNUM')==1)
                n = sfinal.Predicates{w}.Num;
            end
        end
        predsize = size(sfinal.Predicates,2);
        opused = {};
        oldplan = oldplanM{d};

        for j = 1:predsize %store all possible operators that could have led to this stat (predicate by predicate).
            pred = sfinal.Predicates{j};
            oppred = {};
            switch class(pred)
                
                case 'CLEAR'
                    %disp('CLEAR')
                    operators = pred.ADD(pred,Environment,sfinal);
                case 'ON'
                    %disp('ON')
                    operators = pred.ADD(pred.Top,pred.Bot,sfinal);
                case 'ONTABLE'
                    %disp('ONTABLE')
                    operators = pred.ADD(pred.Block,sfinal,n,maxcolumnsnum);
                case 'EMPTYARM'
                    %disp('EA')
                    operators = pred.ADD(pred.Arm,Environment,sfinal,n,maxcolumnsnum);
               case 'HOLDING'
                    operators = pred.ADD(pred.Block,pred.Arm,Environment,sfinal,n,maxcolumnsnum);
                case 'HEAVY'
                    operators = {};
                case 'USEDCOLSNUM'
                    operators = {};
                case 'LIGHTBLOCK'
                    operators = {};
            end
            
            for i = 1:size(operators,2) %check that no operators are tried more than one time.
                if (size(opused,2)>0)
                    for h = 1:size(opused,2)
                        if (strcmp(operators{i}.Id,opused)== 0)
                            opused = [opused {operators{i}.Id}]; %vector that stores the operators that have already been tried for this iteration
                            oppred = [oppred operators(i)];
                        end
                    end
                else
                    opused = [opused {operators{i}.Id}];
                    oppred = [oppred operators(i)];
                end
                
            end
            for i = 1:size(oppred,2) %For each operator check if it leads to a repeated state or an state that can't exist.
                totalvisitedstates = totalvisitedstates+1;
                operator = oppred{i};
                newpredicates={};
                flag = 0;
                regfun = {};
                for q  = 1:size(sfinal.Predicates,2) %Generate the regression functions.
                    predcandidate = sfinal.Id{q};
                    [addbool,delbool,precbool] = COMPARE(predcandidate,operator.Add,operator.Del,operator.Prec);
                    if (addbool == 1)
                        continue;
                    elseif (delbool ==1)
                        flag = 1; %Discard the state if it has a predicate that also exists in the delete list of the operator.
                        break;
                    elseif (precbool == 0)
                        regfun = [regfun {sfinal.Predicates{q}}];
                    end
                end
                
                if (flag == 0) %If flag == 1 the state is discarded
                    regfun = [regfun operator.Prec];
                    trialState = STATE(regfun); %Generate the new state using the preconditions of the operator and the regression functions.
                    for z = 1:size(regfun,2) %Check predicate by predicate whether there are inconsistencies between such predicate and the rest of predicates of the state.
                        if (strcmp(class(regfun{z}),'LIGHTBLOCK') == 0  && strcmp(class(regfun{z}),'HEAVY') == 0 && strcmp(class(regfun{z}),'USEDCOLSNUM') == 0)
                            flag = regfun{z}.CHECK(regfun{z},Environment,trialState);
                            if (flag == 1)
                                break;%If a predicate has inconsistencies stop the iteration and discard the state.
                            end
                        end
                        if(strcmp(class(regfun{z}),'USEDCOLSNUM') == 1)
                            if(regfun{z}.Num>maxcolumnsnum)
                                flag = 1;
                                break;
                            end
                        end
                    end
                end
                
                if (flag == 0) %if the state is not discarded
                    acceptbool = 1;
                    
                    for v = 1:size(visitedstates,2) %Check whether the new state was already visited by the algorithm by comparing the OrdId of the new state with the OrdId of the 
                        %other states.
                        if (strcmp(visitedstates{v}.OrdId,trialState.OrdId)==1)
                            acceptbool = 0;
                            break;
                        end
                    end
                    if (acceptbool == 1) %If the state is accepted, compare it with the initial state.
                        if (strcmp(sinitial.OrdId,trialState.OrdId)==1)
                            endflag = size(visitedstates,2)+1; %If the new state is equal to the initial state, set endflag = position of the state in the cell visitedstates.
                        end
                        %updte all variables
                        newstates = [newstates {trialState}];
                        visitedstates = [visitedstates {trialState}];
                        newplan = [oldplan {operator.Id}];
                        newplanM = [newplanM {newplan}];
                        plans = [plans {newplan}];
                    else%If the state is not accepted because it was repeated, write the state on the file.
                        fprintf(fileID2,'%s\n',trialState.OrdId);
                        fprintf(fileID2,'%s\n','Repeated State');
                        fprintf(fileID2,'%s\n','-------------------------');
                    end
                else %If the state is discarded because it has inconsistencies write the state on the file.
                        fprintf(fileID2,'%s\n',trialState.OrdId);
                        fprintf(fileID2,'%s\n','Contradictory Predicates');
                        fprintf(fileID2,'%s\n','-------------------------');
                end
                
            end
        end
    end
    oldstates = newstates;
    newstates = {};
    oldplanM = newplanM;
    newplanM = {};
end
%Generate the output file respecting the constraints.
if (endflag == 0)
    disp('UNSOLVABLE PROBLEM')
    fclose(fileID2);
    text = fileread(outputfile);
    fileID3 = fopen(outputfile,'w');
    fprintf(fileID3,'%s\n','UNSOLVABLE PROBLEM');
    fprintf(fileID3,'%i\n',size(visitedstates,2)); 
    fprintf(fileID3,'%s\n','-------------------------');
    dlmwrite(outputfile, text, '-append','delimiter', '');
    fclose(fileID3);
else
    fclose(fileID2);
    text = fileread(outputfile);
    fileID3 = fopen(outputfile,'w');
    plan = fliplr(plans{endflag});
    planv = [];
    fprintf(fileID3,'%i\n', size(plan,2)-1);
    fprintf(fileID3,'%i\n',size(visitedstates,2));
    for i = 1:size(plan,2)-2
        planv = [planv plan{i} ', '];
    end
    planv = [planv plan{end-1}];
    fprintf(fileID3,'%s\n',planv);
    fprintf(fileID3,'%s\n','-------------------------');
    dlmwrite(outputfile, text, '-append','delimiter', '');
    fclose(fileID3);
end
end