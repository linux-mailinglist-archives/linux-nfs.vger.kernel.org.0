Return-Path: <linux-nfs+bounces-22078-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBNrJJTIGWpXzAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22078-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:10:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D046062BA
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C7435B1C69
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3333D509;
	Fri, 29 May 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFE6IoO8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11A283FDC;
	Fri, 29 May 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070712; cv=none; b=JJm3dShFA4ML+Nfv6GBlqzUJNClDoFiKqFVodvldgqxbi3Tp6lSETUpFCJopHQnhlVcMwdwx9YSHLn1BWm7bpAA+Fu7A56NAlujDHFdH0I8z+wsvekzpmVx0kSCCbOpoqotSooUUj3RjfZrwjkBEKq7nx4Aj5AW2WlFs2BV9VoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070712; c=relaxed/simple;
	bh=go/O26jSK+55BXNe8Mbksu4VOiqI+cqaiVz/B6htdVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN/V2rbFVnOmpnf07YugXluTL34vvHV6X0eBzbD+4nodSvYfbEVCcIO9uk6QRPsyMZhp2RcUTcZQPLYZKLMjpIVNs286ZOgxjRv1gP1VTDCCvq4puWOqE/WMEZfauPvQyOTYVCboRFWRxqASiLOOEm2D4cB8DLQTb4Zdhcr1oC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFE6IoO8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021481F00893;
	Fri, 29 May 2026 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070711;
	bh=N3fnnX7VE9PwhBi0D6DVowo2N8Sz/N5+UcweBLjWKgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VFE6IoO8nqYZZS+vP+OgRIAvXWwEDcBW5aIx7IAlcq4O3b6WjRFAgLEjyYi89XlKf
	 3ylr1DTJxO9UYwYbHvEOYNwacBJ1BWbC5VWZcASswdUNNPW39KYvyRmrEWTH2syyCw
	 Md25KZg9pCb4ed0WzxIGf8ogeSUhAPlvRsvDpdds7PWcUl+vcsgr8j3qyKwoy4u9NV
	 w3piJvmrkBsQVEGZx7vG2ZC8BMm0oh8H9ocCo/bM9b6gMZgEod1R2JjcvQGQLrTlj8
	 EK93kCUmvFUPGlMnK4JX3bQ+c/MXaaTgIWGrmB4MikMfMSDs+5mf/b0gBP+9MwrCmI
	 ax23i+gzahBnw==
Message-ID: <b51daabc-fb34-4cf2-a5e9-2c0e59e1d5c0@kernel.org>
Date: Fri, 29 May 2026 12:05:09 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] nfsd: serialize nfsd4_end_grace() with atomic
 test-and-set
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, Scott Mayhew <smayhew@redhat.com>,
 Trond Myklebust <Trond.Myklebust@netapp.com>,
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>,
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
 <20260528-nfsd-fixes-v1-3-e78708eff77d@kernel.org>
 <c087f4c4-c17e-474e-a869-14077996beb6@app.fastmail.com>
 <fdbe9d990b0bd14ba0f76f4a989c08a218678c43.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <fdbe9d990b0bd14ba0f76f4a989c08a218678c43.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22078-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: E9D046062BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 11:57 AM, Jeff Layton wrote:
> On Fri, 2026-05-29 at 11:38 -0400, Chuck Lever wrote:
>>
>> On Thu, May 28, 2026, at 5:55 PM, Jeff Layton wrote:
>>> From: Chris Mason <clm@meta.com>
>>>
>>> nfsd4_end_grace() guards its drain path with a plain bool:
>>>
>>>     if (nn->grace_ended)
>>>             return;
>>>     nn->grace_ended = true;
>>>
>>> The read and the write are independent, and nothing in struct
>>> nfsd_net serializes them.  At least two contexts can reach this
>>> code with no lock held:
>>>
>>>     laundromat path
>>>       laundry_wq kworker
>>>         nfs4_laundromat()
>>>           nfsd4_end_grace()
>>>
>>>     RECLAIM_COMPLETE path
>>>       nfsd compound kthread
>>>         nfsd4_reclaim_complete()
>>>           inc_reclaim_complete()
>>>             nfsd4_end_grace()
>>>
>>> Both callers can observe grace_ended == false on different CPUs,
>>> both store true, and both proceed into nfsd4_record_grace_done(),
>>> which invokes the active client_tracking_ops->grace_done callback.
>>> For tracking ops that drain reclaim_str_hashtbl (legacy_tracking_ops
>>> via nfsd4_recdir_purge_old, and the cld v1+ ops via
>>> nfsd4_cld_grace_done), grace_done calls nfs4_release_reclaim(),
>>> which walks every bucket of reclaim_str_hashtbl with no lock and
>>> calls nfs4_remove_reclaim_record() (list_del + kfree) on each
>>> entry.  Two concurrent walkers corrupt the list and double-free
>>> every nfs4_client_reclaim.  A concurrent nfsd4_find_reclaim_client()
>>> iterating the same bucket reads through freed memory.
>>>
>>> A third call site exists in nfs4_state_start_net() on the
>>> skip_grace startup path, but it runs under nfsd_mutex before any
>>> client has connected and before the laundromat's first delayed
>>> work fires, so it cannot race with the two callers above.
>>>
>>> Fix by replacing the read/write pair with try_cmpxchg() so exactly
>>> one caller transitions grace_ended from false to true and proceeds
>>> into the drain; the loser returns immediately.  bool supports
>>> 1-byte cmpxchg on all supported architectures, and no lock
>>> ordering changes are needed.
>>>
>>> Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations 
>>> when using nfsdcld")
>>> Assisted-by: kres:claude-opus-4-7
>>> Signed-off-by: Chris Mason <clm@meta.com>
>>> ---
>>>  fs/nfsd/nfs4state.c | 17 ++++++++++++++---
>>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>> index f4d12dbcf97b..dc4ac541436f 100644
>>> --- a/fs/nfsd/nfs4state.c
>>> +++ b/fs/nfsd/nfs4state.c
>>> @@ -7022,12 +7022,23 @@ nfsd4_renew(struct svc_rqst *rqstp, struct 
>>> nfsd4_compound_state *cstate,
>>>  static void
>>>  nfsd4_end_grace(struct nfsd_net *nn)
>>>  {
>>> -	/* do nothing if grace period already ended */
>>> -	if (nn->grace_ended)
>>> +	bool expected = false;
>>> +
>>> +	/*
>>> +	 * nfsd4_end_grace() can be entered concurrently from the
>>> +	 * laundromat workqueue and from an nfsd compound thread
>>> +	 * handling RECLAIM_COMPLETE.  Without serialization, both
>>> +	 * callers can observe grace_ended==false and proceed into
>>> +	 * nfsd4_record_grace_done().  For tracking ops whose
>>> +	 * grace_done drains reclaim_str_hashtbl, that results in
>>> +	 * list corruption and a double free of every
>>> +	 * nfs4_client_reclaim entry.  Use an atomic test-and-set so
>>> +	 * exactly one caller proceeds.
>>> +	 */
>>> +	if (!try_cmpxchg(&nn->grace_ended, &expected, true))
>>>  		return;
>>>
>>>  	trace_nfsd_grace_complete(nn);
>>> -	nn->grace_ended = true;
>>>  	/*
>>>  	 * If the server goes down again right now, an NFSv4
>>>  	 * client will still be allowed to reclaim after it comes back up,
>>>
>>> -- 
>>> 2.54.0
>>
>> Seems like the usual idiom for something like this is an atomic
>> bit op. Perhaps try_cmpxchg on a boolean variable is not going
>> to behave as you expect on every hardware platform.
> 
> We just need a single flag here though. try_cmpxchg() had better work
> the same way on every platform or a lot of stuff is FUBAR. Where
> wouldn't it?

Codex suggests on Hexagon, cmpxchg grabs more than just that boolean.


-- 
Chuck Lever

