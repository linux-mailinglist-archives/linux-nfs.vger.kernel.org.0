Return-Path: <linux-nfs+bounces-5239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3463B948243
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 21:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660681C20AFB
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344415B147;
	Mon,  5 Aug 2024 19:24:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C3364AB
	for <linux-nfs@vger.kernel.org>; Mon,  5 Aug 2024 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885899; cv=none; b=ObE3AVvswItHoRmP69CVm2joBfok6JqdbxTNaTvX6QHZkardXpluOTIWsq+90AyU73zaykyxMQeyF5kMr3vLSnkvoBmgHpMM3F7RyQbfJcD5nVNHKNWVhgjQ21L/OpSYDgr9tZsdtYEoEQnX+ZrESoYMlM/vanXlWhackNS07Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885899; c=relaxed/simple;
	bh=6Q4LPTYlXj2jdqmZ1SaCW4NNNog8qg2JSrVP1KBASnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BRS1c7Oxpjr/YLwkga/x2pjNqEuyf2VEYMbjhrmDgeBBavU0B1F6ezw/C4s+r1dN+5/d1H0ik5AfIbJsWTji4oyq196tM+fOlxoHp+MJxzOToZZQuZniVTa11+tphrVlo3ayAq1kxhibTC/98Mb/5N02ZtD/bqUTUnVtVUH2XFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36830a54b34so839247f8f.0
        for <linux-nfs@vger.kernel.org>; Mon, 05 Aug 2024 12:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722885896; x=1723490696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9MwDLgoNu4LXZIciKWBF6aAsZeAYC6tbeEFPBDoaR8=;
        b=XXqZNNTGNKJUMB4nWiGPby1hxVfhXhfs1jLNAEye2ZjtVc3iKcLftsRILT4CGRz2Mz
         dFMQF2x7GAbfpi6///EfTI5qtGVOemi98/+8MHXeN9vBW7OLawfA+nmIeczmKPpkQ8NT
         cNT/y8NZqa0TT9sEBAIoWUO57ixhwWffMFSXte0ccbOG8bwPFKw6iRn5yVnmuFFuv1d+
         N+BoWehxjSh/twWIJ34tnBQBpkW0HD9EJZ/CDJiOsv6Ti2t2gx6V+YMVQRCVpU7vfBvd
         /TkbywllvqW3n/hVYbrx6FHQWQco1N+LOTrZzV6H1nGHeE6jfv+JxIRQ3yMr0NUYAZt5
         Ea8g==
X-Forwarded-Encrypted: i=1; AJvYcCV1g0WJIhOyQEi2hEqloYVHtIMRBcr6zfbkTku7DbTf6bVCYe09pWapDk/d/GG4lppvVzj2orQVCA212nOLn61KznoLpZkbFBGc
X-Gm-Message-State: AOJu0YxxULS5+c/P4tdpjb5pFKKiO8SNFULYz2Fec/x5zK7davGCMLXx
	S544Bh5M0OhBzFjKOr4Y8q7Kzcw4quC0wksreVBokXlyUkoEjLwp
X-Google-Smtp-Source: AGHT+IG0N8ummiR4C4JZMD0VYDygUNKc4HJ4Hh6IapF5zvL5u1xguHV5B5prFAomWCnTAQ/IdKbJlw==
X-Received: by 2002:a05:600c:3b92:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-428e6af8117mr59063025e9.2.1722885895488;
        Mon, 05 Aug 2024 12:24:55 -0700 (PDT)
Received: from [10.100.102.74] (CBL217-132-143-121.bb.netvision.net.il. [217.132.143.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7d57asm151593195e9.33.2024.08.05.12.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:24:54 -0700 (PDT)
Message-ID: <888d4896-5936-44cd-8bc2-3bc683c0128e@grimberg.me>
Date: Mon, 5 Aug 2024 22:24:53 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about NFS client locks and delegations
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <6378987a-e289-4173-9f09-093ba50ee75f@grimberg.me>
 <740027864c432cfda867145110b8c5f43d7b0ec4.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <740027864c432cfda867145110b8c5f43d7b0ec4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 05/08/2024 15:39, Jeff Layton wrote:
> On Mon, 2024-08-05 at 12:46 +0300, Sagi Grimberg wrote:
>> Hey,
>>
>> I'm looking at the NFS client locking code, and it seems to me that it
>> violates the spec
>> by caching locks when holding a read delegation.
>>
>>   From 18.10.4.  IMPLEMENTATION
>> --
>>      When a client holds an OPEN_DELEGATE_WRITE delegation, the client
>>      holding that delegation is assured that there are no opens by other
>>      clients.  Thus, there can be no conflicting LOCK operations from such
>>      clients.  Therefore, the client may be handling locking requests
>>      locally, without doing LOCK operations on the server.  If it does
>>      that, it must be prepared to update the lock status on the server, by
>>      sending appropriate LOCK and LOCKU operations before returning the
>>      delegation.
>>
>>      When one or more clients hold OPEN_DELEGATE_READ delegations, any
>>      LOCK operation where the server is implementing mandatory locking
>>      semantics MUST result in the recall of all such delegations. The
>>      LOCK operation may not be granted until all such delegations are
>>      returned or revoked.  Except where this happens very quickly, one or
>>      more NFS4ERR_DELAY errors will be returned to requests made while the
>>      delegation remains outstanding.
>> --
>>
>> I don't see how the second paragraph can be met if the client caches locks.
>> I've added a set of changes to address this [1] (untested, its designed
>> to illustrate the point).
>>
>> Any thoughts on this?
>>
> I don't think this is a bug.
>
> First, we only implement advisory locking in the client. The server may
> enforce mandatory locking, but it's up to the server to mediate that
> properly by recalling delegations at the right time. The client only
> cares that it got a delegation when it comes to locking.
>
> Only one client can hold a write delegation, so the real question is
> this: can two clients caching locks under read delegations set locks
> that conflict with one another?
>
> The answer is no. The protocol does not allow you to set write locks on
> SHARE_ACCESS_READ stateids. In the case where we open SHARE_ACCESS_BOTH
> and get back a read delegation, we _know_ that nothing else can hold a
> read delegation on the file and be caching locks because we have the
> file open for write.

Ah, this last part is the subtle part I was missing. Meaning that no 2 
clients
can hold a read delegation and SHARE_ACCESS_WRITE/SHARE_ACCESS_BOTH opens
at the same time. I revisited the spec and it reinforces this in section 
18.16.4 and
the text reinforces this. IIRC it differs from SMB where leases are 
recalled only
when a WRITE comes along that is considered a conflict, not the 
initially at OPEN time.

A code comment would have been useful here...

Thanks for the explanation Jeff!

