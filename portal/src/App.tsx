import { HashRouter, Route, Routes } from "react-router-dom";
import "./App.css";
import Home from "./pages/Home";
import { NoMatch } from "./pages/Error";

function App() {
  return (
    <div className="app">
      <div className="app-main">
        <HashRouter>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="*" element={<NoMatch />} />
          </Routes>
        </HashRouter>
      </div>
      <div className="app-footer">
        {"ronbb.fun "}
        <a href="https://beian.miit.gov.cn/" target="_blank">
          浙ICP备2022015348号-1
        </a>
      </div>
    </div>
  );
}

export default App;
