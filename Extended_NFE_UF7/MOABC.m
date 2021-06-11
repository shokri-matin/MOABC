clc;
clear;
close all;

%% Problem Definition
global NFE;
NFE = 0;
CostFunction=@(x) UF7(x);	% Cost Function

nVar=3;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

xRange = xboundary('UF7',nVar); % Decision Variables UpperBound And LowerBound

%% Bees Algorithm Parameters

nPop = 200; % Polpulation Size

nArchive = 100; % Archive Size

FoodNumber = round(nPop/2); % Defined to hold the number of food sources

nEmployedBee = FoodNumber;  % Number of employed bees

nOnlookerBee = FoodNumber;  % Number of onlooker bees

epsilon = .02;   % Epsilon Size
alpha=0.1;      % Inflation Rate

Max_Trial = 50; % Maximum Trial Limit For Improve(Else Reset By Scout Bees)

MaxIt = 30000; % Maximum Number of Iterations

%% Initialization

% Empty Food Structure
empty_food.Position = [];
empty_food.Cost = [];
empty_food.Trial = 0;
empty_food.IsDominated = false;
empty_food.GridIndex = [];
empty_food.GridSubIndex = [];

% Initialize Foods Array
foods = repmat(empty_food,FoodNumber,1);

% Create New Solutions
foods = Init(foods,xRange,CostFunction);

% Determine Domination
foods = DetermineDomination(foods);

% Update Archive
archive = foods(~[foods.IsDominated]);

% Create Grid
Grid = CreateGrid(archive,epsilon,alpha);
for i=1:numel(archive)
    archive(i) = FindGridIndex(archive(i),Grid);
end

%% MOABC Algorithm Main Loop

for it=1:MaxIt
   
	% Send Scout Bees
	foods = Send_Scout_Bees(xRange,foods,Max_Trial,CostFunction);

	% Send Employed Bees
	foods = Send_Employed_Bees(xRange,foods,archive,CostFunction);

	% Send Onlooker Bees
    foods = DetermineDomination(foods);
	foods = Send_Onlooker_Bees(xRange,foods,CostFunction);

    % Update Archive
    foods = DetermineDomination(foods);
    archive = Update_Archive(archive,foods,epsilon,alpha);
    
    % Online Plot Costs
     figure(1);
     PlotCosts(foods,archive);
    
    % Show Iteration Information
    disp(['Iteration = ' num2str(it) ': NFE Number = ' num2str(NFE) ': Number of Archive Members = ' num2str(numel(archive))]);
    
end
%% Experiment's Results

% Plot True Pareto Front
figure(2)
[pt ~] = Pareto('UF7', 100, nVar);
plot(pt(1,:),pt(2,:),'b-','LineWidth',2);

hold on;

% Plot Found Pareto Front
rep_costs=[archive.Cost];
plot(rep_costs(1,:),rep_costs(2,:),'r*');
xlabel('1st Objective');
ylabel('2nd Objective');
legend('True Pareto Front','MOABC');

% Calculate IGD
disp('------------------------------------------');
disp('Build IGD');
IGD = Calculate_IGD(pt,rep_costs);
disp(['IGD :' num2str(IGD)]);

