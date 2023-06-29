import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Priority Scheduling Algorithm
class PriorityScheduling implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
        int currentTime = startTime;
        
        
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
        
        int totalTime = 0;
        for (int i = 0; i < processes.size(); i++)
        {
            
            for (int  j = 1;  j < processes.size(); j++)
            {  
                
                if ((processes.get(j).priority > processes.get(i).priority) && (totalTime >= processes.get(j).arrivalTime)) 
                {
                    swap(processes, j,i); 
                   
                }
            }
            totalTime +=  processes.get(i).burstTime;
        }
        
        for (Process process : processes) {
            // Calculate waiting time
            process.waitingTime = currentTime - process.arrivalTime;
            if (process.waitingTime < 0)
                process.waitingTime = 0;
            
            // Calculate turnaround time
            process.turnaroundTime = process.waitingTime + process.burstTime;
            
            // Update current time
            currentTime += process.burstTime;
        }
    }
    
    void swap(ArrayList<Process> processes, int index1, int index2)
    {
        Process temp = processes.get(index1);
        processes.set(index1, processes.get(index2));
        processes.set(index2, temp);
    }          
}
