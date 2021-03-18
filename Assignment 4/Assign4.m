[trainingdata, traingnd] = mnist_parse('train-images', 'train-labels');
numTr = size(trainingdata);
numTr = numTr(3);
trainingdata = double(reshape(trainingdata, size(trainingdata,1)*size(trainingdata,2), []));
traingnd = double(traingnd);


[testdata, testgnd] = mnist_parse('test-images', 'test-labels');
numTe = size(testdata);
numTe = numTe(3);
testdata = double(reshape(testdata, size(testdata,1)*size(testdata,2), []));
testgnd = double(testgnd);


tr_data = trainingdata - repmat(mean(trainingdata,  2), 1, numTr); 
te_data = testdata - repmat(mean(testdata,  2), 1, numTe);

[U,S,V] = svd(tr_data, 'econ');
sig = diag(S);

figure(1)
plot(sig, 'ko', 'Linewidth', 2)
ylabel('\sigma')
title('Singular values of each modes')

figure(2)
for i=0:9
    label_indices = find(traingnd == i);
    plot3(V(label_indices, 2), V(label_indices, 3), V(label_indices, 5), 'o', 'DisplayName', sprintf('%i',traingnd), 'Linewidth', 2);
    hold on
end
xlabel('2nd Mode'), ylabel('3rd Mode'), zlabel('5th Mode')
title('Projection onto V modes 2, 3, 5')
legend
set(gca,'Fontsize', 14)

UdX = S * V';
test = (U(:,1:rank)')*te_data;
rank = 25;
[threshold,w,sortA,sortB] = lda(UdX, traingnd, rank, 0,7);

accuracy1 = accuracy_rate(test, testgnd, threshold, w, 0, 7)

[threshold,w,sortA,sortB] = lda(UdX, traingnd, rank, 1,2);
accuracy2 = accuracy_rate(test, testgnd, threshold, w, 1, 2)

[threshold,w,sortA,sortB] = lda(UdX, traingnd, rank, 2,3);
accuracy3 = accuracy_rate(test, testgnd, threshold, w, 2, 3)

Mdl = fitcecoc(UdX(1:rank,:)', traingnd);
svm_predict = predict(Mdl,test');
accuracy4 = accuracy_rate2(svm_predict, testgnd, 0, 7)
accuracy5 = accuracy_rate2(svm_predict, testgnd, 2, 3)


tree=fitctree(UdX(1:rank,:)', traingnd);
tree_predict = predict(tree,test');
accuracy6 = accuracy_rate2(tree_predict, testgnd, 0, 7)
accuracy7 = accuracy_rate2(tree_predict, testgnd, 2, 3)
