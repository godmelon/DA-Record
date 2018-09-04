# -*- coding: utf-8 -*-

import numpy as np
import operator

def createDataSet():
    group = np.array([[1.0, 1.1], [1.0, 1.0], [0, 0], [0, 0.1]])
    label = ['A', 'A', 'B', 'B']
    return (group, label)
    
# kNN欧式距离实现
def classify0(inX, dataSet, label, k):
    # 计算距离
    dataSetSize = dataSet.shape[0]
    diffMat = np.tile(inX, (dataSetSize, 1)) - dataSet
    sqDiffMat = diffMat ** 2
    sqDistance = sqDiffMat.sum(axis=1)
    distance = sqDistance ** 0.5
    
    #距离从小到大排序，并返回数组下标
    sorteDistIndicies = distance.argsort()
    classCount = {}
    #从小到大找出label，并且投票
    for i in range(k):
        voteIlabel = label[sorteDistIndicies[i]]
        classCount[voteIlabel] = classCount.get(voteIlabel, 0)  + 1
        
    sortedClassCount = sorted(classCount.items(), key=operator.itemgetter(1),
                              reverse=True)
    return sortedClassCount[0][0]

def file2matrix(filename):
    fr = open(filename)
    arrayOLines = fr.readlines()
    numberOLines = len(arrayOLines)
    returnMat = np.zeros((numberOLines, 3))
    classLabelVector = []
    index = 0
    
    for line in arrayOLines:
        line = line.strip()
        listFromLine = line.split('\t')
        returnMat[index, :] = listFromLine[0:3]
        classLabelVector.append(int(listFromLine[-1]))
        index += 1
    return returnMat, classLabelVector

# 归一化，比例调节
def autoNorm(dataSet):
    # 返回每一列的最大值和最小值
    # min(1)返回行最小值
    minVals = dataSet.min(0)
    maxVals = dataSet.max(0)
    
    ranges = maxVals - minVals
    normDataSet = np.zeros(dataSet.shape)
    m = dataSet.shape[0]
    
    normDataSet = dataSet - np.tile(minVals, (m, 1))
    normDataSet = normDataSet/np.tile(ranges, (m, 1))
    return normDataSet, ranges, minVals

# 使用正确率来验证kNN
def datingClassTest():
    # 使用90%做训练集，10%做测试集
    hoRatio = 0.10
    datingDataMat, datingLabels = file2matrix('datingTestSet2.txt')
    normDataSet, ranges, minVals = autoNorm(datingDataMat)
    m = normDataSet.shape[0]
    numTestVecs = int(m*hoRatio)
    errcount = 0
    
    for i in range(numTestVecs):
        classifierResult = classify0(normDataSet[i,:], normDataSet[numTestVecs:m, :],
                                     datingLabels[numTestVecs:m], 6)
        print('the kNN classifier came back with: {0}, the real answer is: {1}'.format(classifierResult, datingLabels[i]))
        
        if (classifierResult != datingLabels[i]): errcount += 1.0
    print('the total error rate is: {}'.format(errcount/float(numTestVecs)))
    

# 预测函数
def classifyPerson():
    resultList = ['not at all', 'in small doses', 'in large doses']
    percentTats = float(input('percentage of time spent playing video games?'))
    ffMiles = float(input('mile earned per year?'))
    iceCream = float(input('cream per year?'))
    
    returnMat, classLabelVector = file2matrix('datingTestSet2.txt')
    normDataSet, ranges, minVals = autoNorm(returnMat)
    
    inArr = np.array([ffMiles, percentTats, iceCream])
    classifierResult = classify0((inArr - minVals)/ranges, normDataSet,
                                 classLabelVector, 3)
    print('You will pro like this person: ', resultList[classifierResult - 1])
    
    