import React from 'react';
import './App.css';

function App() {
  const [users, setUsers] = React.useState([]);
  const [contacts, setContacts] = React.useState([]);

  React.useEffect(() => {
    fetch('http://localhost:5000/users')
      .then(response => response.json())
      .then(data => setUsers(data));

    fetch('http://localhost:5000/contacts')
      .then(response => response.json())
      .then(data => setContacts(data));
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>CRM System</h1>
        <h2>Users</h2>
        <ul>
          {users.map(user => (
            <li key={user.id}>{user.username} ({user.email})</li>
          ))}
        </ul>
        <h2>Contacts</h2>
        <ul>
          {contacts.map(contact => (
            <li key={contact.id}>{contact.name} ({contact.email}) - {contact.phone} - {contact.company}</li>
          ))}
        </ul>
      </header>
    </div>
  );
}

export default App;
