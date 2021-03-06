function PlotParamsDecoder = DefaultPlotParamsDecoder
PlotParamsDecoder.PageTitle = 'VR Decoding';
PlotParamsDecoder.Page = 2;
PlotParamsDecoder.DialogWindow = 1;
PlotParamsDecoder.Window = 2;
PlotParamsDecoder.TrainContrast = 0.5;
PlotParamsDecoder.TrainGain = 1;
PlotParamsDecoder.TrainRoomLength = 1;
PlotParamsDecoder.TrainOutcome = 2;
PlotParamsDecoder.ChosenProbe = 1;
PlotParamsDecoder.PlotObjList = {'Posterior x X', 'Posterior x D','Posterior x Time', 'Projection 45', 'Error x X', 'Error x D', 'Error x Time', 'Mean X-Error', 'Mean D-Error', 'Theta x Error x X', 'Theta x Post x X', 'Theta x Error phase'};
PlotParamsDecoder.ChosenContrast = 1;
PlotParamsDecoder.FpoolContrast = 0;
PlotParamsDecoder.ChosenGain = 1;
PlotParamsDecoder.FpoolGain = 0;
PlotParamsDecoder.ChosenRoomlength = 1;
PlotParamsDecoder.FpoolRoomlength = 0;
PlotParamsDecoder.ChosenOutcome = 1;
PlotParamsDecoder.FpoolOutcome = 0;
PlotParamsDecoder.ChosenObj = {'Posterior x X'};
PlotParamsDecoder.Fdisplaylog = 0;
PlotParamsDecoder.Clim = [0.5 1.5];
PlotParamsDecoder.Fnormalize = 0;
PlotParamsDecoder.explist = 101;
PlotParamsDecoder.FdecXdistribution = false;
PlotParamsDecoder.maxtolerance = 0.1;
PlotParamsDecoder.Fgoodtimebins = false;
PlotParamsDecoder.Fspatialsmooth = true;
PlotParamsDecoder.FthetaPost = false;
PlotParamsDecoder.thetaDecphase = 0; 
PlotParamsDecoder.Fthetabins = false;
PlotParamsDecoder.thetaChannel = 34;
PlotParamsDecoder.thetaphase = 0;
PlotParamsDecoder.nthetaphsbins = 12;
PlotParamsDecoder.nthetaXbins = 50;
PlotParamsDecoder.Fspdbins = false;
PlotParamsDecoder.spdbin = 1;
PlotParamsDecoder.Palettename = 'RedWhiteBlue';
PlotParamsDecoder.Foverlap = false;
PlotParamsDecoder.FdisplayLFP = true;
PlotParamsDecoder.FdisplayMat = true;
PlotParamsDecoder.FdisplayPredMax = false;
PlotParamsDecoder.FdisplayPredAve = true;
PlotParamsDecoder.Plots = [];
end