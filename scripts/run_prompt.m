% -------------------------------------------------------------------------------------------------------------------------
% ■関数名: run_prompt
% ■機能概要: 
% 　１．PROMPT自動実行
% ■入力：
% 　・modelName：解析するモデル名
% 　・target_subsystem_name：対象するサブシステム名
% 　・harness：harnessモデル名
% ■出力：
% 　・proj：PROMPTプロジェクトのオブジェクト
% ■備考：R2017bで正常実施確認済み
% -------------------------------------------------------------------------------------------------------------------------
function proj = run_prompt(modelName,target_subsystem_name,harness)
    %% PROMPTのProject作成
    %harness = [modelName '_harness'];
    proj = Prompt.Project(modelName, harness); %-- 引数：(元モデル名, ハーネスモデル名)
    %% 対象サブシステムでATGを行う
    proj.CutSubsystem(convertStringsToChars(target_subsystem_name)); %PROMPT just accept char not string
    %% ハーネスモデル生成
    proj.MakeHarness();
    %% データ生成実行
    %-- オプション設定
    proj.GenerateOption.MaxProcessTimeSec = 2500;               %-- タイムアウト[sec]
    proj.GenerateOption.MaxCandidates     = 500;               %-- 試行回数
    proj.GenerateOption.StopTime          = str2double(get_param(modelName,'FixedStep'))*1000;          %-- テストケースの長さ（時間）
    %proj.GenerateOption.CalibrationSettingFile = 'calib.txt'; %定数キャリブレーション
    %-- 実行
    proj.Generate();
    %-- 生成後のハーネスモデル保存
    save_system(harness);
    %% レポート生成
    % proj.CoverageReportFile = 'coverage.json';    %--ファイル名変更
    proj.ReportCoverage();
    edit(proj.CoverageReportFile); %--表示
    % proj.UnCoveredReportFile = 'uncoverage.json'; %--ファイル名変更
    proj.ReportUncoveredBlocks();
    edit(proj.UnCoveredReportFile);
    % proj.UnSupportedReportFile = 'unsupported.json'; %--ファイル名変更
    proj.ReportUnsupportedBlocks();
    %% CSV出力
    %-- 一括1ファイル出力
    proj.ExportTestData();
end


