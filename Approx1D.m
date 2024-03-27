%ANFIS Implementation to approximate 1D sine function
%Generating Training Data
t = 0:pi/20:2*pi;
x = sin(t);
data = [t',x']; %Input-Output Data (First column is input and last column is output)

%Generating initial FIS with options
Optg = genfisOptions("GridPartition");
Optg.NumMembershipFunctions = 3;

% Optg.ImputMembershipFunctions = "gaussmf"
Optg.InputMembershipFunctionType = "gbellmf";
inFIS = genfis(data(:,1),data(:,2), Optg);

%ANFIS training options
opt = anfisOptions('InitialFIS',inFIS,'EpochNumber',200);
FIS = anfis(data,opt);
Fisout = evalfis(FIS,data(:,1)); %ANFIS training

figure(1)
plot(t,x,'o-');
hold on
plot(t, Fisout,'*-')
title('Actual function Vs. Approximated function');
legend('Actual Function','ANFIS approximation');

diff = x'- Fisout;
figure(2)
plot(t,diff, 'ro-');
title('Error b/w actual and approximation');


