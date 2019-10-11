function [cm, acc, f1 ] = confusionMatrix( y_actual,y_predicted )
%%% input arguments are actual output (y_actual) and predicted output (y_predicted)
%%% This function returns confusion matrix (cm), accuracy (acc), and F1 score (f1)
tp=0;
fp=0;
tn=0;
fn=0;
y=y_actual;
y_p=y_predicted;
for i=1:length(y)
  if ((y(i,1)==1) && (y_p(i,1)==1))
    tp = tp+1;
  elseif ((y(i,1)==-1) && (y_p(i,1)==1))
    fp = fp+1;
  elseif ((y(i,1)==-1) && (y_p(i,1)==-1))
    tn = tn+1;
  elseif ((y(i,1)==1) && (y_p(i,1)==-1))
    fn = fn+1;
  end
end

tp;
fp;
tn;
fn;
acc = (tp+tn)/(tp+tn+fp+fn);
Recall = tp/(tp+fn);
Precision = tp/(tp+fp);
f1 = (2*Recall*Precision)/(Recall+Precision);
cm = [tp, fp;fn, tn];

end
