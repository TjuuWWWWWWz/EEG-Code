%% ��ȡ֮ǰ�������Ե�����ͼ������TFA���ݣ��������б��Ե�ƽ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ���ô���ű����Ľṹ��
clear all; clc;
field1='Data';              
field2='LoadName';
field3='Name';
One_Subject = struct(field1,'',field2,'',field3,'');   % ��ŵ������ݵĽṹ��
All_Subject = struct(field1,'',field2,'',field3,'');   % ��Ŷ������ݵĽṹ��
load(strcat(...
    'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\','t-Rest.mat'));
%% ��ȡ���ݣ������浽�ṹ����
    % �ò��ִ��룬��Ҫ�������У�����Name�Զ�ȡ��ͬ���Ե�����
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    Name_All=dir('E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\');
    Name_All(1:2)=[];
    for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='CP4_TFmap_SRF_Good_BaseCor1.mat';  % ������Ҫ�������Դ�����
        %Name='zhanghaichao';1
        % ��������������������Ϊ��ͼʱ��Ҫ�ñ�������������û�м��㵽�ñ���
        load(strcat(...
            'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\','TFA_Data\','AEEG.mat'));
        load(strcat(...
            'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\','TFA_Data\','f.mat'));
%         load(strcat(...
%             'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\','TFA_Data\','t.mat'));
        % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % %
        
        path=strcat('E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\');  %���ݴ��·��
        [files,class_num] = GetFiles_path_mat(path); %��ȡ·���ļ����������.mat�ļ�����
        
        DataNum=1;
        for i=1:class_num(1)
            
            %num=ismember(LoadName,files(i).name) ;   % �ú�����Ϊ���ҳ���LoadNameһ�����ļ�����
            %if size(LoadName,2)==size(files(i).name,2);          % ����1������ļ����֣�����LoadName����᷵���߼�ֵ��1��
            % ��ˣ�����ļ�������������LoadNmae
            % ��num���ܺ;͵���LoadName�ĳ���
            % ����2��ֱ�ӱȽ��������ֵĳ��ȣ���һ��������
            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% ��ȡ����
                One_Subject(DataNum).Data=importdata(Loadfile); % ������Name��files(i).name���Լ�����Data���浽�ṹ����
                One_Subject(DataNum).LoadName=files(i).name;
                One_Subject(DataNum).Name=Name;
                DataNum=DataNum+1;
            end
            
            
        end
        
        All_Subject = [All_Subject,One_Subject];      % ���ǽ������ṹ��ƴ��
        One_Subject = struct(field1,'',field2,'',field3,''); % One_Subject��սṹ�壬������һ���˵�
    end
%% ���ݶ�ȡ��Ϻ󣬽��кϲ�����
All_Subject(1)=[]; % ������Ϊ��B�ĵ�һ���ǿհ��У���˸���ɾȥ
Data=[];           % ����һ���հ׾��󣬴�����б��Ե�����
%f=linspace(0,128,1025);
%t=linspace(-1,6,1792);
    % % % % % % % % % % % % % % % % % % % % % 
    % ��һ������Ϊ���ж�����ߴ���ķ���������Ҫѡ������һ������ % 
    % ���Ҫѡ��һ�������������Դμ��ƽ�� %
    %DataName='Mu_Topomap_RF_Good_BaseCor2.mat';      
    SubNum=1;
    for i=1:size(All_Subject,2)
        
        %num=ismember(DataName,All_Subject(i).LoadName);    % �ú�����Ϊ���ҳ���LoadNameһ�����ļ�����
        %if sum(num)==size(DataName,2);          % ����ļ����֣�����LoadName����᷵���߼�ֵ��1��
                                                % ��ˣ�����ļ�������������LoadNmae
                                                % ��num���ܺ;͵���LoadName�ĳ���
            Data(SubNum,:,:) = All_Subject(i).Data;                                    
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
%   Data_1_P=Data;  
  for i=1:length(All_Subject)
      for j = 1:42
          Data_1_P(i,j,:)=smooth(Data(i,j,:),20);
      end
  end
  Data_1=mean(Data_1_P,1); %�������Դν���ƽ��

  Data_1=squeeze(Data_1);

  
  %% ����ʱƵ�ȶ�ͼ %%
% % % % �����趨 % % % %
f_lim = [min(f(f>7)) 28]; % specify the frequency range to be shown (remove 0Hz)
f_idx = find((f<=f_lim(2))&(f>=f_lim(1)));
t_lim = [min(t) max(t)]; % specify the time range to be shown
t_idx = find((t<=t_lim(2))&(t>=t_lim(1)));
% % % % �����趨 % % % %
figure(1);
P_unit_2 = 'Percentage (100%)'; % ��ɫ��������
subplot(1,1,1)
imagesc(t(t_idx),f(f_idx),Data_1)
axis xy; hold on;
plot([0 0],f_lim,'w--')
xlabel('Time (s)'); ylabel('Frequency (Hz)');
colormap(gca,jet);
set(gca,'xlim',t_lim,'ylim',f_lim,'clim',[-2.8 2.8] )   %'clim'����colorbar��Χ
% text(t_lim(2),f_lim(2)/2,P_unit_2,'rotation',90,'horizontalalignment','center','verticalalignment','top')
% title('Baseline-corrected TFD (Relative Change)','fontsize',12)
colorbar;
set(gca, 'linewidth', 2);

%% ��ȡ���ݣ������浽�ṹ����
    % �ò��ִ��룬��Ҫ�������У�����Name�Զ�ȡ��ͬ���Ե�����
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    All_Subject=[];
for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='CP4_TFmap_RF_Good_BaseCor1.mat';  % ������Ҫ�������Դ�����
        %Name='zhanghaichao';
        % ��������������������Ϊ��ͼʱ��Ҫ�ñ�������������û�м��㵽�ñ���
        load(strcat(...
            'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\','TFA_Data\','AEEG.mat'));
        load(strcat(...
            'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\','TFA_Data\','f.mat'));
%         load(strcat(...
%             'E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\','TFA_Data\','t.mat'));
        % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % %
        
        path=strcat('E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\',Name,'\');  %���ݴ��·��
        [files,class_num] = GetFiles_path_mat(path); %��ȡ·���ļ����������.mat�ļ�����
        
        DataNum=1;
        for i=1:class_num(1)
            
            %num=ismember(LoadName,files(i).name) ;   % �ú�����Ϊ���ҳ���LoadNameһ�����ļ�����
            %if size(LoadName,2)==size(files(i).name,2);          % ����1������ļ����֣�����LoadName����᷵���߼�ֵ��1��
            % ��ˣ�����ļ�������������LoadNmae
            % ��num���ܺ;͵���LoadName�ĳ���
            % ����2��ֱ�ӱȽ��������ֵĳ��ȣ���һ��������
            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% ��ȡ����
                One_Subject(DataNum).Data=importdata(Loadfile); % ������Name��files(i).name���Լ�����Data���浽�ṹ����
                One_Subject(DataNum).LoadName=files(i).name;
                One_Subject(DataNum).Name=Name;
                DataNum=DataNum+1;
            end
            
            
        end
        
        All_Subject = [All_Subject,One_Subject];      % ���ǽ������ṹ��ƴ��
        One_Subject = struct(field1,'',field2,'',field3,''); % One_Subject��սṹ�壬������һ���˵�
    end
%% ���ݶ�ȡ��Ϻ󣬽��кϲ�����
%All_Subject(1)=[]; % ������Ϊ��B�ĵ�һ���ǿհ��У���˸���ɾȥ
Data=[];           % ����һ���հ׾��󣬴�����б��Ե�����
%f=linspace(0,128,1025);
%t=linspace(-1,6,1792);
    % % % % % % % % % % % % % % % % % % % % % 
    % ��һ������Ϊ���ж�����ߴ���ķ���������Ҫѡ������һ������ % 
    % ���Ҫѡ��һ�������������Դμ��ƽ�� %
    %DataName='Mu_Topomap_RF_Good_BaseCor2.mat';      
    SubNum=1;
    for i=1:size(All_Subject,2)
        
        %num=ismember(DataName,All_Subject(i).LoadName);    % �ú�����Ϊ���ҳ���LoadNameһ�����ļ�����
        %if sum(num)==size(DataName,2);          % ����ļ����֣�����LoadName����᷵���߼�ֵ��1��
                                                % ��ˣ�����ļ�������������LoadNmae
                                                % ��num���ܺ;͵���LoadName�ĳ���
            Data(SubNum,:,:) = All_Subject(i).Data;                                    
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
%     Data_2_P=Data;
    for i=1:length(All_Subject)
        for j = 1:length(f_idx)
            Data_2_P(i,j,:)=smooth(Data(i,j,:),20);
        end
    end
    Data_2=mean(Data_2_P,1); %�������Դν���ƽ��
    Data_2=squeeze(Data_2);
    
     %% ����ʱƵ�ȶ�ͼ %%
    figure(2);
    P_unit_2 = 'Percentage (100%)'; % ��ɫ��������
    subplot(1,1,1)
    imagesc(t(t_idx),f(f_idx),Data_2)
    axis xy; hold on;
    plot([0 0],f_lim,'w--')
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    colormap(gca,jet);
    set(gca,'xlim',t_lim,'ylim',f_lim,'clim',[-2.8 2.8] )   %'clim'����colorbar��Χ
%     text(t_lim(2),f_lim(2)/2,P_unit_2,'rotation',90,'horizontalalignment','center','verticalalignment','top')
%     title('Baseline-corrected TFD (Relative Change)','fontsize',12)
    colorbar;
    set(gca, 'linewidth', 2);
  
   %% ͳ��ѧ���� %%
    P_Value=[];

    for Time_Num=1:length(t)
        for Freq_Num=1:length(f_idx)
        [~,P_Value(Freq_Num,Time_Num),~]=ttest(Data_1_P(:,Freq_Num,Time_Num)',Data_2_P(:,Freq_Num,Time_Num)');
%         if P_Value(Freq_Num,Time_Num)<0.05
%             P_Value(Freq_Num,Time_Num)=0;
%         else
%             P_Value(Freq_Num,Time_Num)=1;
%         end
        end
    end
    figure(3);
    load mycolor
    P_unit_2 = 'Percentage (100%)'; % ��ɫ��������
    subplot(1,1,1)
    imagesc(t(t_idx),f(f_idx),log(P_Value))
    axis xy; hold on;
    plot([0 0],f_lim,'w--')
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    colormap(mycolor);
    set(gca,'xlim',t_lim,'ylim',f_lim,'clim',[-5 0])   %'clim'����colorbar��Χ
    %text(t_lim(2),f_lim(2)/2)
    %title('Baseline-corrected TFD (Relative Change)','fontsize',12)
    colorbar;
    set(gca, 'linewidth', 2);
    

    