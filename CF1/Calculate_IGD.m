function [ IGD ] = Calculate_IGD(tpf, pf)

    npf = size(pf,2); 
    ntpf = size(tpf,2);
    temp = inf;
    sum_distance = 0;
    for i=1:ntpf
        for j=1:npf
            distance = norm(tpf(:,i)' - pf(:,j)');
            if temp > distance
                temp = distance;
            end
        end
        sum_distance = sum_distance + temp;
        temp = inf;
    end
    IGD = sum_distance/ntpf;
end

