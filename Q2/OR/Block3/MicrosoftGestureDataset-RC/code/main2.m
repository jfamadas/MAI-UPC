%%
%%%%%%%%%%%%%%%%%%%%% 1. Get the whole set of sequences %%%%%%%%%%%%%%%%%%%
[data,tagset] = loadAll();

%%%%%%%% 2. Choose Pattern for each label and divide between training and test set%%%%%%%%
chosen_class=[1:12];
gt = [];
for i = 1:12
    chosen_label = chosen_class(i);
    gt_label = getSamples(data,chosen_label);
    %gt_train{i} = gt_label;
    %gt_test{i} = gt_label;
    gt = [gt; gt_label];
    index = ceil(rand()*size(gt_label,1));
    gesture_pattern{i} = {gt_label{index,1} gt_label{index,2}};
end
% 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%3. Compute DTW%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
finalcost = zeros(12,size(gt,1));
for i = 1:12
  for j = 1:size(gt,1)
          [finalcostv,MT] = multiDTW(gesture_pattern{i}{1,1},gt{j,1});   
          [path] = computePath(MT);
          finalcost(i,j) = finalcostv/sum(sum(path));
  end
  disp(['DTW Computed for Pattern' num2str(i)]);
end
    
%%   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 4. Fit k-nn %%%%%%%%%%%%%%%%%%%%%%%%%%%

gt_labels = cell2mat(gt(:,2))';
train_finalcost = [];
test_finalcost = [];
train_label = [];
test_label = [];
for i = 1:12
    current = finalcost(:,gt_labels == i);
    current_labels = gt_labels(gt_labels == i);
    training_instances = round(size(current,2)*0.9);
    train_finalcost = [train_finalcost current(:,1:training_instances)];
    train_label =[train_label current_labels(1:training_instances)];
    test_finalcost = [test_finalcost current(:,training_instances+1:end)];
    test_label = [test_label current_labels(:,training_instances+1:end)];
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%% K-NN classifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mdl =fitcknn(train_finalcost',train_label,'NumNeighbors',1,'Standardize',1);
pred_labels = predict(mdl,test_finalcost');
acc_knn = mean(pred_labels'==test_label);
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%% Threshold Classifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:12
   for j = 1:10000
       th = j*0.0001;
       predicted = finalcost(i,:)<th;
       correct_pred = predicted == (gt_labels==i);
       TP  = sum(predicted(gt_labels==i));
       FP = sum(predicted(gt_labels~=i));
       TN = sum(predicted(gt_labels~=i) == 0);
       FN = sum(predicted(gt_labels ==i) == 0);
       f1(i,j) = 2*TP/(2*TP+FP+FN);
       precision(i,j) = (TP/(TP+FP));
       posNum = TP+FN;
       negNum = TN+FP;
       accuracy(i,j) = (TP+TN)/(TP+FN+TN+FP);
       if j == 2527 && i == 2
           TP
           FP
           TN
           FN
       end
   end
end

%% Section 5: Single gesture Independent binary classifiers. Find Optimal TH for each Gesture.
gt_labels = cell2mat(gt(:,2))';
precision = zeros(12,6244);
accuracy = zeros(12,6244);
accuracy2 = zeros(12,6244);
threshold = zeros(12,6244);
myScore = zeros(12,6244);
f1 = zeros(12,6244);
accuracy_mov=zeros(1,12);
threshold_mov=zeros(1,12);
for i = 1:12
    meanCost = mean(finalcost(i,:));
    minCost = min(finalcost(i,:));
    delta_th = (meanCost-minCost)/10000;
   for j = 1:10000
       th = j*0.001;
       predicted = finalcost(i,:)<th;
       correct_pred = predicted == (gt_labels==i);
       TP  = sum(predicted(gt_labels==i));
       FP = sum(predicted(gt_labels~=i));
       TN = sum(predicted(gt_labels~=i) == 0);
       FN = sum(predicted(gt_labels ==i) == 0);
       numPositives = TP + FN;
       numNegatives = TN + FP;
       r = numNegatives/numPositives;
       recall = TP/(TP+FN);
       precission = TP/(TP+FP);
       myScore(i,j) = sqrt(recall*precission);
       f1(i,j) = 2*TP/(2*TP+FP+FN);
       precision(i,j) = (TP/(TP+FP));
       accuracy(i,j) = (TP+TN)/(TP+FN+TN+FP);
       
       accuracy2(i,j) = (r*TP+TN)/(r*(TP+FN)+TN+FP);
       threshold(i,j) = th;
   end
   [accuracy_mov(i) idx] = max(accuracy(i,:));
   threshold_mov(i) = minCost+delta_th*idx;
end