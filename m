Return-Path: <linux-nfs+bounces-18735-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDBBJIRqhGl12wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18735-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 11:01:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596AF11EF
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 11:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E57B2300C275
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC60B38B7BF;
	Thu,  5 Feb 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKBGmEXV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA838F234
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285685; cv=none; b=f+y05IN6lrOUZcNfO64dMnZ1hpYf6c7/gqxunQc2W9mDXyzu9vqG3DAx2Pb7X/c08HUxlrBWtVnbdLEf/7s2GSbgFTeXYVhZnfcH0ZR6pyHoQeR1J4Uvxc+lWzMiZEC4NkYcHAl6DvTdw+N9C+OUSZ9pjUb5PhSyr3cjI/SLSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285685; c=relaxed/simple;
	bh=K4cy3FM/CXSzvm3SPhsATbYIYGqm2Ogq7TUj5w3++M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBBjUz1lSqAOAF0GwJBJit722c8K3LKIVJfVp9lD5lMQ00K6IbEKIxfa31EvEjNYHi/7CWOfcFqJQCzKNXcSiZoTpisG6OwG811hR7U0P/uFygWytKlqCaLjjpqaKrYxxPY7ybm4NmtMlu+f0RCJvlkVH0Dcadl+WVnEZlKd+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKBGmEXV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so580273f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 05 Feb 2026 02:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770285684; x=1770890484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wk91Xbv8qNmt7yfeObGK9VXjmHH50bJOgja/zUrERqI=;
        b=eKBGmEXVdfCEQ0nxKRtVhyr0e5MCmxkehD/4QAtgDp4QuH2gYblW7y83++0d/deGFm
         yJko/oqdWFI04//S3eUxPGi1FU9yDcJZidP5C5sau6AP0CToLMWX0qx835tE6HrJuJk/
         OitZSDgiAUOqSnn9hIEMTkD5rAluqQ7pORw5Fa0ie094Pi3My0DipmbbgnFqIN4f4WPD
         OZ+eqlZttvbx0RxA2RZEC+FBENuIeGnYsiGiPKcSbGKHo09G3xESqur+jtVn1Ill7KjC
         es7CNX7qlOym5BGSJXdUqWpK3hJxo6k9O0pe94NcrVr+jFJZ3MOPcVYv/s7F2UzNgcRb
         nltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770285684; x=1770890484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wk91Xbv8qNmt7yfeObGK9VXjmHH50bJOgja/zUrERqI=;
        b=AYJGlz7zU8nLs+s1/u57lsidkDTjJaEl6dM/JEpFG4eQdnB/hXoGtSYvUUastSVp3N
         binGeIeLoqBGAQWzhF0x4C7tCBB88WVPz2wzsP44PNRdu6QamsEqasoU2BZgmPJ5tiky
         WSuSC+sUc2kcrW0RxlUPeDAZKoBL9BoXexJdNq2zQWPPeD/Wo78HnDrpLitJB6HRdOHX
         kZUWGw9ho+eLrxeNOkA7qA3Kk4/FG8rVX4352/i0J9Btn5fYVLpClNk8gfx8gZmvR7Jr
         j3wlNgm3s0DrFhhWyHwrDa+ZzX63VbxDVfo0MeVLrwnk6x8wgevTvW24Wps+IOJfQWyP
         5ewQ==
X-Gm-Message-State: AOJu0Yz2LR8f3sUFHE4w3Ep1MG6WqPUiDvqtSgDZhmiLKVBQijikvE1+
	nEtTvCjHrzTpJD3zHAcY/sD62Aw3KHzn7XPZiq2O/WpEeP8mgm0H9mm5
X-Gm-Gg: AZuq6aJpb6oobY705pKMU0DRyFRFyXfaHxuQH1xonWKerJh12hmBnQkFToL9Z48mHCQ
	Fu7a7Ba9L5hKwVPZzjucgkTc5cVBZnkrpFIYUk0D4gJy8BBAyJ8GsWXC9CSqv0HDC4w4jCk51el
	cLLGWbtQ7JCZIUri0bp6Z8uMbCgdcN32EIV2ejZu3SeJ9JMXNA8PuFs/iHiKCKHlnVic04Y/edR
	j5nTKKlbd3bbG00vu4jo8ewfF/dYPTjXf5DGV6UI+zxdRKedApeo1VaBEeMtC3XGX4E3MDifuP4
	RmbNihpKiHV5kwIe+Z87963oVADJOoePTVoW5qky2UynvCXa/z33ATaeRL2fJnzhJmcddP9oA3b
	oGCVAwksck+B2FHRdHbBei7ORR2G7g67Eq8zXDxi+w7fJWWzSO/0ZoPPrh1CRG7XAlILujMj2H8
	qKZ0M+z/cXNAS2XvPAmM+Nv4nU9RVJe96h08NX7GuP5YQbyth3cyUG6p4ooWjBMLazeaEgPnM=
X-Received: by 2002:a05:6000:26c1:b0:436:2356:47d4 with SMTP id ffacd0b85a97d-436235649ebmr2101131f8f.39.1770285683346;
        Thu, 05 Feb 2026 02:01:23 -0800 (PST)
Received: from [192.168.0.125] (cdmjno2.plus.com. [31.125.38.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a3a9sm12486132f8f.18.2026.02.05.02.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:01:22 -0800 (PST)
Message-ID: <6944906a-9256-4f10-88fa-822a639eb5eb@gmail.com>
Date: Thu, 5 Feb 2026 10:01:21 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: report the requested maximum number of threads
 instead of number running
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204-minthreads-v1-1-7480176baf35@kernel.org>
 <2abf7a33-789f-405d-8993-8fbf30153aaa@app.fastmail.com>
 <bb9c7c2c53d5a4196ceb0ec81dcee747dd7df5e9.camel@kernel.org>
Content-Language: en-GB
From: Mike Owen <mjnowen@gmail.com>
In-Reply-To: <bb9c7c2c53d5a4196ceb0ec81dcee747dd7df5e9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18735-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[jlayton.kernel.org:query timed out];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjnowen@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5596AF11EF
X-Rspamd-Action: no action

Hi,
I currently rely on: "/proc/net/rpc/nfsd" to retrieve the current number of threads via "th": https://svennd.be/nfsd-stats-explained-procnetrpcnfsd/
After the various patches to introduce dynamic threading, where in the future, would a user retrieve the currently set min, max and actual running thread count reliably?
Would be lovely if the man page indicated this.
Thanks,
Mike

On 04/02/2026 19:13, Jeff Layton wrote:
> On Wed, 2026-02-04 at 13:51 -0500, Chuck Lever wrote:
>>
>> On Wed, Feb 4, 2026, at 12:23 PM, Jeff Layton wrote:
>>> The current netlink and /proc interfaces deviate from their traditional
>>> values when dynamic threading is enabled, and there is currently no way
>>> to know what the current setting is. This patch brings the reporting
>>> back in line with traditional behavior.
>>>
>>> Make these interfaces report the requested maximum number of threads
>>> instead of the number currently running.
>>>
>>> Fixes: d8316b837c2c ("nfsd: add controls to set the minimum number of 
>>> threads per pool")
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> I think this is less surprising than the current behavior of what's in
>>> Chuck's tree. We could also consider adding netlink attributes to report
>>> the number of running threads, but you can get that info from ps too.
>>> ---
>>>  fs/nfsd/nfsctl.c | 2 +-
>>>  fs/nfsd/nfssvc.c | 7 ++++---
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 
>>> 4d8e3c1a7be3b3a4e4f5248b27b60d6b3ae88d51..178c7646b2e25630b85de937d7ced18947c047f9 
>>> 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -1700,7 +1700,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, 
>>> struct genl_info *info)
>>>  			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
>>>
>>>  			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
>>> -					  sp->sp_nrthreads);
>>> +					  sp->sp_nrthrmax);
>>>  			if (err)
>>>  				goto err_unlock;
>>>  		}
>>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>>> index 
>>> 8184514c58de8e396795cd4714a04d66d9637f17..be0add971c2d994948c3e8fca19bcf6f3c75dfaf 
>>> 100644
>>> --- a/fs/nfsd/nfssvc.c
>>> +++ b/fs/nfsd/nfssvc.c
>>> @@ -239,12 +239,13 @@ static void nfsd_net_free(struct percpu_ref *ref)
>>>
>>>  int nfsd_nrthreads(struct net *net)
>>>  {
>>> -	int rv = 0;
>>> +	int i, rv = 0;
>>>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>
>>>  	mutex_lock(&nfsd_mutex);
>>>  	if (nn->nfsd_serv)
>>> -		rv = nn->nfsd_serv->sv_nrthreads;
>>> +		for (i = 0; i < nn->nfsd_serv->sv_nrpools; ++i)
>>> +			rv += nn->nfsd_serv->sv_pools[i].sp_nrthrmax;
>>>  	mutex_unlock(&nfsd_mutex);
>>>  	return rv;
>>>  }
>>> @@ -673,7 +674,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct 
>>> net *net)
>>>
>>>  	if (serv)
>>>  		for (i = 0; i < serv->sv_nrpools && i < n; i++)
>>> -			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
>>> +			nthreads[i] = serv->sv_pools[i].sp_nrthrmax;
>>>  	return 0;
>>>  }
>>
>> AI code review observes that:
>>
>> The documentation should be updated to reflect that these interfaces
>> now report the configured maximum threads rather than running threads:
>>
>> 1. Documentation/netlink/specs/nfsd.yaml line 168 - threads-get is
>>    documented as "get the number of running threads" but now returns
>>    the configured maximum
>> 2. fs/nfsd/nfsctl.c lines 387-405 - The write_threads() docstring
>>    says it reports "the number of running NFSD threads" but now
>>    reports the configured maximum
>> 3. fs/nfsd/nfsctl.c lines 1666-1673 - The nfsd_nl_threads_get_doit()
>>    docstring says "get the number of running threads"
>>
> 
> Ok, I'll do that for v2.
> 
> Thanks,


