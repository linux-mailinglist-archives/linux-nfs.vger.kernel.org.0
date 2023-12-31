Return-Path: <linux-nfs+bounces-849-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88822820C73
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 19:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40021F21604
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Dec 2023 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C548F6A;
	Sun, 31 Dec 2023 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="frMILF5T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151A8F71
	for <linux-nfs@vger.kernel.org>; Sun, 31 Dec 2023 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704047304; bh=HiwRm0rJ5Svc0DizNfvOuHwtUzRbt1EWbxbQm/AUj9o=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=frMILF5TyiJ2FlNcz1w916SUiuysoIQog0Pwmhgh9nVIK9hOuJbU+DSnSssRWMLsqvCx3XKU+VmK+Uo+bFRWkupI43nB1pid4CQjYioCEarVnzTXTjXyUde6t8z0vhtAYxr0lCVyLk+PebqlXtvTBD+owqZrO9+0rruv+Jx65SQY2VsZeZTTyxAbgod3zkp0yTzS7VYH+aYA4fYHIeOal8bnsQon8vi0xVKn0POxY2RAWNtRuQUwOIQlDoFMdSU2UDt9Smv3T8OKnj+rTNmY8Gya0oM+PiNKgclF3KPUtkz0CIK0G5uUGQ+DDOqJK4xTGnjK2HDr/vY90wSZIjZ9OA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1704047304; bh=1QDJ/1oGsGas92j/Df8Tct/y8vzK0gAenhT1IgxwNgo=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ZVgw33s3e30QTP5wqqEeC+32cLENIRK2gNvz8i40AhfeC3zeBqc773hcWdSGCQjy/kazry6TLFgzImf+ogW+t6Bxff6j7cS/z4MmXi8r9hkHT1sV44hKIbvL/L8gQd3PfF0O/2Nwo3ofKPZ5HS58mvas8PUOS6PNi7c/IGxfaMyG2Uq8hEQ3ovJWiqzDEkz76IlkiFE7P2iXfYfxM33oXAllmCysooAr3L2Gehc2fVJkqUj01eBTmMs6F7GFlyH6Wbn+eaYK+Q3+AF1OFU4Fg+tXMUvlu6z4coxVS/Y/hBQxR5sPDNbqD+ORrw+JX/l7XoexxSNhM83yn8LSxd/o8A==
X-YMail-OSG: tK430I4VM1nnw7eC_MnXwny0wnFCw_H5T57E.R31mgpppp76EqlDAvfRYViZ7hw
 aF3_WqtHulePDqOoMQ.Ly6v3Isn7FV7Cuxb.vXUoCTfbq2suIHD0kp4nOzb0Qs2t3J520UQ53Mtq
 sgfEZIoOCPVZ2LdN41bJiFtWRu9leVpm2TndAXvcBtAb6rVub2gWMp95RckDp49jZuoPB4rqAdsg
 NdeZcPayXbW08D7YBYnww3TacQgK.bh.nKIDSU6T.iekVnAulYXzaLqfwGwLPrYwPv.iaX09fzne
 T6girChdZ4O4RHnm3uvS.OINeBHJycpqGNdcxRPKmgPsZ9qFo.5F67ZhoX_xdSjyBSFKvgcKzKPu
 3JINyELvnMKqWWpFJ71AEBORhDiKVSlZ0HtMaz2drULb8ZDucAWoqGc9dsZj5YeNMDBsXl38QA16
 ldGMawVh6q6Fndu6V3VC24DOsY1OcH67AjLkqTKJdoNrPYIXm63LjbZOWbgb67Zplkq925LOgzo.
 SkIWlayGYvF0R1WdqJiyVPX4RaxD6W4t0gbojo9P2.vjrg04bi_a8FjFXNeTiBwPTPTvdx5MkSsM
 5zVqP_hqY92w25T70H0iyreoPJarHhl3tej9CYQ7ra.nFPXV_w9SmbLQOSL3bFU4lJ91ovnPVBrj
 jYgLcA.bGzEAcPiClckvCak.QQRgfslk4jdK6nKsEBVn865dnKyvjuDspDOhe2eZaXv_zsCGLu2W
 RdcYd0p3TIcepCmxLj7a2GIjt3E5z.qWf3TjQrpoe2A7vGs9l7lgLYQDQHRX7IiSgM1BQRFdDIKW
 e0HJ3TZQd2mdkDGmDcZdC_7cbfGuUfThv_Ln9niBheE5WG8t3klK7r2EY01EIsnaPZdUwMfRQMoT
 qXkJJh89f4LnPsTbtm2xRWwscuFeYYuA1Wjpcd4mEs4YK8uVuguwD45IHX6p_130Zo6qyT_TRMlA
 h5p6bElfUJWxZW_U0s6TokrbBb1juSZMzxlDnfROwaggHemizOxfymOCB42hTf3TOydnyMyhT0Wz
 j0UMhRrJ5d1bmmqP6LS1yz4bw.djq9Kt.TixpDT.0XZeNIfafBt0qLkbcolLfjwFJrvJaUuY6jUl
 d8aoK.c18gTgOq25AhBpXSzsrhaxiUbcWVkLxOtRL6P966hZaW67NHSGoCUTZg8hwTkYqFQXYJ0L
 j3MIXc.l8B0zlo1cHaHLhSanbFAeUP2ktV2lJLM4ywqT_fIpuXPQ1mP1J9nw_aQRQlAvN4EVQ1TI
 lfmCKEZnGLdulp3eueW3lXYvYVZhSn0loHM3g0I6lvNJB.3_EV6jBWWpn7rCV5mLZhRo.Rq60ukd
 Dots51Jt6VWUkldCiSMlI6iNAeh2arBLb14MwYvCKv6HoGHCCAjPuauz7w3spUpWC4HFKnw4Wdbz
 Ee38yX2BrzcG2_DkOGHA7ZPgOApj1byyFm7tnqYEDCvJCIaiSR5LOeMBZTJfBMKzSnBRwI5AAlcX
 l2Erb0qWJGJF8iitsoDL66IezkEgpVRKLeXWnTTz0T3swC8lY2.mr89jPRNX9BFOVbV40RuWUPVw
 TVJj_d6mqAlaogOnLEXJcvxZpNhWAlW2rH4kEPmlTlGMc_MzlgsVANO7ut5aFUENUY2LZMCzF5Tp
 a6oPRUl2kSGPrwIfstFro44rv2oTAzg8HGxOVDRdHTDmbEQ8s75sX.qbPNBUY72v8QhatISedrpo
 ZwEggtFK7N3_BN.JFMyBBvR.5n3nAJ2PQRUF1C_GXRcOSiOV15l2nem9xtxseHBSxdJDw_TFk0ho
 H2FpMoGxDklpy2qYg1Q2nh37N9OgrrCQ2N7uvjs8OUDJjlyuKqWCNsP0R8x7wMEoYs6rIdwDnEiu
 gNpcaurTM6NQc1Du6DQuUmOMFwz_8T1Fgrrt0GLzVtX08N3O7iHXAv_dY_EF1ao3XMXXmgz2s1P_
 4ZGPP4uPmkuFEoDSif1tG4zP2sj.f3k3HnVGFt5lzvR83PM1957xoN0nihwHQpY957vdoHV2nisU
 _kiwqXB_bnR38s5CDsV.CnJUrJVG.I1j1Xvxn.dwb_ew9Z92.Q7wvAkmYJwJGtrJkPICCvjmm4.X
 H6acdAdDoRq7kDynswNCWVxBnZAVmxe8JtBWTzIva2X0KQIWdoQXPGVBVa_n.TFbEwZd8yURsEGQ
 lTmxsSMN_cP3CaUIaZjwcmJOv478GHn.pjLtvv.De2g3TtvjG52TEnJrK4gNN.TkkYtJiso4m84R
 F.pxUaN.Cn_Ttbo._9uO_2oi.Uw--
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 02b8b50d-e7c4-4b36-85b0-35e9a0106bbd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 31 Dec 2023 18:28:24 +0000
Date: Sun, 31 Dec 2023 18:28:20 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Bruce Perens <bruce@perens.com>, Richard Stallman <rms@gnu.org>, 
	Aditya Pakki <pakki001@umn.edu>
Cc: Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"editor@lwn.net" <editor@lwn.net>,  <esr@thyrsus.com>, 
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
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, Jan Stary <hans@stare.cz>, 
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>, 
	Polarian <polarian@polarian.dev>, 
	Rudy Zijlstra <rudy@grumpydevil.homelinux.org>, 
	"theo@openbsd.org" <theo@openbsd.org>, 
	Wolfenstein Enemy Territory Fans <6469670767@groups.facebook.com>
Message-ID: <289062279.5555651.1704047300437@mail.yahoo.com>
Subject: Re: Shut the fuck up GPL user
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <289062279.5555651.1704047300437.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21952 YMailNorrin

>someone1611 >someone1611 - 5 days ago
>No one is gonna help GPL.
OpenBSD uses GPL'd code in it's kernel, just stripped out the GPL: because that code was a derivative work of an earlier work OpenBSD authored.
(and the change was perhaps deminimus, or the only way one could add the new feature or fix)
Things aren't as "simple" as you white programmers believe.
>Don't post to mailing list.
I won't obey you. Don't like it: meet me in real life: I will fucking kill you dead and gone: or die trying.
You think you're the boss of me faggot white FUCK?

>Can you kindly shut your fck up and stop spreading that virus to mailing list?
No. It's a game, and if you hadn't noticed from Grsecurity: the GPL is basically BSD now-a-days.
Did anyone sue OpenSourceSecurity: no.

So your "ideas" are outdated. GPL is a dog with no teeth.
But it's still opensource.

>Stop spreading virus.
What fucking virus? if the GPL was effective GRsecurity would be sued.
It is not. You're worrying for nothing. Completely outdated information.
You think any white faggot is going to sue someone over the GPL? They never have. They won't even approach a girl, and they worship adult women as a god. They follow a demi-god who tells them to cut their dick-and-balls off (matthew 19, greek). You worry for nothing.

Anyway: please help this videogame do unreal map loading. License it BSD if you want: we won't change your license: we'll make sure around your code the opensource license you choose is made clear (and that others who contribute will use your license): sf.net/p/chaosesqueanthology/tickets/2/

