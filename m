Return-Path: <linux-nfs+bounces-795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5E81DC0E
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 20:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FF3281C85
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C86FD515;
	Sun, 24 Dec 2023 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="suafZmXX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1BD2EE
	for <linux-nfs@vger.kernel.org>; Sun, 24 Dec 2023 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703445683; bh=gphsGtb1GQxBgoQcQIhSB/zVtHpfiI9G1Q8afpjntRY=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=suafZmXXvDyHRzwvKAL+QGPakUSnpVQrfWZWWeDOqhpNyr7BGUoa1DPJk/pMYbY6M2RIBexG4XLo4oBfZvOlny005Gk99WYqEYq5V0LNOYlAjdu3WnG8cJju4u8U7bEhgGKK9j4KGJeByUfckqPFqILeQglPx+eoyjtmZn8j874/aIRMwKUdvJs1bWWk7kEV5edMa+78JHwqlxBop1FbWAaOgXFS9jzgdERwhGQjTJ97CuP0BVCrrWjLZgVtCLOwJ02eOxLRcOkbG2hNL2lU5jVg2yRasVnx95fUMs3drbtuLR0A8oEMCNsBZTDknoiPOxyseVICJYMOieCt80gGbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703445683; bh=alABMA50yfuscidHtmiWpm8hRzVTBMAX74MWEJRP3Hf=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=q2wSinW4mXnfxGSy1CNP90WRagMKLMNs6TOiWuaTuQ3+kAUJWdrKxGauJA0uLUPazAiSutSae7M02tz8pxLEznjGEnhXnZnAU8uvk/eFMg8t8t6oSB8PNJPSev9tfqRBT2M7gTSdUvkPWAlhRFLkL2xRIrH3df/k890M7CTqGqgTMnz1K4S9CPNysVlGDhPT7HgDlHXx8yPBJSoo4Bwx57wCrtcWTXHWPbOcc8+hjPUkBpXu0KeLsfMImzMh3vkYAS4eCP6HxTfBcZ0TkjntCbw3z9eIY1+tbZAKbfMtaZCWRnwtQWwPKr2DL/BA0BMdoIbe0xzd50TRzwMLWVZihg==
X-YMail-OSG: 7DVX91gVM1ku_h9gn1qQYuVyi8DHeyhJU0ok2K_Y8qWAgOiWmJ83n5UVT.uTlPu
 P1pJf_C9UMthNjXfMccuE8PY5wJaMAaGMDYjN8GHLIpDm_n5F9A5NvQMt2EiisZFYWfJFY5WivIk
 4t.vYarO2DXtN2nnzOM0o6aznMduLqyqSdsyf7hPui5TQvtNbQoImUeoBaV0UiTaNfVIL9e69E0_
 HBF5mj35SxyytnU9SkB7AjhDNOfIHbkT.wCHVYhUKsymEfriUp4BrNv0VW9E0oijQyGziumyVLjb
 Qjw2QVThLd_C2zf68.L5Y97NRjP6pyefXDoTWgNTX9Y8WSrpQiwSi7La9LGMENcb4o9kKu7RJXQ1
 ErS_Vj.97wW0NRNp7hB54OWb3vcmHvqLX9Kz3rxVY5O3Wu1jGwQcCSBALp7T6e.eH.vG9l3wi.qW
 F9i.TE7TR6I1kuHY9DnhTrndt1OvQqEdr4zAFKBHmV9WGFU19ROfu2wI55V3zoQrv894QATRmsJx
 _kiQpnXWoPv9ClIm544nMHMB7tofwQPw7xulgRr1Omg7UM3Nx.4hSeSiOjKL8R5fvoUPU6iBHrt1
 XWyJjeh0VPJ0MBwiTvkO4gAT.9YzqcZyHLZG0rNyAWyfgVvpHIEsiFJSGVA48XNtKaHh6xzqWJRg
 2dpAgrhGu4Plz2O9GzlKcr.taCDQqYunnFk2PR.E5p41Xtox8W9oLu8XvziWh6U6NGh7jaBN8j68
 qM9_J_iE1j2ch3a5zZ2MTZyN3ADeKwgevO1r7XujQiTE4Koxs24GXBxxOA62TblkbYujAcy7n3G.
 DCEQ.z.5HMakpv247jJfhoAll2apccAvGFGO6u4vGQJ.fjj9wIB3VoWU.IFMBHU5OZaN5ri5hrVF
 E4I0J7CAiotcIJhgNCyoGB4ErMdHPJbch66u5FUNftBgDCH6cyEMrs79HxHoJGORKPIQlkufOsBK
 wmK43_mrz2yXIq1l_jC0p0OdDBr4BWknSEiXWfV9FrQ8VRFP42KoTZIf6JaUsEBHRU.mHxYjAxf.
 gdzwB1iXiReoKsDaoaW09CE6p28iX6TMJlddpUDAD5A.Yq353y.iz.9kHydRrz950p_DYJ5.uJeY
 o85.gIrtry7Kj2zEg4SjuCZaBJvUhEi2Ahr9X01JwYXSgmZDL02lqle7Qx2UFg.iPWkQ3w3hv8ex
 zp0DLh37WFWQ7GipvgGkGhxLrDMRifsq0vDgpqoqgBs8H_IHqS.fpZFsel3KIkDxDnNppQbqP1Kt
 EQfIcqcC7Ay.yN90BXIn6d3pJSMP5_n9YRSn598XUqcpPFoX.b4nEN8cQa03oH8hJLDPdlcEqntG
 .Fb_24AUl630xHEynWFxSPXPt4JVF7ipztsFOrXBUD8Uya03D0RMUTHsQYuQQhRffZcTRJ193s..
 3L62M7ElgC3SUBkpEqKUxqDzcxoDKbQopVulL.y99ymBLC6TvKzV1mTnd2fAl3SB_Eip9kW0tHxD
 BU1_BCjOGkWuc7HY_J4cQ9HT6mKhDXiyDkM4_FPBbvbpOHCtj4Bv7KZjj9cE6biFKpMVZBznnS6o
 NLaZaLneKu4xINNNhLgPMT82xzWTUqD6qbCHOpOWdMbhy2EnlsRzmy4E3M3Il9z3sxmHl4xCHTyS
 FllTd7E.zWhdvzmK_Ydcuieh.Q.wRmQ7y6j5aNtuG5_Iu087AqFrjKzULQY33FbAg0MliOXUzphM
 bBVTwKsVLja34823ioTpPWf7MLSbA3RKCpQep8zcb.4EIsOrcxtHTV4TS4vC96WqQ5ueMUltWHLW
 t96RIIMF8X36HhgQMO1E3Ha4JyMq8KSqeKIZFNvZBDidNkO.KV0Fj9_omjKw5gYby4ptLh_ya_43
 3Ap0PVJQUoOxxR67iUFehXAnd1.VL4BXVVabsG9o6b4NRuP15ZlFR74QmRtijCSE2rDPG4d7yjsC
 5Q2hmOoHfLReQDhUZM0cDuKjTTwiZmT3ZOX9q9Yje7GRa0TL7pekYk8M5aQILAdluaEnINgx9MST
 6xR2obP_z.GYAi0HU2XczBKr4Lh7heD77rx.Ikv0sjdE.Q.GlLt7MlvAUPPMnLasnCIyEwwzowOl
 t3WlnTfV8m5wE2kFqUuLUDuIDuGpKNIEq2iK3bshYScrXxGJ5.9YR5vwlk7zXRTyg5K2PNDsn3Ll
 yrxh0dfUji_.A6wRi_Hdp2U9PJNkF0sffKWeNCd7INLDeMd1mZQV3hw1QY4lOy1zt5uG9itWZZig
 HhSS1yXiBjwDw0o9w93gThv48lo0-
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 0f70b375-17b5-4735-aea8-a19cd5fa6c59
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 24 Dec 2023 19:21:23 +0000
Date: Sun, 24 Dec 2023 19:21:18 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Polarian <polarian@polarian.dev>, "misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>
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
	Paolo Abeni <pabeni@redhat.com>, Jan Stary <hans@stare.cz>, 
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>
Message-ID: <980936498.4151725.1703445678796@mail.yahoo.com>
In-Reply-To: <20231216183721.22838388@Polaris>
References: <bf818dab301fb4e4@pg4> <1299484129.1816565.1702749635639@mail.yahoo.com> <20231216183721.22838388@Polaris>
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

Ask somewhere appropriate,>You sound like a 13 year old 
I'm 37.
>begging
Correct. Do it for free.

>and considering you have "no money" me,
Why should I seek "money" when it won't buy me a cute virgin child bride: the first purpose of money when it was invented in Sumer?
Tell me. I should slave myself for something that is not actually money. Get real.

>proper emails.
Gno.

>Ask somewhere appropriate, 
Anywhere there are FELLOW C programmers, Is appropriate. No I do not care if you agree.

>OpenBSD is not here to fund your game
Never asked for funding. This is an opensource game. 

 >and everyone else, is instantly going to assume you are 13.

Don't care. 12 yr olds are better. 11 even more so. 8yr olds are even nicer: the prophet of Islam can concur on that (sahih bukari, ashia hadiths).
And he was right.

You white christians are wrong. Even if you are "not christian" and just happen to follow all the anti-male new-testament BS.


>Open source developers only contribute to projects they are interested
in,
I know, I've been one for decades.
> developers don't do things for free, they benefit somehow. 
Correct.
>You haven't even explained what your game engine is
I posted the link. That's good enough. It's allready a finished Work: I simply want more map format support.
I've done 100s of models and megabytes of code. Worked in the game code and the engine code.



> or what it aims to achieve,
Everything. It allready has over 200 weapons, rpg style town etc building (with interiors), vehicles, and procedural city generation.

> is there alternatives? 
No, also incorrect english grammar. White (feminist "chop off dick for heaven matthew 19 greek" chirstian) boy.
>How does this differ from alternatives?
There is no alternative. Cracker.

Anyway: help with Unreal map loading: https://sf.net/p/chaosesqueanthology/tickets/2/

On Saturday, December 16, 2023 at 01:37:31 PM EST, Polarian <polarian@polarian.dev> wrote: 





Hello,

You sound like a 13 year old begging for a video game, that is how the
email comes off as, and considering you have "no money" me, and
everyone else, is instantly going to assume you are 13.

1. Learn to write emails properly, trying to read your emails is
horrific due to the formatting.

2. Ask somewhere appropriate, OpenBSD is not here to fund your game

engine.


3. Don't take on an ambitious project which you do not have the ability
to complete.

Open source developers only contribute to projects they are interested
in, developers don't do things for free, they benefit somehow. You
haven't even explained what your game engine is or what it aims to
achieve, is there alternatives? How does this differ from alternatives?

When planning a project, you spend the majority of your time designing
it, not coding. If its 100% coding there is something wrong.

Hope this helps,
-- 
Polarian
GPG signature: 0770E5312238C760
Website: https://polarian.dev
JID/XMPP: polarian@icebound.dev


