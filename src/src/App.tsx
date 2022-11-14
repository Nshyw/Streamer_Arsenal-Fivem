import { useEffect } from 'react'
import './App.css'
import Streamer from "./assets/Streamer"
import {Routes, Route, useNavigate} from "react-router-dom"

export default function App() {
  const navigate: any = useNavigate()
  useEffect(() => {
    window.addEventListener("message", ({data}) => {
      if (data.show) {
        navigate("/streamer")
      } else {
        fetch("https://streamer/close")
        navigate("/")
      }
    })
  })
  document.onkeyup = (data) => {
     if (data.which == 27){ 
      window.postMessage({show: false})
     }
  }
  return (
    <Routes>
      <Route path="/streamer" element={<Streamer />}></Route>
      <Route path="*" element={<></>}></Route>
    </Routes>
  )
}
