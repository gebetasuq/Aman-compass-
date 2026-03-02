import { useState, useEffect } from 'react';
import Header from '@/components/Header';
import Sidebar from '@/components/Sidebar';
import HeatmapWidget from '@/components/HeatmapWidget';
import ServicePressureWidget from '@/components/ServicePressureWidget';
import PhishingMapWidget from '@/components/PhishingMapWidget';
import PredictiveWidget from '@/components/PredictiveWidget';

export default function Dashboard() {
  const [selectedEmirate, setSelectedEmirate] = useState('all');
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch dashboard data from API
    const fetchData = async () => {
      setLoading(true);
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/dashboard/summary?emirate=${selectedEmirate}`);
        const json = await res.json();
        setData(json);
      } catch (error) {
        console.error('Failed to fetch dashboard data:', error);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [selectedEmirate]);

  return (
    <div style={{ display: 'flex' }}>
      <Sidebar onSelectEmirate={setSelectedEmirate} />
      <main style={{ flex: 1, padding: '20px' }}>
        <Header title="Government Intelligence Dashboard" />
        {loading ? (
          <p>Loading...</p>
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '20px' }}>
            <HeatmapWidget data={data?.heatmap} />
            <ServicePressureWidget data={data?.pressure} />
            <PhishingMapWidget data={data?.phishing} />
            <PredictiveWidget data={data?.predictive} />
          </div>
        )}
      </main>
    </div>
  );
}
