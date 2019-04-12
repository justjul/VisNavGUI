function VisNavGUI(savedParamsFile)
serverName = 'C:\';
if nargin < 1
    savedParamsFile = [];
end
if ~isempty(savedParamsFile)
    load(savedParamsFile,'P');
else
    P = Tstructure('Params');
    P.addprop('DatabaseFilters');
    P.DatabaseFilters = DefaultDatabaseFilters;
    P.addprop('LoadParams');
    P.LoadParams = DefaultLoadParams;
    P.addprop('AnalysisOptions');
    P.AnalysisOptions = DefaultAnalysisOptions;
    P.addprop('PlotParamsMaps');
    P.PlotParamsMaps = DefaultPlotParamsMaps;
    P.addprop('PlotParamsDecoder');
    P.PlotParamsDecoder = DefaultPlotParamsDecoder;
    P.addprop('PlotParamsBehavior');
    P.PlotParamsBehavior = DefaultPlotParamsBehavior;
    P.addprop('DIRS');
    P.DIRS = SetDirectories(serverName);
end

%path of the directories where the data are

%create the data structure object
EXP = Tstructure('Data');
EXP.addprop('animal');
EXP.addprop('series');
EXP.addprop('exp');

EXP.addprop('Nav');
EXP.addprop('Vis');
EXP.addprop('Eye');
EXP.addprop('Spk');
EXP.addprop('Lfp');


%create the GUI object
GUI = TMultigraph('VisNav');
GUI.addPage;
GUI.addPage;

GUI.RenamePage(P.PlotParamsMaps.Page,P.PlotParamsMaps.PageTitle);
GUI.Hdividepage(P.PlotParamsMaps.Page, 2, [1 9]);
SpatialMapsDialog = Tdialog(GUI.window{P.PlotParamsMaps.Page,P.PlotParamsMaps.DialogWindow});

GUI.RenamePage(P.PlotParamsDecoder.Page,P.PlotParamsDecoder.PageTitle);
GUI.Hdividepage(P.PlotParamsDecoder.Page, 2, [1 9]);
DecodingDialog = Tdialog(GUI.window{P.PlotParamsDecoder.Page,P.PlotParamsDecoder.DialogWindow});

GUI.RenamePage(P.PlotParamsBehavior.Page,P.PlotParamsBehavior.PageTitle);
GUI.Hdividepage(P.PlotParamsBehavior.Page, 2, [1 9]);
BehaviorDialog = Tdialog(GUI.window{P.PlotParamsBehavior.Page,P.PlotParamsBehavior.DialogWindow});


uimenu('Parent',GUI.FileMenu,'Label','load session',...
       'Callback', @(source,event)GUI_LoadMenu_Callback(source, event, GUI, EXP, P, SpatialMapsDialog, DecodingDialog, BehaviorDialog));
uimenu('Parent',GUI.FileMenu,'Label','save file',...
       'Callback',@(source,event)GUI_SaveMenu_Callback(source,event,EXP, P));
uimenu('Parent',GUI.FileMenu,'Label','load processed file',...
       'Callback',@(source,event)GUI_LoadProcessedMenu_Callback(source, event, GUI, EXP, P, SpatialMapsDialog, DecodingDialog, BehaviorDialog));

uimenu('Parent',GUI.AnalysisMenu,'Label','Analysis Options','Callback',@(source,event)GUI_AnalysisOptions_Callback(source,event,P));
%parameters for analyses when loading + which analysis to run when loading + load/save directories for
%preprocessed files
uimenu('Parent',GUI.AnalysisMenu,'Label','Compute 1D maps','Callback',@(source,event)GUI_Compute1Dmaps_Callback(source,event,P));
uimenu('Parent',GUI.AnalysisMenu,'Label','Compute 2D maps','Callback',@(source,event)GUI_Compute2Dmaps_Callback(source,event,P));
uimenu('Parent',GUI.AnalysisMenu,'Label','Run Bayesian decoder','Callback',@(source,event)GUI_BayesDecoder_Callback(source,event,P));

uimenu('Parent',GUI.PlotMenu,'Label','Save Figure','Callback',@(source,event)GUI_SaveFigure_Callback(source,event));
uimenu('Parent',GUI.PlotMenu,'Label','Save Plot','Callback',@(source,event)GUI_SavePlot_Callback(source,event));
uimenu('Parent',GUI.PlotMenu,'Label','Add colorbar','Callback',@(source,event)GUI_Colorbar_Callback(source,event));
end

% % *************************Callback functions***************************** %

function GUI_LoadMenu_Callback(source, event, GUI, EXP, P, SpatialMapsDialog, DecodingDialog, BehaviorDialog)
%get animal name
%update the name and loading parameters used in the figure title
%[animalname, iseries, iexplist, processedfiles] = Aman's function;
% LoadandRun(EXP, animalname, iseries, iexplist, processedfiles);
figstr = [num2str(LoadParams.LoadParams.animal) ' ' num2str(LoadParams.LoadParams.iseries)];
GUI.updateTitle(figstr);
InstallSpatialMapsDialog(GUI, EXP, P, SpatialMapsDialog);
InstallDecodingDialog(GUI, EXP, P, DecodingDialog);
InstallBehaviorDialog(GUI, EXP, P, BehaviorDialog);
end

function GUI_SaveMenu_Callback(source,event,EXP,P)
end

function GUI_LoadProcessedMenu_Callback(source, event, GUI, EXP, P, SpatialMapsDialog, DecodingDialog, BehaviorDialog)
dirname = '';
[filename, dirname] = uigetfile(dirname);

S = load([dirname filename]);
exp = TVRData;
exp.Copyobj(S.EXP);
CreateDataStructure(exp, EXP);

figstr = [num2str(EXP.animal) ' ' num2str(EXP.series)];
GUI.updateTitle(figstr);
InstallSpatialMapsDialog(GUI, EXP, P, SpatialMapsDialog);
% InstallDecodingDialog(GUI, EXP, P, DecodingDialog);
% InstallBehaviorDialog(GUI, EXP, P, BehaviorDialog);
end

function GUI_AnalysisOptions_Callback(source,event,P)
AnalysisOptionsDialog = Tdialog([],'Analysis Options',[0.3 0.1 0.4 0.8]);
end