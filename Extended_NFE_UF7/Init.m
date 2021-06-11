function [ foods ] = Init( foods,xrange,CostFunction )
    
    foodNumber = numel(foods);
    NN = foodNumber;
    dim = size(xrange,1);
    points  = repmat(xrange(:,1),[1,NN]) + repmat((xrange(:,2)-xrange(:,1)),[1,NN]).*rand(dim, NN);
    
    for i = 1:foodNumber
        foods(i).Position = points(:,i);
        foods(i).Cost = CostFunction(foods(i).Position);
        foods(i).IsDominated = false;
    end
end

