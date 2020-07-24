function [ MK TP FN FP TN ]= matrica_konfuzije (T, Y, n)

% matrica konfuzije
MK = zeros(2.^size(Y,1));

%%mapiranje rezultata u klase (sluchaj za binarno u dekadno)
%%i punjenje matrice konfuzije u istom prolazu:

B = [ 2.^(0:size(Y,1)) ]';

Tk = sum(B(1:(size(Y,1))).*T)+1;
Yk = sum(B(1:(size(Y,1))).*Y)+1;

for i = 1:(size(Y,2))
    MK(Tk(i),Yk(i)) = MK(Tk(i),Yk(i)) + 1;
end

%punjenje matrica sa TP (true positive), FN (false negative), FP (false
%positive) i TN (true negative) sluchajevima za svaki od n ishoda, matrica
%za precision i recall:

TP = zeros(2.^(size(Y,1)),1);
FN = zeros(2.^(size(Y,1)),1);
FP = zeros(2.^(size(Y,1)),1);
TN = zeros(2.^(size(Y,1)),1);
precision = zeros(2.^(size(Y,1)),1);
recall = zeros(2.^(size(Y,1)),1);


for i = 1:(2.^size(Y,1))

TP(i) = MK(i,i);
FN(i) = sum(MK(1:(i-1),i),1) + sum(MK((i+1):2.^(size(Y,1)),i),1);
FP(i) = sum(MK(i,1:(i-1)),2) + sum(MK(i,(i+1):2.^(size(Y,1))),2);
TN(i) = sum(sum(MK(1:(i-1),1:(i-1)))) + sum(sum(MK((i+1):2.^(size(Y,1)),(i+1):2.^(size(Y,1))))) + sum(sum(MK(1:(i-1),(i+1):2.^(size(Y,1))))) + sum(sum(MK((i+1):2.^(size(Y,1)),1:(i-1))));

end

precision = TP./(TP+FP);
recall = TP./(TP+FN);
fscore = 2*(precision.*recall)./(precision+recall);

MK
TP
FN
FP
TN

precision
recall


end

