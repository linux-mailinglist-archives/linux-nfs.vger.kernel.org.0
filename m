Return-Path: <linux-nfs+bounces-4704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E25929C21
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 08:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7398B1C21454
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651E12E75;
	Mon,  8 Jul 2024 06:23:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58535125DE
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jul 2024 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419817; cv=none; b=F6FeR6xzneXd+ItrF8BZ5qlqcp2noqeCOcY+PVh5ljwKgTZrBeO85PvvpMXnOCRC4WL1wR691B3L75rT2RTthg4klfmP+XeVWMFpLUmAIqzpmbywpmJtPpXtdaANnrPDgVFbEK623qp1T3tveKe5dWsYpPZCdVj+t3d27npXzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419817; c=relaxed/simple;
	bh=orRHPyHqkO7de1P6G5WaHNU195IXg9JT2/XQgz5h5Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJXvN2d6ZDjZ8c9t3ZdBKaUGFTxS0bvQe63nAFjg1L1Eey0bKctYqGPNten7GV3MqB1t7DUzc87aj/vOaMuqXH3zHa15JCP2KyYqEhcYmrkk1PzMrqQkx49xHdZdImtEkFOUkYBi6gpdd99BtdafuizykH72Fh5mQLe8TGFDuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e98c72d2bso348027e87.0
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jul 2024 23:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419813; x=1721024613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3T+HZXsdRZhd+qzsbHa7mJeJMMqOvGwgge/A5xNwgjM=;
        b=PPjV5Iv0796rAgWcNATH6IR2WSPmjHRJTq1HlUvyFXQnaHPdIXtsa/KJ9Ub75PhqSn
         nvsABQVrz7scYZQ5rX7WTn+wjQDRmEWGlSXjAo/8tDRDlHJAhNTc9BAobuPeUSJ1AirT
         sq4y9AYvwVmNSOqvRtSdrlrr/xW+PDWZI9t4CaV4ZhKoj8OAOS35ZbSwHV+riIx4mQFW
         vogz3x86UhS91lev55pjOXlX4LbYhh6wuH38bbwaELse/YVmz8gR1glFEIZsq3u/wyBn
         Abw7aGSvq+xaP5gWyi8WiVLKDG2DLGRQ9ULKuSsfNAQF29PHe7cCnPSqILGsNB0OzZ11
         TE4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJvaA0pZgr3TmTHdhyox0Gm/AR+ZQ6MTgmnCyYFikHXgiP/yfXhJ3InoynyEHEjo3uutcpARWUjfTJAd8eXZiayla/sqpRqpc4
X-Gm-Message-State: AOJu0Yye+iJUqBho0b7xfWOzkkMKw9zSeD8z9YuOE+CUjYE9wW3gcism
	yiZxYhekFJihUCZAwtnV5UvOIEgou2xg/IcfRG+7tJAXkSH+H/+s
X-Google-Smtp-Source: AGHT+IGHejerc/KYFtmtQ2LQWSb+T4shocROlPU+e/T1ZUSgAxwUqYwhfXIC8lQKUddBViu3VuC8QQ==
X-Received: by 2002:a2e:9848:0:b0:2ec:4ed6:f4a with SMTP id 38308e7fff4ca-2ee8ee13dbfmr67225451fa.5.1720419813180;
        Sun, 07 Jul 2024 23:23:33 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d50f5sm150262045e9.9.2024.07.07.23.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 23:23:32 -0700 (PDT)
Message-ID: <f490f4dc-5a90-4f1c-a585-b50eac62da70@grimberg.me>
Date: Mon, 8 Jul 2024 09:23:31 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
 <bdae2f17-7fca-484e-ae46-b822df9f3576@grimberg.me>
 <CAM5tNy7XLxrLMchDTA+AZJkYUGw41FQpajVN6s2f7Z6qnFjkmg@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAM5tNy7XLxrLMchDTA+AZJkYUGw41FQpajVN6s2f7Z6qnFjkmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/07/2024 0:49, Rick Macklem wrote:
> On Sun, Jul 7, 2024 at 1:21 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>> On 07/07/2024 22:05, Rick Macklem wrote:
>>> On Sun, Jul 7, 2024 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
>>>>> Many applications open files with O_WRONLY, fully intending to write
>>>>> into the opened file. There is no reason why these applications should
>>>>> not enjoy a write delegation handed to them.
>>>>>
>>>>> Cc: Dai Ngo <dai.ngo@oracle.com>
>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>> ---
>>>>> Note: I couldn't find any reason to why the initial implementation chose
>>>>> to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seemed
>>>>> like an oversight to me. So I figured why not just send it out and see who
>>>>> objects...
>>>>>
>>>>>    fs/nfsd/nfs4state.c | 10 +++++-----
>>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index a20c2c9d7d45..69d576b19eb6 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>>          *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>>>          *   on its own, all opens."
>>>>>          *
>>>>> -      * Furthermore the client can use a write delegation for most READ
>>>>> -      * operations as well, so we require a O_RDWR file here.
>>>>> -      *
>>>>> -      * Offer a write delegation in the case of a BOTH open, and ensure
>>>>> -      * we get the O_RDWR descriptor.
>>>>> +      * Offer a write delegation in the case of a BOTH open (ensure
>>>>> +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
>>>>>          */
>>>>>         if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>>>>                 nf = find_rw_file(fp);
>>>>>                 dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>> +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>> +             nf = find_writeable_file(fp);
>>>>> +             dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>         }
>>>>>
>>>>>         /*
>>>> I *think* the main reason we limited this before is because a write
>>>> delegation is really a read/write delegation. There is no such thing as
>>>> a write-only delegation.
>>>>
>>>> Suppose the user is prevented from doing reads against the inode (by
>>>> permission bits or ACLs). The server gives out a WRITE delegation on a
>>>> O_WRONLY open. Will the client allow cached opens for read regardless
>>>> of the server's permissions? Or, does it know to check vs. the server
>>>> if the client tries to do an open for read in this situation?
>>> I was curious and tried a simple test yesterday, using the FreeBSD server
>>> configured to issue a write delegation for a write-only open.
>>> The test simply opened write-only first and then read-only, for a file
>>> with mode 222. It worked as expected for both the Linux and FreeBSD
>>> clients (ie. returned a failure for the read-only open).
>>> I've attached the packet capture for the Linux client, in case you are
>>> interested.
>> Nice, thanks for testing!
>>
>>> I do believe this is allowed by the RFCs. In fact I think the RFCs
>>> allow a server
>>> to issue a write delegation for a read open (not that I am convinced that is a
>>> good idea). The main thing to check is what the ACE in the write delegation
>>> reply looks like, since my understanding is that the client is expected to do
>>> an Access unless the ACE allows access.
>>> Here's a little snippet:
>>>       nfsace4   permissions; /* Defines users who don't
>>>                                 need an ACCESS call as
>>>                                 part of a delegated
>>>                                 open. */
>> Yes, I had the same understanding...
>>
>>> Now, is it a good idea to do this?
>>> Well, my opinion (as the outsider;-) is that the server should follow whatever
>>> the client requests, as far as practicable. ie. The OPEN_WANT flags:
>>>      const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     = 0x0000;
>>>      const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        = 0x0100;
>>>      const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       = 0x0200;
>>>      const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         = 0x0300;
>>>      const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          = 0x0400;
>>> If the client does not provide these (4.0 or 4.1/4.2, but no flags), then I
>>> suppose I might be concerned that there is a buggy client out there that
>>> would do what Jeff suggested (ie. assume it can open the file for reading
>>> after getting a write delegation).
>> Well, that is obviously not what the Linux client is asking for today,
>> but even if it
>> did, what would it set in the OPEN_WANT flags for O_WRONLY open? it would
>> set OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG.
> I didn't think to mention that the client was a rather old 6.3 kernel.
> If the Linux client is still not setting OPEN4_SHARE_ACCESS_WANT_xxx
> flags, then maybe it should do so?

To me, it seems simple enough to make it set the want flags, but I don't
have any context to why it wasn't done up until now...

Perhaps Trond and/or Anna can chime in.

