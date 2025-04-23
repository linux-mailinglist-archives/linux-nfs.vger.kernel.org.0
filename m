Return-Path: <linux-nfs+bounces-11229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E970DA986B7
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 12:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B01B3B9932
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4382686AB;
	Wed, 23 Apr 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AYsrFkbU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD851FE45A
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402671; cv=none; b=cMbp2ZUJWpZB3knTejnFLZhRGAsUTKIw9M7slPcT/OBxcRtGf/BsT7NyYTZ7HR0r2mdtyAHvc68Bce7cIWawShu6lJ3RVJliZTdgMLrViHt2M70YQ/wC8W0AV/WbNPCRirE3VUqM/fmwVlYWRbl6qRe/MVvnTNqpmBNFBXiHfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402671; c=relaxed/simple;
	bh=KTgNFK3Vvp8Jow4natChnZDdfjuA5XmZvmfWk308x5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqCmnaHYxjm/UaggIyFY4QoOq+wdxxnU78pPb2mvfht/eJd6GqgVkG+aGkEnDGJdthZeDWwgldMORYmJK+EFxqai/5vLiPTMhPwd9E1mtgxWa2hdpE/iiFhgIoe3UjxQUeTrh59g7b8X1xpXGzZy/cORbN9H6Ea6XHuP0AaJXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AYsrFkbU; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7WwfuvEM2CZIm7WwjukgcL; Wed, 23 Apr 2025 12:03:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745402598;
	bh=aTJWeZ6oDeuGazsritAmOSXtbO4wouLXCoZ+17CAVzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AYsrFkbU0cfu/juuEtLIpgwPud2T+dt7J2Fw5UPd6lNoMTmOswNiSz5T0ebptBjve
	 8E7/ppn9t9Lgjs7g5WbUOH9a2uoywqlAHasT+1khLnznU/rN8MXDihMqCbT3RGzsrK
	 ZO5n2MMy+BqBedhJy9sUvFEl+ojnmq7ZNGOTracKMaWHrENrgMASvYuVK6/JzFR7aV
	 Wr345BMiYLH6soJWqc7UXsXqxZm+v0/m4yEYzvvxoQCY6Zm0TdgOhjDcgGXpIhexGv
	 s2VhZ3CdmEpUQz8oaaY6f94Y6vVW3shD27tuNRFSkBXXCLvuvtSTIltZyfdlME4xDB
	 EwP06gnkiKfLw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Apr 2025 12:03:18 +0200
X-ME-IP: 124.33.176.97
Message-ID: <ddcb56d0-098c-4826-8703-6cd669daa518@wanadoo.fr>
Date: Wed, 23 Apr 2025 19:03:08 +0900
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <> <8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr>
 <174539938027.500591.1190076221216165031@noble.neil.brown.name>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <174539938027.500591.1190076221216165031@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2025 at 18:09, NeilBrown wrote:
> On Wed, 23 Apr 2025, Vincent Mailhol wrote:
>> On 23/04/2025 at 09:32, NeilBrown wrote:
>>> On Wed, 23 Apr 2025, Pali Rohár wrote:
>>>> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
>>>>> On Wed, 23 Apr 2025, Pali Rohár wrote:
>>
>> (...)
>>
>>>>> Actually I do object to this fix (though I've been busy and hadn't had
>>>>> much change to look at it properly).
>>>>> The fix is ugly.  At the very least it should be wrapping in an 
>>>>>    #if  GCC_VERSION  < whatever
>>
>> I acknowledge that the fix is a bit ugly, but Mike is the only one who
>> has proposed a solution so far.
> 
> FYI here is my current patch which fixes this problem and a few other
> problems, but doesn't fix everything I (think I) have found, and may
> introduce some problems because some of the interactions are subtle and
> need careful review.
> 
> Once I'm confident of it I hope to break it up into individual patches
> and submit.

OK. Glad to hear that you are working on an alternative. If you have something
backing, then I will let you continue.

> The key idea for fixing this problem is to pass a pointer to the rcu
> pointer to the function on the nfsd side where it can dereference it
> sensibly.
> I haven't got all the rcu annotations right yet so build testing isn't
> completely conclusive.
> 
> I think the pointer that is passed to nfsd needs to be
> 
>    struct nfsd_file * __rcu * nfp;
> 
> i.e.  the __rcu needs to be between the two "*".  But to test that I
> would need a newer sparse (I hope that will be sufficient).  My current
> sparse install spits way too many errors to be taken seriously.

sparse did not have an official release since v0.6.4 for the last four years. It
is not possible to rely on the distro package anymore. You need to download the
latest sources and either install it, or like I sometimes do, use the CHECK variable

  make CHECK=<path_to_sparse/sparse> C=1 -j$(nproc)


