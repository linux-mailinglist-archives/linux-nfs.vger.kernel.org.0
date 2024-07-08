Return-Path: <linux-nfs+bounces-4739-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6762992A958
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 20:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13FBB21AD9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418CD14A619;
	Mon,  8 Jul 2024 18:56:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CE14884B
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464980; cv=none; b=RrJGyckZ1aT9hIA1CjFduMzwGt+/uRU83BSifaQHeLiqnLllAZHI6M9x6orDaZ3cNYLS4it3o2/00BpO/khTYuKuxCI2TQlrCyiz3TNauIj1vjcVcLw2pDLdw19VpdG6o0JRKzUZHGR1dIukIOpTHCDI2rwxQYKpkdZCLeu6784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464980; c=relaxed/simple;
	bh=oWbPf8hG4uhlRouCTqYPn1vpFOpHy9DiKuxEW6DAPe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYdlPVOpUYPLLHSGsQR7EYiqKZJuRRHiiSJMIPqPNtvM5mzi8ML3ABqyeOL6Xn7EKs1BKFm2HWwCPEao503SfFmvzaGyQX9Ch5bfKU5/vRwLuHZoXVNuPXAPx7YGav56mrGVSWaprn3e9v5aSMR3xe2IGY77yp9lGeGQZh2dFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42111cf2706so5045645e9.0
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2024 11:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464977; x=1721069777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fw7gSOyVGL3FQuvPtIUN+qY39hvWje85qgxFSuVetI=;
        b=BOOSOoZ/o5aR1RtmC4INQgV9ZB4HZLViBIdsOY0pYSxrrSbaoziUcy611UnA7ZbiYy
         yODScxgIPJ62Krb9uCIp4Q3l52NisAmqLWM+MiDAquqsZ4esQLl82hnHMk1sTs6csU2m
         47x7rRFjrG4kOvL7PGoW13j4mibw1j2P+J9/Y2k31h4YnRHK/WO204f6TMFv1rsGPr2K
         dv5/3a2f1wgEUl9pV+xxpkMGk6JpPTWlbkHvK467BnIMDfKdKAm+oKYviHNmPrCrGcVp
         t6HSgawu24+f67bOmYWTTXF7TGZmC4wUMGoFNKb9dGDAq2Hf4asYlLr2xMsnE9KB3c3Z
         TlSQ==
X-Gm-Message-State: AOJu0YxyhAHQM8auk0W0oGzN+Dqo1uNX2Jp/hs9799AFcqf54ufs9Ohl
	ESZj/9bgdkJ9rsd8YOMYsqzNrPFPt/QKLXKKz/hiW2JcONwEFdFB
X-Google-Smtp-Source: AGHT+IGU//4lVg+zIVVlVtnjXaV3cn49uSPQVR6vlGByaoD1To3sWizjS0bfvyBYp5WAh1AEXta6OA==
X-Received: by 2002:a05:6000:1f8a:b0:367:9614:fdf7 with SMTP id ffacd0b85a97d-367ce5de5admr310817f8f.0.1720464976540;
        Mon, 08 Jul 2024 11:56:16 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa070asm477781f8f.83.2024.07.08.11.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:56:16 -0700 (PDT)
Message-ID: <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
Date: Mon, 8 Jul 2024 21:56:14 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever III <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/07/2024 20:39, Dai Ngo wrote:
>
> On 7/8/24 7:18 AM, Chuck Lever III wrote:
>>
>>> On Jul 7, 2024, at 7:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>>>> Many applications open files with O_WRONLY, fully intending to write
>>>> into the opened file. There is no reason why these applications should
>>>> not enjoy a write delegation handed to them.
>>>>
>>>> Cc: Dai Ngo <dai.ngo@oracle.com>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>> Note: I couldn't find any reason to why the initial implementation 
>>>> chose
>>>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it 
>>>> seemed
>>>> like an oversight to me. So I figured why not just send it out and 
>>>> see who
>>>> objects...
>>>>
>>>> fs/nfsd/nfs4state.c | 10 +++++-----
>>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index a20c2c9d7d45..69d576b19eb6 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open 
>>>> *open, struct nfs4_ol_stateid *stp,
>>>>   *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>>   *   on its own, all opens."
>>>>   *
>>>> -  * Furthermore the client can use a write delegation for most READ
>>>> -  * operations as well, so we require a O_RDWR file here.
>>>> -  *
>>>> -  * Offer a write delegation in the case of a BOTH open, and ensure
>>>> -  * we get the O_RDWR descriptor.
>>>> +  * Offer a write delegation in the case of a BOTH open (ensure
>>>> +  * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
>>>>   */
>>>> if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == 
>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>> nf = find_rw_file(fp);
>>>> dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>> + } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> + nf = find_writeable_file(fp);
>>>> + dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>> }
>>>>
>>>> /*
>> Thanks Sagi, I'm glad to see this posting!
>>
>>
>>> I *think* the main reason we limited this before is because a write
>>> delegation is really a read/write delegation. There is no such thing as
>>> a write-only delegation.
>> I recall (quite dimly) that Dai found some bad behavior
>> in a subtle corner case, so we decided to leave this on
>> the table as a possible future enhancement. Adding Dai.
>
> If I remember correctly, granting write delegation on OPEN with
> NFS4_SHARE_ACCESS_WRITE without additional changes causes the git
> test to fail.

That's good to know.
Have you reported this over the list before?

>
> The cause of the failure is because the client does read-modify-write
> using the write delegation stateid.

Does the fact that this is the delegation stateid matters here? How?

> This happens when an application
> does partial write the client side, the Linux client reads the whole
> page from the server, modifies a section and writes the whole page
> back.

Well, the test shouldn't fail for sure. There are servers out there that
hand out write delegations for O_WRONLY opens, so the client is already
facing this issue today (I guess no one noticed).

> I think this is the case with the t0000-basic test in the git
> test suite.
>
> I think this behavior is allowed in section 9.1.2 of RFC 8881.

Yes, agree.

