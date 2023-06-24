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
        Queue<Process> queue = new LinkedList<>();
        int currentTime = 0;
        int completedProcesses = 0;

        while (completedProcesses < processes.size()) {
            // Add arrived processes to the queue
            for (Process process : processes) {
                if (process.arrivalTime <= currentTime && !queue.contains(process))
                    queue.add(process);
            }

            // Execute processes in the queue
            Process currentProcess = queue.poll();
            if (currentProcess != null) {
                // Calculate waiting time
                currentProcess.waitingTime += currentTime - currentProcess.arrivalTime;

                // Execute for time quantum or until completion
                int remainingTime = currentProcess.burstTime;
                if (remainingTime > timeQuantum)
                    remainingTime = timeQuantum;

                currentTime += remainingTime;
                currentProcess.burstTime -= remainingTime;

                // Check if process is completed
                if (currentProcess.burstTime == 0) {
                    // Calculate turnaround time
                    currentProcess.turnaroundTime = currentProcess.waitingTime + currentTime - currentProcess.arrivalTime;
                    completedProcesses++;
                } else {
                    // Add the process back to the queue
                    queue.add(currentProcess);
                }
            } else {
                // No processes in the queue, increment current time
                currentTime++;
            }
        }
    }
}
