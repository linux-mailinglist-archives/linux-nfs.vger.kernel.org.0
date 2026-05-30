Return-Path: <linux-nfs+bounces-22119-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOBKDa1dG2puBgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22119-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:59:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FEE613827
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 23:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22F783014756
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 21:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51BF35DA64;
	Sat, 30 May 2026 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1tS3wm+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3E26299
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780178346; cv=none; b=mzq+zMb4LxT+WEcMHF4lF8AWonFzDX00NbGeW5+Qr7FNBU57hFmjgZjByFW+tFQVFs8+SSVPWOnJ2hisC+W4znzS4bRR84hs05F9K88aZbwfCRzekxxG/BBoGXE/7SOSgbObCFqJILgFE7PXZJLMEYGrk4rulG5YQS3kk+Kdexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780178346; c=relaxed/simple;
	bh=KpWcVWuHeYdSW9PmYkRHoUU3SHc1k5K09KC7xKeuETY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcUFeY/dxyH5POXSW2BKSbbznOF1b/+sPWUkMfBOOw50Ib6mai96+hHZr8TQIsIamVrBZ2xRFgysgiJzPG22qV9LMazVwTD5kGn8cYb29JHsZKRvqYExntHXaVy1qoQxMNz09icvuo/vpXeXFu6a6nZVR59LyBN090PvpzDYQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1tS3wm+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61271F00893;
	Sat, 30 May 2026 21:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780178345;
	bh=ZJNuUU5LqYfgY5Fc6y4ahsiUMtbTuaRiTxFiol1qTiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D1tS3wm+6ThGRMV80qqvI4nGU+rT5TckxFkx//1XP+A0mWNLto6rr/l3g7kwC1+cz
	 FuYqs1wexkqpNq89/W+7KnDCjYGEY0lX/OIAhj0EBEIoo9RlpqZp1J6fq2ijj/tAer
	 Y5qvO5bx/zhNn5+Di4mRdMTXuUkobtd6B3NlmuV5my+uZO8DdzVTBoLIRrgu1atDmx
	 VgxUm6W/N4GoOurSATwVM+TA7xEwjvETSHpNTUcWWzmfm0wGiufqfkky3f2bXfB6MX
	 vuxdDL8QIWgiPZxFThjACPNdCorlNIfdB7l8JPoaXcqp46cSv73+6H2DfKRZCpR/M2
	 7l9KHWZXh9a5A==
Message-ID: <fe9ad070-18fe-43d1-95d1-34420f266efb@kernel.org>
Date: Sat, 30 May 2026 17:59:03 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] SUNRPC: Check svc pool percpu counter allocation
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
 <20260530-tier2-local-v1-2-fc294d34848a@oracle.com>
 <0b0a969d8c8dd4769faf8ea2f0589e5af5a9a0a3.camel@kernel.org>
 <36d0e0ea5f69e600267d9adad085f1fb5d2f6fd9.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <36d0e0ea5f69e600267d9adad085f1fb5d2f6fd9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22119-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C5FEE613827
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/30/26 5:48 PM, Jeff Layton wrote:
> On Sat, 2026-05-30 at 17:45 -0400, Jeff Layton wrote:
>> On Sat, 2026-05-30 at 16:21 -0400, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> __svc_create() initializes three per-pool percpu_counter stats and
>>> ignores every return value. On SMP, percpu_counter_init() fails when
>>> __alloc_percpu_gfp() cannot satisfy the allocation, leaving the failed
>>> counter with fbc->counters == NULL and its embedded raw_spinlock_t,
>>> list_head, and count never initialized. __svc_create() returns the
>>> half-constructed svc_serv to nfsd, lockd, or the NFS callback service
>>> anyway.
>>>
>>> Once that service is live, the hot-path increments in
>>> svc_xprt_enqueue(), svc_handle_xprt(), and
>>> svc_pool_wake_idle_thread() reach a counter whose backing pointer is
>>> NULL. The pointer is a per-cpu offset, so the access does not fault:
>>> it resolves to offset zero of the current CPU's per-cpu area and
>>> silently corrupts whatever variable lives there. A
>>> /proc/fs/nfsd/pool_stats read walks the same NULL per-cpu storage and
>>> returns garbage, and on CONFIG_DEBUG_SPINLOCK or lockdep it splats on
>>> the never-initialized lock.
>>>
>>> Creating the broken service requires a percpu allocation failure during
>>> RPC server startup, so it is reachable only by a local administrator
>>> under memory pressure or fault injection; a remote peer cannot induce
>>> the bad state on its own.
>>>
>>> Initialize the three adjacent pool counters with one checked
>>> percpu_counter_init_many() call and fail __svc_create() when the
>>> allocation fails, unwinding the counters for pools already set up. Use
>>> the matching percpu_counter_destroy_many() at teardown so the single
>>> per-cpu allocation is freed exactly once.
>>>
>>> Fixes: ccf08bed6e7a ("SUNRPC: Replace pool stats with per-CPU variables")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  net/sunrpc/svc.c | 32 ++++++++++++++++++++++++++------
>>>  1 file changed, 26 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>> index ae9ec4bf34f7..aeb6e631848c 100644
>>> --- a/net/sunrpc/svc.c
>>> +++ b/net/sunrpc/svc.c
>>> @@ -476,6 +476,22 @@ __svc_init_bc(struct svc_serv *serv)
>>>  }
>>>  #endif
>>>  
>>> +enum {
>>> +	SVC_POOL_COUNTERS = 3,
>>> +};
>>> +
>>> +static int svc_pool_init_counters(struct svc_pool *pool)
>>> +{
>>> +	return percpu_counter_init_many(&pool->sp_messages_arrived, 0,
>>> +					GFP_KERNEL, SVC_POOL_COUNTERS);
>>> +}
>>>
>>>
>>
>> Switching to this looks like a good thing, but it means that the
>> svc_pool struct fields now have some strict ordering requirements. The
>> percpu_counters all need to be snuggled up together.
>>
>> That deserves a comment to that effect in the struct svc_pool, so that
>> we don't inadvertently break it later.
>>
> 
> Actually, sashiko points out that struct randomization could break here
> too. Given that service creation isn't a hot codepath, I'd keep these
> as discrete percpu_counter_init/destroy() calls and avoid the hassle.
Yeah. It's too clever by half.


-- 
Chuck Lever

