function es = combineTwoVRexpts(es1, es2)

% function to combine two VR experiments.
% Created AS 2011

% Combines the following fields:
%.     'screenTimes2'
%.     'sortIDX'
%.     'screenTimes'
%.     'sampleRate'
%.     'sampleTimes'
%.     'trialID'
%.     'traj'
%.     'trajspeed'
%.     'ballspeed'
%     'lick'
%     'reward'
%     'currTime'
%     'contrast'
%     'start'
%     'gain'
%     'blanks'
%     'active'
%     'rewardPos'
%     'outcome'

es = es1;
lims = [1 size(es1.sampleTimes,1) (size(es1.sampleTimes,1)+size(es2.sampleTimes,1))];
trials1 = max(es1.trialID);

es.sampleTimes = [es1.sampleTimes' (es2.sampleTimes + es1.sampleTimes(end))']';
es.screenTimes = [es1.screenTimes' es2.screenTimes']';
es.screenTimes2 = [es1.screenTimes2' es2.screenTimes2']';
es.trialID = [es1.trialID' (trials1+es2.trialID)']';
es.traj = [es1.traj' es2.traj']';
es.trajspeed = [es1.trajspeed' es2.trajspeed']';
es.ballspeed = [es1.ballspeed' es2.ballspeed']';
es.sortIDX = [es1.sortIDX' es2.sortIDX']';
es.smthBallSpd = [es1.smthBallSpd' es2.smthBallSpd']';
es.smthTrajSpd = [es1.smthTrajSpd' es2.smthTrajSpd']';
es.distTrav = [es1.distTrav' es2.distTrav']';
es.totDistTrav = [es1.totDistTrav' es2.totDistTrav']';
es.trajPercent = [es1.trajPercent' es2.trajPercent']';
es.trajPercentunwrapped = [es1.trajPercentunwrapped' es2.trajPercentunwrapped']';
%     'lick'
es.lick = [es1.lick' es2.lick']';
%     'reward'
es.reward = [es1.reward' es2.reward']';
%     'currTime'
es.currTime = [es1.currTime' es2.currTime']';
%     'contrast'
es.contrast = [es1.contrast' es2.contrast']';
%     'start'
es.start = [es1.start' es2.start']';
%     'gain'
es.gain = [es1.gain' es2.gain']';
%     'blanks'
es.blanks = [es1.blanks' es2.blanks']';
%     'active'
es.active = [es1.active' es2.active']';
%     'rewardPos'
es.rewardPos = [es1.rewardPos' es2.rewardPos']';
%     'outcome'
es.outcome = [es1.outcome' es2.outcome']';
%     'gain'
es.roomLength = [es1.roomLength' es2.roomLength']';

%JUL:added some fieldss to the es structure
if isfield(es1, 'firstrewlick')
    es.firstrewlick = [es1.firstrewlick' es2.firstrewlick']';
end
if isfield(es1, 'firstgoodlick')
    es.firstgoodlick = [es1.firstgoodlick' es2.firstgoodlick']';
end
if isfield(es1, 'preRewlick')
    es.preRewlick = [es1.preRewlick' es2.preRewlick']';
end
if isfield(es1, 'postRewlick')
    es.postRewlick = [es1.postRewlick' es2.postRewlick']';
end
if isfield(es1, 'goodlick')
    es.goodlick = [es1.goodlick' es2.goodlick']';
end
if isfield(es1, 'firstbadlick')
    es.firstbadlick = [es1.firstbadlick' es2.firstbadlick']';
end
if isfield(es1, 'badlick')
    es.badlick = [es1.badlick' es2.badlick']';
end
if isfield(es1, 'passivelick')
    es.passivelick = [es1.passivelick' es2.passivelick']';
end
if isfield(es1, 'smthBallAcc')
    es.smthBallAcc = [es1.smthBallAcc' es2.smthBallAcc']';
end
if isfield(es1, 'runTime')
    es.runTime = [es1.runTime' es2.runTime']';
end
if isfield(es1, 'afterblanks')
    es.afterblanks = [es1.afterblanks' es2.afterblanks']';
end
if isfield(es1, 'trialgainchange')
    es.trialgainchange = [es1.trialgainchange' es2.trialgainchange']';
end
if isfield(es1, 'halfID')
    es.halfID = [es1.halfID' es2.halfID']';
end
if isfield(es1, 'completetrial')
    es.completetrial = [es1.completetrial' es2.completetrial']';
end


es.eyeXpos = [es1.eyeXpos' es2.eyeXpos']';
es.eyeYpos = [es1.eyeYpos' es2.eyeYpos']';
es.pupilSize = [es1.pupilSize' es2.pupilSize']';

es.iexp = [es1.iexp' es2.iexp']';
es.series = [es1.series' es2.series']';
if isfield(es, 'spikeTrain')
    es.spikeTrain = [es1.spikeTrain' es2.spikeTrain']';
    es.mua = [es1.mua' es2.mua']';
end
if isfield(es, 'spikePhase')
    es.spikePhase = [es1.spikePhase' es2.spikePhase']';
end
if isfield(es, 'spikePhaseV1')
    es.spikePhaseV1 = [es1.spikePhaseV1' es2.spikePhaseV1']';
end
if isfield(es1, 'spikeTimes')
    for icell = 1:length(es1.spikeTimes)
        es2.spikeTimes{icell} = es2.spikeTimes{icell} + es1.sampleTimes(end);
        es.spikeTimes{icell} = [es1.spikeTimes{icell}' es2.spikeTimes{icell}']';
    end
end
if isfield(es, 'spiketrajPercent')
    es.spiketrajPercent = [es1.spiketrajPercent' es2.spiketrajPercent']';
end
if isfield(es1, 'LFPphaseV1')
    es.LFPphaseV1 = [es1.LFPphaseV1' es2.LFPphaseV1']';
end
if isfield(es1, 'LFPpowerV1')
    es.LFPpowerV1 = [es1.LFPpowerV1' es2.LFPpowerV1']';
end
if isfield(es1, 'LFPthetaV1')
    es.LFPthetaV1 = [es1.LFPthetaV1' es2.LFPthetaV1']';
end
if isfield(es1, 'LFPphase')
    es.LFPphase = [es1.LFPphase' es2.LFPphase']';
end
if isfield(es1, 'LFPpower')
    es.LFPpower = [es1.LFPpower' es2.LFPpower']';
end
if isfield(es1, 'LFPtheta')
    es.LFPtheta = [es1.LFPtheta' es2.LFPtheta']';
end
if isfield(es1, 'LFPphase_Ch')
    es.LFPphase_Ch = [es1.LFPphase_Ch' es2.LFPphase_Ch']';
end

if isfield(es, 'theta')
    es.theta.A.hill = [es1.theta.A.hill' es2.theta.A.hill']';
    es.theta.B.hill = [es1.theta.B.hill' es2.theta.B.hill']';
end
if isfield(es, 'freq')
    es.freq         = es1.freq;
    es.origLFPtime  = [es1.origLFPtime es2.origLFPtime];
    es.coherence    = [es1.coherence' es2.coherence']';
    es.cohPhi       = [es1.cohPhi' es2.cohPhi']';
    es.powA         = [es1.powA' es2.powA']';
    es.powB         = [es1.powB' es2.powB']';
    es.powAB        = [es1.powAB' es2.powAB']';
end
if isfield(es, 'A')
    es.A.delta.hill    = [es1.A.delta.hill' es2.A.delta.hill']';
    es.B.delta.hill    = [es1.B.delta.hill' es2.B.delta.hill']';
    es.C.delta.hill    = [es1.C.delta.hill' es2.C.delta.hill']';
    % theta
    es.A.theta.hill    = [es1.A.theta.hill' es2.A.theta.hill']';
    es.B.theta.hill    = [es1.B.theta.hill' es2.B.theta.hill']';
    es.C.theta.hill    = [es1.C.theta.hill' es2.C.theta.hill']';
    % beta
    es.A.beta.hill    = [es1.A.beta.hill' es2.A.beta.hill']';
    es.B.beta.hill    = [es1.B.beta.hill' es2.B.beta.hill']';
    % gamma
    es.A.gamma.hill    = [es1.A.gamma.hill' es2.A.gamma.hill']';
    es.B.gamma.hill    = [es1.B.gamma.hill' es2.B.gamma.hill']';
    % gamma_narrow
    es.B.gamma_narrow.hill = [es1.B.gamma_narrow.hill' es2.B.gamma_narrow.hill']';
end