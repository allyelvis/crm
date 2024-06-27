from flask import request, jsonify
from app import app, db
from models import User, Post

@app.route('/')
def home():
    return "Portal API"

@app.route('/users', methods=['GET', 'POST'])
def manage_users():
    if request.method == 'GET':
        users = User.query.all()
        return jsonify([{'id': user.id, 'username': user.username, 'email': user.email} for user in users])
    elif request.method == 'POST':
        data = request.json
        new_user = User(username=data['username'], email=data['email'])
        db.session.add(new_user)
        db.session.commit()
        return jsonify({'id': new_user.id, 'username': new_user.username, 'email': new_user.email})

@app.route('/posts', methods=['GET', 'POST'])
def manage_posts():
    if request.method == 'GET':
        posts = Post.query.all()
        return jsonify([{'id': post.id, 'title': post.title, 'content': post.content} for post in posts])
    elif request.method == 'POST':
        data = request.json
        new_post = Post(title=data['title'], content=data['content'])
        db.session.add(new_post)
        db.session.commit()
        return jsonify({'id': new_post.id, 'title': new_post.title, 'content': new_post.content})
