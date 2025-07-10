% initial var to store; 保存SFC值, 被试*脑区
[SFCs_s1, SFCs_s2] = deal(zeros(numel(subnums), size(SCmat, 2)));
% 每个被试计算
for i = 1:numel(subnums)

    % 提取每个被试的连接矩阵
    subiFC_s1 = squeeze(FCmat_ses1(i, :, :));
    subiFC_s2 = squeeze(FCmat_ses2(i, :, :));
    subiSC = squeeze(SCmat(i, :, :));
    % initial var to store
    [subi_SFC_s1, subi_SFC_s2] = deal(zeros(size(subiSC, 1), 1));
    % 每个脑区计算    
    for n = 1:size(subiSC, 1)
        % SC 向量提取
        SCvector = subiSC(n, :); SCvector(n) = [];
        % ses 1; 去除自身值
        FCvector_s1 = subiFC_s1(n, :); FCvector_s1(n) = [];
        % ses 2; 去除自身值
        FCvector_s2 = subiFC_s2(n, :); FCvector_s2(n) = [];
        % 计算adjusted r2
        % 回归分析;模型结果有R2和adjusted R2
        mdl = fitlm(SCvector', FCvector_s1');
        r2SFC_s1 = mdl.Rsquared.Adjusted;
        % s2
        mdl = fitlm(SCvector', FCvector_s2');
        r2SFC_s2 = mdl.Rsquared.Adjusted;
        % store
        subi_SFC_s1(n) = r2SFC_s1;
        subi_SFC_s2(n) = r2SFC_s2;
    end

    % 保存
    SFCs_s1(i,:) = subi_SFC_s1(:);
    SFCs_s2(i,:) = subi_SFC_s2(:);
end
