import { Footer } from '@/components/component/footer'
import { Nosotros } from '@/components/component/nosotros'
import { Navbar } from '@/components/component/navbar'
import React from 'react'

function page() {
  return (
    <div>
        <Navbar />
        < Nosotros />
        < Footer/>
    </div>
  )
}

export default page