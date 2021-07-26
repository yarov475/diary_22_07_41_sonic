import React from "react";
import s from "./ProfileInfo.module.css"
import Preloader from "../../common/preloader/preloader";
const ProfileInfo = (props) => {
	if(!props.profile){
		return <Preloader/>
	}
	return (
		<div>
		<div >
			<img src="https://images.theconversation.com/files/223729/original/file-20180619-126566-1jxjod2.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop" height="300px" width="100%"></img>
			</div>
			<div className={s.descriptionBlock}>
						<p>*********

							В этом проекте проводится анализ тем текста, эти темы озвучиваются в super Collider затем музыка анализируется и мы
							получаем график. Это герменевтический круг на каждом из витков мы понимаем что-то об исходном тексте.

							В данной работе использлванны материалы дневников прожито. Мы стараемся веделить в них скрытое эмоциональное послание.
							Для этого нам полезна музыка</p>

				<p>{props.profile.contacts.facebook}</p>

				<p>{props.profile.lookingForAJob}</p>
				<p>{props.profile.lookingForAJobDescriptio}</p>

<p>{props.profile.fullName}</p>




			</div>
		</div >
	)
}
export default ProfileInfo;
