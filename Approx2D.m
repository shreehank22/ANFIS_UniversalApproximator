%Creating Dataset
x = -10:0.5:10;
y = -10:0.5:10;
[X,Y] = meshgrid(x,y);
[row,col] = size(X);

r = sqrt(X.^2+Y.^2);
Z = sin(r+eps)./(r+eps);
figure(1);
surf(Z);
title("Actual function");

L1 = reshape(X,[row*col,1]);
L2 = reshape(Y,[row*col,1]);
L3 = reshape(Z,[row*col,1]);

data = [L1,L2,L3]; %Input-Output Data (First two cols are I/P and the last col is output)

%Generating initial FIS with options
Optg = genfisOptions('GridPartition');
Optg.NumMembershipFunctions = 20;
Optg.InputMembershipFunctionType = 'gaussmf';
fis1 = genfis(data(:,1:2), data(:,3),Optg); %Initial FIS

%ANFIS Training options
options = anfisOptions('InitialFIS',fis1,'EpochNumber',5);
fis2 = anfis(data,options);
anfis_output = evalfis(fis2,data(:,1:2));
O = reshape(anfis_output,[row,col]);
figure(2);
surf(O);
title('Estimated function');

error = Z-O; %Finding error between actual and approximated function
figure(3);
surf(error);
title('Error b/w actual and approximation');




