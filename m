Return-Path: <linux-nfs+bounces-796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52C81DC29
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 20:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C941F21460
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 19:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A386D523;
	Sun, 24 Dec 2023 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="acoAvou0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic310-21.consmr.mail.gq1.yahoo.com (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598DDDA6
	for <linux-nfs@vger.kernel.org>; Sun, 24 Dec 2023 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703446910; bh=uA6nD/97r9MoxZlnk5Ueccj6mlEO6MxnzK5MIj2jiZs=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=acoAvou03BAp8l2bQEdpeuE5G0NPMoO9jOqoSWkBP7Kv+FHD9C7FCz4QTj1jE+Z8AyIhVoF0GWhNCHUG60FY+JYtqOYg+q0YNsI/HWL70JDwVNXzxPyWZiJ/um3ELRXqjAo/qh+h05rdqg09ljy4Ardkgl4JnGzaHs+Mk0CdTkwZqbarUfB8B3A7Mb/ps0D055ESpp9dfFkU773XnYqONeRHL93qRbLcqtLeEsdo1emUiN6RhaBmQHkzZyBZcJVXVZRMYP8j0lgtSsFPSQZhUVYEohfkTC7WnPuyONJP+U3r3NR2a9iC26288WnQYZT4c8B5BM+ilHvVw3e28Ftg1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703446910; bh=Cwa0LvWoVGMsnQLQysY7mjBX6CUVkuVE7WPFLZBg/Eu=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=M7wTyPKaEzvAOeEehqvrX0vwlAAqH4k+WWFl1O2ydY7C1kNajnPOsdFfUNty0k7vPLwsr0pfmPscHjKyhpQHdx/poiakOPBIGJ1yfyGImtZ4ERvaivnfyY8tLqinYcvDjzr4PNXzTcnhEWCM0P0WFoRHRFGhDSlDzYm/j74V4Eq4ss/4H+DbK3vnXaL8QJz9slS67/Czdrs33LCnJTo4hTLTjrMUNZ+zhJqbS+bwdocj6ElEAwgSabZTPGEFd6wlBG2mrAszEyaV/+izY7HJwff/Tw0P1lOndnMi5hn3+RFZJ+dDRkUm/JbRKijm7esa61wX+Pb88+vjgPDNpY6l3Q==
X-YMail-OSG: Sc2dY.QVM1mCJ6LiFAwUKsyRSZZTr3FNa2AWMRQPeXj7YyC.Pn4AceZuqftuM4C
 f0SPakCY.CI7io4Qmz86rdqUPxGEpvpwqv7v6tPNHT6d1upKNO0dUdWxLn8vu0lkL7FsBCFbwW8c
 vFh3X9lV8LnrWQsH.fDIw55dJPJvikAzq6HokwePjdzg6lLdboMs5Ix15o98H8HOJbqIrzsqPG42
 S5DE9pbo4N5o9SWdAiehlljKzjtRzlp9hBJVjNBY9N0ZsMM5nDm5YBLtdFnz4YRL6hukBmUPdkxU
 wrPendWAux._qYOM8hxHJ7fUM8J92xCRLQ03tdQMVHQT.5i6J.p8EeJaxaTEMQALgifwdOvJATrt
 UA.m4F91qP5.K_OjZXKQXSEB4oAY2Cd4t9jKVzxeV3g5OL2Q9PsepILzbDBBSYcXQ3VykZA3Cl2i
 VLx.MKZbXe4irGEurx8gyJkF.poTvBtuRqTj5AXKotoW2BJTeiDBYNAEP9joi5r7QpugVcYxrACv
 xZUQ_Gjla2HolSpBSvUORHlP_oY80Sp8aXIeVkdJeezPS.UPrboAWwVtyS1XjG3nulvtOLuhfU39
 sVGPDjpFL6ku.NXKnvqfmezxLFh2WVD5u24rQjSth_HWtWTbPLLm0ENqymsaqmMMObAWrUNfaFgA
 yCb_LqqVlS39F3C2kzKh2XRxGngwVmnTVvtUqYpQMIB6_h2vrTJGgXnT.L5LcDelTk3P73hzG2ug
 w6MNRZTy0i4xbhWlKzNhQBiG_cgVqwhzcCVHBwdZ9LKHbPLo2Jog1DqCA47mnm_rZz1upVwTMCM1
 v5sU1wROH0DmwKlwCG2oaye7QNZDpfhWvcIh47CGsR3xW9yY9gKk4MYx68RTl2WZAjOZAejI1TJE
 klFb7MgVNpwFos7JQcj66pBCEw0xVitghcrevaKtPz_zuk1vjNq_ybsIEedGLVOVrOvQ6W7t93k4
 SAa1vYtCso1NKZ6mkx14FTJdd2H5bX69GwSr7nwsEwEDPLsjts5QgkOJXIV8tnXODpoCTmEnZB2H
 lMgbDuSuw7K6Ut3du0BL3kxBFbhmXh9T1QwgR1MxwDCYcD4rUCD18i.BATHcrIIHOOyxNzPVzPOk
 DGwt77bAjPCBvIS8RIGTwYQV.LKNrE_VDIdtxja_i41l8SV6Z819o9IeGU2qMsxtVQWOMKNXNo5v
 6aLHYYSEu.NvM.srtoLEZEC.UBbB0YkrMR6P8_PXOJQGSdKTDxZ8N1nM6n3cz7I7ncepR3fL145Y
 sz9i3RWOOBBAR_hIR_xhDYPC5QB_jQ_Aw0dzOcWlV_iEL37MhBuCNRF9OiH0F6L1nsen2fwbXZY3
 gHcuNhZFBAsNj.zc8SZ_oIQYuM85gofmgpMr6heIlqkPNq0lJ169DYbDPFBkOOexEKF4qCdA2sfe
 gNrm._PzYhGwFt_EUSaiKsc7cwp4P7Grieve3jvt0OCTvhEb0KQ_5K4hFP0M._rdEPdKuuTjQQR.
 Lj3OcVUcxxM3Dvhe74PrrgYEjQYHwcNlpRf3CtHp4mcHZMzJaB74GYGAwt6inAfE8PVNV8Rc3ubw
 Oa4z4HjHlphabjvENLNr5vE3RvahsY57GfKvOb93gskANBz5uGCQJvhvE5v0td.CiTdutTsV4mJ4
 TYNIIQ.61fMx5xqfoIbZrGmUKEeLkRnvItbgSBumSDscit4K6atGFMIEV.6Wc728CDL_O9P8RxxY
 jbW8btPiXy5Aem5JoaJSLoO1HZXyZcR1d1Pj5HC8ithdDUmAkT39o9.Yqa8XYjSlTKz5kYBCSCGe
 afM9ZwCw7LPVweYeNAsJntmRJy9FraaiuWVxyyRLnGjFHE.BoRT2NwR3FSA9W5Bqq5kOjjbPGwqE
 m6CJwnWmlZCTr9D1mw929AAOmPE1DshYU56hZiSlueOEWR1e0j7jfs9ra8DliVZeEhO.ZjiKPjBB
 pMoDL0kC7mk1A36BMerieWhBoTS1yqa1ZsKOkrEbgSdjOFKFSb9tBc_oCTY_iVYgR_DlawN.X3pr
 UhBjth7ue6ZS5OK2tm8MFIJ04GonK_cFgRUzXT7qnxx06n8xtr9MiYlVDDJBL25NcK8AL0tG.vkh
 5V33.rKDJEiCDCGnd6LatmZaFNhBAZ0gcivEhYugCLeJ2nz9RMdU2DruyvlrRbqgskLtbknWN4cF
 Iptt1ZuyeXoqZk3era7_GLXoYT6OQea4d.lloB6zmLl6lL94yCrC_xB6uPb4Rvu0alrave_Nikj6
 RnLLlmqURiT3uI99vRPKmb8ZsnHo-
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 23d90a21-5293-425a-b296-4bfbe4ef9831
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 24 Dec 2023 19:41:50 +0000
Date: Sun, 24 Dec 2023 19:41:48 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: "polarian@polarian.dev" <polarian@polarian.dev>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, Jan Stary <hans@stare.cz>
Cc: Richard Stallman <rms@gnu.org>, Bruce Perens <bruce@perens.com>, 
	Aditya Pakki <pakki001@umn.edu>, 
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
	Paolo Abeni <pabeni@redhat.com>, 
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>
Message-ID: <549578214.4148875.1703446908152@mail.yahoo.com>
Subject: Re: I can't get contributors for my C project. Can you help?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <549578214.4148875.1703446908152.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21952 YMailNorrin

Note: This is about Unreal map support in this project: sf.net/p/chaosesqueanthology/tickets/2/
Which is an opensource project. White people will not help
me because, as Polaris here says, they are feminist scum.

>Hello,

>In case this is not a troll,
It is not
>and is a stupid narcissistic teenager who
Also incorrect. 37 years old.

>thinks the way open source functions is via extremism and horrific
>sexism, and promotion of terrorism, I will respond.
I've likely been an opensource/freesoftware programmer longer than you.
Maybe not; maybe so; but I'm not the neophyte you take me to be.

>Congratulations, you will not find a single contributor, if you think
>that storming into a public mailing list spewing sexist comments, and
"All opensource C programmers are pro-women's right's dick-chopping faggots
as their new-testament demi-god tells them to be (matthew 19 greek)"

I thought there was more religious plularity amongst them.
There used to be.

Want a religious war? We can do that if that's what you're up for.
If you are all our enemies than we'll treat you as such.
Do you understand what I am saying: ? Do you?

>then supporting terrorism is the way open source functions, then you
Why shouldn't one (morally) "support" those who slaughter feminists, and
in the alternative,
ensure men may marry female children, as YHWH's Law commands in
Devarim chapter 22 verse 28 (greek, hebrew, latin, not english (white fuck))
?

Tell me?
Should I "not support" the hellenistic greeks who put the Amazons to the sword?
And introduced an epoc of rape for young virgin child brides? (Zeus was a rapist)
(white faggot males seethe while clutching their New Testament "BETTER A MILLSTONE")
(english) ("CHOP OFF DICK FOR HEAVEN!!!" "NO MALE NORE FEEMALLE!!")

In hebrew it's called "tahphas" btw. Also supported by the actual God you white scum
try to bury.

>have the complete wrong idea.
When I started opensource/freesoftware programming it wasn't all woman
worshiping faggot white christian scum. Guess it is now. Regardless of
whether your pro-woman teachings are acknowleged from the New Testament
or not by you.
(hint: that's where they're from, uneducated trash)

>Best choice of action would be to not speak any further, and at the
How would that get me contributors to assist in additional map format support?
It wouldn't.
>minimum apologise to Jan,
Jan is some cunt who opposes child brides and is mad that the taliban are
raping their little girl wives as we speak.
No I will not apologize to Jan.
Especially since you allready gave up the "secret" that no opensource programmers
will help anyone who isn't a woman worshiping faggot piece of shit.

I'm so fucking glad your feminists have been killed in
1) Central Asia
2) Iran.

Anyone opposed to men having young virgin girls as brides, deserves that fate.
>but I doubt anyone will take you seriously
I'm simply asking for some more map format compatability.
I did several myself.

>moving forward now anyways.

>Best way to deal with people like this is simply to ignore. Note to the
Best way to deal with feminists is to kill them dead: like the Taliban did.
The only way men can get their rights back is to do what the Hellenistic Greeks
did in their history: that is to slaughter people like you who uphold women's
rights.

>mailing list is I did offlist the user in response to their previous
>email, which was aimed to provide feedback on how to properly ask for
>help, and how openbsd is not a freelancing community for random C
>projects. I did not receive a response so they obviously aren't here
>for any decent reason, and are likely a troll.

>Please now get out my mailbox and go somewhere else, I rather read
>constructive emails instead of spiteful sh*t.
Want me to physically fuck you up dipshit?
How about you go talk to a wall.

My emails are about Unreal Map support in an opensource engine.
Not you showing how much of a white faggot that you are.
Do you understand that?

sf.net/p/chaosesqueanthology/tickets/2/
>Take care,
>--
>Polarian
>GPG signature: 0770E5312238C760
>Website: https://polarian.dev
>JID/XMPP: polarian@icebound.dev

