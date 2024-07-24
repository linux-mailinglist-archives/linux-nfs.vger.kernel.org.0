Return-Path: <linux-nfs+bounces-5046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF2793B8C9
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 23:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7771F21490
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484B913A41D;
	Wed, 24 Jul 2024 21:47:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A5C6FC2
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857634; cv=none; b=N3Ui0Dmc30Gl15jVZftaL8AiI4dqDognTEEewsBzDwFhCunp23JsS5tTU+6yrW45s95EsRMXs8PTZvXVmN7tIEQ9l/cLQpVpnmKSlytfM5Zygjfe+Cmp/3OrPEK7rYjccfiKqBsf0lP4BpUmslrNaTcEY7j7aNIEFNXt53cenAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857634; c=relaxed/simple;
	bh=Gwr2amEqaf+oMUyU2EHijzLCqkfcNOb+doYzUuT6qrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4C/Zdygt6EVgGDqgna2hc9TG9L3m9lXwYECnfbMgKqwXBGn0DTjELPDlRH2aE0ZmZiMsaGZTlmP9LIyP7d6+h1h9+UvG1YmkMj+mVNuerLMvDo+CQXYPWkUO916bNAGSp0cwwjROvloDZpZf53k1x89nzSGY/gtuDHIZQYL4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb5eafd585so28518a91.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 14:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721857632; x=1722462432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcXWkb3pmt3Tyj91igh7I9jaBi5NSVDgR7ogBF29S58=;
        b=k3Dd44HInaielNCl6ft8EX/na2mvuqxZd+REhZsQNklKJLiNYR0+7WNluDjvS99wQv
         CeC/LjsT4wH39eu2RcDKivan2kKbo1sWLfPrepNQv8cGp7Ia9i+isbd1q+xuJLLAZm3F
         2exzKyvuZvW2/pHXhEJVCJq7Mhw5rt2Gzg/wXJXoR5mdZHh2Cd5ki/GyxhLQHgVH2Cob
         FuCuapUl4whQIRIStgAdZjeQWdxU4dm3KSa5110AK5qz0bzTFcSh5CYyAiPNmvCrxnar
         3RwJTGwrr5p9hghtfZXed2Rrysiw2zPIG48/sg/XFwkd2Yhduq3x5gEIxCqQpnTZzkbY
         ngzg==
X-Forwarded-Encrypted: i=1; AJvYcCU54P0aMt5Kx1PHI+Akoh7jwg3wc87sEX8fNDJNWT7t4fTogeNF2D/RPxY16jUaQsQI10Rg4G+2QBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eVEDRU5buduYDi+dkehkkjL4tRSSyacaiuRBoFJeNv3BXNJy
	+iCSid48wpnWpQ0BHZDM6g1N/Z0hVNqNrHtbhpjF4ZcXT0CsAR4/
X-Google-Smtp-Source: AGHT+IFlCDWh3h/f1ZomJYgIQu9rfhFe+7V8igvB/Z/Owf8BhUGGhHhLLGpNoRdsfbvJYB4jvJXQKA==
X-Received: by 2002:a17:902:934c:b0:1fa:ab25:f634 with SMTP id d9443c01a7336-1fed6bf9dd5mr2988495ad.3.1721857631979;
        Wed, 24 Jul 2024 14:47:11 -0700 (PDT)
Received: from [10.113.157.61] ([216.228.113.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cd8cfb85c0sm4321541a91.0.2024.07.24.14.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 14:47:11 -0700 (PDT)
Message-ID: <683439e6-3251-4ffa-bac1-21343e05db4e@grimberg.me>
Date: Wed, 24 Jul 2024 14:47:10 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <CAN-5tyF4fjD4sGDx7CTnYWuCcOLsX3dSQpiPyLNNQAM1Hd5TJg@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAN-5tyF4fjD4sGDx7CTnYWuCcOLsX3dSQpiPyLNNQAM1Hd5TJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 24/07/2024 22:29, Olga Kornievskaia wrote:
> On Wed, Jul 24, 2024 at 1:01 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
>> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
>> Stateid and Locking.
>>
>> In addition, for anonymous stateids, check for pending delegations by
>> the filehandle and client_id, and if a conflict found, recall the delegation
>> before allowing the read to take place.
>>
>> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>>   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  9 +++++++++
>>   fs/nfsd/state.h     |  2 ++
>>   fs/nfsd/xdr4.h      |  2 ++
>>   5 files changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 7b70309ad8fb..324984ec70c6 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>          /* check stateid */
>>          status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>                                          &read->rd_stateid, RD_STATE,
>> -                                       &read->rd_nf, NULL);
>> -
>> +                                       &read->rd_nf, &read->rd_wd_stid);
> Now I can see that this patch wants to leverage the "returned stateid
> of the nfs4_preprocess_stateid_op() but the logic in the previous
> patch was in the way because it distinguished the copy_notify by the
> non-null passed in stateid. So I would suggest that in order to not
> break the copy_notify and help with this functionality something else
> is sent into nfs4_proprocess_staetid_op() to allow for the stateid to
> be passed and then distinguish between copy_notify and read.

My thinking is that instead having the generic stateid pre-processing
be aware which proc may accept a special stateid and which may not,
we'd want to have the call-sites enforce that...

But I am not the expert here, and will be happy to change based on
your preference...

