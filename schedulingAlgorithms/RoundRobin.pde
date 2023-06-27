import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Round Robin Algorithm
class RoundRobin implements SchedulingAlgorithm {
    private int timeQuantum;
    
    RoundRobin(int timeQuantum) {
        this.timeQuantum = timeQuantum;
    }
    
    @Override
    public void execute(ArrayList<Process> processes) {
        int currentTime = 0;
        Queue<Process> processQueue = new LinkedList<>();
        processQueue.addAll(processes);

        ArrayList<Process> processsn = new ArrayList<Process>();
        
        while (!processQueue.isEmpty()) {
            Process currentProcess = processQueue.poll();
            currentProcess.startTime = currentTime;
            
            if (currentProcess.burstTime <= timeQuantum) {
                // Process completed
                currentTime += currentProcess.burstTime;
                processsn.add(currentProcess);
                
            } else {
                // Process needs to be scheduled again
                currentTime += timeQuantum;
                currentProcess.burstTime=currentProcess.burstTime - timeQuantum;
                processQueue.add(currentProcess);
                processsn.add(currentProcess);
            }
           
            
        }
        processes=processsn;
}
}
