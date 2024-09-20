import { useEffect } from 'react'
import { useRouter } from 'next/router'
import jwt from 'jsonwebtoken'

export function withAuth(WrappedComponent, allowedRoles = []) {
  return function AuthComponent(props) {
    const router = useRouter()

    useEffect(() => {
      const token = localStorage.getItem('token')
      if (!token) {
        router.push('/login')
      } else {
        try {
          const decodedToken = jwt.decode(token)
          if (!allowedRoles.includes(decodedToken.rol)) {
            router.push('/unauthorized')
          }
        } catch (error) {
          localStorage.removeItem('token')
          router.push('/login')
        }
      }
    }, [])

    return <WrappedComponent {...props} />
  }
}