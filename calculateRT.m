function [meanRT,medianRT,fastMean,fastRecip,slowMean,slowRecip,lapsePrc, NumFalseStart] = calculateRT(RTgot)
    %     hist(RTgot);
    NumFalseStart = sum(RTgot < 100);
    validRT = RTgot((RTgot >= 100) & (RTgot <= 3000)); % 排除无效试次
    coreRT = validRT(validRT <= 500); % 得到100-500区间试次
    % 计算均值/中位数
    meanRT = mean(coreRT);
    medianRT = median(coreRT);
    % 计算前/后10%
    fastThres = prctile(coreRT,10);
    slowThres = prctile(coreRT,90);
    fastTrials = coreRT(coreRT <= fastThres);
    slowTrails = coreRT(coreRT >= slowThres);
    fastMean = mean(fastTrials);
    fastRecip = mean(1000./fastTrials);
    slowMean = mean(slowTrails);
    slowRecip = mean(1000./slowTrails);

    % 计算lapses百分比
    lapses = validRT(validRT > 500);
    lapsePrc = numel(lapses)/numel(validRT); % 分母是有效RT的次数
end
