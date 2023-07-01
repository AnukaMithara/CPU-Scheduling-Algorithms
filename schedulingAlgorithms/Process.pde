// Process class representing a single process
class Process {
    int arrivalTime;
    int burstTime;
    int burstTimeC;
    int waitingTime;
    int turnaroundTime;
    int priority;
    int processId;
    int startTime;
    int endTime;
    int remainingTime;
    
    Process(int processNum, int arrivalTime, int burstTime, int priority) {
        this.processId = processNum;
        this.arrivalTime = arrivalTime;
        this.burstTime = burstTime;
        this.priority = priority;
        this.remainingTime = burstTime;
        this.burstTimeC=burstTime;
    }
}

// Interface for the Scheduling Algorithm
interface SchedulingAlgorithm {
    void execute(ArrayList<Process> processes);
}
