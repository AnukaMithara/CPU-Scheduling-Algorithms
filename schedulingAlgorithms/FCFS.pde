import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// First Come First Served (FCFS) Algorithm
class FCFS implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
        int currentTime = 0;

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
}
