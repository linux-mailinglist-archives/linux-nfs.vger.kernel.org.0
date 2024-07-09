Return-Path: <linux-nfs+bounces-4747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4ED92B0F2
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E31C20A3A
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9A12C80F;
	Tue,  9 Jul 2024 07:18:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C01DA303
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jul 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509527; cv=none; b=LDbeD6bdpKLMVefgp2YMaILeWMLL4Fof/78dVNhAVAKXC3Okcju8BNXopiFxvumCbV1aEBe+TEKRNp1E7soul55jfpNsAMQFZzFfbhD9RXDVn4O8KqsHfOs7rpon3kzkaBUE3Bertm+BRQJ9rpeaXpYXQjwDV2VXUiKPMR3wtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509527; c=relaxed/simple;
	bh=BP3cUmNK85xFHu9pPhCxadQ9V3QzbZ9oy98w5Xemuk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKmO3387s+iQIditafvw8bEVCHWANopgH9gK3OquOtjOax23KQoRolJh/0/4R0+xgGqXqbtrV1t/oZjfCn2LGVm/lakAFFh2wjePZI2B71xZq7kpf6AUbvQwEhzAS/VRAGvifXGBQfqK+MHzDnSf7ohH7iqWdFFLra+p80erGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3679483091aso323053f8f.0
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2024 00:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720509524; x=1721114324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRdKo92p0pq+CqHeU/r+394j47v9rK+z3x1LSHZb9Og=;
        b=m1NKPzpDNdtHD31HJC9mBz0oYb0d1rd6bT9pMYszPbcKrmqPyAv+nAb5bI4ICMvatX
         +FXY36/woAXkdBuSZNFBKaa7B/j9R1xrhbXqHW2bL8tvq9SueRpJtn+sLnSte37AfD87
         VOkb70n41Kir5i26QCVWYNfWIAq34Ymnm2Ahj81v0L9OgK1L1vqv2mVlqrao7g6uB1SZ
         EFKCUOkRpweDmhXbiWaiq9w5Qtls+HKdrevvW1ko02TeVf2v5AUQ9xvwlWEJJtmz+Ae1
         UseMmgrI0CRmhyZB8ig1WrowT5A1kzbTLBWVZJzrLs/Pc3cY1bL7EMPbPpxh/QIbgv2i
         z3PA==
X-Gm-Message-State: AOJu0Yxafgw4cMeqzGpzEI2vjjN6Ka3Ix4DChtnrKDMdMjpyxSlKeF2A
	eEqZFMxIc3m32KCv6R+YpT4TBMZdGS/uTVjZkqWo+5vm8oMiditL
X-Google-Smtp-Source: AGHT+IF4mZLHxzfcspTY9UQk8RQo3Mf8zPbd8Kbn0UfPaTY0+6sUqKycBZ+JETEVspNDj5CrNpKXqA==
X-Received: by 2002:a5d:64c1:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-367ceae1d39mr1005786f8f.7.1720509523721;
        Tue, 09 Jul 2024 00:18:43 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06b6sm1653229f8f.86.2024.07.09.00.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 00:18:43 -0700 (PDT)
Message-ID: <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
Date: Tue, 9 Jul 2024 10:18:42 +0300
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
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/07/2024 0:41, Dai Ngo wrote:
>
> On 7/8/24 11:56 AM, Sagi Grimberg wrote:
>>
>>
>> On 08/07/2024 20:39, Dai Ngo wrote:
>>>
>>> On 7/8/24 7:18 AM, Chuck Lever III wrote:
>>>>
>>>>> On Jul 7, 2024, at 7:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>
>>>>> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>>>>>> Many applications open files with O_WRONLY, fully intending to write
>>>>>> into the opened file. There is no reason why these applications 
>>>>>> should
>>>>>> not enjoy a write delegation handed to them.
>>>>>>
>>>>>> Cc: Dai Ngo <dai.ngo@oracle.com>
>>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>>> ---
>>>>>> Note: I couldn't find any reason to why the initial 
>>>>>> implementation chose
>>>>>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it 
>>>>>> seemed
>>>>>> like an oversight to me. So I figured why not just send it out 
>>>>>> and see who
>>>>>> objects...
>>>>>>
>>>>>> fs/nfsd/nfs4state.c | 10 +++++-----
>>>>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index a20c2c9d7d45..69d576b19eb6 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open 
>>>>>> *open, struct nfs4_ol_stateid *stp,
>>>>>>   *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>>>>   *   on its own, all opens."
>>>>>>   *
>>>>>> -  * Furthermore the client can use a write delegation for most READ
>>>>>> -  * operations as well, so we require a O_RDWR file here.
>>>>>> -  *
>>>>>> -  * Offer a write delegation in the case of a BOTH open, and ensure
>>>>>> -  * we get the O_RDWR descriptor.
>>>>>> +  * Offer a write delegation in the case of a BOTH open (ensure
>>>>>> +  * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY 
>>>>>> descriptor).
>>>>>>   */
>>>>>> if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == 
>>>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>>>> nf = find_rw_file(fp);
>>>>>> dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>> + } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>> + nf = find_writeable_file(fp);
>>>>>> + dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>> }
>>>>>>
>>>>>> /*
>>>> Thanks Sagi, I'm glad to see this posting!
>>>>
>>>>
>>>>> I *think* the main reason we limited this before is because a write
>>>>> delegation is really a read/write delegation. There is no such 
>>>>> thing as
>>>>> a write-only delegation.
>>>> I recall (quite dimly) that Dai found some bad behavior
>>>> in a subtle corner case, so we decided to leave this on
>>>> the table as a possible future enhancement. Adding Dai.
>>>
>>> If I remember correctly, granting write delegation on OPEN with
>>> NFS4_SHARE_ACCESS_WRITE without additional changes causes the git
>>> test to fail.
>>
>> That's good to know.
>> Have you reported this over the list before?
>
> I submitted a patch to allow the client to use write delegation, granted
> on OPEN with NFS4_SHARE_ACCESS_WRITE, to read:
>
> https://lore.kernel.org/linux-nfs/1688089960-24568-3-git-send-email-dai.ngo@oracle.com/ 
>
>
> This patch fixed the problem with the git test. However Jeff reported 
> another
> problem might be related to this patch:
>
> https://lore.kernel.org/linux-nfs/6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org 
>
>
> I did not investigate this pynfs problem since we dropped this support.

I see, thanks for the info. I initially thought that the client has an 
issue. But now
I see that you referred to nfsd that is unable to process a READ with a 
writedeleg stid
(which is allowed).

Is there any appetite to address this? Or are we fine with not handing 
out delegations
in these case? The patch I sent served its goal, which was to understand 
if there is
some reasoning behind the lack of it.

