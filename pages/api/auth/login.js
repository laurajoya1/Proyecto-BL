import mysql from 'mysql2/promise'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method Not Allowed' })
  }

  const { email, password } = req.body

  try {
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    })

    const [rows] = await connection.execute(
      'SELECT * FROM Usuarios WHERE username = ?',
      [email]
    )

    if (rows.length === 0) {
      return res.status(401).json({ message: 'Usuario no encontrado' })
    }

    const user = rows[0]
    const passwordMatch = await bcrypt.compare(password, user.password)

    if (!passwordMatch) {
      return res.status(401).json({ message: 'Contraseña incorrecta' })
    }

    const token = jwt.sign(
      { id: user.id_Usuario, username: user.username, rol: user.rol },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    )

    res.status(200).json({ token })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Error del servidor' })
  }
}