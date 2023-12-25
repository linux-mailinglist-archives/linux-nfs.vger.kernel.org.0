Return-Path: <linux-nfs+bounces-805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F395E81E192
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 17:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25432822EA
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E252F6F;
	Mon, 25 Dec 2023 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cITrekLU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic305-20.consmr.mail.gq1.yahoo.com (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542852F62
	for <linux-nfs@vger.kernel.org>; Mon, 25 Dec 2023 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703521031; bh=b7oS2vPf5l0YuvHJ8ryWJgEKy/P1iTrjvk6flK5KjbA=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=cITrekLUdQ+3EUIQUOfiWooqmL15m+qXqJ6mTCinis4kV91yW/7qMvIcq0IjogChg/oRaOGlnehMUqim3U1CFxr62RG0+BzFwKKwVhUS+qD6BIC533vF6wjQa0wWnMw+bjB9XtZuy/p6T40/j8s+SkWlrbxdP3U2z1qgPILNcieF/IOHrAEQKknVseZldmybgGhDuboRcnHGPGfvYmyiQEYAYXYQhUj7uj0OZ2pubzGYdpqBjpzn05AqN8MZ6kaVTx0kC/FD5mukwkwfxdmv3RYTiAtKQtmQMNA62JXBgRKMH7UVUs99DC1T4xEbry2mXCknT89sXnYboaF3SoiWPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703521031; bh=Bj5q7H9zY/QnbGfGbmc4UqE7a36AS8vkFwj2ONt38o1=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=D8tIxtl1AS4gajQtBHxT1ZB2nYUewEkYnqa2t34vog+0WEOOFsPSE7Vx5GRmYo5VhMxJVqVjVvsQZKWJFFfnFXG3Gyg16nz6iOWcJtUaxJMW44QVVYm8/wrxmFXl7kGS5VMOvSPaRNdMnFPNeeQ10Ms0BRYzwVa9kB4JcNnTJhhXBUmGARTPq6XwfsPZvmIwgBEH+lSiWUab89eth5iPvjKutnwgrw831SXwESG7fI+YJzG7pGZUEuqr98lidD8qPCChnDZcucm5TspjYshH4r47yzPnbqMABZS+5jEhzrZzH7ItNvdqexmeVsfItNPUbfzXMvrmnCzWycplfGWgoA==
X-YMail-OSG: M2_0rK8VM1kkh4orrRbBQpWohCcXmhjECf6_GE7lPxkipgxpDT83vfcUsxZD5oq
 WhRgfQffSK_mQiM0Lxniu_GjIPXMNUb9vVXEcaeNJvz6WOjpUxjOmw8jlZrWe1o7hqLIv0TctXhe
 TwIMdHxtNLAisSmWuyKjCMjVdRut3TNeA_EJpjqXR6oTrhWziZBZmbnwOO1XyCtvbaPxPZUie.F0
 gqvDUHimYFJXfYtMZJCNMKb595rXxaLl00_hpgBkz8dERR3dXDrP2a0H9SDnKmHqRzk0KZQ7l4yB
 t2ZzyP4H7W1L76YVtSFjp4oR4tdEYtTN_iR9VR7FztzmgOygx1S0beGm_.p.95FnuNNa2d5odQz.
 LMBTrUyqPmNy0knqHpblkvxWi0s_qCw.c3tRfao_yibVehAfnQt9EhVFY3rIBE95BCvxQtblQ9l5
 D7mP6lbMS7uiwiUYRnxOajAxfxfA4QbzalVXfNLuMxoxvfAWY8mJpAlsPIC49..EGSnerGnh7_UA
 CecBu4dW55aLb9EUMEQCwAuPoi02FcM8AnfOZarK3MgV9SBvOGCoYMNo9BDIfMt9g.FO.wRg3h6J
 cIxBZbdnIvmhDOAhcbZuR997yUBCzVuF0v_n7sdPAJOYrreDqJFhMCH2XNdsIQLtYl0rUQGIn5W5
 giALpeY.EIVseW9I87cSxiGVu8uWRFDSUk1DvIOuOh5zl6zsdIIL0b9gdyYxk4Q2PNRzPJl9N0EZ
 MUn.Kefn46gd3vL0CeUwNcxFlHhH_JxGhfo3_PRIfl2zHERLN2a_Kk5eTZVSvPwYcRRbtqhj_sI_
 jNY5DtIP3IH76A284uzSX4BBY8LBVbedO0DeU_Ks8gCVnpLN9Sh27ymhpjqouBJ9_nLQvRlfTUuY
 TLdtU1TUwUoBLnoxlmb.9x76OwU1RK.2dISrpyHYzJVyjGawNbUseeSAKyu8yzN775K719bnEBl2
 dWR4oznBPpNd8hu74BQ4OaCLFv.zxgSD_.nm8c9NpF639u1YAt3PPVLHiQNWLtqTAUXJTS8C687i
 fG2oP2WXfjWWz6VQt2c37JPPpADAoETBHhHL_HN5RGJby4Ktk6eY9urIDAKNpvBZVfQRy0irZG5s
 ecnTbs7.VvnKt0inkwa9PjmrkIWBVSauMdOgRdXiBxGn.iz_HER7ZgGhHRxPBF35Q6D7of7pG1wu
 CtH.4beUZq1HcG_uEUM5Xv21yEvxbnuXAXWW7l4_t5ClRgwbRSc51WPbXdHAtXSj45rakitiyBmV
 P2TWCle0PC.c_pjTFSk1LXgTIo3vqdsCj3q9vEgBx.KVgQBeeUdtsuyhBynbutUYSOQBntgOfxNQ
 oNOFKNSh_bJAIwIwi9hChgMC4QT1NC.r1IzICDqW7tKpOdui9ctRqt1UgHOyqyQekQjlvvxHocsU
 r_snrf_NDNiANPkPZLce8w3QN_pMFsOE4V1G6Wm5HIBoJTFpbNfwGOHVoWtPc0j2M8VUfAb_6gHj
 ZUcvwTVLq7OBvqbraXgnUPxS3Bj6mtOH2tMw2hUTzn4vLxjsfz6k0Vpuguqa1Ar9pGhP.CffSkSI
 3Nbfo7HSk27ar8sb4y5MS0a_gTbrf0XAHwZ8IVu9P1JIf1FW5CrkcTcLp4CVa7uUjjNgfgV25Jxa
 6gcN4c.RlH8U1eQYSx4dD4.4yjftNnIDmv_0QxKWIkGLs9faN_.KCCjJ2YvmRoS_NTQnbxqt3V79
 Be9geQ5xfzMyOR8dDhkqJlfpe8xRQdEAmMA6a3C6TMmRARboCRKod4K198QvCovtghBevY9Z.5KT
 aQryf8ESG.WZrJdXwqG2D0AtkRLgPSCOCVR_6eXp32d4yquEP7W7HAbJn.1v1daJW2ni6qRTq2vT
 2W8habuv.5uqwHsa9vH8weQx3rTByHPSzMAhkbLs_VngW15K5I2SGvD4HnSpqps38RaoQURNLIK6
 ecyWGBfMCtFksM4LXVs8TfJSdK7XyBB3C5u1cgVoa_UIQmU5B5Ar9dCS3gDsWpFnp4zzzW0fFAPl
 O8WA08v0bi3qZ3FFAES3s0QhU2YG5fdmC9I1Fcu_nw3uJwfc_jlAGo.izofxb1WUt5GVEJd4dFHc
 cY90hnQKlZhqZ8BH8fon4bBPwhE16aL2nm6a8vavWTMzF073gb7TlZ2F.dF0Lf8UY.7ExWdZ1bmZ
 EpkKYv2.si4i4sPYTsI7bqqqqIqEa9vlIGaQPWnhfk086wP4JzFLJNPWRviOKHaEPeHWUam0Y0WZ
 rOeehmrVc3duLoD29xo.vPPWh
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: d97e5afa-a11a-4c89-bc5a-99dc184621c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 25 Dec 2023 16:17:11 +0000
Date: Mon, 25 Dec 2023 16:17:09 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Polarian <polarian@polarian.dev>, "theo@openbsd.org" <theo@openbsd.org>, 
	Richard Stallman <rms@gnu.org>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>
Cc: Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"editor@lwn.net" <editor@lwn.net>, 
	"esr@thyrsus.com" <esr@thyrsus.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, Bruce Perens <bruce@perens.com>, 
	Jan Stary <hans@stare.cz>, 
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>, 
	Rudy Zijlstra <rudy@grumpydevil.homelinux.org>, 
	Wolfenstein Enemy Territory Fans <6469670767@groups.facebook.com>, 
	ChaosEsque Team <chaosesqueteam@yahoo.com>
Message-ID: <1149317171.4243163.1703521029010@mail.yahoo.com>
Subject: Re: Why the mail filter?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1149317171.4243163.1703521029010.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21952 YMailNorrin

>I am normally against centralised control, but if you are unwilling to go away, then I have no choice.
Ah, another dipshit white fuck who thinks there's no such things as "constructive eviction" or "constructive dismissal" 
and he can claim one thing, but do another.

"I'm normally against centralised control, except when it benifits me"

>but if you are unwilling to go away, then I have no choice.
No one's infront of you, retarded white (pro-woman's rights) fuck.
I never met you. Do you want me to show you what "not going away" is?
Do you?

>I would kindly ask you to stop spreading your hate towards me across
every OpenBSD mailing list, and Linux mailing list, thank you!
And I kindly asked my "fellow opensource C programmers" to assist me 
in adding Unreal binary map format support to the aformentioned (previous emails)
opensource project.

But then you informed me that opensource was an exclusive Pro-woman's rights
anti-child bride white faggot club and that I was NEVER going to find any 
contributors because I was not a pro-woman's rights white faggot.

You then called me 13, claimed I was looking for financial support for the project,
put the project in a false light as if it was just starting out, etc etc etc.

I may have been programming opensource longer than you; but because you
have the "correct" white faggot beliefs (your religion) I'm "less experianced".
Been programming for decades, dipshit fuck.

Go here: sf.net/p/chaosesqueanthology/tickets/2/
And program.

Show us the code. Also go here: www.youtube.com/watch?v=9-BuCt5KReo

---------------------------------------------------------------------------------------------------
Polarian wrote:
Hello,

Seen as you won't go away I have forwarded the abuse to yahoo and
firemail.cc, I wish you the best in life. I am normally against
centralised control, but if you are unwilling to go away, then I have
no choice.

I would kindly ask you to stop spreading your hate towards me across
every OpenBSD mailing list, and Linux mailing list, thank you!

Can the mailing list admins please bounce both the firemail email and
the yahoo email please.

Take care,
-- 
Polarian
GPG signature: 0770E5312238C760
Website: https://polarian.dev
JID/XMPP: polarian@icebound.dev

