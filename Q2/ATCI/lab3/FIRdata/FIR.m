clear all
close all
clc

tic

MAD_mat = zeros(9,5);
REC025_mat = zeros(9,5);
REC05_mat = zeros(9,5);
REC1_mat = zeros(9,5);
for complexity = [2,3,4,5,6,7,8,9]
    disp(complexity)
    for nclasses = [2,3,4,5]
        disp(nclasses)
        for i = 1:5
            createFileDiscretization('Discretization.mat', nclasses)
            createFileConfiguration('Configuration.mat', ['P' num2str(i) '-Train.mat'], ['P' num2str(i) '-Test.mat'], i, nclasses, complexity)
            Auto2('Configuration.mat')
        end

        MADcumulated = 0;
        REC025cumulated = 0;
        REC05cumulated = 0;
        REC1cumulated = 0;
        
        for i = 1:5
           results = load(['Results_fold' num2str(i)]);
           pred = results.pred;
           real = results.real;
           N = length(pred);
           diff = abs(pred-real);
           
           MADcumulated = MADcumulated + sum(diff)/N;
           REC025cumulated = REC025cumulated + sum(diff<0.25)/N;
           REC05cumulated = REC05cumulated + sum(diff<0.5)/N;
           REC1cumulated = REC1cumulated + sum(diff<1.0)/N;
           
        end
        MAD_mat(complexity,nclasses) = MADcumulated / 5;
        REC025_mat(complexity,nclasses) = REC025cumulated / 5;
        REC05_mat(complexity,nclasses) = REC05cumulated / 5;
        REC1_mat(complexity,nclasses) = REC1cumulated / 5;
        
        
    end
end

toc