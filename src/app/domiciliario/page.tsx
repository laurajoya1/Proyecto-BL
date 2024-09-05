import { Footer } from '@/components/component/footer'
import { Navbar } from '@/components/component/navbar'
import { PerfilDomiciliario } from '@/components/component/perfil-domiciliario'
import React from 'react'

function page() {
  return (
    <div>
        <Navbar />
        < PerfilDomiciliario/>
        < Footer/>
    </div>
  )
}

export default page