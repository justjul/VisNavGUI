function [ZeroCorrection, RateCorrection] = SynchSignals(SynchRef, SynchSignal)
%

SynchRef = SynchRef - mean(SynchRef);
SynchSignal = SynchSignal - mean(SynchSignal);

%Measuring the intervals between successive up transiton
SynchIntRef = diff(find(diff(sign(SynchRef)) > 0));
SynchInt = diff(find(diff(sign(SynchSignal)) > 0));

%Selecting a pattern of n intervals in the middle of the reference signal
NintRef = numel(SynchIntRef);
Npattern = 20;
idxRef = floor((NintRef/2)+1):(floor(NintRef/2)+Npattern);
patternRef = SynchIntRef(idxRef);
patternRef = (patternRef - mean(patternRef));
patternRef = patternRef./sqrt(sum(patternRef.^2));

%creating a matrix with shifted versions of the sequence of intervals in
%the SynchSignal
SynchInt = repmat(SynchInt(:),[1 Npattern]);
for k = 0:(Npattern-1)
    SynchInt(:,k + 1) = circshift(SynchInt(:,k + 1), -k);
end
SynchInt = (SynchInt - repmat(mean(SynchInt,2), [1 Npattern]));
SynchInt = SynchInt./repmat(sqrt(sum(SynchInt.^2,2)), [1 Npattern]);

%Computing normalized correlation between patterns of intervals and finding
%the position of maximal correlation in units of number of pulses
SynchCorr = SynchInt*patternRef(:);
[~, correction] = max(SynchCorr);
SynchIntcorrection = correction - idxRef(1) + 1;

%Ratio between sampling rate of the two input signals 
RateCorrection = mean(SynchInt(SynchIntcorrection:(SynchIntcorrection+numel(SynchIntRef)-1))./SynchIntRef);

%ZeroCorrection should then be extrapolated from SynchIntcorrection to the
%beginning of the SynchRef signal
ZeroCorrection = 0;

end