import React from "react";

import s from "./Navbar.module.css";
import {NavLink} from "react-router-dom";


const Navbar = (props) => {
    return (

        <nav className={s.nav}>

            <div><NavLink to='/project' activeClassName={s.active}> О проекте </NavLink></div>
            < div><NavLink to='text' activeClassName={s.active}>Загрузить тексты </NavLink></div>

            <div><NavLink to='/news' activeClassName={s.active}> Новости </NavLink></div>
            <div>< NavLink to='/sonic' activeClassName={s.active}> Сонификация</NavLink></div>
            <div><NavLink to='/settings' activeClassName={s.active}>SETTINGS</NavLink></div>
            <div><NavLink to='/users' activeClassName={s.active}>Сообщество</NavLink></div>

        </nav>


    );

}
export default Navbar;
