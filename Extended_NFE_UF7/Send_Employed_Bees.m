function [ foods ] = Send_Employed_Bees(xrange,foods,archive,CostFunc)

    FoodNumber = numel(foods);
    w1 = .8;
	for i = 1:FoodNumber
        food = foods(i);
        d = randi(size(xrange,1));
        r = randi(numel(archive));
        leader = archive(r);
        newfood = food;
        
        newfood.Position(d) = newfood.Position(d) ...
                            + w1*unifrnd(-1,1)*(newfood.Position(d) - leader.Position(d));
        
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

