for i = 1:12
        figure;
        plot(threshold(i,:),f1(i,:))
        title(['Gesture' num2str(i)])
        xlabel('Threshold');
        ylabel('F1-Score');
        
        [val, idx] = max(f1(i,:));
        disp(['Gesture' num2str(i) ': Th - ' num2str(threshold(i,idx)) '  F1 - ' num2str(val)])  
end


