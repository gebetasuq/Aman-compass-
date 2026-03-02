import React from 'react';
import { Bar } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);

export default function HeatmapWidget({ data }) {
  const chartData = {
    labels: data?.labels || ['Civic', 'SME', 'Cyber', 'Aman', 'Data'],
    datasets: [
      {
        label: 'Query Volume',
        data: data?.values || [65, 59, 80, 81, 56],
        backgroundColor: 'rgba(53, 162, 235, 0.5)',
      },
    ],
  };

  return (
    <div style={{ background: 'white', padding: '15px', borderRadius: '8px', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
      <h3>Civic Confusion Heatmap</h3>
      <Bar data={chartData} />
    </div>
  );
}
