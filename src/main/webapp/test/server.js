const express = require('express');
const bcrypt = require('bcrypt');
const cors = require('cors');
const mysql = require('mysql2/promise');

const app = express();
app.use(express.json());
app.use(cors());

// MySQL 연결 설정
const db = mysql.createPool({
  host: 'localhost',
  user: 'yjy',
  password: 'q!w@e#r$',
  database: ''
});

// 로그인 API
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ message: '모든 필드를 입력해주세요.' });
  }

  try {
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
    if (rows.length === 0) {
      return res.status(404).json({ message: '사용자를 찾을 수 없습니다.' });
    }

    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: '비밀번호가 일치하지 않습니다.' });
    }

    res.status(200).json({ message: '로그인 성공!', user: { username: user.username, role: user.role } });
  } catch (error) {
    console.error('로그인 오류:', error);
    res.status(500).json({ message: '로그인 중 오류가 발생했습니다.' });
  }
});

// 회원가입 API
app.post('/api/signup', async (req, res) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).json({ message: '모든 필드를 입력해주세요.' });
  }

  try {
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [email]);
    if (rows.length > 0) {
      return res.status(409).json({ message: '이미 존재하는 사용자입니다.' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const createdAt = new Date().toISOString().slice(0, 19).replace('T', ' ');

    const query = 'INSERT INTO users (username, password, role, created_at) VALUES (?, ?, ?, ?)';
    const values = [email, hashedPassword, 'user', createdAt];
    await db.execute(query, values);

    res.status(201).json({ message: '회원가입 성공!' });
  } catch (error) {
    console.error('회원가입 오류:', error);
    res.status(500).json({ message: '회원가입 중 오류가 발생했습니다.' });
  }
});

app.listen(3000, () => console.log('서버 실행 중: http://localhost:8080'));