% -------------------------------------------------------------------------------------------------------------------------
% ���֐���: run_prompt_makeharness
% ���@�\�T�v: 
% �@�P�DPROMPT�Ńn�[�l�X���f���܂ō쐬������
% �����́F
% �@�EmodelName�F��͂��郂�f����
% �@�Etarget_subsystem_name�F�Ώۂ���T�u�V�X�e����
% �@�Eharness�Fharness���f����
% ���o�́F
% �@�Eproj�FPROMPT�v���W�F�N�g�̃I�u�W�F�N�g
% �����l�FR2017b�Ő�����{�m�F�ς�
% -------------------------------------------------------------------------------------------------------------------------
function proj = run_prompt_makeharness(modelName,target_subsystem_name,harness)
    %% PROMPT��Project�쐬
    %harness = [modelName '_harness'];
    proj = Prompt.Project(modelName, harness); %-- �����F(�����f����, �n�[�l�X���f����)
    %% �ΏۃT�u�V�X�e����ATG���s��
    proj.CutSubsystem(convertStringsToChars(target_subsystem_name)); %PROMPT just accept char not string
    %% �n�[�l�X���f������
    proj.MakeHarness();
end


