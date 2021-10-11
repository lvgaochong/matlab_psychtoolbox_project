clc;
clear;
close all;
sca;
oldPreferenceValue = 0;
oldPreferenceValue = Screen('Preference', 'SkipSyncTests', 1);
KbName('UnifyKeyNames');
t_start = datetime('now');         %开始记录时间
numb_all_sample = 5;
% global center;
try
    KeyIsDown=0;%定义按键变量，赋值为0代表被试没按键
    Screens=Screen('Screens');
    ScreenNum=max(Screens);
    % 打开一个新的屏幕
    %     [w,wRect]=Screen('OpenWindow',ScreenNum);%w指代当前的屏幕的位置大小
    %     [center(1), center(2)] = RectCenter(wRect); % [横轴，纵轴]=中心位置
    Screen('Preference', 'SkipSyncTests', 1)
    [w, wRect] = PsychImaging('OpenWindow', ScreenNum, white);  % open a screen window with grey color
    Screen('Flip', w);
    [center(1), center(2)] = Screen('WindowSize',w);
    
    black=BlackIndex(w);
    white=WhiteIndex(w);
    gray=(white+black)/2;
    Screen('FillRect',w,gray); %把屏幕w涂成gray颜色
    Screen('Flip',w); %需要flip上面对屏幕的操作才会显现出来
    %---------------------------%
    spaceKey = KbName('space');
    escapeKey = KbName('escape');
    LookKey =KbName('q');
    SmellKey=KbName('w');
    TasteKey1=KbName('e');
    swallowKey=KbName('t');
    %---------------------------%
    fontsize = 30;%字号
    %% 欢迎界面
    [t_screenr0,t_spacer0] = welcome_design(spaceKey,w,1,center,fontsize);%15s
    rest_time(spaceKey,w,15,center,fontsize);%休息15s
    %------------------%
    for i = 1:5
        second_group_start(spaceKey,w,1,i,fontsize);%您将对第1组进行。。。
        Look_time_all(w,LookKey,15,i,fontsize);%观色15s
        smell_time_all(w,SmellKey,30,i,fontsize);%闻30s
        taste_time(TasteKey1,w,5,i,fontsize)%品尝5s
        swallow_time(swallowKey,w,20,i,fontsize)%吞咽后20s
        smell_time_1_s(w,spaceKey,1,i,fontsize);%停止1s
    end
    %----------------%
    end_time(spaceKey,w,0,fontsize);%结束0s
    Screen('CloseAll');  %结束，关闭屏幕
catch
    ShowCursor;
    Screen('CloseAll');
    Priority(0);
    psychrethrow(psychlasterror);
end
function [t_screenr1,t_spacer1] = welcome_design(spaceKey,w,second,cent,fontsize)
%% 欢迎界面
Text_r1=double('您好，感谢您参与本次实验。');
Text_r2=double('您将品评共5个样品');
Text_r3=double('请您根据屏幕提示，对每个样品进行');
Text_r4=double('观色15秒、闻香30秒、品尝5秒（不吞咽）、吞咽后20秒');
Text_r5=double('品评后，根据喜好度，');
Text_r6=double('填写调查问卷');

% Text = {Text_r1,Text_r2,Text_r3,Text_r4,Text_r5};
% screen_display(w,Text,cent);
% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为40号
Screen('Preference','TextEncodingLocale','UTF-8')
Screen('TextFont', w, 'Simsun');

Screen('TextSize',window,48);
Screen('TextFont', window, 'Simsun');
DrawFormattedText(window, Text_r1, 'center',cent(2)*0.4,[0 0 0]);
DrawFormattedText(window, Text_r21, 'center',cent(2)*0.4,[0 0 0]);

Screen('DrawText', w, Text_r1 ,650-length(Text_r1)*fontsize/2,540-10*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_r2 ,650-length(Text_r2)*fontsize/2,540-6*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_r3 ,650-length(Text_r3)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_r4 ,650-length(Text_r4)*fontsize/2,540+2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_r5 ,650-length(Text_r5)*fontsize/2,540+6*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_r6 ,650-length(Text_r6)*fontsize/2,540+10*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('Flip',w);
t_screenr1=datetime('now');
start_r1=1;
while (start_r1==1)
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(spaceKey)
            start_r1=0;
            t_spacer1=datetime('now');
        end
    end
end
KeyIsDown=0;
count_down(w,second);
end

function [t_screenr1,t_spacer1]=rest_time(spaceKey,w,second,cent,fontsize)
Text_r1=double('请您放松，静息15秒');
Text_r2=double('按空格键进入倒计时');
% Text_r3=double('准备好后，按空格后开始计时。');
Text = {Text_r1,Text_r2};
% screen_display(w,Text,cent);
% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为40号
Screen('Preference','TextEncodingLocale','UTF-8')
Screen('TextFont', w, 'Simsun');
Screen('DrawText', w, Text_r1 ,650-length(Text_r1)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_r2 ,650-length(Text_r2)*fontsize/2,540+2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
% Screen('DrawText', w, Text_r3 ,650-length(Text_r3)*fontsize/2,540+3*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('Flip',w);
t_screenr1=datetime('now');
start_r1=1;
while (start_r1==1)
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(spaceKey)
            start_r1=0;
            t_spacer1=datetime('now');
        end
    end
end
KeyIsDown=0;
%     count_down(w)
% 倒计时
count_down(w,second);
end
function [t_screen2,t_space2] = prompt_time_all(w,spaceKey1,second,numb_sample,fontsize)
%%  闻香
Text_1=double(['您将对样品',num2str(numb_sample),'进行评价']);
Text_2=double('请按屏幕提示进行操作，并填写问卷');
Text_3=double('按空格键继续');
% Text_4=double('按q键开始闻香倒计时');

% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为18号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-6*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+2*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+6*fontsize/2,[0,0,1]);
Screen('Flip',w);
t_screen2=datetime('now');
start_2=1;
while (start_2==1)
    [KeyIsDown, secs, KeyCode] = KbCheck;
    if KeyIsDown
        if KeyCode(SmellKey1)
            start_2=0;
            t_space2=datetime('now');
        end
    end
end
KeyIsDown=0;
count_down(w,second);
end

function [t_screen2,t_space2] = Look_time_all(w,SmellKey1,second,numb_sample,fontsize)
%%  闻香
Text_1=double(['请您端起样品',num2str(numb_sample)]);
Text_2=double('举杯对光，观察杯中酒的色调、透明度及有无悬浮物或沉淀物。');
Text_3=double('看酒体的过程持续15秒');
Text_4=double('按q键开始闻香倒计时');

% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为18号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-6*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+2*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+6*fontsize/2,[0,0,1]);
Screen('Flip',w);
t_screen2=datetime('now');
start_2=1;
while (start_2==1)
    [KeyIsDown, secs, KeyCode] = KbCheck;
    if KeyIsDown
        if KeyCode(SmellKey1)
            start_2=0;
            t_space2=datetime('now');
        end
    end
end
KeyIsDown=0;
count_down(w,second);
end

function [t_screen2,t_space2] = smell_time_all(w,SmellKey1,second,numb_sample,fontsize)
%%  闻香
Text_1=double(['请您端起样品',num2str(numb_sample)]);
Text_2=double('置于鼻下，并轻轻转动酒杯，');
Text_3=double('持续闻香30秒，感受气味。');
Text_4=double('按w键开始闻香倒计时');

% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为18号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-6*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+2*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+6*fontsize/2,[0,0,1]);
Screen('Flip',w);
t_screen2=datetime('now');
start_2=1;
while (start_2==1)
    [KeyIsDown, secs, KeyCode] = KbCheck;
    if KeyIsDown
        if KeyCode(SmellKey1)
            start_2=0;
            t_space2=datetime('now');
        end
    end
end
KeyIsDown=0;
count_down(w,second);
end

function [t_screen2,t_space2] = smell_time_1_s(w,SmellKey1,second,numb_sample,fontsize)
%%  闻香
Text_1=double(['样品',num2str(numb_sample),'品评结束，']);
Text_2=double('请填写调查问卷。');
Text_3=double('填写问卷后，请喝水、吃苏打饼干清口。');
Text_4=double('按空格键继续');
% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为18号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-6*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+2*fontsize/2,[0,0,1]);
Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+6*fontsize/2,[0,0,1]);
Screen('Flip',w);
t_screen2=datetime('now');
start_2=1;
while (start_2==1)
    [KeyIsDown, secs, KeyCode] = KbCheck;
    if KeyIsDown
        if KeyCode(SmellKey1)
            start_2=0;
            t_space2=datetime('now');
        end
    end
end
KeyIsDown=0;
count_down(w,second);
end

function [t_screen1,t_space1] = second_group_start(LookKey,w,second,groupNumb,fontsize)
Text_1=double(['您将对第',num2str(groupNumb),'组样品进行评价']);
Text_2=double('请按屏幕提示进行操作，并填写问卷');
Text_3=double('按空格键继续');
% Text_4=double('请喝一口酒，按数字键2开始计时。');
% fontsize =80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为40号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-4*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-0*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+4*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
% Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+4.5*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('Flip',w);
t_screen1=datetime('now');
start_1=1;
while (start_1==1)
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(LookKey)
            start_1=0;
            t_space1=datetime('now');
        end
    end
end
KeyIsDown=0;
%% 倒计时
count_down(w,second);
end


function [t_screend1,t_spacend1] = end_time(spaceKey,w,second,fontsize)
Text_e1=double('本次实验品评部分已结束，');
Text_e2=double('非常感谢您的参与。');
Text_e3=double('请按空格键退出');
% fontsize = 80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为18号
Screen('DrawText', w, Text_e1 ,650-length(Text_e1)*fontsize/2,540-4*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_e2 ,650-length(Text_e2)*fontsize/2,540,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_e3 ,650-length(Text_e3)*fontsize/2,540+4*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('Flip',w);
t_screene11=datetime('now');
WaitSecs(5);
end


function [] = count_down(w,second)
%% 倒计时
nominalFrameRate = Screen('NominalFrameRate', w);
colorChangeCounter = 0;
color = rand(1,3);
presSecs_1 = sort([1:1:second],'descend');
for i = 1:second
    % Convert our current number to display into a string
    numberString = num2str(presSecs_1(i));
    oldTextSize=Screen('TextSize',w,120); %调整文字的大小为40号
    Screen('DrawText', w, numberString,650-60,540-60,color);
    Screen('Flip',w);
    if colorChangeCounter == nominalFrameRate
        color = rand(1, 3);
        colorChangeCounter = 0;
    end
    WaitSecs(1);
end
end

function [t_screen1,t_space1] = taste_time(LookKey,w,second,sample_numb,fontsize)
Text_1=double(['请您端起样品',num2str(sample_numb),'，']);
Text_2=double('轻轻的闻一下，然后喝一口（不要吞咽），');
Text_3=double('品尝5秒');
Text_4=double('按e键开始倒计时');
% fontsize =80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为40号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-6*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+6*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('Flip',w);
t_screen1=datetime('now');
start_1=1;
while (start_1==1)
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(LookKey)
            start_1=0;
            t_space1=datetime('now');
        end
    end
end
KeyIsDown=0;
%% 倒计时
count_down(w,second);
end

function [t_screen1,t_space1] = swallow_time(LookKey,w,second,sample_numb,fontsize)
Text_1=double(['现在请把酒咽下去，']);
Text_2=double('在接下来的20秒，');
Text_3=double('请安静品味该酒带给您的整体感受。');
Text_4=double('按t键开始倒计时');
% fontsize =80;
oldTextSize=Screen('TextSize',w,fontsize); %调整文字的大小为40号
Screen('DrawText', w, Text_1 ,650-length(Text_1)*fontsize/2,540-6*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_2 ,650-length(Text_2)*fontsize/2,540-2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_3 ,650-length(Text_3)*fontsize/2,540+2*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('DrawText', w, Text_4 ,650-length(Text_4)*fontsize/2,540+6*fontsize/2,[0,0,1]);%呈现文字在屏幕上的函数，颜色为黑色
Screen('Flip',w);
t_screen1=datetime('now');
start_1=1;
while (start_1==1)
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(LookKey)
            start_1=0;
            t_space1=datetime('now');
        end
    end
end
KeyIsDown=0;
%% 倒计时
count_down(w,second);
end



