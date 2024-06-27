from flask import request, jsonify
from app import app, db
from models import User, Product

@app.route('/')
def home():
    return "ERP API"

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

@app.route('/products', methods=['GET', 'POST'])
def manage_products():
    if request.method == 'GET':
        products = Product.query.all()
        return jsonify([{'id': product.id, 'name': product.name, 'price': product.price, 'stock': product.stock} for product in products])
    elif request.method == 'POST':
        data = request.json
        new_product = Product(name=data['name'], price=data['price'], stock=data['stock'])
        db.session.add(new_product)
        db.session.commit()
        return jsonify({'id': new_product.id, 'name': new_product.name, 'price': new_product.price, 'stock': new_product.stock})
