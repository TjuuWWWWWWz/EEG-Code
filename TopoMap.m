
%% ���ô���ű����Ľṹ��
clear all; clc;
field1='Data';              
field2='LoadName';
field3='Name';
One_Subject = struct(field1,'',field2,'',field3,'');   % 
All_Subject = struct(field1,'',field2,'',field3,'');   % 

%% ��ȡ���ݣ������浽�ṹ����
    % 
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    Name_All=dir('E:\Matlab\��֫�塢����MI������ʵ��\���ݴ������\����\Data\');
    Name_All(1:2)=[];
    for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='Hz1720_Topomap_SRF_Good_BaseCor1.mat';  % 
        
        
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
            

            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% ��ȡ����
                One_Subject(DataNum).Data=importdata(Loadfile); % 
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
    SubNum=1;
    for i=1:size(All_Subject,2)
        

            Data(SubNum,:,:) = All_Subject(i).Data;                                    
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
  Data_1=Data;  
  Data=mean(Data,1); %�������Դν���ƽ��
  Data=reshape(Data,size(Data,2),size(Data,3));
  
  
%% ���Ե�����ͼ %%figure(2)

figure(1);clf
topoplot(Data,AEEG.chanlocs,'numcontour',4,'electrodes','on');
colorbar;

%% ��ȡ���ݣ������浽�ṹ����
All_Subject=[];
for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='Hz1720_Topomap_RF_Good_BaseCor1.mat';  % 
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
  
    SubNum=1;
    for i=1:size(All_Subject,2)
        

            Data(SubNum,:,:) = All_Subject(i).Data;                                    
            SubNum=SubNum+1;
        %end 
        
    end
    % % % % % % % % % % % % % % % % % % % % 
  Data_2=Data;  
  Data=mean(Data,1); %�������Դν���ƽ��
  Data=reshape(Data,size(Data,2),size(Data,3));
  
  
%% ���Ե�����ͼ %%figure(2)

figure(2);clf
topoplot(Data,AEEG.chanlocs,'numcontour',4,'electrodes','on');%,'maplimits',[-0.035 0.035]
colorbar;

 

P_Value=[];
for Chan_Num=1:AEEG.nbchan
    [~,P_Value(Chan_Num),~]=ttest(Data_1(:,Chan_Num)',Data_2(:,Chan_Num)');
%     if P_Value(Chan_Num)<0.05
%         P_Value(Chan_Num)=0;
%     else
%         P_Value(Chan_Num)=1;
%     end
end


figure(3);clf
load mycolor
topoplot(log(P_Value),AEEG.chanlocs,'numcontour',0,'electrodes','on','maplimits',[-5 0]);%,'maplimits',[-0.035 0.035]
colormap(mycolor);  % ʹ�����õ�jet��ɫ GRAY, HOT, COOL, BONE, COPPER, PINK, FLAG, PRISM, JET,
caxis([-5 0]); % ������ɫ�༭���������СֵΪ 1 �� -1
colorbar;

