function [Signal_Zero, Signal_relativeRate] = SynchSignals(SynchRef, SynchSignal)
%Returns the time of start of SynchRef in recording units of SynchSignal
%and also returns the sampling rate of SynchSignal relative to SynchRef

%Finding the onset of pulses
SynchRef = SynchRef - mean(SynchRef);
SynchSignal = SynchSignal - mean(SynchSignal);
SynchTimesRef = find(diff(sign(SynchRef)) > 0);
SynchTimes = find(diff(sign(SynchSignal)) > 0);

%Measuring the intervals between successive up transiton
SynchIntRef = diff(SynchTimesRef);
SynchInt = diff(SynchTimes);

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

%Sampling rate of SynchSignal relative to Ratio SynchRef
SynchIntRef = diff(SynchTimesRef);
SynchInt = diff(SynchTimes);
Signal_relativeRate = median(SynchInt(SynchIntcorrection:(SynchIntcorrection+numel(SynchIntRef)-1),1)./SynchIntRef);

%Signal_Zero expressed in recording units of SynchSignal
Signal_Zero = SynchTimes(SynchIntcorrection) - Signal_relativeRate * SynchTimesRef(1) + 1;

end