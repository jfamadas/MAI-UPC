%% Section 1: LOAD THE WHOLE SET OF SEQUENCES
[data,tagset] = loadAll();

%% Section 2: CHOOSE GESTURE PATTERN FOR EACH TYPE OF GESTURE RANDOMLY
chosen_class=[1:12];
gt = [];
for i = 1:12
    chosen_label = chosen_class(i);
    gt_label = getSamples(data,chosen_label);
    gt = [gt; gt_label];
    index = ceil(rand()*size(gt_label,1));
    gesture_pattern{i} = {gt_label{index,1} gt_label{index,2}};
end

%% Section 3: COMPUTE DTW
finalcost = zeros(12,size(gt,1));
for i = 1:12
  for j = 1:size(gt,1)
          [finalcostv,MT] = multiDTW(gesture_pattern{i}{1,1},gt{j,1},'cosine');   
          [path] = computePath(MT);
          finalcost(i,j) = finalcostv/sum(sum(path));
  end
  disp(['DTW values Computed for Pattern' num2str(i)]);
end

%% Section 4 : K-NN Classifier with Cross-Validation
gt_labels = cell2mat(gt(:,2))';
current={};
current_labels={};
indices={};
truth_label = [];
for j = 1:12
    current{j} = finalcost(:,gt_labels == j);
    current_labels{j} = gt_labels(gt_labels == j);
    indices{j} = crossvalind('Kfold',size(current{j},2),10);
end
pred_labels_total_svm = [];
pred_labels_total_knn = [];
for j = 1:10
    train_finalcost = [];
    test_finalcost = [];
    train_label = [];
    test_label = [];
    for i = 1:12
        train_finalcost = [train_finalcost current{i}(:,indices{i}~=j)];
        train_label =[train_label current_labels{i}(indices{i}~=j)];
        test_finalcost = [test_finalcost current{i}(:,indices{i}==j)];
        test_label = [test_label current_labels{i}(indices{i}==j)];
    end
    truth_label = [truth_label test_label];
    mdl_knn =fitcknn(train_finalcost',train_label,'NumNeighbors',1,'Standardize',1);
    pred_labels_knn  = predict(mdl_knn,test_finalcost');
    accuracy_knn(j) = mean(pred_labels_knn'==test_label);
    pred_labels_total_knn = [pred_labels_total_knn; pred_labels_knn];
    t = templateSVM('Standardize',1)
    mdl_svm = fitcecoc(train_finalcost',train_label,'Learners',t);
    pred_labels_svm = predict(mdl_svm,test_finalcost');
    pred_labels_total_svm = [pred_labels_total_svm ;pred_labels_svm];
    accuracy_svm(j) = mean(pred_labels_svm'==test_label);
end
figure(2)
mat = eye(12);
%plotconfusion(mat(truth_label,:),mat(pred_labels_total_knn',:));
figure(1)
%plotconfusion(truth_label,pred_labels_total_svm');

%% Section 5: Single gesture Independent binary classifiers. Find Optimal TH for each Gesture.
precision = zeros(12,6244);
accuracy = zeros(12,6244);
threshold = zeros(12,6244);
f1 = zeros(12,6244);
f1_opt=zeros(1,12);
threshold_mov=zeros(1,12);
for i = 1:12
    maxCost = max(finalcost(i,:))/5;
    minCost = min(finalcost(i,:));
    delta_th = (maxCost-minCost)/10000;
   for j = 1:10000
       th = minCost + j*delta_th;
       predicted = finalcost(i,:)<th;
       correct_pred = predicted == (gt_labels==i);
       TP  = sum(predicted(gt_labels==i));
       FP = sum(predicted(gt_labels~=i));
       TN = sum(predicted(gt_labels~=i) == 0);
       FN = sum(predicted(gt_labels ==i) == 0);
       f1(i,j) = 2*TP/(2*TP+FP+FN);
       precision(i,j) = (TP/(TP+FP));
       accuracy(i,j) = (TP+TN)/(TP+FN+TN+FP);
       threshold(i,j) = th;
   end
   [f1_opt(i) idx] = max(f1(i,:));
   threshold_mov(i) = minCost+delta_th*idx;
end