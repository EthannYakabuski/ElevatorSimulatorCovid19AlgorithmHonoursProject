import matplotlib
import matplotlib.pyplot as plt
import numpy as np

timesWaited = []
timesOnElevator = []

timesWaitedInSeconds = []
timesOnElevatorInSeconds = []

totalTimeSpentInSeconds = []

#https://www.w3schools.com/python/matplotlib_pyplot.asp
#xpoints = np.array([0, 6])
#ypoints = np.array([0, 250])

#plt.plot(xpoints, ypoints)
#plt.show()




#turn the statistic files into data for the graphs
elevatorFile = open("elevatorStatistics.txt","r")
peopleFile = open("peopleStatistics.txt","r")

elevatorStats = elevatorFile.read()
peopleStats = peopleFile.read()

for line in elevatorStats.split(): 
    #print(line)
    splitLine = line.split(":")
    
    
for line in peopleStats.split():
    #print(line)
    splitLine = line.split(":")
    timesWaited.append(splitLine[1])
    timesOnElevator.append(splitLine[0])



#convert the times given in the statitistics to real world seconds
for entry in timesWaited:
    timesWaitedInSeconds.append(int(entry)/15)

for entry in timesOnElevator:
    timesOnElevatorInSeconds.append(int(entry)/15)



#make the first histogram for waiting for pickups
figure = plt.figure()
ax1 = figure.add_subplot(211)
ax1.set_ylabel("Frequency")
ax1.set_xlabel("Wait time in seconds")
ax1.set_title("Time waited for elevator pick up")

plt.hist(timesWaitedInSeconds)
plt.show()

blocking = input("blocking .. enter to continue for the next graph")


#make the second histogram for time spent on elevator
figure = plt.figure()
ax1 = figure.add_subplot(211)
ax1.set_ylabel("Frequency")
ax1.set_xlabel("Time on Elevator in seconds")
ax1.set_title("Time waited inside the elevator cab")

plt.hist(timesOnElevatorInSeconds)
plt.show()


#make the third histogram that shows overall average wait time
for i in range(0, len(timesWaitedInSeconds)):
    totalTimeSpentInSeconds.append(timesWaitedInSeconds[i] + timesOnElevatorInSeconds[i])
    

figure = plt.figure()
ax1 = figure.add_subplot(211)
ax1.set_ylabel("Frequency")
ax1.set_xlabel("Total time of trip seconds")
ax1.set_title("Total time spent on trip")

plt.hist(totalTimeSpentInSeconds)
plt.show()

