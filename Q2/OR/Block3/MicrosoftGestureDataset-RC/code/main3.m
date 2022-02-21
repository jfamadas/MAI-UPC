[data,tagset] = loadAll();

%%%%%%%% 2. Choose Pattern for each label and divide between training and test set%%%%%%%%
chosen_label = 10;
% gt = [];
 gt_label = getSamples(data,chosen_label);
 index = ceil(rand()*size(gt_label,1));
 gesture_pattern = {gt_label{index,1} gt_label{index,2}};




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%3. Compute DTW%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for j = 1:size(data(1:400),2)
         [DTW,DTWM] = multiDTW(gesture_pattern{1,1},data(j).X);  
         matDTW(j) = min(DTWM(end,:));
         exists_class = sum(data(j).Y(:,chosen_label));
         labels(j) = exists_class>0;
 end
     mdl =fitcknn(matDTW',labels);
    %%% K-NN CLASSIFIER%%
    for j = 401:593
        [DTW,DTWM] = multiDTW(gesture_pattern{1,1},data(j).X);  
        matDTWv = min(DTWM(end,:));
        pred_labels(j-400) = predict(mdl,matDTWv);
        exists_class = sum(data(j).Y(:,chosen_label));
        truth_labels(j-400) = exists_class>0;
    end
    acc = mean(pred_labels==truth_labels);
    TP  = sum(pred_labels(truth_labels==1));
    FP = sum(pred_labels(truth_labels==0));
    TN = sum(pred_labels(truth_labels==0) == 0);
    FN = sum(pred_labels(truth_labels ==1) == 0);
    f1 = 2*TP/(2*TP+FP+FN);
    precision = +(TP/(TP+FN));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 4. Find Optimal TH %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:10000
    th(i) = i;
    predicted = matDTW<th(i);
    correct_pred = predicted == labels;
    TP  = sum(predicted(labels==1));
    FP = sum(predicted(labels==0));
    TN = sum(predicted(labels==0) == 0);
    FN = sum(predicted(labels ==1) == 0);
    f1(i) = 2*TP/(2*TP+FP+FN);
    precision(i) = +(TN/(TN+FP));
    accuracy(i) = sum(correct_pred)/size(data,2);
  end