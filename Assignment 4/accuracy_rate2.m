function accuracy_rate2 = accuracy_rate2(predictgnd, testgnd, digitA, digitB)
    accu = testgnd(find(testgnd == digitA | testgnd == digitB));
    predicts = predictgnd(find(testgnd == digitA | testgnd == digitB));
    p_length = length(predicts);
    count_right = 0;
    for k = 1:p_length
        if accu(k) == predicts(k)
            count_right = count_right + 1;
        end
    end
    accuracy_rate2 = count_right / p_length;
end
    