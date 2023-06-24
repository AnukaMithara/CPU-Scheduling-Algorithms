import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Shortest Process Next Algorithm
class ShortestProcessNext implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
        processes.sort((p1, p2) -> p1.burstTime - p2.burstTime);

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
