function [maxcolumns,Environment,initialstate,goalstate] = ReadFile(fileID,readlines)
%Function that reads the input file ad extracts the maxcolumns value,
%the blocks used and it's properties, and the initial and goal state of the
%configuration.
for i = 1:readlines
    fgetl(fileID);
end
line = fgetl(fileID); %Read the first Line
linesplit = strsplit(line, '=');
maxcolumns = str2num(linesplit{2}); %Select the number on the right of the sign "=" which is the maxcolsnum value.

%%% BLOCKS %%%
line = fgetl(fileID); %Read the second line.
linesplit = strsplit(line, {'=',',',';'}); %Separate each block.
for i = 2:size(linesplit,2)-1 %Read all components after the equal sign.
    Environment(i-1) = BLOCK(linesplit{i});
end

%%% INITIAL STATE%%%
line = fgetl(fileID);
line = strsplit(line,'=');
line = line{2}(1:end-1);
expression = '([^)]+)'; %Divide the line in predicates. To idetify a predicate, use a regular expresion that searches for all "(text)" combinations.
reg = regexp(line,expression);
initialstatepred{1} = line(reg(1):reg(2)-1);
for i = 2:size(reg,2)-1
  initialstatepred{i} = line(reg(i)+1:reg(i+1)-1);
end
initialstatepred{size(reg,2)} = line(reg(end)+1:end);
initialstate ={};
usedcolsnum = 0;
for i = 1: size(initialstatepred,2)
    predicvec = strsplit(initialstatepred{i},'('); %Divide a predicate between it's class and the blocks and arms to which applies
    predic = predicvec{1}; %Type of predicate
    blockarm = predicvec{2}(1:end-1); %Blocks and arms to which it applies.
    
    switch predic %Check the class of th predicate 
        case 'ON-TABLE'
            usedcolsnum = usedcolsnum +1; %Each on-table statement implies that a column is being used.
            for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm) == 1) %Compare the block/arm identifiers within the environment vector, and the name of the block/arm stored in blockarm.
                    initialstate{i} = ONTABLE(Environment(k));
                    break;
                end
            end
        
        case 'EMPTY-ARM'
            if (strcmp(blockarm,'L') == 1)
                initialstate{i} = EMPTYARM('Left');
            else
                initialstate{i} = EMPTYARM('Right');
            end 
        
        case 'ON'
             for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm(1)) == 1)
                    top = Environment(k);
                end
                if(strcmp(Environment(k).Name,blockarm(3)) == 1)
                    bot = Environment(k);
                end
             end
             initialstate{i} = ON(top,bot);
             
        case 'CLEAR'
            for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm) == 1)
                    initialstate{i} = CLEAR(Environment(k));
                    break;
                end
            end
         
        case 'HOLDING'
            for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm(1)) == 1)
                    if (strcmp(blockarm(3),'L')==1)
                        initialstate{i} = HOLDING(Environment(k),'Left');
                    else
                        initialstate{i} = HOLDING(Environment(k),'Right');
                    end
                    break;
                end
            end
    end
end
initialstate{end+1} = USEDCOLSNUM(usedcolsnum); 



%%% GOAL STATE %%%%
%In the same way that for the initial state.
line = fgetl(fileID);
line = strsplit(line,'=');
line = line{2}(1:end-1);
reg = regexp(line,expression);
goalstatepred{1} = line(reg(1):reg(2)-1);
for i = 2:size(reg,2)-1
  goalstatepred{i} = line(reg(i)+1:reg(i+1)-1);
end
goalstatepred{size(reg,2)} = line(reg(end)+1:end);
goalstate ={};
usedcolsnum = 0;
for i = 1: size(goalstatepred,2)
    predicvec = strsplit(goalstatepred{i},'(');
    predic = predicvec{1};
    blockarm = predicvec{2}(1:end-1);
    
    switch predic
        case 'ON-TABLE'
            usedcolsnum = usedcolsnum +1;
            for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm) == 1)
                    goalstate{i} = ONTABLE(Environment(k));
                    break;
                end
            end
        
        case 'EMPTY-ARM'
            if (strcmp(blockarm,'L') == 1)
                goalstate{i} = EMPTYARM('Left');
            else
                goalstate{i} = EMPTYARM('Right');
            end 
        
        case 'ON'
             for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm(1)) == 1)
                    top = Environment(k);
                end
                if(strcmp(Environment(k).Name,blockarm(3)) == 1)
                    bot = Environment(k);
                end
             end
             goalstate{i} = ON(top,bot);
             
        case 'CLEAR'
            for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm) == 1)
                    goalstate{i} = CLEAR(Environment(k));
                    break;
                end
            end
         
        case 'HOLDING'
            for k = 1:size(Environment,2)
                if(strcmp(Environment(k).Name,blockarm(1)) == 1)
                    if (strcmp(blockarm(3),'L')==1)
                        goalstate{i} = HOLDING(Environment(k),'Left');
                    else
                        goalstate{i} = HOLDING(Environment(k),'Right');
                    end
                    break;
                end
            end
    end
end
goalstate{end+1} = USEDCOLSNUM(usedcolsnum);
end

