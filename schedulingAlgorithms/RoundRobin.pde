import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Round Robin Algorithm
class RoundRobin implements SchedulingAlgorithm {
    private int timeQuantum;
    private ArrayList<Process> processsn = new ArrayList<Process>();
    private ArrayList<Integer>bt = new ArrayList<Integer>();
    
    public RoundRobin(int timeQuantum) {
        this.timeQuantum = timeQuantum;
    }   
    
    public void execute(ArrayList<Process> processes) {
        int currentTime = 0;
        int addT = 0;
        Queue<Process> processQueue = new LinkedList<>();
        Queue<Process> readyQueue = new LinkedList<>();
        
        //sorting according to arrival times
        for (int i = 0; i < processes.size(); i++)
        {
            for (int  j = 0;  j < processes.size() - 1; j++)
            {
                if (processes.get(j).arrivalTime > processes.get(j + 1).arrivalTime)
                {
                    swap(processes, j,j + 1);                
                }
            }
        }
        
        processQueue.addAll(processes);
        
        currentTime = processQueue.peek().arrivalTime;
        readyQueue.add(processQueue.poll());      
        
        while(!readyQueue.isEmpty()) {
            
            print(currentTime + "  ");            
            
            Process currentProcess = readyQueue.poll();            
            
            if (currentProcess.burstTime <= timeQuantum && currentProcess.arrivalTime <= currentTime) {
                // Process completed
                
                processsn.add(currentProcess);
                bt.add(currentProcess.burstTime);
                addT = currentProcess.burstTime;
                currentProcess.endTime = currentTime + addT;
                while(!processQueue.isEmpty()) {
                    if (processQueue.peek().arrivalTime<= currentTime + addT) {
                        print("Inside While Loop  ::" + processQueue.peek().arrivalTime + "  ");
                        readyQueue.add(processQueue.poll());
                        
                    }
                    else{
                        break;
                    }               
                }
            }
            else {
                // Process needs to be scheduled again
                
                if (currentProcess.burstTime > timeQuantum && currentProcess.arrivalTime <=  currentTime)
                {
                    bt.add(timeQuantum);
                    addT = timeQuantum;
                }
                else{
                    bt.add(currentProcess.burstTime);
                    addT = currentProcess.burstTime;
                }
                
                currentProcess.burstTime = currentProcess.burstTime - timeQuantum;
                currentProcess.waitingTime = currentTime - currentProcess.arrivalTime;
                currentProcess.turnaroundTime = currentProcess.waitingTime + addT;
                processsn.add(currentProcess);
                currentProcess.endTime = currentTime + addT;
                
                while(!processQueue.isEmpty()) {
                    if (processQueue.peek().arrivalTime<= currentTime + addT) {
                        print("Inside While Loop  ::" + processQueue.peek().arrivalTime + "  ");
                        readyQueue.add(processQueue.poll());                        
                    }
                    else{
                        break;
                    }
                }                
                readyQueue.add(currentProcess);           
            }
            currentTime += addT;
        }
        for (int h = 0; h < processes.size(); h++) {
            Process process = processes.get(h);
            int turnaroundTime = process.endTime - process.arrivalTime;
            process.turnaroundTime = (turnaroundTime);
            process.waitingTime = turnaroundTime - process.burstTimeC;
        }
    }
    
    public ArrayList<Integer> getBt() {
        return bt;
    }
    
    public ArrayList<Process> getProcess() {
        return processsn;
    }
    void swap(ArrayList<Process> processes, int index1, int index2)
        {
        Process temp = processes.get(index1);
        processes.set(index1, processes.get(index2));
        processes.set(index2, temp);
    }   
}
