Return-Path: <linux-nfs+bounces-800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F5881DFB6
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEDB1C211E6
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FD1EB34;
	Mon, 25 Dec 2023 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jVrouFQg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic318-22.consmr.mail.gq1.yahoo.com (sonic318-22.consmr.mail.gq1.yahoo.com [98.137.70.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3935287
	for <linux-nfs@vger.kernel.org>; Mon, 25 Dec 2023 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703499895; bh=aG3x/Gwjn4cN307RnrwhQb++OwappqX7kReZEfjgj5c=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=jVrouFQgsySEUWGUYXeA57nsyHQWkDGCn/dP9smlmwy+mWKsZ+tspD0/94KCmqrwbrg3vWTl5/pV0niDsMs97ygImvlOsjxy9wEuBgtxjq3Dq2RY41YZkJx0U0kP5q/8UvBieVGW5bVPVkVl+t3Q/IWYssMEBB6sgeRPc/X6UOiHPA/C6SKFoA84fWb2cLJUD8d0K53aQvL9pCK0cF0ziKyVZ9ijgRiqmr1DacIVdKEDNEdU/eFZvcpypOzXJkt10PaBgyPt5U5biLlZZAy+kyJpxphVjo79Z8DkdgMmsYrmM9BiFIZI1/1LVH4oXLKzPSt9TfdI5pZfZ+c3EjvYiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703499895; bh=3I+A1BGOEHxw7N2aHAggKOCR/+Zl54N2fMGMpZCnUyA=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=pXN0Dqtckzp0zcvA5VodjZzwC8jFQvhXYL4MF3+KcKGAaE6R3AYAs3pn/VdCj8/Y0GchcEOHhv72M6ix5TUGRcFH5gGQpFQxevioKuze6WsQojh80FkL0vMA7kOKHsDtyoYae7PxnD63jO2mK7cZBQzcI5FoGSyDEdU2eP2rhkWFrPqTazFYTL0D54povoQKfInQtFFHOGfLbWO2aiYli4GTzIZqehY8wkZg0HF642Jqvd/IBKIEi3pGF7XsBMGNDrdd6wqCOHTcUYK1p31GVvZN2pl4aZxezdJztWxbjXJIZUwlKTkT0/3d8XApCH3EFjse9LaQNvOgrjUexpuwSA==
X-YMail-OSG: ma3XuzoVM1kp7oHntbDC7ULbgl_mNUnqWmmT2dfa1HIQTXZShKwT5OVkuvXlSua
 0bU6XyzGKjoG_Ni0aPOrdXJKxLoJQY87KOPs3oqhZuU1oZue.7vMKZIDROFpub6Md35lil2BtbGn
 jHkKVgDd0kzO3y8.fNIoI2wobeQtqwhmGkSxsRXejNwDSPypio_lPJHi3ltky5ONAtNI9N_nPaiZ
 yEmPxoz8J5JKSoEmkjoTOPRsAsXcd8IKuembJdAk0eDyLSiXyV_cntdLFumq02UAboxqYnVNEq7u
 PXtKAUFbTF2kTrikyuF3PDaBiOfELNRpw6u8rRMtZhvs15EKP6vT2dLw2ExcsN7Iu2Vewi4bL.kt
 GNM8zjXC0dFBL7U3s8QcJMxzfrAq7F12CFRfXXp8GZCbwAS4oGiweLUdSDrDOp2f_dSw4v7nE1iY
 cHLnRFrEa5QrJT2fBNC4W1PDbfTmBlp8G.c2u4Pq6pZ2VYEkC9dRDnKTO.xk1.KJwDVqBgB4aG8M
 TVLt2obpHHdy8SLj79T5VidVMh9.5Q2Ui9N7R2rclw5d6ZpqMt9Fubi04zKlYXnENilNFxRzqIaT
 Oa8PMxusQkda63NTPii.eroJq8cxuz0jX3FsqZuoiv5DVDfo_aDiuWbxFwK4tsN6LOxpq45NBfFy
 7ww6jWY4jkW1gRl7elyc58jDGfJYej55v3fvVwQ_Vmvq8SqjzJ5lD8E75w4LQpEdQEhWt_fMV4N9
 5dpT3Ui7lOnSydQA3RUpO4AL.GGXYtjsp4CP0hSIdB8VUD5EmG9JkqaonOJUd7H2PTJokWGCjqin
 6PxTqkLHLFjH_luoqRJT4XcU_rsRfmr5ypLus9v..UmSrKnk2nKNNIP5oiqccdMrOBYaTEHXJVqq
 OtupeWDlethxkgV2KtrsEABaByzqFAEsA0VnpEWPY3KIXlVZfz1eKLkAGBmRl4wZEiMLPi4EhKji
 7VNVeaWq8us4NN4ZYdaYC3NXX5_i3IOVZPwZrQl5MWI.iBtunf_kJ5qdvpavkQkMAY5NMTK7WWrm
 8n.9QAxGSYLawv8K1V5WTwhPg3bzGxTlF7rI7ehEL_WrK4IOnEKr7jNocYVU8vpr9cZKR49qSzyc
 tjFeTVn8M44JLSE7yPg1.Qu6fZInzuvw4yTE2pyjuGJEla4DbP8FxriaETzG48pzKu4m6WGF2018
 6hVX._wv5R6wA7zKc_VoLytJR65lWogW.BBhlByzzeg1gUXxhQFQvSmnEtzJGk_Nucgz91TOnTCD
 vVASxJ0la.7SHbdSXFZgGXjGpQ4SsUvnDcYSXFj6RQStMptBVbhUyhxwjon_yaf.poN9_K8H87so
 airQraoakhcB8UyPkwzKOX9z77qSDkIVAcC56A5nZxYCfAbS6aCAsc4U9N5Ba21dtbjlmRpc3Y0I
 f1BZAfOluGZCa31VQdII37_pD0l_gTLMk6b1Bykwk5QlzioknYy.pvkdZbfJ3nUFpKzM0ke8i.Lx
 rrKEyFgVHFbq79yqZ96f_E0YZH2KhGbatill2ELqZMq92o_N_Y09Ncvi8OIo0L.6J0tP4Vq7lX7A
 alo7_rIp3Zk6.kjhljvJOF6yzNTbnp8f0fbALi.Rt6JYEtXa5.omnbrBc2ha3JncNiIKRSgUuNR4
 S0JCR9hCkTYSZqAE8LT0_nqYVrHPkzfoL1nCnqbZhelCQRS1PjjQAWd53qai3KwSjT_KxMlOIpKx
 QQSKA.UVZvb3kAx85bQ9LILHB5od1y7Hs4Y7Dz6u42ThGBrK_rAbwmc_tcpn57GvmQltw0pPGfaf
 hhEO9f3.A_XCFkp7qJzg6Wx8dCTAxKs4jqC0yX3uKpKfio9mmYAAlprqJX4dJEU7oKiGNt4y9hA4
 5ME0Y7iGtJq0D_abayrn6e2Fq44csmjHbtYlpkayNsBEsSVCOOckATb5yRLACmQcex2I2zcoRxH2
 B4LBJkPYH4xEjPWnADSRXJiwV1hHlHQFlaxs6FDYQdK4i5q5IhlDHHSsnMwd2rmmSnQsABovpKxQ
 aBiJZCMrZy.xtj62nlXDztqSV2o7lP69_L2guyMmfkkecAbA4K1kEh.fQDPkIp_fTKXgQX3lZD2V
 ZfMkU87EDDztmfi3fzg5jcUMcnZKZP9EBSdzM_zcHcscDnkYbjFz09pzul.dRO7VltyUSGrWLGkF
 vE1dEAVgLlIEY39FKgdPeIfC.npY07aqg7yTIP42xvjvgs79_aTSpHn.LItciy6cSUk_PMS228sE
 Nr89L5EfR3rQrhOl_e0ER83vFU1JPBjTV_Q--
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: a9a50c8d-9fac-4aaf-8c30-4f44041f89dc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic318.consmr.mail.gq1.yahoo.com with HTTP; Mon, 25 Dec 2023 10:24:55 +0000
Date: Mon, 25 Dec 2023 10:24:51 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: "polarian@polarian.dev" <polarian@polarian.dev>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, Jan Stary <hans@stare.cz>, 
	Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
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
Message-ID: <609690527.4210086.1703499891491@mail.yahoo.com>
In-Reply-To: <e274b55d-9818-0919-fb90-bc6d0b522b0e@grumpydevil.homelinux.org>
References: <549578214.4148875.1703446908152.ref@mail.yahoo.com> <549578214.4148875.1703446908152@mail.yahoo.com> <e274b55d-9818-0919-fb90-bc6d0b522b0e@grumpydevil.homelinux.org>
Subject: Re: I can't get contributors for my C project. Can you help?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 YMailNorrin

Pathetic






On Sunday, December 24, 2023 at 03:25:55 PM EST, Rudy Zijlstra <rudy@grumpydevil.homelinux.org> wrote: 





blacklisted. Long ago i needed to do that...

On 24-12-2023 20:41, chaosesqueteam@yahoo.com wrote:
> Note: This is about Unreal map support in this project: sf.net/p/chaosesqueanthology/tickets/2/
> Which is an opensource project. White people will not help
> me because, as Polaris here says, they are feminist scum.
>
>> Hello,
>> In case this is not a troll,
> It is not
>> and is a stupid narcissistic teenager who
> Also incorrect. 37 years old.
>
>> thinks the way open source functions is via extremism and horrific
>> sexism, and promotion of terrorism, I will respond.
> I've likely been an opensource/freesoftware programmer longer than you.
> Maybe not; maybe so; but I'm not the neophyte you take me to be.
>
>> Congratulations, you will not find a single contributor, if you think
>> that storming into a public mailing list spewing sexist comments, and
> "All opensource C programmers are pro-women's right's dick-chopping faggots
> as their new-testament demi-god tells them to be (matthew 19 greek)"
>
> I thought there was more religious plularity amongst them.
> There used to be.
>
> Want a religious war? We can do that if that's what you're up for.
> If you are all our enemies than we'll treat you as such.
> Do you understand what I am saying: ? Do you?
>
>> then supporting terrorism is the way open source functions, then you
> Why shouldn't one (morally) "support" those who slaughter feminists, and
> in the alternative,
> ensure men may marry female children, as YHWH's Law commands in
> Devarim chapter 22 verse 28 (greek, hebrew, latin, not english (white fuck))
> ?
>
> Tell me?
> Should I "not support" the hellenistic greeks who put the Amazons to the sword?
> And introduced an epoc of rape for young virgin child brides? (Zeus was a rapist)
> (white faggot males seethe while clutching their New Testament "BETTER A MILLSTONE")
> (english) ("CHOP OFF DICK FOR HEAVEN!!!" "NO MALE NORE FEEMALLE!!")
>
> In hebrew it's called "tahphas" btw. Also supported by the actual God you white scum
> try to bury.
>
>> have the complete wrong idea.
> When I started opensource/freesoftware programming it wasn't all woman
> worshiping faggot white christian scum. Guess it is now. Regardless of
> whether your pro-woman teachings are acknowleged from the New Testament
> or not by you.
> (hint: that's where they're from, uneducated trash)
>
>> Best choice of action would be to not speak any further, and at the
> How would that get me contributors to assist in additional map format support?
> It wouldn't.
>> minimum apologise to Jan,
> Jan is some cunt who opposes child brides and is mad that the taliban are
> raping their little girl wives as we speak.
> No I will not apologize to Jan.
> Especially since you allready gave up the "secret" that no opensource programmers
> will help anyone who isn't a woman worshiping faggot piece of shit.
>
> I'm so fucking glad your feminists have been killed in
> 1) Central Asia
> 2) Iran.
>
> Anyone opposed to men having young virgin girls as brides, deserves that fate.
>> but I doubt anyone will take you seriously
> I'm simply asking for some more map format compatability.
> I did several myself.
>
>> moving forward now anyways.
>> Best way to deal with people like this is simply to ignore. Note to the
> Best way to deal with feminists is to kill them dead: like the Taliban did.
> The only way men can get their rights back is to do what the Hellenistic Greeks
> did in their history: that is to slaughter people like you who uphold women's
> rights.
>
>> mailing list is I did offlist the user in response to their previous
>> email, which was aimed to provide feedback on how to properly ask for
>> help, and how openbsd is not a freelancing community for random C
>> projects. I did not receive a response so they obviously aren't here
>> for any decent reason, and are likely a troll.
>> Please now get out my mailbox and go somewhere else, I rather read
>> constructive emails instead of spiteful sh*t.
> Want me to physically fuck you up dipshit?
> How about you go talk to a wall.
>
> My emails are about Unreal Map support in an opensource engine.
> Not you showing how much of a white faggot that you are.
> Do you understand that?
>
> sf.net/p/chaosesqueanthology/tickets/2/
>> Take care,
>> --
>> Polarian
>> GPG signature: 0770E5312238C760
>> Website: https://polarian.dev
>> JID/XMPP: polarian@icebound.dev

