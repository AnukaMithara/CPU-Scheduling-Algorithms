import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Shortest Remaining Time Next Algorithm
class ShortestRemainingTimeNext implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
       ArrayList<Process> SRTN  = new ArrayList<>();  
       ArrayList<Process> readyQueue = new ArrayList<>();       
       
      //sorting according to burst times
        for (int i = 0; i < processes.size(); i++)
        {
            for (int  j = 0;  j < processes.size() - 1; j++)
            {
                if (processes.get(j).burstTime > processes.get(j + 1).burstTime)
                {
                    swap(processes, j,j + 1);                
                }
            }
        }
                
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

        int time = startTime;
        int currentProcess = -1;
       
        while(time < TotalburstTime){
            boolean added = false;
            for(int i = 0; i < processes.size(); i++){
                if(processes.get(i).arrivalTime <= time && processes.get(i).burstTime > 0) && !readyQueue.contains(processes.get(i)){
                    readyQueue.add(processes.get(i));
                    added = true;
                }
            }

            if(added){
                currentProcess++;
                //Find the process with the shortest burst time
                int min = readyQueue.get(0).burstTime;
                int index = 0;
                for(int i = 0; i < readyQueue.size(); i++){
                    if((readyQueue.get(i).burstTime < min)&& (readyQueue.get(i).burstTime > 0)){
                        min = readyQueue.get(i).burstTime;
                        index = i;
                    }
                }

                readyQueue.get(index).arrivalTime = time;
                readyQueue.get(index).burstTime--;
                SRTN.add(readyQueue.get(index));
                
            }

            SRTN.get(currentProcess).burstTime = time - SRTN.get(currentProcess).arrivalTime;
            time++;
        }
    }
    
    void swap(ArrayList<Process> processes, int index1, int index2)
    {
        Process temp = processes.get(index1);
        processes.set(index1, processes.get(index2));
        processes.set(index2, temp);
    }          
}
