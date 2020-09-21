import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
import projectsJson from './projects.json'

// assets
import derivativesSrc from './img/proj_icons/derivatives.png';
import hiitTimerSrc from './img/proj_icons/hiit-timer.png';
import ptableSrc from './img/proj_icons/ptable.png';
import uiBootstrapSrc from './img/proj_icons/ui-bootstrap.png';
import atomicTheory from './img/proj_icons/atomic-theory.png';
import cli from './img/proj_icons/cli.png';
import defaultIcon from './img/proj_icons/default_icon.png'
import githubIcon from './img/github-icon.png'

var projIcons = [{
    src: derivativesSrc,
    id: 'derivative'
}, {
    src: hiitTimerSrc,
    id: 'hiit-timer'
}, {
    src: ptableSrc,
    id: 'ptable'
}, {
    src: uiBootstrapSrc,
    id: 'ui-bootstrap'
}, {
    src: atomicTheory,
    id: 'atomic-theory'
}, {
    src: cli,
    id: 'cli'
}]


const app = Elm.Main.init({
    node: document.getElementById('root'),
    flags: {
        windowSize: {
            height: window.innerHeight,
            width: window.innerWidth
        },
        projectsJson: projectsJson,
        projectIcons: {
            icons: projIcons,
            default: defaultIcon
        },
        githubIcon: githubIcon
    }
});

window.onload = function () {
    app.ports.scroll.send(null)
}


// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();


// here is the old school projects I did not include in my thing
/*{
        "name": "Country Fact Finder",
        "imgLink": null,
        "blurb": "An application that parses and displays information from 5 text files.",
        "githubLink": "https://github.com/joshuanianji/Country-Fact-Finder",
        "link": "https://joshuaji.com/projects/fact-finder",
        "year": 2019,
        "language": "Elm",
        "concepts": [],
        "pinned": false
    },
    {
        "name": "WordRank",
        "imgLink": null,
        "blurb": "An application that ranks words based on usage from a string input or a text file.",
        "githubLink": "https://github.com/joshuanianji/Wordrank",
        "link": "https://joshuaji.com/projects/word-rank",
        "year": 2019,
        "language": "Elm",
        "pinned": false
    },
    {
        "name": "Cryptography",
        "imgLink": null,
        "blurb": "An app that deals with Caesar and Viginere cyphers, and can calculate hashes.",
        "githubLink": "https://github.com/joshuanianji/Cryptography",
        "link": "https://joshuaji.com/projects/cryptography",
        "year": 2018,
        "language": "Elm",
        "pinned": false
    }
    */