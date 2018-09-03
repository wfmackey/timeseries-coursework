'*** Solutions to Individual Assignment 1, 2018 ***************

' *******************************************************************************
' *** Preamble
' *******************************************************************************
' Turn off verbose mode
mode quiet
' Open the Eviews workfile hours.wf1
wfopen .\asx_volume
' Save with a new name
wfsave .\asx_volume_solutions

' *******************************************************************************
' *** Question 2.1 
' *******************************************************************************
graph graph1.line log(volume)
graph1.options connect

' *******************************************************************************
' *** Question 2.2 
' *******************************************************************************
' Loop to generate the day-of-the-week dummy variables
for !j=1 to 5 
genr D{!j}=0
smpl if @weekday=!j
genr D{!j}=1
smpl @all
next

'% generate the trend term
genr trend=@trend+1

'% generate the broken trend term
scalar Tb=@dtoo("31/10/2011")
genr dt=@recode(trend>Tb,@trend(31/10/2011),0)

' Estimate a broken trend model with day-of-the-week dummy variables
equation volume_broken.ls log(volume) c trend dt d2 d3 d4 d5

' *******************************************************************************
' *** Question 2.4 
' *******************************************************************************
volume_broken.makeresids residuals
graph graph2.line residuals
graph2.options connect

freeze(table1) residuals.correl(20)

' *******************************************************************************
' *** Question 2.5
' *******************************************************************************
' Estimate a broken trend model with day-of-the-week dummy variables
equation volume_broken_nw.ls(cov="hac",nodf) log(volume) c trend dt d2 d3 d4 d5


