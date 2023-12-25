Return-Path: <linux-nfs+bounces-801-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FB81DFFB
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 11:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D056B1C20A18
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E851006;
	Mon, 25 Dec 2023 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kw5pT7nc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic308-54.consmr.mail.gq1.yahoo.com (sonic308-54.consmr.mail.gq1.yahoo.com [98.137.68.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EE50271
	for <linux-nfs@vger.kernel.org>; Mon, 25 Dec 2023 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703501837; bh=WZJHBDfXrL4RE+tFURASwm2NmeFhKAEbMkkWGIw7SG4=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=kw5pT7ncr3XzZwpViMBZVznTO/PUlUqYsIZ7NyQ9TNmt4OZN09LU/BR5Tfm0goS9z7CQvM9as9bKyCb0Pc8IBciWQvMzS0sWjWTCY76b0PnwcqMmZi0AqLRueopRST/il0v8hBPBKh1KF4oK7fWcNlLt5l7+OkGSXz6zmSKG5uPqMSpCzJfgbpcbrom53xzdQarozXyPNgrAfB8D3wzxkBj2vD0Av1R+S4pyBPlPlj6kj5EvHFDT83d2ZkZlFPec3KYWLLBKeoP2M6OB1lpHnu5agDcXFIJX7+V9g6cjjzVkFczRQbYmez12u8TEKqOqMtBzQmVXLczu52TRTWy+mA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703501837; bh=78GRMEJVC6CKl4vF3AbpZgFTLa+/yfBgLIzxA4b4QnP=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=eldcm2BoNt7orIvDwy5QPhkfCXe70Ue3Sy9HSgi+feIC5tLTHBiHoaxPJkednlX1G1XvYpRBdjQN6lXjg/J4AAnHzdi9UXIuuf2Yf7H7a4utWIW4YOOoufnUzJ2YX5Nr/O5bhOCzoGrVzZBORTS8TpXtafjWg/gqg5Lx9QrrmHP06jnfOU27Wt1+DWmfr11tLdQ7M4J5SzNGOu7GxGAIu4OM8MOF6JsMr2a8LasISTMeNf/E+xzmnVINPAqZe6fWWFvQi2kWaDfT0QtiqUjXOlY4e9v10fZ+n0PHsdXXmz85sghmwMWgOC1VQ0o0TcDlshgvKbX7mCXsb6MnPh2/4A==
X-YMail-OSG: 1DwaD6gVM1kvYGf__3K4eT63XtnDU8cRRVJST4lYjUyFAWQ7EqWre_EYgi4lnze
 5KyO64fBw2MixCYt5pY7EqCgZwST30zvZxQBy42DZPxom92RZ667gLSJtqgB3u_sN_YmVCBmuF7S
 rB_.WCyAan2D5kzp2QgeTLoPLY0L5qs5O7f2gRtEX_usoIXjtB1SUDPIJblijT_85yU9xYVVcAVa
 tjqks55bA0cvp5SJfA2igAnC.fa.4b_NlwjUS02wHJsnQtAOrsZqf9POmEItA1p9lDG.K3kQVPmn
 tD4J6EbH_jXDqKZEjqnUeyf2LDh.F5CVj4lF56X2PRG4mlANnuWZlsrcpjOEiCLkik2vj2.TWaGu
 ua_uV9__591XPRjesoRjC7nIdtM4qOjVv358Pogw8YzNnInWh4g.kkkNWUB9vQpp4zJgXo3oEtko
 8z9K38CpSsSt6Ia0osvUbddzmQKWp3QVu9IjHDrQFaL75vj6UEhgkNZvfMKEulp.94cnpargJp6m
 2dswl9ZNc7RaVnDMMhrf102nAQeHH2Je7BFO0nbOZGH7pv_5gew3OUxea57CNYwUbti8csGmKDFA
 X8OxnNvHlSXSprCByj5T1GbL9Axol08CRHmJeut596NwQiR2FXVxXUbJW4J5XR1K3QPvGlMOU3Gj
 LCQRE0GPPQ.JMAdR69IqqAyR1QxxQJxaIzXp8pIDNdBriYSXZ56WgOehwr5BtgjPoZ6UT96Took1
 qKXmyuWJTutaFH4dkPRgqKrQqjXMa19q0BG4cg4ffEpiU4yAN4KAfcKHy20lXiLgOa9AYP3cNsXP
 vfaXGjUkvhqBbeJXfA8BRwlpsRUFiWy3pQO5RbIrLKMp.1nOSNP2p.kqaH5.yzId.RGyhRUqFu2z
 MMzTV.6ZtojSph6zfDcG.0SgTF8PzkvsGzDMV34agjSXCjIBAwBHgyXByB8EsG77xDSdfIBUilWO
 VYf8JpcMil.P5mpshaVj8uo8MzxUT__bt0JaZRqAiF4gMGFmhYkrKzJCmjetbsCGUV7ik.X0gAhP
 HSE7tpIijDmwxFm2J1y96HlNOVAsqNGHeBEG.vWl5Gmrg95_5VFSXseM83gS7vPuXieA2DIIpnHI
 erEhjMvZzBS6ZzgyGVc28JfZlwdx3bXyX18ToEsN22_qqFAcI.MwytZlroIPhdSJ7pvFTq47U2q7
 7iXGGV7jgHsDnFHtsu2Q_kgVVcg9cAXDbBd0Y3l7r3CirvUwXBFYMjh77jttTsr.CsEQXjl2uxwK
 4JIQg9AqFpj3BFl6TLKUbrg_VoS90Xv_blq08Fh27BZMUBST4pTFbZbR9aXN6Wqt.TyNDWl4lkRT
 2GvJ5mjRKVvSUdBoCAbuhkQdD14Tpey01OMa4jFNq4CMIII7MdqoMaOAnAhY1BvvjIz87.lSr3Sg
 LVomvsO83nHeZ9xm20H_d1t.ZbCtYMWWCDWP0GlrhVza2ljbj2nFdhGFlDgDf.DgLOYxjVjr9cia
 iQs.VaNro0tzgDIkxyrSvh86PJwGdFXAmD.mYG3AKwQcTKjI0b8OuFGXFl043HywSGZH2O15gOT7
 uU6twzILi_6k3ZW85aLP3_kZE5sbH3CxQ71R4wUQvFdwdRyZLORr5jAs5L3Q.FvMl8yWc5KRtg2l
 LsavRE8atvcCP.uxaKPkOaOMgG4yS89veDBwRmMWkQJJ_y4Bx2p_Ft5xFfuHDxQg4A7Bt1e01E_C
 NM8zHbBPdicpPzf2CNYKaFvqvWiNeR2k1nBIUmQg39gFNf6qrIi4CiGqotRSjGXxeQeJcby5vn.M
 xolO9.CzWEQrtQ5gY7q1hxqq7hMbH4oWD90UxCoL2qRbCcqwXwh9FYcSJ.u5p82joyOmCBnPwFCY
 RP.9hiO1JH3db8.dGsQaCrVGoSR6_XS3pI6ug1k_f5A7vv0xq9vyxkqtTOV4M.ekna2mjZIG6S1f
 9nUotBbi2MIW.9zxhzCmretpC93yNcRIY6tgy1xA7aglKcvzwbBW5N_qOdt6eKWDHon2Y5lZOUux
 6AYZElqeVxaw940wh1x1jSSOrYdKxLzvoovalPT8XObBapdC7V1j49Z3TjXYpchoqS_uayC1v6Ml
 2EfU3E.QePgAhH2PRxc5dU_1H6y_vgKknYmwnmMhDPEC_TRFCv3bbqmUa5I1PzmUyajhLTp0zT90
 0Bj_xl9JJ.E7bnNvwj9YdPLMGmX2lrZ9uc6ApxcDNmlHfpNQJmTK_lMGE3g2BxGgupq3jsnSrAG.
 2e8fGgqvr1efBm8eDFY55TUoec8lSkFmS0RKo
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 7df4c24b-6571-4ef4-b3c4-4839fb91178b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 25 Dec 2023 10:57:17 +0000
Date: Mon, 25 Dec 2023 10:57:13 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: polarian@polarian.dev, misc@openbsd.org, tech@openbsd.org, 
	Jan Stary <hans@stare.cz>, 
	Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Cc: Richard Stallman <rms@gnu.org>, Bruce Perens <bruce@perens.com>, 
	Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, ansgar@debian.org, 
	blukashev@sempervictus.com, Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, editor@lwn.net, 
	esr@thyrsus.com, gregkh@linuxfoundation.org, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	moglen@columbia.edu, skraw.ml@ithnet.com, tcallawa@redhat.com, 
	torvalds@linuxfoundation.org, torvalds@osdl.org, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, jon@elytron.openbsd.amsterdam, 
	netbsd-current-users@netbsd.org, netbsd-users@netbsd.org
Message-ID: <1392628657.4223133.1703501833006@mail.yahoo.com>
Subject: Clarification: Project is Old. Project is fully opensource. Yes we
 code ourselves, want more contributors, not neophytes.
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1392628657.4223133.1703501833006.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21952 YMailNorrin

A posting by Polaris to this list put our Project (ChaosEsque Anthology) (note: NOT on g*th*b) in a False Light (maybe we'll sue him for the tort)
Suggesting, with malicious aforethought, knowingly false premises:
1) that we weren't programmers
2) that our Project hasn't even started and that we were "fishing" for opensource programmers.
3) that we are 13
4) that we materially support terrorists
5) that we seek funding for our project
6) that we don't know how to make a game.

We've been programming for decades. Recently we programmed in support into the 3d engine for other map formats.
THIS is what lead us to /ASK/ on lists we know OTHER opensource _C_ programmers congregate for help with even MORE map formats.

So see 1) we did some work on extra map formats. Then we did some more work on more map formats
And then we thought "hey, we'd like Unreal map format too, and hey look at all these project NOT IN C that sorta all work with abit of that format. WOULDN'T it be great if we could expand from our very small opensource programming TEAM to and actual T E A M...

So we asked.

Now, our project has been around for over a decade or so, and has lots of features; Polaris makes it seem that we're a brand new project; or even non existent; or some commercial concern just trying to get free work to make a buck. We've never made a buck. Never sought out monetary contributions. We want code.

But what do you people want now? Compliance with your /religion/ (women's rights).
Wasn't the case when I started in programming. But you people chased out any non-faggot-woman-worshiping man.
And we won't forget that.
"DURRR IF U DONT WORSHIP CUNTS YOU WILL __NEVER__ FIND CONTRIBUTORS" --t. white faggot.

Hey: If you ALL are enemies: then we will treat you as such.
Do you get that?
You are making an equivalence between OpenSourceProgrammer and WomanWorshipingFaggotWhiteMMAAALLLEEEE
If they are the same thing: as Polaris suggests, and the rest of you with your silent bans suggest: then they WILL be treated as such.

3) We're not 13. Would be good to be; would have more energy to code new things.
4) Afghans have the right to brutally torture and kill any white faggot that seeks to change their woman oppressing culture. (I see it more as a little girl appreciating culture and a woman ignoring culture: but I guess that would be the same to women)
And I mean _BRUTALLY_ TORTURE: so you fucking understand in your head that your FAGGOT white ways do not need to be in every culture of the globe. Killing you white scum is NOT terrorism. It's resistance to occupation by your garbage religion.

And we don't materially support anyone.
I prayed to YHWH years ago that Afghans would be free; that they would be able to marry cute little girls again without the courts you faggot scumbag white pieces of shit installed to persecute them
Prez came through and freed them as his first act.

5) We've never sought funding

6) We don't know how to parse Unreal binary map format. Game is allready made. Rifle is fine.

sf.net/p/chaosesqueanthology/tickets/2/

