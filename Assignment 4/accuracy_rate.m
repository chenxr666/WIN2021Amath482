function accuracy_rate = accuracy_rate(test, testgnd, threshold, w, digitA, digitB)
    testA_i = find(testgnd == digitA);
    la = length(testA_i);
    testB_i = find(testgnd == digitB);
    lb = length(testB_i);
    count_right = 0;
    test1 = w'*test;
    i = 0;
    for j = 1:la
        i = i+1;
        if test1(testA_i(i)) < threshold;
            count_right = count_right + 1;
        end
    end
    i = 0;
    for j = 1:lb
        i = i+1;
        if test1(testB_i(i)) > threshold;
            count_right = count_right + 1;
        end
    end
    accuracy_rate = count_right / (la + lb);
end