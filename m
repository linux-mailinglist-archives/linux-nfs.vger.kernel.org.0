Return-Path: <linux-nfs+bounces-673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051828159DA
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3794F1C217E3
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0392DF92;
	Sat, 16 Dec 2023 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eJ6XuSLe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic321-19.consmr.mail.gq1.yahoo.com (sonic321-19.consmr.mail.gq1.yahoo.com [98.137.66.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676C2D797
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702736333; bh=c9Q/G8q7C7ZJqKauA6OpQdBE0Zs7XsAVs9LzN52MOKI=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=eJ6XuSLeXDcal5rlHHn4Q2vE2A7CDfUQw4O6ooED2Eci8j9Zg3UXLhY99EoalKlcW7TIwI1I6jd9QQYNAg0OmnlhVkDH0xvaleEA+s2gEkzHXvMTrA4FxL4GkYO1PCoTBcEF6xispglw64ECxqROSaqrLIjdjcHWptz8DY5rfJaIHHjJWK05g3av34uJQncbgZTa7omHkA+R5ixpZa5FcsBm8jMYuWHWDlWD/z/Jt6OrPE8b6MgYznjFsz4j6/7ifN+bO90JsMWMP3x+WG01veUixOeek6IlNFFzL4F05JmYnjwxEH/Zhp8z+m48DK5mS4Bp//Ud6Z6GaguxAbMYhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702736333; bh=ZQZcyLosgWogrvyY0hMVJrwXAkmzP4bsitvbQRkzg1f=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Yv7Vd/swhBePvq6J30781WSAUjQEFdknvBH5dvH4oTe2t9NlL4xD1dGbqWF6CMaE3ZzDf1fTaW3T+9YGqhnhb1hTwfZ6/6bo+72RsxRbrGqJwaRuLiHwf0ARd7+PQ9voYE7sBcINmAg2iSukOIcHfHS/vBvhtCneBv5cZk97MWQ718T714KJI7Hn9EQXg5bmiRL7Z9tsA+F2I2i19U20n1EKiB6UlYNPgfkU4Yl6EcvCNz9ZHxkif6baWxp184/QnMu3Z4rshOdXHFERxfGTLCZDPc/Db0EnvC7Gs83XGngqVyz03wyUUCnMYJYV9kO992J/14b6q7v4AKm38d0I2Q==
X-YMail-OSG: zf5PvwwVM1lgzi8w_2Sg2c9AVWQ_gJXn8RmjoZZyWpKqWMCHrur.I2BYn.cEYWI
 wDJNGP_l4XN9ZLleLTy4Edci0ztjYImtxTWu_L.yuFsQH_DMvdGof2mGKRY9SPxhhAdVmArC.KP2
 aXR9zyd5eEipCEeMpQxBHrx153wjPjkhSG944uGAJJ5VOdO47OVYlMOCyfF1i0UYh5NWbYwJba8s
 CG58IBRwu.h6FEfGfnO3zkWeFRWH46LYDszNc14zqflJEkA0UZNfIz2RWrJEqYQtMzWWLhq4RE9B
 LbzSpXktHxzXlWxZ0oEA06YI6QVZTNC2i9SdnjkMEnxBUG0fDZH.H2fG_BzQiQRxFMaW8sX5OP0A
 QhhGDnHZ80g54olRfLZSl_i5_9uAramI00gRr0DpiliMyCDkdNjRJv.zcjq9jt5U6MpiO3.xk9NQ
 SnzC0P5OnWYHCka_5OxiEY4bfNo4epk2vhTCBE3BDV_WHBKc7DPHqBzSY_y8KauUXqrfajJwwI0G
 kAe9T.8_bE3iaDeI_LouMlMDsJDvHLlYnZBb.X6aNWS0MSJvIQ1bV7ULGZQ2tS6NX2acIpJs_.a9
 Xvx_hhLCoQjudZiPDEamVVhgnuHeIdqyHHdAKO_EeFxEvI1qQjv9blBCmzDbAk5Rq6kHZUaq5EeJ
 .252jBuAAbFGeQz4BYgOx37W_ee03dI9n21WRzk6FPSZogNRrme9kyQMhIzBA7.cGfkw0FLbzTcJ
 hmL0oLxu3sH4pGl0bir7VwNPDZ040HNggX4zKeay1vnuV7QZRs5v.JdIdJi_hlBRAQlQsAKb4MgF
 6HINv051RugBE8if3EIFyi0ju3ecQLmUookScERpitnKEVJtD7PMCbafCaYjfLhKEYZH6gitehYN
 KSCY8rA2q26P_Zd4xktXmjdSxgiq4SR5RBvhKMcMvdsK1J4k8yvCDueoOkBQanFIMQ2V5sZMCoXy
 wye9Cj1ymtlObQwV4CDCPKuyZRx3VUnuqMNG6qcvAUeH1o.DfSV6zvSuKBd6DrBo_eR.7177A5R6
 K4pI2VliQsI9mZ3i9VqUbz_afgCaVZbH6U341GOLusXARLcFvE19BnAsZ0guG6DxnYW79i4wPgV1
 _whQwJ02S.rTdK21lmZkNNympE7NzVLb_piINOQSwQROStPMQRFRxttA3lI41BlAvWpsiu02OPhP
 sCoyTmru3kLuuDoZYrzC87ArXbbHvBegpteK8piUMC5KHImrnjavoobFvCRVypoJjyn0Hgpv9EHu
 RcYIszQOB0qY5RCfj4Ulx0TQ4vIujrUmRRDQVaVg9jDtgqOALWnnzeD5dSn19YetI1YY8vZQf8wW
 XDx0WNBlNC5PbSR7c10ahmr3EXYq0.I1Ebj025TrEUvI85OHlreYmLHUGq9UtO7Ht4avWmgUEpw5
 U4at6zqkCbZ0ulthLN6hAVu3MD9eAC.T_uYewHLKdeo6ecbgsqHbtfmdfcQE7Mst9oJDGyNQU8E1
 W3fXYm69YfO.SEqwZ7v.Fiwh8sx1FhAL_pF_82Ww.rAPBggqrBVgSX3By0JA8BWDmOMOSRzcvcin
 xKR3Pr731nXLfw9hCsXfd3QWJGHCoC3QD8kdVeeq8_pp3owfuB_SuiCvmlsLbjakEIxOWYr4GR4C
 gqojBsSGxA9bf15d3pb_kwedCQ0UWx9Sqbo.vnH0ICl7H23baoMydYX2r0P2rEisi35uk.FaPPEb
 90YKLpflu2Mu8YXHVq0GfZWYp8pkY1VCQWUvnykl3F9vGY2IrBDoQkHfx0qQ5g8qd7CowwiVHZRa
 .Od7ZqFLI_vrl87_sj9NFBhDBWuHxLHlbaQYnc47A2I54JBrvbIq0ZYCT8GdYOwP8OSIXF1hZ3IA
 NorFynQJmTbnxkvWZ6MHjcWsxnANoh0S1.2HeDtnh94aqSaQhNHxYgnWmhHS4YGa7e9U6qyS3yXU
 ovEO8me0ddVejBxfAZlyGcKdazHcP.cb4hwqt4iQmiSTiF9qndQ5reou3.bDPRl2qJrI6p0IaZ4Y
 BSq0C.SxxqkUjQQmiC8JNQJbK7aIC090MolZEM2JdtMFWHb200ALwaRE7Qy7ygEJ3jsVflTpLVS1
 UZ0lSa8S63ArEYuRz1saNb4hGnv3BULmT62ma7VsXfkUoiAJDz2uZyKwLDxYk5udBQuv1gKcy3vH
 L3Oxt.irrSN8mmVx0FmJc8GKRaEja.tL..U1UXIgTysVypOqIOHpOCECCCKtbl1qoNlmPEJvb46g
 GW0S3
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 8a05b375-9c08-478a-93f5-59b199466fb4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Dec 2023 14:18:53 +0000
Date: Sat, 16 Dec 2023 14:18:48 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Bruce Perens <bruce@perens.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Richard Stallman <rms@gnu.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"editor@lwn.net" <editor@lwn.net>, 
	"esr@thyrsus.com" <esr@thyrsus.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Leon Romanovsky <leon@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>
Message-ID: <1587993142.1777988.1702736328778@mail.yahoo.com>
In-Reply-To: <1891850654.636910.1701859570489@mail.yahoo.com>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com> <875007189.3298572.1696619900247@mail.yahoo.com> <ZSEdS8a5imvsAE8F@debian.me> <457035954.3503192.1696688953071@mail.yahoo.com> <CAK2MWOsK=pTKADr1kUuj=fvmRB=X2Z0+SkWQ9PTSxCqOVCq39A@mail.gmail.com> <641990627.3964368.1696950113530@mail.yahoo.com> <CAK2MWOurH4AHGd3ntgVvg-+Z6rNZriO2xQm9_RNqpUMwWWQCkg@mail.gmail.com> <1891850654.636910.1701859570489@mail.yahoo.com>
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

Why won't anyone help my free software project?
I simply want help with the unreal map format. https://sourceforge.net/p/chaosesqueanthology/tickets/2/

