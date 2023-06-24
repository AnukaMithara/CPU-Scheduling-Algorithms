import javax.swing.JOptionPane;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

// Shortest Remaining Time Next Algorithm
class ShortestRemainingTimeNext implements SchedulingAlgorithm {
    @Override
    public void execute(ArrayList<Process> processes) {
        int currentTime = 0;
        int completedProcesses = 0;

        while (completedProcesses < processes.size()) {
            // Select the process with the shortest remaining time
            Process shortestProcess = null;
            for (Process process : processes) {
                if (process.arrivalTime <= currentTime && process.burstTime > 0 &&
                        (shortestProcess == null || process.burstTime < shortestProcess.burstTime)) {
                    shortestProcess = process;
                }
            }

            if (shortestProcess != null) {
                // Calculate waiting time
                shortestProcess.waitingTime += currentTime - shortestProcess.arrivalTime;

                // Execute the process for one time unit
                shortestProcess.burstTime--;
                currentTime++;

                // Check if process is completed
                if (shortestProcess.burstTime == 0) {
                    // Calculate turnaround time
                    shortestProcess.turnaroundTime = shortestProcess.waitingTime + currentTime - shortestProcess.arrivalTime;
                    completedProcesses++;
                }
            } else {
                // No processes available, increment current time
                currentTime++;
            }
        }
    }
}
