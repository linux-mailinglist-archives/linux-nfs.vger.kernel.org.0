Return-Path: <linux-nfs+bounces-6875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F629991407
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 04:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA01C21AF9
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300110A18;
	Sat,  5 Oct 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="as8dDuC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXabLT+z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C017C8D
	for <linux-nfs@vger.kernel.org>; Sat,  5 Oct 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728097101; cv=none; b=oCL3HtQm39XP6nOphdu/UHfwVprTZyqUMGaARFxIZzbbwgwlF1UI0TCsaB/xw/4xvNGQO6ee9bd6HV+emvTVE/j+/P3dHVt00I2pBwG8G2s5cA4OrkuWiufiaeckf7bMA+z6Rz5TJniR5ura+wfOEnhEm1p1iP1dHBTOrc8DeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728097101; c=relaxed/simple;
	bh=SQlwTbK5SKrXFBN9/Z/GrEAuXZtndESsdP5L3sjTr7o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=S8nzu+izfvDCIwkm0TL7pV8Tfg8kBC24Dt3utWtomOh734r0RlBihb0O/VXxSihKdD211jR7uQ1ge7r3RofZc+cFuIbXCs5VemFAqEMu99I5/njHMLv8L+zALA/LAhuuGuq5u4Fypx7d4WYeRwVGrXGS1AznEGP2en0JIcU6Bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=as8dDuC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXabLT+z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7839D13806F5;
	Fri,  4 Oct 2024 22:58:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 04 Oct 2024 22:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728097098;
	 x=1728183498; bh=s4yRWrVoegPnIlcSg7W2T/j3rBXl4xv/JOXV5IvncVQ=; b=
	as8dDuC02WVzwprZA72OJaynzBd2ttEfV4Zx4Emrgxk2ylvmfOzWrY5Cx+86n2pk
	uNeSLcQeYejSbpR3ajQH4TaE/PcRDqbCnxaHhNpQg7tvM25+IXrjTaewfHavvCtk
	wUuoVQNFNKXZ+MsNW6YxKtKQsIYvcg9Nh/cU3wb9mkjEvIRVFL2xt38ZRcXoUcoQ
	6zLNlp8A90dE2CoXH97sRehwFYeD5Q1fcEHMj5z+hb7GLGe2L+JAb78FDbLP83QT
	EudNFnzuyo03QjK/TL39TTLRdYIDAnl8XLheTDwzq0Du3BWOIG3q/xv9+11tzp3y
	VjzDuz9sqIQFiYc8lWsXsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728097098; x=
	1728183498; bh=s4yRWrVoegPnIlcSg7W2T/j3rBXl4xv/JOXV5IvncVQ=; b=P
	XabLT+zbhqOzhB529r+7taCa/RDAteKa6JS90zXvUcoX3/HD6xyUqaEYd4ctcz/t
	UOjOWSO3ni0ltmgyVp/Ug8ICSLfcDFeHAr/gJzyNuL1WTze9J8itcUum+DYPX6mT
	kC9ERdwqNvFFa2GjUhOH6AZyS5Rtd+NEQu+Z9ShwY9NlK5OnpCRwSZvwt7MZ/k0t
	i71sUGFLn1jqyvd1FTDiXbM/WbpT6jXmEY1sveDnzc015LQHxtxgw+o9XMIGj2oI
	RhODLtiKGvj3I6fAJMMWCxQc2f2OW8zSL8ixSLGKvtHVeKUe4SCKsEXCcJK16GQ8
	CY3IJcvHUdnRMGQMjZ1aQ==
X-ME-Sender: <xms:SqsAZ5zlKN2pE_y-we5w0pe-b1OiGqPN70zMUrdmFf_66KVnQi9bGw>
    <xme:SqsAZ5QHeiSgydTfapPMdW1M-TktyPvdTqWCZY2u2XF2Zj42AQUMCwnKevurR7Tz8
    yXed_aUQ2a0>
X-ME-Received: <xmr:SqsAZzWKlHaCqxDh2Di7tii8XJMoffBNq-TehO3Jearg6FTpfX7GNoLBFyoyfDndEOYrZ9KoeDT-G6ya_3BqBXEG2J__2CYjWnAY6ziLQpjIYah7WAn53KFx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfhfjggtgfesthekredttddvjeen
    ucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeffkeeiffdufeeugfdtheekgeejleetfeetudejieeuieekjeet
    vdeiheejudejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghvvggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehhvggurhhitghksehruhhtghgvrhhsrdgvughupdhrtghpthhtohep
    lhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SqsAZ7jiKZWBE4lNNcndZKS7fTQF54qSRlkyUZo6stB6IBg-lk5RlQ>
    <xmx:SqsAZ7CcavKKGTpZ_fysnKsOKz8fWlU2vOyRnCugHR4ROvwUIz9u-A>
    <xmx:SqsAZ0JzUZPY7sWitnx2T8J_PkK71XwZKpFUAh34yTE3TfMBObFdUw>
    <xmx:SqsAZ6DwsNY42B7ooqquCwSnwZ8LlvU_oX7ZdAh2mZfzWcBPd9A9WA>
    <xmx:SqsAZ-OPSimnG6UIO6MOV9wEC20yU8vanw4FVOyBT8cuq16r877gHwoV>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 22:58:16 -0400 (EDT)
Message-ID: <b6744232-7d0b-4278-a71a-b9d744b8372d@themaw.net>
Date: Sat, 5 Oct 2024 10:58:14 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable big in nfs-utils
From: Ian Kent <raven@themaw.net>
To: Steve Dickson <steved@redhat.com>, Charles Hedrick <hedrick@rutgers.edu>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
 <0654ecc2-74fa-4e50-8878-bf37f17a5748@redhat.com>
 <209f2590-9bc6-4c01-a14b-87b7575a6f20@themaw.net>
 <fb80e74f-177f-4ff8-8987-8d4d313286cc@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <fb80e74f-177f-4ff8-8987-8d4d313286cc@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Here we go again ...

On 5/10/24 10:47, Ian Kent wrote:
> Umm, let's try that again ...
>
> On 5/10/24 10:41, Ian Kent wrote:
>> Hi Steve,
>>
>> On 5/10/24 03:54, Steve Dickson wrote:
>>> Hello,
>>>
>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>> While looking into a problem that turns out to be somewhere else, I 
>>>> noticed that in gssd_proc.c , getpwuid is used. The context is 
>>>> threaded, and I verified with strace that the thread is sharing 
>>>> memory with other threads. I believe this should be changed to 
>>>> getpwuid_r. Similarly the following call to getpwnam.
>>>>
>>>> Is this the right place for reports on nfs-utils?
>>> Yes... but I'm not a fan of change code, that been around
>>> for a while, without fixing a problem... What problem does changing
>>> getpwuid to getpwuid_r fix?
>>>
>>> Patches are always welcome!
>>>
>>> steved.
>>>
>>>
>>
>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and presumably 
>> gssd is a service so it
>>
>> could have multiple concurrent callers.
>>
>>

[PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd


gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
these functions are not thread safe.

Signed-off-by: Ian Kent <raven@themaw.net>

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 2ad84c59..2a376b8f 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -489,7 +489,10 @@ success:
  static int
  change_identity(uid_t uid)
  {
-       struct passwd   *pw;
+       struct passwd  pw;
+       struct passwd *ppw;
+       char *pw_tmp;
+       long tmplen;
         int res;

         /* drop list of supplimentary groups first */
@@ -502,15 +505,25 @@ change_identity(uid_t uid)
                 return errno;
         }

+       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
+       if (tmplen < 0)
+               bufsize = 16384;
+
+       pw_tmp = malloc(tmplen);
+       if (!pw_tmp) {
+               printerr(0, "WARNING: unable to allocate passwd buffer\n");
+               return errno ? errno : ENOMEM;
+       }
+
         /* try to get pwent for user */
-       pw = getpwuid(uid);
-       if (!pw) {
+       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
+       if (!ppw) {
                 /* if that doesn't work, try to get one for "nobody" */
-               errno = 0;
-               pw = getpwnam("nobody");
-               if (!pw) {
+               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
+               if (!ppw) {
                         printerr(0, "WARNING: unable to determine gid 
for uid %u\n", uid);
-                       return errno ? errno : ENOENT;
+                       free(pw_tmp);
+                       return res ? res : ENOENT;
                 }
         }

@@ -521,12 +534,13 @@ change_identity(uid_t uid)
          * other threads. To bypass this, we have to call syscall() 
directly.
          */
  #ifdef __NR_setresgid32
-       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw->pw_gid);
+       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, pw.pw_gid);
  #else
-       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw->pw_gid);
+       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
  #endif
+       free(pw_tmp);
         if (res != 0) {
-               printerr(0, "WARNING: failed to set gid to %u!\n", 
pw->pw_gid);
+               printerr(0, "WARNING: failed to set gid to %u!\n", 
pw.pw_gid);
                 return errno;
         }



