import React from 'react';

export default function ServicePressureWidget({ data }) {
  return (
    <div style={{ background: 'white', padding: '15px', borderRadius: '8px', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
      <h3>Service Pressure Index</h3>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
}
