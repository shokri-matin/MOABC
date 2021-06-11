function [ foods ] = Send_Scout_Bees(xrange,foods,Max_Trial,CostFunction)

    index = find([foods.Trial] > Max_Trial);
    %&[foods.IsDominated] == true
    if ~isempty(index)
       foods(index) = Init(foods(index),xrange,CostFunction);
    end
    
end

