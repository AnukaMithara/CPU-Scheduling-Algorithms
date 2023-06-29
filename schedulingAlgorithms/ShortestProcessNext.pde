import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Shortest Process Next Algorithm
class ShortestProcessNext implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
        int currentTime = startTime;
        int j=0, k =0,z=0;
        Process[] newarray = new Process[processes.size()];
        
        //sorting according to arrival times
        for (int i = 0; i < processes.size(); i++)
        {
            for (int  n = 0;  n < processes.size() - 1; n++)
            {
                if (processes.get(n).arrivalTime > processes.get(n + 1).arrivalTime)
                {
                    swap(processes, n,n + 1);                
                }
            }
        }
        
        int i = startTime;
        
        
        while(i< TotalburstTime){
          
          for(j=z;j<processes.size();j++){
            if (processes.get(j).arrivalTime <= i){
              newarray[k] = processes.get(j);
              k++;
            }
          }
          
          Process tempary = newarray[0];
          for(j=0;j<k-1;j++)
          {
            if(newarray[j+1].burstTime< tempary.burstTime)
            {
              tempary = newarray[j+1];
            }
              
          }
          
          for(j=0;j<processes.size();j++){
             
            if(tempary.arrivalTime==processes.get(j).arrivalTime)
            {
              swap(processes,j,z);                                    //Methana check karapn
              z++;                                                    //Ekata wadi una gmn index out of bound yanwa 
            }                                                         // https://www.guru99.com/priority-scheduling-program.html
          }                                                          //Me link eke thiyn example ekata check krl blpn
          
          k=0;

          i = i +  tempary.burstTime;
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
