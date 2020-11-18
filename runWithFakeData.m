% %RM 2
% close all
% clear all
% figure();
% fakeData1=[10+randn(100,1), 13+randn(100,1)];
% fakeData2=[11+randn(100,1), 17+randn(100,1)];
% fakeData3=[8+randn(100,1), 18+randn(100,1)];
% ChangeSet.DataSet.cloud.type = "rash";
% ChangeSet.DataSet1.fig.legend = "DataSet1";
% ChangeSet.DataSet2.fig.legend = "DataSet2";
% ChangeSet.DataSet3.fig.legend = "DataSet3";
% [test3, test4] = plotRaincloud(fakeData1, fakeData2, fakeData3, ChangeSet);
% 
% %RM 3
% figure();
% fakeData1=[30+randn(100,1), 13+randn(100,1), 11+randn(100,1)];
% fakeData2=[31+randn(100,1), 17+randn(100,1), 14+randn(100,1)];
% fakeData3=[38+randn(100,1), 18+randn(100,1), 8+randn(100,1)];
% ChangeSet.DataSet.cloud.type = "rash";
% ChangeSet.DataSet1.fig.legend = "DataSet1";
% ChangeSet.DataSet2.fig.legend = "DataSet2";
% ChangeSet.DataSet3.fig.legend = "DataSet3";
% [test1, test2] = plotRaincloud(fakeData1, fakeData2, fakeData3, ChangeSet);
% 
% %Single measure
% figure();
% fakeData1=[10+randn(100,1)];
% fakeData2=[17+randn(100,1)];
% fakeData3=[18+randn(100,1)];
% ChangeSet.DataSet.cloud.type = "ks";
% ChangeSet.DataSet1.fig.legend = "DataSet1";
% ChangeSet.DataSet2.fig.legend = "DataSet2";
% ChangeSet.DataSet3.fig.legend = "DataSet3";
% [test5, test6] = plotRaincloud(fakeData1, fakeData2, fakeData3, ChangeSet);