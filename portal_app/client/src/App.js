import React from 'react';
import './App.css';

function App() {
  const [users, setUsers] = React.useState([]);
  const [posts, setPosts] = React.useState([]);

  React.useEffect(() => {
    fetch('http://localhost:5000/users')
      .then(response => response.json())
      .then(data => setUsers(data));

    fetch('http://localhost:5000/posts')
      .then(response => response.json())
      .then(data => setPosts(data));
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Portal System</h1>
        <h2>Users</h2>
        <ul>
          {users.map(user => (
            <li key={user.id}>{user.username} ({user.email})</li>
          ))}
        </ul>
        <h2>Posts</h2>
        <ul>
          {posts.map(post => (
            <li key={post.id}>{post.title}: {post.content}</li>
          ))}
        </ul>
      </header>
    </div>
  );
}

export default App;
