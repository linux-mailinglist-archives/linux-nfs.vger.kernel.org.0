Return-Path: <linux-nfs+bounces-4697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1B9299A7
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0251F211AF
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D173CF4F;
	Sun,  7 Jul 2024 20:21:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348E1EA6F
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720383692; cv=none; b=XBZmP/gFs2XzB0r8iuRd+8CtOF0MqG0EGmap2sFYeZGiXLkagtuWptWjAeRfTSuy7szPEgHkm7x1accnb/2+WEg3UyhFjWN0b1SQnrcLnPL20jtXl8GzVLtEy/p1RKEMrEthGprzCUhNuOglc5UWq/mZFakVylWbJM3CpEWC07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720383692; c=relaxed/simple;
	bh=qaAbRz7+7iuZb7LugEfMElmuXqikiH+wkldikWC6iwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo1765VwZycbNlxVs1zHwMIlkBrcBRVygS+IHzFP8mZ0PWGscEBtB5yn2rWVgHATpnbJlYCZSJ17yCBj1ohZzxRMQmwo70rc8iig1RaP8mxRnXyaAa7JhFKJiF0v4tqN40LDFg2o5RsOeBTTbZidaKU/N12JlhGAVoICeMdWNuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4264c77037cso3500245e9.3
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jul 2024 13:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720383689; x=1720988489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx/TJJ+OiNhXv233HWf0K5Jku/UYTBfljIOou3G5afg=;
        b=L8MERwPLy8IltjamzNQMTzlMIMEed+sKwuGGbTHZKQImqcItpME9I1EojJofirnU/H
         Z2g/V/MdmfxT4y8UyqeXroJqpyjWDohgf13HQyIGTbyNyRyeVQFL8aZGqLXJk3h2JQHH
         9WObWWOT/vofi7SRDWbjnjAOZwCKgFpbqgRtrLRWzfLpcAGqyFmnKDNqoIpN7/JRxS3B
         IODIAV6/RLpV7qfsey7lPa/8iCQzoSEvId+BWaJhvLMge8GkRIsYSP8PD/odfYUwYITa
         xbI7gCP4LN5bvTM7bk8tQKNdb8MBBxDRZmk15Fco/GVx8ktfinyh5NittgDdGHC4FTco
         ApRg==
X-Forwarded-Encrypted: i=1; AJvYcCVkftxSog7vm1WDtS/20kGOUAn0FFtfOw8UqtwSbJRDDPfaPsT+NLjW6AawPkWhez6Ex3I1gdfyPG9OyrIUzmPdtDmcfpr7fYZO
X-Gm-Message-State: AOJu0Yw0mPgmMMO5fPdDPQBmoS/4J8xY9p+b6S6mjACf/nng7JHx0xGx
	FA1mF5UQknOQT5CQkJR6Wp1M/w5zLIoAEIiIZrHQG+2XmSW/1H1b
X-Google-Smtp-Source: AGHT+IEtqDC950dxkru1fcDNS4c6d63fjGPgbD0Wpjkd8SCU3sNcenBbyi+FF7beDVqxCB1G2ubPrg==
X-Received: by 2002:a05:600c:1c85:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-42667e0075dmr12497895e9.1.1720383688815;
        Sun, 07 Jul 2024 13:21:28 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679dd5ea09sm9097697f8f.65.2024.07.07.13.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 13:21:28 -0700 (PDT)
Message-ID: <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me>
Date: Sun, 7 Jul 2024 23:21:27 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Rick Macklem <rick.macklem@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/07/2024 22:05, Rick Macklem wrote:
> On Sun, Jul 7, 2024 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
>> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>>> Many applications open files with O_WRONLY, fully intending to write
>>> into the opened file. There is no reason why these applications should
>>> not enjoy a write delegation handed to them.
>>>
>>> Cc: Dai Ngo <dai.ngo@oracle.com>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>> Note: I couldn't find any reason to why the initial implementation chose
>>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seemed
>>> like an oversight to me. So I figured why not just send it out and see who
>>> objects...
>>>
>>>   fs/nfsd/nfs4state.c | 10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index a20c2c9d7d45..69d576b19eb6 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>         *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>         *   on its own, all opens."
>>>         *
>>> -      * Furthermore the client can use a write delegation for most READ
>>> -      * operations as well, so we require a O_RDWR file here.
>>> -      *
>>> -      * Offer a write delegation in the case of a BOTH open, and ensure
>>> -      * we get the O_RDWR descriptor.
>>> +      * Offer a write delegation in the case of a BOTH open (ensure
>>> +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
>>>         */
>>>        if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>>                nf = find_rw_file(fp);
>>>                dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>> +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>> +             nf = find_writeable_file(fp);
>>> +             dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>        }
>>>
>>>        /*
>>
>> I *think* the main reason we limited this before is because a write
>> delegation is really a read/write delegation. There is no such thing as
>> a write-only delegation.
>>
>> Suppose the user is prevented from doing reads against the inode (by
>> permission bits or ACLs). The server gives out a WRITE delegation on a
>> O_WRONLY open. Will the client allow cached opens for read regardless
>> of the server's permissions? Or, does it know to check vs. the server
>> if the client tries to do an open for read in this situation?
> I was curious and tried a simple test yesterday, using the FreeBSD server
> configured to issue a write delegation for a write-only open.
> The test simply opened write-only first and then read-only, for a file
> with mode 222. It worked as expected for both the Linux and FreeBSD
> clients (ie. returned a failure for the read-only open).
> I've attached the packet capture for the Linux client, in case you are
> interested.

Nice, thanks for testing!

>
> I do believe this is allowed by the RFCs. In fact I think the RFCs
> allow a server
> to issue a write delegation for a read open (not that I am convinced that is a
> good idea). The main thing to check is what the ACE in the write delegation
> reply looks like, since my understanding is that the client is expected to do
> an Access unless the ACE allows access.
> Here's a little snippet:
>      nfsace4   permissions; /* Defines users who don't
>                                need an ACCESS call as
>                                part of a delegated
>                                open. */

Yes, I had the same understanding...

>
> Now, is it a good idea to do this?
> Well, my opinion (as the outsider;-) is that the server should follow whatever
> the client requests, as far as practicable. ie. The OPEN_WANT flags:
>     const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     = 0x0000;
>     const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        = 0x0100;
>     const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       = 0x0200;
>     const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         = 0x0300;
>     const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          = 0x0400;
> If the client does not provide these (4.0 or 4.1/4.2, but no flags), then I
> suppose I might be concerned that there is a buggy client out there that
> would do what Jeff suggested (ie. assume it can open the file for reading
> after getting a write delegation).

Well, that is obviously not what the Linux client is asking for today, 
but even if it
did, what would it set in the OPEN_WANT flags for O_WRONLY open? it would
set OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG.

I do agree that there is an argument to be made that Linux nfsd should not
hand out any delegation that is not explicitly solicited by the client, 
but I don't see
how this particular delegation against a wronly open is any different 
from any
other type of delegation that Linux nfsd hands out today.

