function [] = visualizeFeatures2D(feature1, feature2, descriptor1, descriptor2, descriptor3)

    figure;
    plot(descriptor1(:,feature1),descriptor1(:,feature2),'bo')
    hold on
    plot(descriptor2(:,feature1),descriptor2(:,feature2),'r+')
    plot(descriptor3(:,feature1),descriptor3(:,feature2),'g*')
    grid on
    
end