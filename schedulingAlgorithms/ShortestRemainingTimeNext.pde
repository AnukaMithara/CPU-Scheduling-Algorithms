import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Shortest Remaining Time Next Algorithm
class ShortestRemainingTimeNext implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
       ArrayList<Process> processControlBlock  = new ArrayList<>();     
       
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
       int currentTime = 0; 
       while (!processes.isEmpty()) {
            Process shortestProcess = null;
            int shortestTime = Integer.MAX_VALUE;

            // Find the process with the shortest remaining time
            for (Process process : processes) {
                if (process.arrivalTime <= currentTime && process.remainingTime < shortestTime) {
                    shortestProcess = process;
                    shortestTime = process.remainingTime;
                }
            }

            if (shortestProcess != null) {
                // Execute the shortest process for 1 time unit
                System.out.println("Executing process " + shortestProcess.processId + " at time " + currentTime);
                shortestProcess.remainingTime = shortestProcess.remainingTime - 1;

                // Add the process to the process control block
                processControlBlock.add(shortestProcess);

                // Check if the process is completed
                if (shortestProcess.remainingTime == 0) {
                    processes.remove(shortestProcess);
                }
            } else {
                // No process is available at the current time, increment the current time
                currentTime++;
            }
        }

        // Print the process control block
        System.out.println("\nProcess Control Block:");
        for (Process process : processControlBlock) {
            System.out.println("Process " + process.processId);
        }
    
       
        
        
        
        
        
        
        
        
        
        
 
    }
    
    void swap(ArrayList<Process> processes, int index1, int index2)
    {
        Process temp = processes.get(index1);
        processes.set(index1, processes.get(index2));
        processes.set(index2, temp);
    }          
}
