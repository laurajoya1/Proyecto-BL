import { withAuth } from '../component/withAuth.js'

function AdminDashboard() {
  return (
    <div>
      <h1>Dashboard de Administrador</h1>
      {/* Contenido del dashboard */}
    </div>
  )
}

export default withAuth(AdminDashboard, ['Administrador'])