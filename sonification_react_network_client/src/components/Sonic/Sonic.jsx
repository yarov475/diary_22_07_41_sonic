import React from 'react'
import s from './Sonic.module.css';

const Sonic = () => {
    return (
        <div className={s.item}>
            <ul>
                <li>График тональности текста</li>
                <li>График тональности тем</li>
                <li> Музыкальные треки</li>
                <li>График треков</li>

            </ul>
        </div>
    )
};
export default Sonic;