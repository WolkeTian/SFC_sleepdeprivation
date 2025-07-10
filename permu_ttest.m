function p_value = permu_ttest(data1, data2, n_perm)
    % permutation_paired - Paired permutation test
    %
    % Syntax: p_value = permutation_paired(data1, data2, n_perm)
    %
    % Inputs:
    %    data1 - Vector of session 1 data (Nx1 or 1xN)
    %    data2 - Vector of session 2 data (Nx1 or 1xN)
    %    n_perm - Number of permutations (default: 5000)
    %
    % Output:
    %    p_value - Two-tailed permutation p-value

    if nargin < 3
        n_perm = 5000;
    end

    if length(data1) ~= length(data2)
        error('data1 and data2 must be the same length');
    end

    N = length(data1);
    diff_obs = mean(data2 - data1);  % Observed mean difference

    perm_diffs = zeros(n_perm, 1);   % Store permutation differences
    % 串起来数据
    wholedata = [data1(:); data2(:)];

    for i = 1:n_perm
        % 打乱数据即可
        data_permed =  wholedata(randperm(numel(wholedata)));
        data1_permed = data_permed(1:numel(data1));
        data2_permed = data_permed((numel(data2)+1):end);
        permuted_diff = mean(data2_permed - data1);
        perm_diffs(i) = permuted_diff;
    end

    % Two-tailed p-value
    p_value = mean(abs(perm_diffs) >= abs(diff_obs));
end
