function particle = FindGridIndex(particle,Grid)
    
    % Get Number of Objective Dimension
    nObj = numel(particle.Cost);
    
    nGrid = numel(Grid(1).LB);
    
    particle.GridSubIndex=zeros(1,nObj);
    
    for j = 1:nObj
        particle.GridSubIndex(j) = ...
            find(particle.Cost(j)<Grid(j).UB,1,'first');
    end

    particle.GridIndex = particle.GridSubIndex(1);
    for j=2:nObj
        particle.GridIndex = particle.GridIndex-1;
        particle.GridIndex = nGrid * particle.GridIndex;
        particle.GridIndex = particle.GridIndex + particle.GridSubIndex(j);
    end
    
end