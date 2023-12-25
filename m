Return-Path: <linux-nfs+bounces-803-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7481E179
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31B61F217E8
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Dec 2023 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E58C52F65;
	Mon, 25 Dec 2023 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U/x/7bfK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic306-20.consmr.mail.gq1.yahoo.com (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465052F64
	for <linux-nfs@vger.kernel.org>; Mon, 25 Dec 2023 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703520011; bh=E6GDVW0jgxUqwBx/1yTNwZnDLEaTO4y8BRCT0lPT2TA=; h=Date:From:To:Cc:Subject:References:From:Subject:Reply-To; b=U/x/7bfKHs8VoKWtMGsUkZ5dMKghghJP7X85FAdqmnRvRwQg6UklzInJwIh2dY0B0nIHBgUkWy07mkuViEElwagSdeTnrYFdeUFEZrU1p0tVRec28UZPmwTkps/NhqW5/PgG5jCxs8fe0wxXR7uieU041Q5XO9xruw3FhDPVh0TpT/KRUZk0/116itrKT9jnZSkpMAmwno/sTJDw4F1SHZRq6fGMUk0TrigEJQEtzHS6gdlr2Shp4p+zy2zI0nD3Na9j2xhIfEKFE4PQwqvgvWaYJW1UnGo9OhMKSK8cNU3aAk6r6DEgtgNlSPKb9pw7VHn5jYqBJW/yt0kpu6KqEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1703520011; bh=Q2F++ZdkGcxd/IKw6swcIXSaocUZZEJTsmI8n8LQRC+=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=nvee9OugUzohi4UX+O2iSyHpCnNAn4Y9nsn6iJq/Ea2POOEHiBPc7n+hZ8NLAIV/g7CJrpByVqwBMZBwocae/jtkPaBi5pSYwQBZ7eNvgQB5b/nJ+q4hmMAzIaJUecw20IzjQ0aCv2z9kDlmjU6VTZ+ZSzHvDZX78GYc+Ls55hkg/xgfaLuvp/6R7ipWRZiVkiw+VhdQwp1SYg04sq/6KEU7sPXnwskpsC1qNBLjTkJ+DLyLqCXgSPFkQ9nFCHbU98YJVH57c9cFh6DwBvxDaQNUvK/qfLtuK6ZtX+FAIsMK4TiAgCsgoEIj4DFy8fnffABcbZbEElhvnhXgWLnVJA==
X-YMail-OSG: JUccaEMVM1kDIWzKmqk.WRcwhQLd_sWI3QmcSo7CkeyR8w1SuKMctW3__Cy4XCa
 82yn_Kcj8rApUCfO0LKcrr8vJPyxfHQReae7jEgXhZy0RNUvz3pfTnfnyA.sOr8Ltm7Kd2t3BGgl
 zpDbSp3sJD4aLzRotcYeBXpy4gMY6ca_V6DqRNYC2tiY9xCVJyZ602wXoo3WJvmNBjXGEbJ.cCMt
 MiX1RE63r0ReUbTMfYiHAA0yst9rF7zlng.AUgqVz4epbWqtUi9VuF4Wg2Do116hZv9dE6tR8hfe
 DMXewXQva0iAv6FRsomiSIVXdnx0GFs2iMlRoP5oxY8cS0KgCpEZtlonSbfkhZOr1PTR9TLjApLZ
 rGo3N.s2oLWiHuFZIjDtetHN_.kXzz9Wtw6A_VWGSmosRqDEHec0W9gVnK8wRKwONri5R7YRt5Lr
 ._2CEIYZ0fXiJ1ylCE79KEXzbXeaCId1avWZldqVNlLNvKhcPYi6z_fLXk7V9JlvH8S15wbA7yRT
 2dbKbcC2iQlcZSHcd6EIXblJMY2s_PEnN6XmoAg08S09IQAgJ1UAxAJiyjfP1jLV0zfNFcg3KXj0
 .MgWjYUkxvtAEnzLt.4Q4a3QKDKaLyjSFm.9IiCXAuGMNA_v65KPRYJpE__i.yo_GBbl8Hh4k_zX
 pYfTP_N6Qd7f_iiCNyfA5IDzbrcf3mb0RLCCe_y9vK0rVXk85TdD2m.mZjbh_qrz5KDdIqB2QOY6
 XHkwvrOIQOooztxngygaXF0q6iXdcHlNz4VKZ4xgOUE_z.kFMt2U7AKxi77YgHa95jw3rjz3uQUQ
 tih9F0BFwrkmb0QuoAYgm9TKLHFLDhEBqTpYlBFk_0OQwC_IVnkIHNfWXswuQMM.8UQ2y2YKE8sy
 .LqKDIVDj.7FUqKAVPYk_6DR2I3d9WJ3XmtQeezprThvopr6nB9VKUvGC0FZjn2vvMOQVqM2eQGJ
 NthzKh4z6Am33yZp19aP6MdKnSVGjVht8TzzMZhEJtZzMBVTm7UAXQxugVjAzOdnqu7U9Cl8f6Wr
 ReCp6p4rRy08_IitReQEtDHlhMwLNw0T2dkf5ajrTjZFcZfKehaDBVuJtEWkPPNAJRE0fNYbLqK8
 FIoqKNwQXV39rTp2w_tNA6VQY3Yyae5TpFpb5DYIaDaGi7X48yNtHB8muS6SG5ogf3GMAJ.EdZ3J
 hxXfx_WO6SV51h7hRU1FKhoESOMJZ53lrGpzZeiA.2cnRIGQQpoNDGOkVDBfIGa9iVp9Xxj4F1pb
 QJKNXM23w0E8lmo2KPCw9GuSlR9BajlNMS3fym2nRaY8Tknmbf4ZQwR_3Ok3TYE7Vd7MX7_3rlgI
 5bJRlgV1JhsNLloRw_3_wlP9VNZX2pKUjvOLhTKCEhgdC7ndI0oed8RPf2kdFml3vsE7..MK4gwD
 F.RUfMCXwMWHFTLVmdmesYJ7bD6dFVRHab58UDE64e1RUnJRU7eKRlVYcbEcbaLdWlXa7dO7ijrP
 GaXzxd4msbCTZZ.PTWyqVe0obj_RW8RQ7RpkdnS8NiRMnu0YdJmHM5qa_ovh7SvgSDBu0Ttkaqi2
 1_emPL3ae5PiRZczDJ.Ds.4L88Fxmhasj5EAPEh1A0qITsSSHxpo1wVz8p5obEFnyWDY9Qm9.Y2C
 dRWTRgc9.qybLuX6VZzacSupi6uiJE8mEAav10K73jIpeOUOBsjDWMcXuF8XMd7FYxYuwmJTdPPy
 KUMUGPgBi4LtKRa8yHy_BToP6fCuH0zNDmKmo1sVR.lO6qOqGgR.iHUZKcsQT2ofz2odCiA006Jh
 CSAqzZPHwnb4gTfVGDQkY2Vb3._5Qimja_ubqq70QzP157si4aArw.sNly_lD_xAnkVpNBe7R0pO
 yUW3in.ndVQV.vEGpJ0zHQ9Eju6L9lHIbdNkWnWPqBAubgG7PrkQXkNSbLhcm7tuY3dQc_fX1Iyr
 VwVOThOhFNsjRkKv_6bQjubOK00TgvHZMbp92r74WXmL2eoschVtM7mEzMtGVHcGN6oJjTCL8P7q
 MG3DxESpvG4qYk7sZguTqv6t2SShXO2o6_iQknrKr02J.orXwwllxbEKOzeE9VxiDLBI0in4DiKs
 MFOEclDi.tA.IdKumSTazjSpBwjjAX2XHbL.fguG4EYSJr1ilsGk2Q5wzSrt3_IUD2PtziNzH4aG
 QxEo0kzQ9lECwhUtsPjd.Rcz8Dm5q2XUoLFZIIcH8Ogz0tDqhyv9BiSOWnAFGZbP1d4n5UtTDR0j
 zxtJXAnz4j.9Lel1wOVxGecfaYExCyH.h
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: aacf46a0-fd74-41c4-9d3f-00bc9a43c314
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 25 Dec 2023 16:00:11 +0000
Date: Mon, 25 Dec 2023 15:59:59 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: "misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>
Cc: Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"editor@lwn.net" <editor@lwn.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"esr@thyrsus.com" <esr@thyrsus.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Jakub Kicinski <kuba@kernel.org>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Leon Romanovsky <leon@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Richard Stallman <rms@gnu.org>, Bruce Perens <bruce@perens.com>, 
	Jan Stary <hans@stare.cz>, 
	"jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>, 
	"netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>, 
	"netbsd-users@netbsd.org" <netbsd-users@netbsd.org>, 
	Rudy Zijlstra <rudy@grumpydevil.homelinux.org>, 
	Polarian <polarian@polarian.dev>
Message-ID: <1149516167.4244601.1703519999726@mail.yahoo.com>
Subject: Re: Why the mail filter?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1149516167.4244601.1703519999726.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21952 YMailNorrin

>On 2023-12-25 06:32, Jan Stary wrote:
> There's nothing to "confront". Go away.
The classic white belief:
"You're not a real man if you're not an obedient worker drone for muh society (aka women)"

Fuck you cunt.
I'm glad the taliban and Iran have been slaughtering your kind.
Guess they're "nothing to """confront""" " either.

Bet you'd say the same thing to someone like Hans Reiser (kernel programmer (linux)).
And then when he shows you he IS someone to """"""""confront"""""""";
then he gets criticized from the other direction.

There's no winning with you fucking faggots.
You're simply a woman's society.

Glad you lost in afghanistan :)

Men are _FUCKING_ their young girl brides there.
White CUNT.

Oh: and please some help with Unreal Map format loading: sf.net/p/chaosesqueanthology/tickets/2/

On 2023-12-25 06:32, Jan Stary wrote:
> There's nothing to "confront". Go away.
>
> On Dec 25 05:31:13, mikeeusa@firemail.cc wrote:
>> Got a problem with my emails? Can't confront me man to man? Like fucking
>> faggot scum?
>>
>>


