function [ dep, inv ] = getPartVibrate(f0)
%ȡ�õ��εĲ�������
%   �˴���ʾ��ϸ˵��
    fLen = length(f0);
    t = diff(sign(diff(f0)));
    peaks = find(t < 0);  % ��ֵ
    valleys = find(t > 0);% ��ֵ
    dep = zeros(1, fLen);
    inv = zeros(1, fLen);
    % ������� = (��ֵ - ��ֵ) / 2
    % ������   = | ��ֵ�±� - ��ֵ�±� |
    % ������ʼ = ��ֵ�±� - ������ / 2
    vLen = min(length(peaks), length(valleys));
    endl = 1;
    depth = 0;
    interval= 0;
    for i = 2 : vLen
        depth = abs(f0(peaks(i)) - f0(valleys(i)));
        interval = abs(valleys(i) - peaks(i));
        start = round(max(1, peaks(i - 1) - interval / 2));
        endl = round(min(fLen, peaks(i) - interval / 2));
        for j = start : endl
            dep(j) = depth;
            inv(j) = interval;
        end;
    end;
    for i = endl : fLen
        dep(i) = depth;
        inv(i) = interval;
    end;
end

