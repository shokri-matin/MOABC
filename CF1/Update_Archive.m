function [ archive ] = Update_Archive( archive,foods,epsilon,alpha )

    % Add Non-Dominated Particles to Archive
    archive = [archive; foods(~[foods.IsDominated])];
    
    % Determine Domination of New Archive Members
    archive = DetermineDomination(archive);
    
    % Keep only Non-Dminated Memebrs in the Archive
    archive = archive(~[archive.IsDominated]);
    
    % Update Grid
    Grid = CreateGrid(archive ,epsilon ,alpha);
    
    % Update Grid Indices
    for i=1:numel(archive)
        archive(i) = FindGridIndex(archive(i),Grid);
    end
    
    
    % Check if Archive is Full
    archive = DeleteArcMemebr(archive);

end

