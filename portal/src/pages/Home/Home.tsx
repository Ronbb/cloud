import { FC } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faGithub, faWeibo } from "@fortawesome/free-brands-svg-icons";
import "./Home.css";

const Home: FC = () => {
  return (
    <div className="home">
      <div className="home-title">
        <div className="home-title-left">
          <h1 className="home-title-left-header">Ronbb for fun</h1>
          <p className="home-title-left-item">
            <a className="home-title-left-link" href="https://github.com/Ronbb">
              <FontAwesomeIcon icon={faGithub} /> Ronbb
            </a>
          </p>
          <p className="home-title-left-item">
            <a
              className="home-title-left-link"
              href="https://weibo.com/n/%E6%A5%89%E4%B8%8B"
            >
              <FontAwesomeIcon icon={faWeibo} /> 楉下
            </a>
          </p>
        </div>
        <div className="home-title-right">
          <img className="home-title-right-avatar" src="/avatar_360.png" />
          <img
            className="home-title-right-avatar-background"
            src="/avatar_360.png"
          />
        </div>
      </div>
    </div>
  );
};

export default Home;
