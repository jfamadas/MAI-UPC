function [gt] = getSamples(data, chosen_class)
    counter = 0;
    for i = 1:size(data,2)
        [gest,ngest]=gestureCuts(data(i).X,data(i).Y);
        if (size(gest,1)>0)
            gesture_matches = find(gest(:,1)==chosen_class);
            for j =1:size(gesture_matches,1)
                initial_frame = gest(gesture_matches(j),2);
                end_frame = gest(gesture_matches(j),3);
                counter = counter+1;
                v = ones(1,80);
                v(4:4:80) = 0;
                gt{counter,1} = data(i).X(initial_frame:end_frame,v==1);
                gt{counter,2} = chosen_class; 
            end
        end
    end
return