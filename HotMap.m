%% 读取之前分析的脑电拓扑图数据与TFA数据，进行所有被试的平均
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 设置待存放变量的结构体
clear all; clc;
field1='Data';              
field2='LoadName';
field3='Name';
One_Subject = struct(field1,'',field2,'',field3,'');   % 存放单人数据的结构体
All_Subject = struct(field1,'',field2,'',field3,'');   % 存放多人数据的结构体
load(strcat(...
    'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\','t-Rest.mat'));
%% 读取数据，并保存到结构体中
    % 该部分代码，需要反复运行，更改Name以读取不同被试的数据
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    Name_All=dir('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\');
    Name_All(1:2)=[];
    for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='CP4_TFmap_SRF_Good_BaseCor1.mat';  % 设置需要分析的试次名字
        %Name='zhanghaichao';1
        % 导入以下三个变量是因为画图时需要该变量，而本程序没有计算到该变量
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','AEEG.mat'));
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','f.mat'));
%         load(strcat(...
%             'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','t.mat'));
        % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % %
        
        path=strcat('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\');  %数据存放路径
        [files,class_num] = GetFiles_path_mat(path); %读取路径文件夹里的所有.mat文件名字
        
        DataNum=1;
        for i=1:class_num(1)
            
            %num=ismember(LoadName,files(i).name) ;   % 该函数是为了找出与LoadName一样的文件名字
            %if size(LoadName,2)==size(files(i).name,2);          % 方法1：如果文件名字，包含LoadName，则会返回逻辑值“1”
            % 因此，如果文件名字完整包含LoadNmae
            % 则num的总和就等于LoadName的长度
            % 方法2：直接比较两个名字的长度，若一样，则导入
            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% 读取数据
                One_Subject(DataNum).Data=importdata(Loadfile); % 将变量Name、files(i).name、以及数据Data储存到结构体中
                One_Subject(DataNum).LoadName=files(i).name;
                One_Subject(DataNum).Name=Name;
                DataNum=DataNum+1;
            end
            
            
        end
        
        All_Subject = [All_Subject,One_Subject];      % 这是将两个结构体拼接
        One_Subject = struct(field1,'',field2,'',field3,''); % One_Subject清空结构体，储存下一个人的
    end
%% 数据读取完毕后，进行合并分析
All_Subject(1)=[]; % 这是因为，B的第一行是空白行，因此给他删去
Data=[];           % 定义一个空白矩阵，存放所有被试的数据
%f=linspace(0,128,1025);
%t=linspace(-1,6,1792);
    % % % % % % % % % % % % % % % % % % % % % 
    % 这一步是因为，有多个基线处理的方法，我们要选择其中一个方法 % 
    % 因此要选定一个方法，进行试次间的平均 %
    %DataName='Mu_Topomap_RF_Good_BaseCor2.mat';      
    SubNum=1;
    for i=1:size(All_Subject,2)
        
        %num=ismember(DataName,All_Subject(i).LoadName);    % 该函数是为了找出与LoadName一样的文件名字
        %if sum(num)==size(DataName,2);          % 如果文件名字，包含LoadName，则会返回逻辑值“1”
                                                % 因此，如果文件名字完整包含LoadNmae
                                                % 则num的总和就等于LoadName的长度
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
  Data_1=mean(Data_1_P,1); %对所有试次进行平均

  Data_1=squeeze(Data_1);

  
  %% 画脑时频热度图 %%
% % % % 参数设定 % % % %
f_lim = [min(f(f>7)) 28]; % specify the frequency range to be shown (remove 0Hz)
f_idx = find((f<=f_lim(2))&(f>=f_lim(1)));
t_lim = [min(t) max(t)]; % specify the time range to be shown
t_idx = find((t<=t_lim(2))&(t>=t_lim(1)));
% % % % 参数设定 % % % %
figure(1);
P_unit_2 = 'Percentage (100%)'; % 颜色柱的名字
subplot(1,1,1)
imagesc(t(t_idx),f(f_idx),Data_1)
axis xy; hold on;
plot([0 0],f_lim,'w--')
xlabel('Time (s)'); ylabel('Frequency (Hz)');
colormap(gca,jet);
set(gca,'xlim',t_lim,'ylim',f_lim,'clim',[-2.8 2.8] )   %'clim'设置colorbar范围
% text(t_lim(2),f_lim(2)/2,P_unit_2,'rotation',90,'horizontalalignment','center','verticalalignment','top')
% title('Baseline-corrected TFD (Relative Change)','fontsize',12)
colorbar;
set(gca, 'linewidth', 2);

%% 读取数据，并保存到结构体中
    % 该部分代码，需要反复运行，更改Name以读取不同被试的数据
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    All_Subject=[];
for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='CP4_TFmap_RF_Good_BaseCor1.mat';  % 设置需要分析的试次名字
        %Name='zhanghaichao';
        % 导入以下三个变量是因为画图时需要该变量，而本程序没有计算到该变量
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','AEEG.mat'));
        load(strcat(...
            'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','f.mat'));
%         load(strcat(...
%             'E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\','TFA_Data\','t.mat'));
        % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % %
        
        path=strcat('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\Data\',Name,'\');  %数据存放路径
        [files,class_num] = GetFiles_path_mat(path); %读取路径文件夹里的所有.mat文件名字
        
        DataNum=1;
        for i=1:class_num(1)
            
            %num=ismember(LoadName,files(i).name) ;   % 该函数是为了找出与LoadName一样的文件名字
            %if size(LoadName,2)==size(files(i).name,2);          % 方法1：如果文件名字，包含LoadName，则会返回逻辑值“1”
            % 因此，如果文件名字完整包含LoadNmae
            % 则num的总和就等于LoadName的长度
            % 方法2：直接比较两个名字的长度，若一样，则导入
            if strcmp(LoadName,files(i).name)==1
                
                Loadfile=strcat(path,files(i).name);% 读取数据
                One_Subject(DataNum).Data=importdata(Loadfile); % 将变量Name、files(i).name、以及数据Data储存到结构体中
                One_Subject(DataNum).LoadName=files(i).name;
                One_Subject(DataNum).Name=Name;
                DataNum=DataNum+1;
            end
            
            
        end
        
        All_Subject = [All_Subject,One_Subject];      % 这是将两个结构体拼接
        One_Subject = struct(field1,'',field2,'',field3,''); % One_Subject清空结构体，储存下一个人的
    end
%% 数据读取完毕后，进行合并分析
%All_Subject(1)=[]; % 这是因为，B的第一行是空白行，因此给他删去
Data=[];           % 定义一个空白矩阵，存放所有被试的数据
%f=linspace(0,128,1025);
%t=linspace(-1,6,1792);
    % % % % % % % % % % % % % % % % % % % % % 
    % 这一步是因为，有多个基线处理的方法，我们要选择其中一个方法 % 
    % 因此要选定一个方法，进行试次间的平均 %
    %DataName='Mu_Topomap_RF_Good_BaseCor2.mat';      
    SubNum=1;
    for i=1:size(All_Subject,2)
        
        %num=ismember(DataName,All_Subject(i).LoadName);    % 该函数是为了找出与LoadName一样的文件名字
        %if sum(num)==size(DataName,2);          % 如果文件名字，包含LoadName，则会返回逻辑值“1”
                                                % 因此，如果文件名字完整包含LoadNmae
                                                % 则num的总和就等于LoadName的长度
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
    Data_2=mean(Data_2_P,1); %对所有试次进行平均
    Data_2=squeeze(Data_2);
    
     %% 画脑时频热度图 %%
    figure(2);
    P_unit_2 = 'Percentage (100%)'; % 颜色柱的名字
    subplot(1,1,1)
    imagesc(t(t_idx),f(f_idx),Data_2)
    axis xy; hold on;
    plot([0 0],f_lim,'w--')
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    colormap(gca,jet);
    set(gca,'xlim',t_lim,'ylim',f_lim,'clim',[-2.8 2.8] )   %'clim'设置colorbar范围
%     text(t_lim(2),f_lim(2)/2,P_unit_2,'rotation',90,'horizontalalignment','center','verticalalignment','top')
%     title('Baseline-corrected TFD (Relative Change)','fontsize',12)
    colorbar;
    set(gca, 'linewidth', 2);
  
   %% 统计学分析 %%
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
    P_unit_2 = 'Percentage (100%)'; % 颜色柱的名字
    subplot(1,1,1)
    imagesc(t(t_idx),f(f_idx),log(P_Value))
    axis xy; hold on;
    plot([0 0],f_lim,'w--')
    xlabel('Time (s)'); ylabel('Frequency (Hz)');
    colormap(mycolor);
    set(gca,'xlim',t_lim,'ylim',f_lim,'clim',[-5 0])   %'clim'设置colorbar范围
    %text(t_lim(2),f_lim(2)/2)
    %title('Baseline-corrected TFD (Relative Change)','fontsize',12)
    colorbar;
    set(gca, 'linewidth', 2);
    

    