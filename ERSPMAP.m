%% 读取之前分析的脑电拓扑图数据与TFA数据，进行所有被试的平均
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 设置待存放变量的结构体
clear all; clc;
field1='Data';              
field2='LoadName';
field3='Name';
One_Subject = struct(field1,'',field2,'',field3,'');   % 存放单人数据的结构体
All_Subject = struct(field1,'',field2,'',field3,'');   % 存放多人数据的结构体

%% 读取数据，并保存到结构体中
    % 该部分代码，需要反复运行，更改Name以读取不同被试的数据
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % %
    Name_All=dir('E:\Matlab\外肢体、本体MI差异性实验\数据处理程序\数据\第二篇SCI\');
    Name_All(1:2)=[];
    for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='C3_Hz1720_ERSPmap_SRF_Good_BaseCor1.mat';  % 设置需要分析的试次名字
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
Data=squeeze(mean(Data,2));
Data_1=Data;
for i=1:length(All_Subject)
Data(i,:)=smooth(t,Data(i,:),20);
Data_1_smooth(i,:)=smooth(t,Data(i,:),20);
end

Data=mean(Data,1); %对所有试次进行平均
Data=reshape(Data,size(Data,2),size(Data,3));
  
  
 %% 读取数据，并保存到结构体中
    % 该部分代码，需要反复运行，更改Name以读取不同被试的数据
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % 
    All_Subject=[];
     for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='C3_Hz1720_ERSPmap_RF_Good_BaseCor1.mat';  % 设置需要分析的试次名字
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
%All_Subject(1)=[]; % 这是因为，B的第一行是空白行，因此给他删去
Data_Other=[];           % 定义一个空白矩阵，存放所有被试的数据
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
  
  Data_Other=mean(Data_Other,1); %对所有试次进行平均
  Data_Other=reshape(Data_Other,size(Data_Other,2),size(Data_Other,3)); 
  
 
  
  %% 读取数据，并保存到结构体中
    % 该部分代码，需要反复运行，更改Name以读取不同被试的数据
    % % % % % % % % % % % % % % % % % % % % %
    % % % % % % % % % % % % % % % % % % % % % 
    All_Subject=[];
     for Num=1:length(Name_All)
        Name=Name_All(Num).name;
        LoadName='C3_Hz1720_ERSPmap_Rest_BaseCor1.mat';  % 设置需要分析的试次名字
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
%All_Subject(1)=[]; % 这是因为，B的第一行是空白行，因此给他删去
Data_Rest=[];           % 定义一个空白矩阵，存放所有被试的数据
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
  
  Data_Rest=mean(Data_Rest,1); %对所有试次进行平均
  Data_Rest=reshape(Data_Rest,size(Data_Rest,2),size(Data_Rest,3));  
  
  
  %% 统计学分析
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

  %% 画图
  
  % % % % % 参数设定 % % % %
  t_lim = [min(t)+0.1 max(t)-0.1]; % specify the time range to be shown 这里+ - 0.1是为了消除边界突变的值，导致画图不好看
  t_idx = find((t<=t_lim(2))&(t>=t_lim(1)));
  % % % % 参数设定 % % % %
  
  figure(1);
  hold on; box on;
  plot(t,Data,'m','linewidth',2) % 这里的t是TFA_Data.m程序处理后，保存的变量，在本程序中直接Load进来的
  % 并且mean（）是为了平均Mu节律的ERSP值
  plot(t,Data_Other,'b','linewidth',2)  % 可以将多个状态下的ERSP波形图画在一幅图
  plot(t,Data_Rest,'k','linewidth',2) % 这里的t是TFA_Data.m程序处理后，保存的变量，在本程序中直接Load进来的
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  set(gca, 'linewidth', 2);

  
  
  figure(2);
  hold on; box on;
  plot(t,P_Value,'r','linewidth',2) % 这里的t是TFA_Data.m程序处理后，保存的变量，在本程序中直接Load进来的
  % 并且mean（）是为了平均Mu节律的ERSP
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  xlim=get(gca,'Xlim'); % gca代表此时的绘图区，'Xlim'代表X轴的范围'
  hold on
  plot(xlim,[0.05,0.05],'k-','LineWidth',1)
  
  figure(3);
  hold on; box on;
  plot(t,P_Value_Other,'r','linewidth',2) % 这里的t是TFA_Data.m程序处理后，保存的变量，在本程序中直接Load进来的
  % 并且mean（）是为了平均Mu节律的ERSP
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  xlim=get(gca,'Xlim'); % gca代表此时的绘图区，'Xlim'代表X轴的范围'
  hold on
  plot(xlim,[0.05,0.05],'k-','LineWidth',1)
  
  figure(4);
  hold on; box on;
  plot(t,P_Value_SRFRF,'r','linewidth',2) % 这里的t是TFA_Data.m程序处理后，保存的变量，在本程序中直接Load进来的
  % 并且mean（）是为了平均Mu节律的ERSP
  xlabel('Time'); ylabel('Power (dB)')
  %hl = legend('Welch''s (M=160, D=80)','Welch''s (M=160, D=0)','Welch''s (M=80, D=0)');
  %set(hl,'box','off','location','southwest')
  set(gca,'xlim',[min(t_lim),max(t_lim)])
  xlim=get(gca,'Xlim'); % gca代表此时的绘图区，'Xlim'代表X轴的范围'
  hold on
  plot(xlim,[0.05,0.05],'k-','LineWidth',1)
  

