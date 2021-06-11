function PlotCosts(pop,rep)

    pop_costs=[pop.Cost];
    plot(pop_costs(1,:),pop_costs(2,:),'ko');
    
    hold on;
    
    rep_costs=[rep.Cost];
    plot(rep_costs(1,:),rep_costs(2,:),'r*');
    
    xlabel('1st Objective');
    ylabel('2nd Objective');
    
    %grid on;
    
    hold off;

end