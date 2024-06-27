from flask import request, jsonify
from app import app, db
from models import User, Contact

@app.route('/')
def home():
    return "CRM API"

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

@app.route('/contacts', methods=['GET', 'POST'])
def manage_contacts():
    if request.method == 'GET':
        contacts = Contact.query.all()
        return jsonify([{'id': contact.id, 'name': contact.name, 'phone': contact.phone, 'email': contact.email, 'company': contact.company} for contact in contacts])
    elif request.method == 'POST':
        data = request.json
        new_contact = Contact(name=data['name'], phone=data['phone'], email=data['email'], company=data.get('company'))
        db.session.add(new_contact)
        db.session.commit()
        return jsonify({'id': new_contact.id, 'name': new_contact.name, 'phone': new_contact.phone, 'email': new_contact.email, 'company': new_contact.company})
