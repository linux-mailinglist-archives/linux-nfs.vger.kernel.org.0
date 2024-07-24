Return-Path: <linux-nfs+bounces-5045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D929C93B8C7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 23:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F85B246A6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2F13BC11;
	Wed, 24 Jul 2024 21:43:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E263134DE
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857430; cv=none; b=HmVfrrqXLHBYbsAKC/uJ1/IvEJVziflWJtprMSzZM2ZY+oDjxeYs4sII/DI2AVN+1MT3zEsJkkS8ewNA82ixfhoruNz/0zB7VfctQ+1SkDadrnNOUsUo4Q4eGH+2N033Ht0zj0IrQLGnKwSu53Nr8mGXldWQu/No/SYHKqM4c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857430; c=relaxed/simple;
	bh=vC6ghN3xJx2xcSnTLbNLJW3d6XJO0/kQE/kV4QV7Mu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpDOX/j3sPhCS7BjZgdds+6iuIbJvvjQZ88MnL4jSWbB0QkjJOX0/k/WEEAsGUC7/U83CbpUxdDyZtbyZF3Uh3LBO+x/dtPD5u54I0gjo54TmhyXICeoHX2hXsXc1WknyKHi7B+TzYSlZNxuqdshBqri3emMozZfVpEui2jjynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d39a836ccso15962b3a.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 14:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721857427; x=1722462227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMlj1yIzgfLDqTKFtU6C7oaQingDvJM/pD1nh9XmIs4=;
        b=C421/OeP7LF8HwipJC49VkmGM1iqxTK38fNaKiZ6AfS/AzJohHZ7Y+WJ79v52JH4g4
         UNU1k7eOK12+hhXBUO82h1Q7IoKuvS+leBloFvsOSfmnHvtVYBvjPZjrfzvP/uXzXoOs
         m7AKT/0o3OQ+vHlgOhqJBxhcVdhPi+j4wqMWBlw+eCcX6pFnbVh+NS82Gjm4ol+aR0VJ
         cKJrgF0XQB11EXS6QsUv/V3ANMuPqP0Z+CVGadaqakP/WgEWOOGVCzNE6Pzxpky7DYsC
         DEbAPw3Hrqmw1kqn/fG4cvby814Jn8Egy/GZ2MVZWMohTcPyi0sD56P74hcQgCNZmnLA
         LoPA==
X-Forwarded-Encrypted: i=1; AJvYcCVKjG1ZlawoHu+P/QuUPeZxtqZ4Lni+QfqTvko0M8VFsMigkUnA2tba0UqfQiuJqGALXNW8I34On9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhQwQaC8orC6ti0RFPR3D0ozBJVTEKhX9kW465cGVQjVZCUN2
	vCu2e3CUvYuJ9kfmIzymQYjz6puW1eD3HhiAR7RB7JVljHb8TY/SMxOPwQ==
X-Google-Smtp-Source: AGHT+IGNaYya+l6zIFakmIZMe8i0HVcOC0OgwSKMrKXJmNNnJeZBRjzwab4qpMFL55OY8ffvVnnzog==
X-Received: by 2002:a05:6a00:1783:b0:70b:705f:8c5e with SMTP id d2e1a72fcca58-70eacb3b1a1mr282958b3a.5.1721857427477;
        Wed, 24 Jul 2024 14:43:47 -0700 (PDT)
Received: from [10.113.157.61] ([216.228.113.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874ae3sm27867b3a.161.2024.07.24.14.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 14:43:46 -0700 (PDT)
Message-ID: <cf9e9f1c-6e54-4982-a82e-9208a3979989@grimberg.me>
Date: Wed, 24 Jul 2024 14:43:45 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when preprocessing
 the stateid
To: Olga Kornievskaia <aglo@umich.edu>, Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <ZqE0kTRdRAibsjm7@tissot.1015granger.net>
 <CAN-5tyGAm3LYqTaJvu=w32UEdRPhOCAMtdhnK0e0KacYzTw7Uw@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAN-5tyGAm3LYqTaJvu=w32UEdRPhOCAMtdhnK0e0KacYzTw7Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 24/07/2024 22:12, Olga Kornievskaia wrote:
> On Wed, Jul 24, 2024 at 1:06 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> Adding Olga for her review and comments.
>>
>> On Wed, Jul 24, 2024 at 10:01:37AM -0700, Sagi Grimberg wrote:
>>> Move the stateid handling to nfsd4_copy_notify, if nfs4_preprocess_stateid_op
>>> did not produce an output stateid, error out.
>>>
>>> Copy notify specifically does not permit the use of special stateids,
>>> so enforce that outside generic stateid pre-processing.
> I dont see how this patch is accomplishing this. As far as I can tell
> (just by looking at the code without actually testing it) instead it
> does exactly the opposite.

I haven't tested this either, does pynfs have a test for it?

>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   fs/nfsd/nfs4proc.c  | 4 +++-
>>>   fs/nfsd/nfs4state.c | 6 +-----
>>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 46bd20fe5c0f..7b70309ad8fb 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>        struct nfsd4_copy_notify *cn = &u->copy_notify;
>>>        __be32 status;
>>>        struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>>> -     struct nfs4_stid *stid;
>>> +     struct nfs4_stid *stid = NULL;
>>>        struct nfs4_cpntf_state *cps;
>>>        struct nfs4_client *clp = cstate->clp;
>>>
>>> @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>>                                        &stid);
>>>        if (status)
>>>                return status;
>>> +     if (!stid)
>>> +             return nfserr_bad_stateid;
>>>
>>>        cn->cpn_lease_time.tv_sec = nn->nfsd4_lease;
>>>        cn->cpn_lease_time.tv_nsec = 0;
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index 69d576b19eb6..dc61a8adfcd4 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>>>                *nfp = NULL;
>>>
>>>        if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
>>> -             if (cstid)
>>> -                     status = nfserr_bad_stateid;
>>> -             else
>>> -                     status = check_special_stateids(net, fhp, stateid,
>>> -                                                                     flags);
> This code was put in by Bruce in commit ("nfsd: fix crash on
> COPY_NOTIFY with special stateid"). Its intentions were to make sure
> that IF COPY_NOTFY was sent with a special state it, then the server
> would produce an error (in this case bad_stateid). Only from
> copy_notify do we call nfs4_preproces_stateid_op() with a non-null
> cstid. This above logic is needed here as far as I can tell.

So the purpose was now special stateids will not generate an output
stateid, which COPY_NOTIFY now checks, and fails locally in this case.

Maybe I'm missing something, but my assumption is that if a client
sends a COPY_NOTIFY with a special stateid, it will still error out with
bad stateid (due to the change in nfsd4_copy_notify...

