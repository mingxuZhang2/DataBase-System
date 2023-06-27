from flask import Flask, render_template, request, url_for, redirect,session,flash
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
from enum import Enum
from sqlalchemy.exc import IntegrityError
from sqlalchemy import text

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:030401@localhost/blog'
app.config['SECRET_KEY'] = 'your-secret-key'  # 设置你的秘密密钥
db = SQLAlchemy(app)
@app.template_filter('get_user_name')
def get_user_name(user_id):
    user = User.query.get(user_id)
    if user:
        return user.UserName
    return ''


class PostPermission(Enum):
    student = 1
    teacher = 2
    all = 3

class User(db.Model):
    UserID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    UserName = db.Column(db.String(100), unique=True, nullable=False)
    UserPassword = db.Column(db.String(100), nullable=False)
    UserType = db.Column(db.String(20), nullable=False)

class Post(db.Model):
    PostID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    PostTitle = db.Column(db.String(255), nullable=False)
    PostContent = db.Column(db.Text, nullable=False)
    UserID = db.Column(db.Integer, db.ForeignKey('user.UserID'))
    PostDate = db.Column(db.Date, nullable=False)
    PostPermission = db.Column(db.Enum(PostPermission), nullable=False, default=PostPermission.all)  # 将 PostPermission 添加到模型中


class Comment(db.Model):
    CommentID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    CommentContent = db.Column(db.Text, nullable=False)
    UserID = db.Column(db.Integer, db.ForeignKey('user.UserID'))
    PostID = db.Column(db.Integer, db.ForeignKey('post.PostID'))
    CommentDate = db.Column(db.Date, nullable=False)

class Enrollment(db.Model):
    __tablename__ = 'Enrollment'
    EnrollmentID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    StudentID = db.Column(db.Integer, db.ForeignKey('user.UserID'))
    CourseID = db.Column(db.Integer, db.ForeignKey('Course.CourseID'))
    Grade = db.Column(db.Float)
    course = db.relationship('Course', backref=db.backref('enrollments', cascade='all, delete'))
    
class Course(db.Model):
    __tablename__ = 'Course'
    CourseID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    TeacherID = db.Column(db.Integer, db.ForeignKey('user.UserID'))
    CourseName = db.Column(db.String(255), nullable=False)
    CourseCapacity = db.Column(db.Integer, nullable=False)
    student_enrollments = db.relationship('Enrollment', backref='student', lazy=True)
    teacher = db.relationship('User', backref=db.backref('courses_taught', lazy=True))

class SearchHistory(db.Model):
    SearchID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    UserID = db.Column(db.Integer, db.ForeignKey('user.UserID'))
    SearchContent = db.Column(db.String(255), nullable=False)
    SearchDate = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    user = db.relationship('User', backref='search_history')

class CourseInfo(db.Model):
    __tablename__ = 'CourseInfo'
    CourseID = db.Column(db.Integer, primary_key=True)
    StudentID = db.Column(db.Integer, primary_key=True)
    StudentName = db.Column(db.String(255))
    Grade = db.Column(db.Integer)


@app.route('/')
def home():
    user_id = session.get('user_id')
    if user_id is None:
        return redirect(url_for('login'))
    else:
        return redirect(url_for('profile'))
        
    


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        usertype = request.form['usertype']
        password_hash = generate_password_hash(password)

        try:
            new_user = User(UserName=username, UserPassword=password_hash, UserType=usertype)
            db.session.add(new_user)
            db.session.commit()
            return 'User registered successfully!'
        except Exception as e:
            print("qwq")
            db.session.rollback()
            error_msg = 'Username already exists.'
            flash(error_msg)

            return render_template('register.html')

        return redirect(url_for('login'))
    else:
        return render_template('register.html')

@app.route('/error')
def error_page():
    return render_template('error.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(UserName=username).first()
        if user and check_password_hash(user.UserPassword, password):
            session['user_id'] = user.UserID  # 保存用户ID
            return redirect(url_for('show_posts'))
        else:
            return render_template('login.html', error='Incorrect username or password.')
    else:
        return render_template('login.html')

@app.route('/create_post', methods=['GET', 'POST'])
def create_post():
    if request.method == 'POST':
        # 读取表单字段
        title = request.form['title']
        content = request.form['content']
        post_permission = request.form['post_permission']
        user_id = session.get('user_id')
        
        # 将选中的帖子权限值转换为枚举类型
        if post_permission == 'student':
            post_permission = PostPermission.student
        elif post_permission == 'teacher':
            post_permission = PostPermission.teacher
        else:
            post_permission = PostPermission.all
        
        # 创建新帖子对象并将其存储到数据库中
        new_post = Post(PostTitle=title, PostContent=content, UserID=user_id, PostDate=datetime.now(), PostPermission=post_permission)
        db.session.add(new_post)
        db.session.commit()
        
        # 重定向到帖子列表页面
        return redirect(url_for('show_posts'))
    else:
        # 显示创建新帖子的表单页面，包括帖子权限的下拉列表
        post_permissions = ['student', 'teacher', 'all']
        return render_template('create_post.html', post_permissions=post_permissions)

@app.route('/show_posts', methods=['GET', 'POST'])
def show_posts():
    if request.method == 'POST':
        search_content = request.form['search_content']
        user_id = session.get('user_id')
        
        # 保存搜索历史记录到数据库
        new_search = SearchHistory(UserID=user_id, SearchContent=search_content)
        db.session.add(new_search)
        db.session.commit()
        
        # 根据搜索内容从数据库中检索帖子
        posts = Post.query.filter(Post.PostTitle.ilike(f"%{search_content}%")).all()
        return render_template('post_result.html', posts=posts)
    posts = Post.query.order_by(Post.PostDate.desc()).all()
    user_id = session.get('user_id')
    if user_id is None:
        return redirect(url_for('login'))
    return render_template('show_posts.html', posts=posts)

@app.route('/post/<int:post_id>', methods=['GET', 'POST'])
def post(post_id):
    post = Post.query.get(post_id)
    if request.method == 'POST':
        comment_content = request.form['comment']
        user_id = session.get('user_id')
        user = User.query.filter_by(UserID=user_id).first()  # 获取当前用户
        user_type = user.UserType  # 获取当前用户的类型
        post_permission = post.PostPermission.value  # 获取帖子权限
        if user_id is None:
            return redirect(url_for('login'))
        elif post_permission == 1 and user_type == 'Teacher':
            flash('You do not have permission to comment on this post')
            return redirect(url_for('show_posts'))
            flash('You do not have permission to comment on this post')
        elif post_permission == 2 and user_type == 'Student':
            flash('You do not have permission to comment on this post')
            return redirect(url_for('show_posts'))
            flash('You do not have permission to comment on this post')
        else:
            new_comment = Comment(CommentContent=comment_content, UserID=user_id, PostID=post_id, CommentDate=datetime.now())
            db.session.add(new_comment)
            db.session.commit()
    comments = Comment.query.filter_by(PostID=post_id).order_by(Comment.CommentDate.desc()).all()
    return render_template('post.html', post=post, comments=comments)

@app.route('/create_course', methods=['GET', 'POST'])
def create_course():
    if request.method == 'POST':
        course_name = request.form['course_name']
        course_capacity = request.form.get('course_capacity')
        user_id = session.get('user_id')
        if user_id is None:
            return redirect(url_for('login'))
        user = User.query.filter_by(UserID=user_id).first()  # 获取当前用户
        user_type = user.UserType  # 获取当前用户的类型
        if user_type!='Teacher':
            flash('You do not have permission to create course')
            return redirect(url_for('courses'))
            flash('You do not have permission to create course')
        teacher_id = user_id  # 获取当前登录的教师的ID
        new_course = Course(CourseName=course_name, TeacherID=teacher_id,CourseCapacity=course_capacity)
        db.session.add(new_course)
        db.session.commit()
        return redirect(url_for('courses'))
    return render_template('create_course.html')

@app.route('/courses', methods=['GET', 'POST'])
def courses():
    user_id = session.get('user_id')
    if user_id is None:
        return redirect(url_for('login'))
    user = User.query.filter_by(UserID=user_id).first()  # 获取当前用户
    courses = Course.query.all()
    for course in courses:
        course.teacher = User.query.get(course.TeacherID)
        course.enrollments = Enrollment.query.filter_by(CourseID=course.CourseID).all()
    return render_template('courses.html', courses=courses, user=user)



@app.route('/enroll_course/<int:course_id>', methods=['POST'])
def enroll_course(course_id):
    course = Course.query.get(course_id)
    user_id = session.get('user_id')
    if user_id is None:
        return redirect(url_for('login'))

    user = User.query.filter_by(UserID=user_id).first()  # 获取当前用户
    user_type = user.UserType  # 获取当前用户的类型
    if user_type != 'Student':
        flash('You do not have permission to enroll in course')
        return redirect(url_for('courses'))
    enrolled_students_count = Enrollment.query.filter_by(CourseID=course_id).count()
    if enrolled_students_count < course.CourseCapacity:
        # 还有空位，可以进行选课
        enrollment = Enrollment.query.filter_by(StudentID=user_id, CourseID=course_id).first()
        if enrollment:
            flash('You have already enrolled in this course.')
            return redirect(url_for('courses'))
        new_enrollment = Enrollment(StudentID=user_id, CourseID=course_id)
        db.session.add(new_enrollment)
        db.session.commit()
        flash('You have successfully enrolled in the course')
    else:
        # 没有空位，不能选课
        flash('The course is full, you cannot enroll')

    return redirect(url_for('courses'))

@app.route('/my_grades')
def my_grades():
    user_id = session.get('user_id')
    if user_id is None:
        return redirect(url_for('login'))
    enrollments = Enrollment.query.filter_by(StudentID=user_id).all()
    return render_template('my_grades.html', enrollments=enrollments)

@app.route('/profile')
def profile():
    user_id = session.get('user_id')
    user = User.query.get(user_id)

    if user.UserType == 'Student':
        # 获取学生发过的帖子
        posts = Post.query.filter_by(UserID=user_id).all()
        # 获取学生修读的课程和成绩
        enrollments = Enrollment.query.filter_by(StudentID=user_id).all()
        courses = [enrollment.course for enrollment in enrollments]
        grades = [{'CourseID': enrollment.course.CourseID, 'grade': enrollment.Grade} for enrollment in enrollments]
        print(grades)
        return render_template('profile.html', user=user, posts=posts, courses=courses, grades=grades)
    elif user.UserType == 'Teacher':
        # 获取老师发过的帖子
        posts = Post.query.filter_by(UserID=user_id).all()
        
        # 获取老师教授的课程
        courses = Course.query.filter_by(TeacherID=user_id).all()

        return render_template('profile.html', user=user, posts=posts, courses=courses)

    # 添加一个默认的返回语句
    return "Invalid user type"  # 或者重定向到其他页面

@app.route('/get_students')
def get_students():
    course_id = request.args.get('course')
    students = Enrollment.query.filter_by(CourseID=course_id).all()
    return render_template('students_table.html', students=students)


@app.route('/grade_students', methods=['GET', 'POST'])
def grade_students():
    user_id = session.get('user_id')
    user = User.query.get(user_id)

    if user.UserType == 'Teacher':
        # 获取老师教授的课程
        courses = Course.query.filter_by(TeacherID=user_id).all()

        if request.method == 'POST':
            # 处理打分逻辑
            course_id = request.form.get('course')
            # 遍历课程下的学生列表，并获取每个学生的成绩
            for course in courses:
                if str(course.CourseID) == course_id:  # Only process the selected course
                    for enrollment in course.enrollments:
                        grade_key = f"grade-{enrollment.StudentID}"
                        student_grade = request.form.get(grade_key)
                        # 更新成绩记录
                        enrollment.Grade = float(student_grade)
                        # 更新CourseInfo表中的成绩
                        course_info = CourseInfo.query.filter_by(CourseID=course.CourseID, StudentID=enrollment.StudentID).first()
                        if course_info:
                            course_info.Grade = enrollment.Grade
            db.session.commit()
            flash('Grades have been submitted successfully.')
            return redirect(url_for('profile'))
        else:
            return render_template('grade_students.html', courses=courses)

    else:
        flash('You do not have permission to access this page.')
        return redirect(url_for('profile'))


# Route for the teacher's course withdrawal page
@app.route('/withdraw/<int:course_id>', methods=['POST'])
def withdraw_course(course_id):
    try:
        # 开启事务
        db.session.begin()
        # 查询课程
        course = Course.query.get(course_id)
        if course is None:
            raise Exception('Course not found.')
        # 删除课程
        db.session.delete(course)
        # 删除关联的选课记录
        enrollments = Enrollment.query.filter_by(CourseID=course_id).all()

        for enrollment in enrollments:
            db.session.delete(enrollment)
        # 提交事务
        db.session.commit()
        return 'Course withdrawal successful.'
    except Exception as e:
        # 出现异常时回滚事务
        db.session.rollback()
        return 'Course withdrawal failed: ' + str(e)


@app.route('/admin')
def admin():
    # 执行查询操作，获取view2的数据
    query = text('SELECT * FROM view2')
    result = db.session.execute(query)
    view2_data = result.fetchall()
    # 渲染admin.html视图，并将查询结果传递给模板
    return render_template('admin.html', view2_data=view2_data)

@app.route('/user_comments')
def user_comments():
    user_id = session.get('user_id')
    if user_id is None:
        return redirect(url_for('login'))
    query = text('SELECT * FROM user_comment_view WHERE UserID = :user_id')
    result = db.session.execute(query, {'user_id': user_id})
    comments = result.fetchall()
    return render_template('user_comments.html', comments=comments)


# 在课程详细页面的路由处理函数中获取选课学生信息和已选人数
@app.route('/course_details/<int:course_id>')
def course_details(course_id):
    course = Course.query.get(course_id)
    if course:
        teacher = User.query.get(course.TeacherID)
        enrollments = course.enrollments  # 获取课程的选课记录
        students = []
        for enrollment in enrollments:
            student = User.query.get(enrollment.StudentID)
            students.append({
                'StudentID': student.UserID,
                'StudentName': student.UserName,
                'Grade': enrollment.Grade
            })
        return render_template('course_details.html', course=course, teacher=teacher, students=students, enrollment_count=len(enrollments))
    else:
        # 处理课程不存在的情况
        flash('Course not found')
        return redirect(url_for('courses'))

if __name__ == "__main__":
    with app.app_context():
        db.create_all()  # 在第一次运行时创建数据库表
    app.run(debug=True) #在这个更改端口