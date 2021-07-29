% -------------------------------------------------------------------------------------------------------------------------
% ■関数名: run_prompt_makeharness
% ■機能概要: 
% 　１．PROMPTでハーネスモデルまで作成させる
% ■入力：
% 　・modelName：解析するモデル名
% 　・target_subsystem_name：対象するサブシステム名
% 　・harness：harnessモデル名
% ■出力：
% 　・proj：PROMPTプロジェクトのオブジェクト
% ■備考：R2017bで正常実施確認済み
% -------------------------------------------------------------------------------------------------------------------------
function proj = run_prompt_makeharness(modelName,target_subsystem_name,harness)
    %% PROMPTのProject作成
    %harness = [modelName '_harness'];
    proj = Prompt.Project(modelName, harness); %-- 引数：(元モデル名, ハーネスモデル名)
    %% 対象サブシステムでATGを行う
    proj.CutSubsystem(convertStringsToChars(target_subsystem_name)); %PROMPT just accept char not string
    %% ハーネスモデル生成
    proj.MakeHarness();
end


