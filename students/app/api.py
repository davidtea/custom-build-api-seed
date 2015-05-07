import os
from flask import Flask, url_for, jsonify, request, render_template
from flask.ext.bootstrap import Bootstrap
from flask.ext.sqlalchemy import SQLAlchemy

basedir = os.path.abspath(os.path.dirname(__file__))
db_path = os.path.join(basedir, '../data.sqlite')

app = Flask(__name__)
bootstrap = Bootstrap(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + db_path

db = SQLAlchemy(app)


class ValidationError(ValueError):
    pass


class Question(db.Model):
    __tablename__ = 'questions'
    id = db.Column(db.Integer, primary_key=True) 
    Show_Number = db.Column(db.Integer, index=True)
    Air_Date = db.Column(db.String(32), index=True)
    Round = db.Column(db.String(64), index=True)
    Category = db.Column(db.String(128), index=True)
    Value = db.Column(db.String(16), index=True)
    Question = db.Column(db.String(256), index=True)
    Answer = db.Column(db.String(256), index=True)

    def get_url(self):
        return url_for('get_question', id=self.id, _external=True)

    def export_data(self):
        return {
            'self_url': self.get_url(),
	    'Show Number': self.Show_Number, 
	    'Air Date': self.Air_Date,
	    'Round': self.Round, 
	    'Category': self.Category,
	    'Value': self.Value,
	    'Question': self.Question, 
	    'Answer': self.Answer 
        }

    def import_data(self, data):
        try:
            self.Show_Number = data['Show Number']
	    self.Air_Date = data['Air Date']
	    self.Round = data['Round']
	    self.Category = data['Category']
	    self.Value = data['Value']
	    self.Question = data['Question']
	    self.Answer = data['Answer']
        except KeyError as e:
            raise ValidationError('Invalid question: missing ' + e.args[0])
        return self


@app.route('/questions/', methods=['GET'])
def get_questions():
    return jsonify({'questions': [question.get_url() for question in
                                  Question.query.all()]})

@app.route('/questions/<int:id>', methods=['GET'])
def get_question(id):
    return jsonify(Question.query.get_or_404(id).export_data())

@app.route('/questions/', methods=['POST'])
def new_question():
    question = Question()
    question.import_data(request.json)
    db.session.add(question)
    db.session.commit()
    return jsonify({}), 201, {'Location': question.get_url()}

@app.route('/questions/<int:id>', methods=['PUT'])
def edit_question(id):
    question = Question.query.get_or_404(id)
    question.import_data(request.json)
    db.session.add(question)
    db.session.commit()
    return jsonify({})

# todo: implement this template
@app.errorhandler(404)
def not_found(e):
    return render_template('404.html')

@app.route('/')
def index():
    highlight = {'min': 1, 'max': 5}
    questions = Question.query.all()
    return render_template('index.html', questions=questions, highlight=highlight)

if __name__ == '__main__':
    db.create_all()
#    app.run( debug=True )
    app.run(host="0.0.0.0", port=int("4000"), debug=True)
#    Using Nitrous.io only allows ports to run on 0.0.0.0