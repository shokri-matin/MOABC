function [ foods ] = Send_Onlooker_Bees(xrange,foods,CostFunc)
    
    % Calculate Probabilities for each food source
    n = numel(foods);
    dom = zeros(1,n);
    for i=1:n
        for j=i+1:n
            if(Dominates(foods(i),foods(j)))
               dom(i) = dom(i) + 1;
            else
               dom(j) = dom(j) + 1;
            end
        end
    end
    
    fit = dom/n;
    
    P = fit/sum(fit);

    w2 = .7;
    for i = 1:n
        food = foods(i);
        d = randi(size(xrange,1));
        index = RouletteWheelSelection(P);
        leader = foods(index);
        newfood = food;
        
        % Create New Food
        newfood.Position(d) = newfood.Position(d) ...
                            + w2*unifrnd(-1,1)*(newfood.Position(d) - leader.Position(d));
        % Reform Position
        newfood.Position(d) = max(xrange(d,1),min(newfood.Position(d),xrange(d,2)));
        newfood.Cost = CostFunc(newfood.Position);
        
        if Dominates(newfood,food)
            food.Position = newfood.Position;
            food.Cost = newfood.Cost;
            food.Trial = 0;
            food.IsDominated = 0;
        else
            food.Trial = food.Trial + 1;
        end
        foods(i) = food;
    end
end

