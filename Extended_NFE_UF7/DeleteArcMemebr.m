function archive = DeleteArcMemebr(archive)

    % Grid Index of All Arcive Members
    GI=[archive.GridIndex];
    
    % Occupied Cells
    OC=unique(GI);
    
    % Number of Particles in Occupied Cells
    N=zeros(size(OC));
    for k=1:numel(OC)
        N(k)=numel(find(GI==OC(k)));
    end
    
    % Keep Left Corner Of Solution
    for k=1:numel(OC)
        if N(k)>1
           try
           GI=[archive.GridIndex];
           OC=unique(GI);
           SCM= GI==OC(k);
           
           index = LeftCorner(archive,SCM);;
           catch
               a = 0;
           end
           SCM(index) = 0;
           archive(SCM) = [];
        end
    end
end
function index = LeftCorner(archive,SCM)
    
    members = archive(SCM==1);
    temp = inf;
    for i=1:numel(members)
        Cost = abs(members(i).Cost(1));
        if temp > Cost;
            temp = Cost;
            index = i;
        end
    end
    list = find(SCM == 1,index);
    index = list(index);
end