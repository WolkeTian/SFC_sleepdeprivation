function [r_obs, p_value] = perm_corr_pval(x, y, n_perm, method)
% perm_corr_pval - Compute permutation p-value for correlation coefficient
%
% Syntax: [r_obs, p_value] = perm_corr_pval(x, y, n_perm, method)
%
% Inputs:
%   x       - Vector of variable 1
%   y       - Vector of variable 2 (same length as x)
%   n_perm  - Number of permutations (default: 5000)
%   method  - Correlation method: 'Pearson' (default), 'Spearman', etc.
%
% Outputs:
%   r_obs   - Observed correlation coefficient
%   p_value - Two-tailed permutation p-value

    if nargin < 3
        n_perm = 5000;
    end
    if nargin < 4
        method = 'Pearson';
    end

    % Check input
    if length(x) ~= length(y)
        error('x and y must be the same length');
    end

    x = x(:);
    y = y(:);
    
    % Observed correlation
    r_obs = corr(x, y, 'Type', method);

    % Preallocate for permuted correlations
    r_perm = zeros(n_perm, 1);

    % Permutation loop: shuffle y
    for i = 1:n_perm
        y_perm = y(randperm(length(y)));
        r_perm(i) = corr(x, y_perm, 'Type', method);
    end

    % Two-tailed p-value
    p_value = mean(abs(r_perm) >= abs(r_obs));
end
