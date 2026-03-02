import React from 'react';

const emirates = ['all', 'Abu Dhabi', 'Dubai', 'Sharjah', 'Ajman', 'Umm Al Quwain', 'Ras Al Khaimah', 'Fujairah'];

export default function Sidebar({ onSelectEmirate }) {
  return (
    <aside style={{ width: '250px', background: '#f4f4f4', padding: '20px', minHeight: '100vh' }}>
      <h3>Filter by Emirate</h3>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {emirates.map((e) => (
          <li key={e} style={{ margin: '10px 0' }}>
            <button onClick={() => onSelectEmirate(e)} style={{ width: '100%', padding: '8px' }}>
              {e === 'all' ? 'All Emirates' : e}
            </button>
          </li>
        ))}
      </ul>
    </aside>
  );
}
