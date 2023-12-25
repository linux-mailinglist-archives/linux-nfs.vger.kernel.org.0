Return-Path: <linux-nfs+bounces-804-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB781E180
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE091281EF6
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1F52F61;
	Mon, 25 Dec 2023 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Pc1ptCn6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic322-19.consmr.mail.gq1.yahoo.com (sonic322-19.consmr.mail.gq1.yahoo.com [98.137.70.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16631A66
	for <linux-nfs@vger.kernel.org>; Mon, 25 Dec 2023 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703520335; bh=utkBGe9g/rXX1ee3dzx4d2PU7zoNuIal2sZjMURSdn8=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Pc1ptCn6lB6sUPvtXwUa40cpm9Cc1FJ16CP40RBmsWiL5hncAOhVzb18BgjmBUF4WMF3uCV+gKDcMUBxzdbgsZcw+rc2VLdX+CUIiU3blfPUxaPD10e18RYClP1gOauE8HFSFGLBYrucuiDYkJAYjcGXSkFVM0p1R3Dv2YwKX3KLWGlL0grqtzdQz1LqVJYuNS+K95CbgRIFQdEEkQh3G5796k/WssxAHYDfWVy4/bJAnqxlM0R/MVI+OJBz6KUYVZzfrPNcN1vIe/iiRLN1WmczkVyWybblwNvertM0wopdU7B3uiDiucK0FKNH5yczdg2zADU808B+BwUTiFoiKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703520335; bh=zVXwExR0fO8/nvgS8FcHpB/IeFgyvH8jsxYy3cB++LG=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=D3dnGcuK2S8NePc2TToj1CTSr+SHLIT0Q8yY4VgqNgKF738z06XbBymWac7qIdsiwz8WSsegHU0SCwWRhRqPqtXb1FBkKel+z4D94h8ps+aYiWY/3WaZtHeWpaqsN9sS/Ih1Q+AKpoJmMxh1J8H5UGP8+JmmdTlOEjsgVf437GMxe/Wz5rq0ra5rqn6QH/AVg8WkzJwo2SZcuI24J9BDsw5cFEd1GZxHsnGEJfITvHNe0RcRHrYuRq/3+loh9KOPqtctRzkqx+VN2Ab80FgD0zGEUsZQL1PqtGkk9tfB9PpYmyJL4f4l9o7qik3qd0ap6kyOYm8HBekDWtgeN2jc1A==
X-YMail-OSG: 9RHHXYMVM1kr3VIz1_jN0AanDhY816EV1VcSLx2NtsRCDcqHcBFzCK7qfeSV_nD
 RIqzrBWgTBMCPNh9Cvw0LTcrS_YxghL9gHWs3AsIhYYNgXN57ZHLmSgAZTGpbS.mfVLWr7puFPPZ
 Df2OF91oT2TEtcQOekIpfDpXfeoBWhOtHzoQYVutJ6hN6Y0R7sponwXAQ52dpHCC.QTZGQ651p1d
 OZUt9iHv_3SSJwCw1QAm0ZSO5EKWhWGHLLaCRuTIGvxzyf5wNEs3XgX2i4VByKuL0l4aUBRAT9cT
 c8yLtRNpzYUdSkpqwTb01cval9Hsld9LdcANzDdrq8ADOPP9.a34DA.n3QRGJWxzU0eQKeGVP65m
 9mncYzcQ8nsDhNRVmwLWeDZTCuCi0V92L8J4fDouVPjSRr2ODXV3YxuU26gAYnOmJuIht8w81sLa
 6qAtCmh0XvVEs.Kot0nTxZBq0W2wHo1WZFtqTmTkMa5EC8ZyLvSb55kK8mNJVjauZoz790.HAN4B
 2O4Djn78H.ORGTm1RJZiHRMCO9.e8X.FqTt4oJOfRuiz1FMee0lHft2O_j0aUnxeBhr1pujFfYIt
 8dTWZhGDNdSXfIS7jCTen8Kd3QokiQQMJIJgg43RPkqqNnWZ.g4kC8nfaRVq5BjhrQRZ2xMWEZwC
 DJ68UmQZqT.Wf2VCRTIk_IhJJ3_Up3To78ZrYSJrvSj49lCmxaxt.mtwl7bsZTrl850q3MqahDuK
 9jHL_.ImNarPTfmlZs6toDVHc96UDI7A0QMTgw3BKXXrRNEKZtl5JK46q5JVK2PYNRa6ptUN8nul
 7RMBokmaJ3Jsne.XpLXBlrIDzp3eQ_jfhf_emxpjS8b0z8i2gvxyLmzEz0gWug7awCi7HRgd4aXy
 eaSEjPIuW069hhodpg5ZZTnVvm.Fli_AiGTMNEvIA57JI96cH85L7096C5X.8u1HDTacaqXGAPow
 iRgg5Z0aJJh6ucJV0Pir63xiJL6QWTtpkahd4gmXxVZFhS5KGaVZWR4F4TnALU_tSDERmLdAsv6b
 .ERHfAey_cfOMSGrcuShO7dv6M4_yAgVOqVNhmUe3ZHjWJ2zMoq3kMeCGFMbbgpCaYdqz7bgc4N.
 7jRnOj6HZ4EF02MSdAQkUD7P46QeEifufJQKeDor_jBr4PVCs3LE7NTqE.1ChmuJu4i55Wj1w0wj
 BaG6aVHI2ckMcphn0c7BmWQT63grpZDGefcLYn5aZpy6XGHuvqyFuEdcYUzoxezXudUXKKTzjpZk
 WeIWkXF_jWvbHzTgl8F.X5YwV6WeB5H9yE1eD.R2QnEWHWsZg3oBacbWdpF96kOWWqOvyd.4far.
 2F0iICh3.EHD0cyjc6P9cPnVGpO9mU7FVRbHAOmKDNBgREpssmT16fH4q.3tqmz4a61lXFw4pBGR
 xoyaNBcqynvGmkWQlFw882S4A3lGFw7Mjq2IC5aKogjJQfMgAsoIgjLATRHqj620LTbAJ8yW3mcs
 RS9wBZKIfkUP8.MnTpE4lrXMOm4zbqohzaAGA1YrOYfVvOH3MGbNmPLzHJQyl0rWhGlRKZ.oO8cS
 VKtknedoCinznpBSc531bpH92e.N5.qzcIGOKLxvGpWAWH1vgxRYvZKiGhuPQSbQGdpS0LCk_b4g
 9zEjw9uO9OHptUNYAjK8PzDPf3Qe80z8VfG5WWOMX.VJboBY.onlh9XJWQTfvYHVb8Ys43xa.hOz
 .ZLSYZZOPdppyNpdTL9HxXQycJXv_owZjK_vflMeSguGTO545t7lcUyaFG1ZmKcFl4nBBOVrFZjq
 n4MAowmbXHZjau4VPfwapWPbJ2ekc.i_ca5UEuO6lrC8Tnm_WpwYsVhUrMjeQGXpVPgFgSgOD0.Y
 cMcdpQcwSdiw8tOLGBOCfPpe_gtfTHUGfq3Og8wV21y6MU93kH5jzYdghnqDqqRhS7GmnKe0JzLY
 8zgK01e68A.m3aH0qj2g5bFDJD_5EUIzLEKbogBBLJsffnErXj1jE6bcEj_mHwmQ4UDEWCt2PbnJ
 httsIEohaLFL3_qdKPWz2yl3EGbhw6P7zV4IRib.OoHA6bdqg0Gt_CFMljHL3uchHLMOY6JdDlmY
 MfncYkeJA11j401rXzFcTtpbeW0aacpI8mnrTkKT6pgMvWUbV57Xmuv5xXCVVHnus7AHRRHr7JYy
 mS0Oo782_BpUuc.W4gJwQFerLpkh7TGWQkoOAkY0a4PGOv7seKhYb2xAHazhoqmFC69EHfC0D5LB
 SVN38SLxaPX9UjD3ArnK27RAdVrA-
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: f11ea5e4-fc69-4465-bc3b-c3066c3cc785
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.gq1.yahoo.com with HTTP; Mon, 25 Dec 2023 16:05:35 +0000
Date: Mon, 25 Dec 2023 16:05:29 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Jan Stary <hans@stare.cz>, "misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	"theo@openbsd.org" <theo@openbsd.org>
Cc: "esr@thyrsus.com" <esr@thyrsus.com>, Richard Stallman <rms@gnu.org>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"editor@lwn.net" <editor@lwn.net>, 
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
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>, 
	Polarian <polarian@polarian.dev>, 
	Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
Message-ID: <688030322.4237856.1703520329380@mail.yahoo.com>
In-Reply-To: <ZYln2W2kI2O_rpGv@www.stare.cz>
References: <1392628657.4223133.1703501833006.ref@mail.yahoo.com> <1392628657.4223133.1703501833006@mail.yahoo.com> <ZYln2W2kI2O_rpGv@www.stare.cz>
Subject: Re: Clarification: Project is Old. Project is fully opensource. Yes
 we code ourselves, want more contributors, not neophytes.
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 YMailNorrin

No.
Counter offer: Use your supposed brain, Jan, (a woman) and code Unreal binary map format loading into this opensource project:
sf.net/p/chaosesqueanthology/tickets/2/





On Monday, December 25, 2023 at 06:30:36 AM EST, Jan Stary <hans@stare.cz> wrote: 





Take your irelevant ramblings out of misc@

On Dec 25 10:57:13, chaosesqueteam@yahoo.com wrote:
> A posting by Polaris to this list put our Project (ChaosEsque Anthology) (note: NOT on g*th*b) in a False Light (maybe we'll sue him for the tort)
> Suggesting, with malicious aforethought, knowingly false premises:
> 1) that we weren't programmers
> 2) that our Project hasn't even started and that we were "fishing" for opensource programmers.
> 3) that we are 13
> 4) that we materially support terrorists
> 5) that we seek funding for our project
> 6) that we don't know how to make a game.
> 
> We've been programming for decades. Recently we programmed in support into the 3d engine for other map formats.
> THIS is what lead us to /ASK/ on lists we know OTHER opensource _C_ programmers congregate for help with even MORE map formats.
> 
> So see 1) we did some work on extra map formats. Then we did some more work on more map formats
> And then we thought "hey, we'd like Unreal map format too, and hey look at all these project NOT IN C that sorta all work with abit of that format. WOULDN'T it be great if we could expand from our very small opensource programming TEAM to and actual T E A M...
> 
> So we asked.
> 
> Now, our project has been around for over a decade or so, and has lots of features; Polaris makes it seem that we're a brand new project; or even non existent; or some commercial concern just trying to get free work to make a buck. We've never made a buck. Never sought out monetary contributions. We want code.
> 
> But what do you people want now? Compliance with your /religion/ (women's rights).
> Wasn't the case when I started in programming. But you people chased out any non-faggot-woman-worshiping man.
> And we won't forget that.
> "DURRR IF U DONT WORSHIP CUNTS YOU WILL __NEVER__ FIND CONTRIBUTORS" --t. white faggot.
> 
> Hey: If you ALL are enemies: then we will treat you as such.
> Do you get that?
> You are making an equivalence between OpenSourceProgrammer and WomanWorshipingFaggotWhiteMMAAALLLEEEE
> If they are the same thing: as Polaris suggests, and the rest of you with your silent bans suggest: then they WILL be treated as such.
> 
> 3) We're not 13. Would be good to be; would have more energy to code new things.
> 4) Afghans have the right to brutally torture and kill any white faggot that seeks to change their woman oppressing culture. (I see it more as a little girl appreciating culture and a woman ignoring culture: but I guess that would be the same to women)
> And I mean _BRUTALLY_ TORTURE: so you fucking understand in your head that your FAGGOT white ways do not need to be in every culture of the globe. Killing you white scum is NOT terrorism. It's resistance to occupation by your garbage religion.
> 
> And we don't materially support anyone.
> I prayed to YHWH years ago that Afghans would be free; that they would be able to marry cute little girls again without the courts you faggot scumbag white pieces of shit installed to persecute them
> Prez came through and freed them as his first act.
> 
> 5) We've never sought funding
> 
> 6) We don't know how to parse Unreal binary map format. Game is allready made. Rifle is fine.
> 
> sf.net/p/chaosesqueanthology/tickets/2/
> 

