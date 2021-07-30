% -------------------------------------------------------------------------------------------------------------------------
% ���֐���: run_prompt
% ���@�\�T�v: 
% �@�P�DPROMPT�������s
% �����́F
% �@�EmodelName�F��͂��郂�f����
% �@�Etarget_subsystem_name�F�Ώۂ���T�u�V�X�e����
% �@�Eharness�Fharness���f����
% ���o�́F
% �@�Eproj�FPROMPT�v���W�F�N�g�̃I�u�W�F�N�g
% �����l�FR2017b�Ő�����{�m�F�ς�
% -------------------------------------------------------------------------------------------------------------------------
function proj = run_prompt(modelName,target_subsystem_name,harness)
    %% PROMPT��Project�쐬
    %harness = [modelName '_harness'];
    proj = Prompt.Project(modelName, harness); %-- �����F(�����f����, �n�[�l�X���f����)
    %% �ΏۃT�u�V�X�e����ATG���s��
    proj.CutSubsystem(convertStringsToChars(target_subsystem_name)); %PROMPT just accept char not string
    %% �n�[�l�X���f������
    proj.MakeHarness();
    %% �f�[�^�������s
    %-- �I�v�V�����ݒ�
    proj.GenerateOption.MaxProcessTimeSec = 2500;               %-- �^�C���A�E�g[sec]
    proj.GenerateOption.MaxCandidates     = 500;               %-- ���s��
    proj.GenerateOption.StopTime          = str2double(get_param(modelName,'FixedStep'))*1000;          %-- �e�X�g�P�[�X�̒����i���ԁj
    %proj.GenerateOption.CalibrationSettingFile = 'calib.txt'; %�萔�L�����u���[�V����
    %-- ���s
    proj.Generate();
    %-- ������̃n�[�l�X���f���ۑ�
    save_system(harness);
    %% ���|�[�g����
    % proj.CoverageReportFile = 'coverage.json';    %--�t�@�C�����ύX
    proj.ReportCoverage();
    edit(proj.CoverageReportFile); %--�\��
    % proj.UnCoveredReportFile = 'uncoverage.json'; %--�t�@�C�����ύX
    proj.ReportUncoveredBlocks();
    edit(proj.UnCoveredReportFile);
    % proj.UnSupportedReportFile = 'unsupported.json'; %--�t�@�C�����ύX
    proj.ReportUnsupportedBlocks();
    %% CSV�o��
    %-- �ꊇ1�t�@�C���o��
    proj.ExportTestData();
end


