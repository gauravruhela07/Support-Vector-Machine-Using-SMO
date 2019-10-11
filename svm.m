%%%% SVM Implementation: %%%%
clear all;clc; 
data=csvread('Data.csv');
data(:,1:end-1)=zscore(data(:,1:end-1));

x =  data(:,1:end-1);   % training data
y =  data(:,end);   % labels
%% plot the data %%%%
figure
hold on
scatter(x(y==1,1),x(y==1,2),'+b')
scatter(x(y==-1,1),x(y==-1,2),'sr')
axis ([-2 2 -2 2])
title('Linearly seperable data')
xlabel('{x_1}'),ylabel('{x_2}')
legend('Positive class','Negative class')
hold off
fprintf('Press enter to continue...');
pause
%% obtaining support vectors and corresponding alpha and y values
[alpha,x,y] = smo(x,y);
    
%% Calculate weight vector W and bias
W = sum(alpha.*x.*y);
%b = (1/length(y))*sum(y-(x.*W));
b = (sum(y-(W*x')'))/length(alpha);

% Support Vectors
fprintf('Number of support Vectors : %d\n',length(alpha))

Xsupport=x;
Ysupport=y;

%0.2991 0.3789
%% Predict using training data
x = data(:,1:end-1);
y = data(:,end);
y_p = sign((W*x')'+b); % y_p contains predicted values of output
% Accuracy and F-measure
[cm, Accuracy, F1_score] = confusionMatrix( y,y_p );

fprintf('Accuracy : %d\n',Accuracy);
fprintf('Confusion Matrix : %d\n',cm);
fprintf('F1_Score : %d\n',F1_score);
%% Plotting the Decision Boundry
hold on
scatter(x(y==1,1),x(y==1,2),'+b')
scatter(x(y==-1,1),x(y==-1,2),'sr')
scatter(Xsupport(Ysupport==1,1),Xsupport(Ysupport==1,2),'ob')
scatter(Xsupport(Ysupport==-1,1),Xsupport(Ysupport==-1,2),'or')
syms x1 x2
fn=vpa((-b-W(1)*x1)/W(2),6);
fn1=vpa((-1-b-W(1)*x1)/W(2),6);
fn2=vpa((1-b-W(1)*x1)/W(2),6);
fplot(fn,'Linewidth',2);
fplot(fn1,'Linewidth',1);
fplot(fn2,'Linewidth',1);
axis([-2 2 -2 2])
xlabel ('support vectors are circled')
hold off
