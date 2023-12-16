Return-Path: <linux-nfs+bounces-676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10356815AEC
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 18:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BCC282ABF
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 17:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660993159D;
	Sat, 16 Dec 2023 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cJ2OvdTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic309-21.consmr.mail.gq1.yahoo.com (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFB30677
	for <linux-nfs@vger.kernel.org>; Sat, 16 Dec 2023 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702749379; bh=3ywQ30xHRQGoctUza57VrSGBvlL0tJAUFYSNd2wM/kU=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=cJ2OvdTEz0udI2PTzrD70iVuUtfna5bcsdtvuUO1HMyf4SD5AmlgVlI0Ed0WDWiB70iQiJCDVOsyJgot/V40LVf/dQD65CVLRdGfjUun6GxyWbaetJgHgLiwIu9bfe7F0CpTf3nfKpqwVb/XQqIGJ6x2hzJ4vTo3m8TxyammdoZoTmWqWBpcp4grqKS3gXwH99nWNddZVfC4SnZGfvwMXwimLLxjOvq6DWTiuzlygz4pP6DrsHR7Bcqlcb7lyDBZ3DYGl6KUHROZFBEaCjHLcNpo5uXobtFR4vF7FDHcTrE7CV7A7FcZXy6iH7MWhXIXOLz3cdO0T6Pm/RvqS9kkaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702749379; bh=AyIeB1fq/aAa32dktPDdYa69LW/FqpDdIrtdmsC2b/m=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=LbmfSbAxUvLXfn4t+03GyUY0HQbpyLLm6OaNMuhAD1b2Cms3i6UEBcDb7OW1iuMyqCJCgHtEdz2O7p0BjQERlNx55td7qGqfES0CTTi2vFakAwjacrHpPPBTlRcB5Me68u18X100O7SnhA2+BC2/ynKAog1VJc7f2/ZReWI/X40w2yZnOvzkHWDI1K4Qy2Mjw7KoaihavcBcOKAg7sI7jp4DenmjtbSf/DXFbic5KdjTYgy5ahzbDZMz0WrxTNBpepZJBQtYCgBNEeINlEx8tAzkaH6UKk+zhQG9ka+PpTn7Y6eruIKu6VqWN9FzAqcJKInzYcTXR/Gms5mQ4ovGgA==
X-YMail-OSG: dM9YqbIVM1kbWb.dV5VjyR49GbeFFR7ilofNFYGk4PxejMth8EYvD2cV9P8VuiK
 3SiaSGLl1OvqWzplRiFdj8Ubde3PZO9nPS5IPfpTjYQDAeDsmXp6dPfwbaDYKHN7XtO8tD9.vR4g
 Ys.MESGEK7xPsJ9ZEMDiNi9gaI38wG._EB45o0woHJTzgfaH_1Md3o.csbT8mJWu_VUDL7c4rrPs
 QIOfowP2ubEyxHSewLlPvtHggDXkk1eo9T.mKgDbuYwMZBh_oM5x3wOrj_z7HSnVrMNukYxEviLG
 CfaB_ebYruRUcg1Z9390vpUTHV2U1JiIwHKwEEX7AX42yzx4nT0SGKIPCPgYmcm5fMzwY6Oue_bU
 llcTweHQINOI0HkF7aNAziCIhpb_MmsVPUtZnAZpsS5n4P99qUeP8_6j04ugxnGfUb_csiPJXJ_c
 AypXEnN5vbK9B7MhWhh5ge47SZxfMg0oXz0gxZOZrM_GcfkyeJjyHsf0qFdSJITLpC5aCpyP9syD
 7uZN_JrRjERi7SUJ6iCuCZjP3etAS8sdEXajO2yJ_B_bPTbewAfONf2tCDzBPzQY__LwCDzohSO6
 zPQxxCo1sKJrQujUZLk0auzy.TjtWUTfv0XtLtPBaRfHkwA8cVFrKKy4S0nsoZTLu15sU9lh4jEV
 0ZyCIlq8wxEZkpevymkfgBbMS3B24iQeRzhrLuHrLlnu4nk0TfbX5wVBbtRaLPksUmBTNzMERr2w
 UdtXPj5UujgF70ImEAIqFqwjHxxIBU5JaYIYiHUgFIrXVj2EsW41JEHgzU9Mg.Eqc1u7tJUjDFkR
 mRKX04YXjtWRQbwNmfRkE1h6V.7aCpxWvdfazIRTAvpSzG.bUhDa1anFjmpNJ_XQcxwEZddqckCJ
 QiEC1w3t2mYbKmE0Zax8h7oSlO1yWVh2U0WyKkZXsFFBd1VxVDFrnYGbNzfRxbrWxqXDun1VDMke
 DZNK1OaL8iH9KlJqv0F7jVpigpi4BXxU0EiC6JEaXPEFzzvGjWnB6XNAjrkFVVtcl4KwGsOrZg_U
 RlFWdsgvNBi_fJdsE4DRgIwBHsDqOxR.8H9shoLfoAQipkKU1wGhJvPjhuVxkgF5JBqquPsdNn2p
 NMOZO0alGnOBDTcVgijB6OtZlFBkPevvVJ7yN4BrUyr95Vh3iaUpwCQoIAjLDdHarIWSvMgsd_3Z
 jDJ_8C9YEMd9qrsAvNdXxjWSghHvQJd_pAWU0cFVwCEyqicmyU.fZpXPvcZuykCn.oPZxaT_NTsd
 6UqIrXn2r6WVhgg5GtZRmeljIedCfCRJ5uFLDHAI88ou0urFbLs33FbVTnlYhvWFmdrIt28CiC.H
 Dn5ILhf.uiF_XY1j1a_Oj_IVfaqIDdZjTSmTDRCGcSMtvTSjkoh0zjkkomiLK6jJaoLFfqdQSDtw
 oj.rxO7G7yPDb7J3Uqv24sGyG3eHxy073S7UKDQs06b49poUIfmHhOCv3GtbRlc7_JFPZ7C1OWCG
 UYaFzOPthtAgoFjCMu9spoTSkOymupaUnE9vSx9jqZaO1PInuQObN8aBdEpSiyxLE92_DQm9bMV1
 92qwoP1alReCY6MTGlM4uWd010n_2m3VmHPW5WPQ1uOM4twOigO4bzvkj3PP1Cc_n9EF86Ytjpt4
 d2GP4W4fU0iCn3eE8q9aPi1UwAlg2LrmUEyZBnpXrHDFjcVK6QGuNkHz7P8pVmXhAgOb9kYFSQut
 K4ASQ83TuO_9uXMY7s5zXHKar4l_vtU.g8JCtzFyzwCv3O5StilI8Xgc4jTlbVm9.PcnmyUySE4D
 gyeRqgsbEFaktvreaptyYno9LNSP8QYqLvRXbF0Is4TXh4YhrPvzXSguKkUpt53X_aiQ84CMDdIc
 R9ffjb9dzdVGK0ukJagWAv5ZKu1.I9la6OudcyxvFTLHV2vTmmj0xBmZKCAZG1buiWYGCrD6PdVV
 bG6zdlMSI7x7JzVc3QhDuyAEhxSmKrMPB3vBv672qk_kBDcaBFJfD2YajOvo8I_aa8QtLzgbNma4
 Xk8qriGa6TcBt_b93oNulDnS35eUSujJ86qERrK1mNAr29ib_S1kAnrf13FpGDtaxVZq2W9NOrX.
 Y4NZXX6za0ZuuTzZy0Odf_vixbc02r2NoLAs.wKaI3T7_nbDUTjaagkLeRJq6Bu8s0r8gabu.pd0
 T1S_dqKzi5p1Xriu7Rk2OHw4zoF.q.UNFDnrP4wX8XSXjKGc_pKCfvOnogzbEpMhZ9CPAdmQWKnh
 QHSEGITeyBs9VUu6EVg--
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 65d099a4-8cca-4028-8c81-4b5b677d577a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Dec 2023 17:56:19 +0000
Date: Sat, 16 Dec 2023 17:56:14 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: "misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Networking <netdev@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Richard Stallman <rms@gnu.org>, 
	Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"editor@lwn.net" <editor@lwn.net>, 
	"esr@thyrsus.com" <esr@thyrsus.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Leon Romanovsky <leon@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Paolo Abeni <pabeni@redhat.com>, Bruce Perens <bruce@perens.com>
Message-ID: <2070059348.1814523.1702749374962@mail.yahoo.com>
In-Reply-To: <ZX3TEj9LyyHg1cHQ@skapet.bsdly.net>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com> <875007189.3298572.1696619900247@mail.yahoo.com> <ZSEdS8a5imvsAE8F@debian.me> <457035954.3503192.1696688953071@mail.yahoo.com> <CAK2MWOsK=pTKADr1kUuj=fvmRB=X2Z0+SkWQ9PTSxCqOVCq39A@mail.gmail.com> <641990627.3964368.1696950113530@mail.yahoo.com> <CAK2MWOurH4AHGd3ntgVvg-+Z6rNZriO2xQm9_RNqpUMwWWQCkg@mail.gmail.com> <1891850654.636910.1701859570489@mail.yahoo.com> <1587993142.1777988.1702736328778@mail.yahoo.com> <ZX3TEj9LyyHg1cHQ@skapet.bsdly.net>
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

Thanks. I don't know either. The engine is a pure C project (nothing else, engine wise).
So I need to talk to (fellow) C programmers.
Its main area of interest is old 3d file formats from the golden age of 3d shooters.

That limits where one can discuss since no one seems to like C anymore.






On Saturday, December 16, 2023 at 11:40:52 AM EST, Peter N. M. Hansteen <peter@bsdly.net> wrote: 





On Sat, Dec 16, 2023 at 02:18:48PM +0000, chaosesqueteam@yahoo.com wrote:

> Why won't anyone help my free software project?
> I simply want help with the unreal map format. https://sourceforge.net/p/chaosesqueanthology/tickets/2/


If you are not getting any response, you are most likely not addressing the
right forums or individuals.

Then again, I have no idea what would be the proper forum(s) for this.

All the best,
Peter (who you reached via openbsd-misc)

-- 
Peter N. M. Hansteen, member of the first RFC 1149 implementation team
https://bsdly.blogspot.com/ https://www.bsdly.net/ https://www.nuug.no/
"Remember to set the evil bit on all malicious network traffic"
delilah spamd[29949]: 85.152.224.147: disconnected after 42673 seconds.


