
function ...
  [ParamGeneral ...
   ParamData ...
   ParamPreprocess ...
   ParamSamplingDevelopment ...
   ParamConstructModel...
   ParamResults] = MLE_DefaultParameters;

%----------------------------------

ParamGeneral.ClassificationProblem = 0;
ParamGeneral.RegressionProblem = 0;

Command = 'echo $$';
[Status,Pid] = system(Command);
ParamGeneral.PrefixTmpFile = './tmpfile-';
for i=1:prod(size(Pid))-1 %%% In Pid there is an abnormal extra character
  ParamGeneral.PrefixTmpFile = sprintf('%s%s',ParamGeneral.PrefixTmpFile,Pid(i));
end
%%%ParamGeneral.PrefixTmpFile = sprintf('./tmpfile-%s',Pid);

%----------------------------------

ParamData.DataDirectory = '.';

%----------------------------------

ParamPreprocess.TypeTransform = 'NoTransform';

%----------------------------------

ParamSamplingDevelopment.NTimes = 1;
ParamSamplingDevelopment.Randomize = 1;
ParamSamplingDevelopment.RandomSeed = 0;  %%% values <=0: clock
ParamSamplingDevelopment.Type = 'CrossValidation';
ParamSamplingDevelopment.CrossValidation.NFolds = 10;

%----------------------------------

ParamConstructModel.ParamModel.Dummy = 0;  %%% Allows general treatment

%----------------------------------

ParamResults.Dummy = 0;

%----------------------------------

%%% Disables bar of progress for PRTools (otherwise it may cause an error)
prwaitbar off;

%----------------------------------
