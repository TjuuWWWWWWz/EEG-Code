%% ��ȡ֮ǰ�������Ե�����ͼ������TFA���ݣ��������б��Ե�ƽ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ���ô���ű����Ľṹ��
clear all; clc;
field1='Data';              
field2='LoadName';
field3='Name';
One_Subject = struct(field1,'',field2,'',field3,'');   % ��ŵ������ݵĽṹ��
All_Subject = struct(field1,'',field2,'',field3,'');   % ��Ŷ������ݵĽṹ��

%% ��ȡ���ݣ������浽�ṹ����
    % �ò��ִ��룬��Ҫ�������У�����Name�Զ�ȡ��ͬ���Ե�����
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    Name_All=dir('E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\�ڶ�ƪSCI\');
    Name_All(1:2)=[];
    for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='C3_Hz1720_ERSPmap_SRF_Good_BaseCor1.mat';  % ������Ҫ�������Դ�����
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
Data=squeeze(mean(Data,2));
Data_1=Data;
for i=1:length(All_Subject)
Data(i,:)=smooth(t,Data(i,:),20);
Data_1_smooth(i,:)=smooth(t,Data(i,:),20);
end

Data=mean(Data,1); %�������Դν���ƽ��
Data=reshape(Data,size(Data,2),size(Data,3));
  
  
 %% ��ȡ���ݣ������浽�ṹ����
    % �ò��ִ��룬��Ҫ�������У�����Name�Զ�ȡ��ͬ���Ե�����
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % 
    All_Subject=[];
     for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='C3_Hz1720_ERSPmap_RF_Good_BaseCor1.mat';  % ������Ҫ�������Դ�����
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
%All_Subject(1)=[]; % ������Ϊ��B�ĵ�һ���ǿհ��У���˸���ɾȥ
Data_Other=[];           % ����һ���հ׾��󣬴�����б��Ե�����
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
            Data_Other(SubNum,:,:) = All_Subject(i).Data; 
            
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
  Data_Other=squeeze(mean(Data_Other,2));  
  Data_2=Data_Other;
  for i=1:length(All_Subject)
  Data_Other(i,:)=smooth(t,Data_Other(i,:),20);
  Data_2_smooth(i,:)=smooth(t,Data_Other(i,:),20);
  end
  
  Data_Other=mean(Data_Other,1); %�������Դν���ƽ��
  Data_Other=reshape(Data_Other,size(Data_Other,2),size(Data_Other,3)); 
  
 
  
  %% ��ȡ���ݣ������浽�ṹ����
    % �ò��ִ��룬��Ҫ�������У�����Name�Զ�ȡ��ͬ���Ե�����
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % 
    All_Subject=[];
     for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='C3_Hz1720_ERSPmap_Rest_BaseCor1.mat';  % ������Ҫ�������Դ�����
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
%All_Subject(1)=[]; % ������Ϊ��B�ĵ�һ���ǿհ��У���˸���ɾȥ
Data_Rest=[];           % ����һ���հ׾��󣬴�����б��Ե�����
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
            Data_Rest(SubNum,:,:) = All_Subject(i).Data; 
            
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
  Data_Rest=squeeze(mean(Data_Rest,2));  
  Data_3=Data_Rest;
  for i=1:length(All_Subject)
  Data_Rest(i,:)=smooth(t,Data_Rest(i,:),20);
  Data_3_smooth(i,:)=smooth(t,Data_Rest(i,:),20);
  end
  
  Data_Rest=mean(Data_Rest,1); %�������Դν���ƽ��
  Data_Rest=reshape(Data_Rest,size(Data_Rest,2),size(Data_Rest,3));  
  
  
  %% ͳ��ѧ����
%   for i=1:39
%       [~,P_Value(i),~]=ttest2(mean(Data_1(:,i*5:(i+1)*5),2)',mean(Data_1(:,1:24),2)');
%             if P_Value(i)<0.01
%                 P_Value(i)=0;
%             else
%                 P_Value(i)=1;
%             end
%   end
%   
  
  for Time_Num=1:length(t)
      
%       [~,P_Value(Time_Num),~]=ttest(Data_1(:,Time_Num)',mean(Data_1(:,1:24),2)');
      [~,P_Value(Time_Num),~]=ttest(Data_1_smooth(:,Time_Num)',mean(Data_1_smooth(:,1:24),2)');
%       if P_Value(Time_Num)<0.01
%           P_Value(Time_Num)=0;
%       else
%           P_Value(Time_Num)=1;
%       end
      
  end
  
  for Time_Num=1:length(t)
      
%       [~,P_Value_Other(Time_Num),~]=ttest(Data_2(:,Time_Num)',mean(Data_2(:,1:24),2)');
      [~,P_Value_Other(Time_Num),~]=ttest(Data_2_smooth(:,Time_Num)',mean(Data_2_smooth(:,1:24),2)');
%       if P_Value_Other(Time_Num)<0.01
%           P_Value_Other(Time_Num)=0;
%       else
%           P_Value_Other(Time_Num)=1;
%       end
%       
  end
  
  for Time_Num=1:length(t)
      
      [~,P_Value_SRFRF(Time_Num),~]=ttest(Data_1_smooth(:,Time_Num)',Data_2_smooth(:,Time_Num)');
%       [~,P_Value_SRFRF(Time_Num),~]=ttest(Data_1(:,Time_Num)',Data_2(:,Time_Num)');
%       if P_Value_SRFRF(Time_Num)<0.05
%           P_Value_SRFRF(Time_Num)=0;
%       else
%           P_Value_SRFRF(Time_Num)=1;
%       end
      
  end

  %% ��ͼ
  
  % % % % % �����趨 % % % %
  t_lim = [min(t)+0.1 max(t)-0.1]; % specify the time range to be shown ����+ - 0.1��Ϊ�������߽�ͻ���ֵ�����»�ͼ���ÿ�
  t_idx = find((t<=t_lim(2))&(t>=t_lim(1)));
  % % % % �����趨 % % % %
  
  figure(1);
  hold on; box on;
  plot(t,Data,'m','linewidth',2) % �����t��TFA_Data.m������󣬱���ı������ڱ�������ֱ��Load������
  % ����mean������Ϊ��ƽ��Mu���ɵ�ERSPֵ
  plot(t,Data_Other,'b','linewidth',2)  % ���Խ����״̬�µ�ERSP����ͼ����һ��ͼ
  plot(t,Data_Rest,'k','linewidth',2) % �����t��TFA_Data.m������󣬱���ı������ڱ�������ֱ��Load������
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  set(gca, 'linewidth', 2);

  
  
  figure(2);
  hold on; box on;
  plot(t,P_Value,'r','linewidth',2) % �����t��TFA_Data.m������󣬱���ı������ڱ�������ֱ��Load������
  % ����mean������Ϊ��ƽ��Mu���ɵ�ERSP
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  xlim=get(gca,'Xlim'); % gca�����ʱ�Ļ�ͼ����'Xlim'����X��ķ�Χ'
  hold on
  plot(xlim,[0.05,0.05],'k-','LineWidth',1)
  
  figure(3);
  hold on; box on;
  plot(t,P_Value_Other,'r','linewidth',2) % �����t��TFA_Data.m������󣬱���ı������ڱ�������ֱ��Load������
  % ����mean������Ϊ��ƽ��Mu���ɵ�ERSP
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  xlim=get(gca,'Xlim'); % gca�����ʱ�Ļ�ͼ����'Xlim'����X��ķ�Χ'
  hold on
  plot(xlim,[0.05,0.05],'k-','LineWidth',1)
  
  figure(4);
  hold on; box on;
  plot(t,P_Value_SRFRF,'r','linewidth',2) % �����t��TFA_Data.m������󣬱���ı������ڱ�������ֱ��Load������
  % ����mean������Ϊ��ƽ��Mu���ɵ�ERSP
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  xlim=get(gca,'Xlim'); % gca�����ʱ�Ļ�ͼ����'Xlim'����X��ķ�Χ'
  hold on
  plot(xlim,[0.05,0.05],'k-','LineWidth',1)
  

