Return-Path: <linux-nfs+bounces-6872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8865E9913FB
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 04:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C353284D46
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 02:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B8D1BDC3;
	Sat,  5 Oct 2024 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="d78X0r9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/RwljMn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE94087C
	for <linux-nfs@vger.kernel.org>; Sat,  5 Oct 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728096116; cv=none; b=QVfGdhN1dE+4FMEcaX3U8CThwL/QabfzoyzwQQUeFBEgnc/hJuTH9h+WEjwkkcpZI1XQLcUrWTweQoCMdZr+3KNYMaVxSNamreWattR299iXBhvCsM3BnYS/bKfaqb8sA8sZYT8hHALzJoodpGHTTHL0flVO7UazcfIvkriPbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728096116; c=relaxed/simple;
	bh=b/jG0NBC82GvkwlEYqVZsAgmCgyuv9+7LRAuwP4xz5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CgWDfd1VpSnayCoS+HKDFIo64bB8GT/Ag95wfjk4wxiLHoW74qDW44dIeGgJ1G5JDI+gtxF6rn14igu6c9Kie8zXdZXB5SLu6oOKYSr08JNC8Um/K8DcZpTqgxW1mVFgwMnmCCqbmf/r3J4AsKwceY5RhMHaufAg8AY/CZryX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=d78X0r9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/RwljMn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7F2811400A2;
	Fri,  4 Oct 2024 22:41:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 04 Oct 2024 22:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728096112;
	 x=1728182512; bh=Yn/RoRNekJp0DFBvFKxPGiOsn6YbDq/ZYiHJSHTrOX4=; b=
	d78X0r9RAxZocf6fgzlNKtvuFphU0kSaip3Q7eQWPQLfQaCUnneW8/fISIaFu2Cn
	izk+qAXP0lu9b41jCpHRfYKcEfKE99Zy+VFQiXloECegnv3JcMjBWYzUyXnE9X22
	jTwrEuXb2KSqItKZ0F0BzPfkLFJuWGpuS24NusPVWdtfPJ5T3pNe6LOxfN4nqOaB
	Nl6x/yHI3fSEIC3RyULCKpoV9NZl9ok4+I/iFD+kewgpAwNRdOa4Gl003zMaHJ+a
	tRYK6tGp6HKChtf5jmIX+tir3A7A9VcGxX1DIlg7iOV6DwanCPZlmYqZztfXllDM
	432/7F6ZwzOTLCoI6JCiTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728096112; x=
	1728182512; bh=Yn/RoRNekJp0DFBvFKxPGiOsn6YbDq/ZYiHJSHTrOX4=; b=U
	/RwljMn4WIIEFb4v6Fofi6ZNQ80ksZyHgBHHU11dRPWD9Xwzwx0ZXZNSlUVHDTGR
	h3LKuiRRI1XhQf+fG+8CyoFgEl87yPHJiwDaNId+OfVIDWflkJWQwRIpEcEh8Q8N
	TNcENzjru3u3xmBJbRzkL285Rt5nW4DpHEwJHTkb39uZCDoRsCJQfLRj26Wib7GA
	/x7iGDLhJbT/Gz2YzCu6oitlWjkOnRKswM1R5PMdshnE1BB2/GpMxnkuv0OAYVMO
	4lje/ly3D6sW4HCh4n7ZA5bmdENNGUxqCekGqYbhLseNV8alyGs1Yx836a7oNt2E
	j+7VCfmlQxvjW+y8Xf68g==
X-ME-Sender: <xms:cKcAZ5tQJaG_dWz-0MZ8SDwlvyz9FfwvyIDNhxs0ndtlRLMmE32Djg>
    <xme:cKcAZyewKCTtya_1y2lVHnn6_l0UVJMnQDdzC4QmeaXKc-g2VoxVqAusXqb5odUng
    TG_VwieAx1B>
X-ME-Received: <xmr:cKcAZ8xi6iCbWFhuJX2QsFRUwfMJhKx9enBpRrZyl_uptIApSzDhBHsFCMYkll39wtqfsglnz3WywjeQHFJC-KEEi5uysxbui3UDL57elOa4xOCj7OucnKyl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeejueeuteffueegjeehkeetiedufeehvdehteejtdejteelleeh
    kefgfeefuedtgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghvvggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehhvggurhhitghksehruhhtghgvrhhsrdgvughupdhrtghpthhtohep
    lhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cKcAZwPFgtkksUqYtw99Fzm-QYNj-_6oIM1_XFXv_vqtKbnKgU63QA>
    <xmx:cKcAZ59Yto7TLQognD9XwsvhrqKz05Fzou_FkLvuVZ1J8X5HekshIw>
    <xmx:cKcAZwUyvaxJ9By-0yG-c3puP4T_g9lFKSXCAApHK9C8jpBgXUN6nw>
    <xmx:cKcAZ6dbuGwTa6l1NQ7jHBo7H4HSllFETLgDmNybEhTnDET8Y1ZMzQ>
    <xmx:cKcAZ7I6UvMMAl81b-snbwyGiKjfbkFUlETzlGmY4kS1BoEqyO0AtFhg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 22:41:51 -0400 (EDT)
Message-ID: <209f2590-9bc6-4c01-a14b-87b7575a6f20@themaw.net>
Date: Sat, 5 Oct 2024 10:41:47 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable big in nfs-utils
To: Steve Dickson <steved@redhat.com>, Charles Hedrick <hedrick@rutgers.edu>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
 <0654ecc2-74fa-4e50-8878-bf37f17a5748@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <0654ecc2-74fa-4e50-8878-bf37f17a5748@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 5/10/24 03:54, Steve Dickson wrote:
> Hello,
>
> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>> While looking into a problem that turns out to be somewhere else, I 
>> noticed that in gssd_proc.c , getpwuid is used. The context is 
>> threaded, and I verified with strace that the thread is sharing 
>> memory with other threads. I believe this should be changed to 
>> getpwuid_r. Similarly the following call to getpwnam.
>>
>> Is this the right place for reports on nfs-utils?
> Yes... but I'm not a fan of change code, that been around
> for a while, without fixing a problem... What problem does changing
> getpwuid to getpwuid_r fix?
>
> Patches are always welcome!
>
> steved.
>
>

Yeah, getpwuid(3) and getpwnam() aren't thread safe and presumably gssd 
is a service so it

could have multiple concurrent callers.


You could use domething like this ...


nfs-utils: use getpwuid_r() and getpwnam_r() in gssd From: Ian Kent 
<raven@themaw.net> gssd uses getpwuid(3) and getpwnam(3) in a pthreads 
context but these functions are not thread safe. Signed-off-by: Ian Kent 
<raven@themaw.net> --- utils/gssd/gssd_proc.c | 28 
+++++++++++++++++++++------- 1 file changed, 21 insertions(+), 7 
deletions(-) diff --git a/utils/gssd/gssd_proc.c 
b/utils/gssd/gssd_proc.c index 2ad84c59..c718be6f 100644 --- 
a/utils/gssd/gssd_proc.c +++ b/utils/gssd/gssd_proc.c @@ -489,7 +489,10 
@@ success: static int change_identity(uid_t uid) { - struct passwd *pw; 
+ struct passwd pw; + struct passwd *ppw; + char *pw_tmp; + long tmplen; 
int res; /* drop list of supplimentary groups first */ @@ -502,15 
+505,25 @@ change_identity(uid_t uid) return errno; } + tmplen = 
sysconf(_SC_GETPW_R_SIZE_MAX); + if (tmplen < 0) + bufsize = 16384; + + 
pw_tmp = malloc(tmplen); + if (!pw_tmp) { + printerr(0, "WARNING: unable 
to allocate passwd buffer\n"); + return errno ? errno : ENOMEM; + } + /* 
try to get pwent for user */ - pw = getpwuid(uid); - if (!pw) { + res = 
getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw); + if (!ppw) { /* if that 
doesn't work, try to get one for "nobody" */ - errno = 0; - pw = 
getpwnam("nobody"); - if (!pw) { + res = getpwnam_r("nobody", &pw, 
pw_tmp, tmplen, &ppw); + if (!ppw) { printerr(0, "WARNING: unable to 
determine gid for uid %u\n", uid); - return errno ? errno : ENOENT; + 
free(pw_tmp); + return res ? res : ENOENT; } } @@ -525,6 +538,7 @@ 
change_identity(uid_t uid) #else res = syscall(SYS_setresgid, 
pw->pw_gid, pw->pw_gid, pw->pw_gid); #endif + free(pw_tmp); if (res != 
0) { printerr(0, "WARNING: failed to set gid to %u!\n", pw->pw_gid); 
return errno;


