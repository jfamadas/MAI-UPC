%%%%%%%%%%%%%%%%%%%%% 1. Get the whole set of sequences %%%%%%%%%%%%%%%%%%%
% [data,tagset] = loadAll();
% 
% %%%%%%%% 2. Choose Pattern for each label and divide between training and test set%%%%%%%%
 chosen_label = 10;
 % gt = [];
  gt_label = getSamples(data,chosen_label);
  index = ceil(rand()*size(gt_label,1));
  gesture_pattern = {gt_label{index,1} gt_label{index,2}};

%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%3. Compute DTW%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for j = 1:size(data,2)
           disp(j)
           [DTW,DTWM] = multiDTW(gesture_pattern{1,1},data(j).X); 
           [path,optVal] = computePath2(DTWM);
           length_path = sum(sum(path));
           matDTW(j) = optVal/(length_path*1.0);
           exists_class = sum(data(j).Y(:,chosen_label));
           labels(j) = exists_class>0;
   end
  
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%% 4. Find Optimal TH %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:10000
    th(i) = i*0.00001;
    predicted = matDTW<th(i);
    correct_pred = predicted == labels;
    TP  = sum(predicted(labels==1));
    FP = sum(predicted(labels==0));
    TN = sum(predicted(labels==0) == 0);
    FN = sum(predicted(labels ==1) == 0);
    f1(i) = 2*TP/(2*TP+FP+FN);
    precision(i) = +(TP/(TP+FN));
    posNum = TP+FN;
    negNum = TN+FP;
    accuracy(i) = (negNum*TP+posNum*TN)/(negNum*(TP+FN)+posNum*(TN+FP));
  end
