function [] = visualizeFeatures3D(feature1, feature2, feature3, descriptor1, descriptor2, descriptor3)
    
    figure;
    plot3(descriptor1(:,feature1),descriptor1(:,feature2),descriptor1(:,feature3),'bo')
    hold on
    plot3(descriptor2(:,feature1),descriptor2(:,feature2),descriptor2(:,feature3),'r+')
    plot3(descriptor3(:,feature1),descriptor3(:,feature2),descriptor3(:,feature3),'g*')    
    grid on
 
 
 
end