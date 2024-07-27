Return-Path: <linux-nfs+bounces-5097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709593E0B9
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 21:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E55F1F2149E
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263A45026;
	Sat, 27 Jul 2024 19:33:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F6376F5
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722108805; cv=none; b=NlHIUB9zTcyn95nEZIy6sToztMeU9LIYwFN+dm5XcmVJX39YY701HnvvHgabH7oC0V50Di5DjCvj0sgr8Ng7cdRXOZa5hc7Cdgcgj9cHhew9gOsCD6bQUxFGVvIwANTlQw79NX6F6h1KwRugKM39atXnGg/SCzp+sL4+h4qoWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722108805; c=relaxed/simple;
	bh=bPZybTwZkeLaReqizLNwRmcZkbpTqA0C67gSNwGVHRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMAIq57V5NF9J6Sq31Gql2UCV3yWRKfZwJu179omHnisKIrp/VYuTO8/ylkDb0IKpsnXRYs/VE9lrrQT1WIw8GJGFgDwMG53ZjbXsK2oIvo1F0jl7E18hU/Rz+UfO76Vamz4yDHhmML7bgnVOxZkM+/TpxwgdKGehZYzr8pZhiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280921baa2so763645e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 12:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108802; x=1722713602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wG0eIqfwKdIvNuk5fkpFXvtaRVxGWesyJvy3I/OkVx8=;
        b=LX06fpELusMuTeHmC584KvwIyv9Fa5rORx2qU7V6ti9LN9dXVkrDx9cnBTrK0fcA/D
         24Ldpg6S5Tr4N7MDHmQ7D4ATpUdsZabcIZQ0SZb0X2ad419uehjGtwI2pzCz2B20Dk74
         3BZ4M6AF3n4NT37FCnht462iAXCVTXzFrZT1m4ZKfCFVk+V1vfxsmOmMp+qtmmSUVvGj
         wvK3b/X9IjtbgIl/XsYQKpGwVYbfMTamG/URL1kJq4TZjYXhRF8jdbt4AbuGDZgyEV3q
         MxPDA0bjGw7PIPOtwPcCMwdU5tN87/spNsDlVWITDfTqmtnRyATDT7pwPmnQYVCcPaQR
         Laww==
X-Forwarded-Encrypted: i=1; AJvYcCWoR3jse/RFQVybPL/oCnLJNiMPN1LqM3byMSFZumCBLK66W0K/Ztd4GbrOn41hBqa+hpmnx34hGwq/s9uV2JrEvxgL2xHp9Yv/
X-Gm-Message-State: AOJu0Yxlt9mWYXW/8Pt3BThmsBSXaSy+itGb+sixU+jdDAZc6sH0wsLu
	k33/ZwW9OHi1XInmcauZ64vFwd3YRIWabN4dHGUkWO8tJi4RCNG1txEZQA==
X-Google-Smtp-Source: AGHT+IEjNLdfOgk9egb0OG5IZp4EVz890Kb+GSzNg/pUJ0ub8/8m+QC7aakDplzq2Pd1Rk8coBkL4A==
X-Received: by 2002:a05:600c:19c7:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-4280576b7famr41804215e9.5.1722108802088;
        Sat, 27 Jul 2024 12:33:22 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730d5bsm127435905e9.8.2024.07.27.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:33:21 -0700 (PDT)
Message-ID: <ed10be52-2853-4cf3-8a8f-7adbc6dd865a@grimberg.me>
Date: Sat, 27 Jul 2024 22:33:20 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <df15b4f4-e325-4ed0-bc94-957113a64915@oracle.com>
 <ZqUl0EyyJYJhsItg@tissot.1015granger.net>
 <c1463e37-ae0e-47d8-93d6-9787ff35c989@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c1463e37-ae0e-47d8-93d6-9787ff35c989@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>> id(cstate, &u->write.wr_stateid);
>>>>    }
>>>> +/**
>>>> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
>>>> + * @rqstp: RPC transaction context
>>>> + * @clp: nfs client
>>>> + * @fhp: nfs file handle
>>>> + * @inode: file to be checked for a conflict
>>>> + * @modified: return true if file was modified
>>>> + * @size: new size of file if modified is true
>>>> + *
>>>> + * This function is called when there is a conflict between a write
>>>> + * delegation and a read that is using a special stateid where the
>>>> + * we cannot derive the client stateid exsistence. The server
>>>> + * must recall a conflicting delegation before allowing the read
>>>> + * to continue.
>>>> + *
>>>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>>>> + * code is returned.
>>>> + */
>>>> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>>>> +        struct nfs4_client *clp, struct svc_fh *fhp)
>>>> +{
>>>> +    struct nfs4_file *fp;
>>>> +    __be32 status = 0;
>>>> +
>>>> +    fp = nfsd4_file_hash_lookup(fhp);
>>>> +    if (!fp)
>>>> +        return nfs_ok;
>>>> +
>>>> +    spin_lock(&state_lock);
>>>> +    spin_lock(&fp->fi_lock);
>>>> +    if (!list_empty(&fp->fi_delegations) &&
>>>> +        !nfs4_delegation_exists(clp, fp)) {
>>>> +        /* conflict, recall deleg */
>>> I don't see how we can have a delegation conflict here. If a client
>>> has a write delegation then there should not be any delegations from
>>> other clients.
>> A delegation conflict is possible if the client is using an
>> anonymous stateid to perform the READ.
>
> Then we should not detect any delegation conflict from this
> function.

Can you explain why?

If the client sent a raed with anon stateid, this function checks the 
pending
delegations (fi_delegations), and not from the same client 
(!nfs4_delegation_exists),
then it should detect a conflict.

>
>>
>> One thing we could perhaps do is add support for the use of
>> anonymous stateids as a separate patch.
>
> This would be a separate issue from allowing write delegation
> stateid to read. This would be to detect the scenario where a
> client using special stateid to read while another client has
> a write delegation on the file.

As mentioned, I can separate it, but this would make this patch
break a pynfs test.

