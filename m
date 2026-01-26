Return-Path: <linux-nfs+bounces-18473-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI1TC+R8d2m9hgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18473-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 15:40:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 638EA89A28
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B98A3019B87
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C323D288;
	Mon, 26 Jan 2026 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8t2MGZd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE68245020
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438151; cv=none; b=mQjXaMnQ9OSW81XW03ynbX/JV9EsFgQSkmDv4vyuBvcCh8pTT0QnT0M/4UqX1linCIQpedSvVASxRKRHPZzG3IBjuS8G5pB1stMZY6i4z7dVUMI3IjpWkThfUcj0N0DNLT9sf5vujR755t/zuLV0EptC8g6lvnSOQrOoajdkj9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438151; c=relaxed/simple;
	bh=1Tl3/exD1R6JXaWWe2lxJ6tsFN/KWIRVRAoE98sG8cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxRZwYOOQflKX5YED4Qhcr5uafZe/D7nZmwj3KLsGCxhQ7KYVgQI8V6S4QzZvSc3i1EuYKNWt4fBQfp7fMYru+rzaKhKTNKdvOzE3eYTlKW1FbGaZZYLUWUuqd+yB9X6uIRzzYE51LTftvtq2I++lqnuPD1zgUdrIxwt/N8htN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8t2MGZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD0EC116C6;
	Mon, 26 Jan 2026 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769438151;
	bh=1Tl3/exD1R6JXaWWe2lxJ6tsFN/KWIRVRAoE98sG8cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q8t2MGZdU5QTRM/BamOJOVvaUdF2qHX0zai3uB33YS+xEiG3LAxFRSMDO8c/P2vMQ
	 0KPQkO++qJjVGSLDuAYvBsEmKaVotIwmnBNf+Mz7TPjVw2SNFC3AXcreaHWEMos+LZ
	 ZQeNn9CdMxjAHicY8h7YuWLnI2Ioy1hLN91EqppeX938nUf+dfVA43F5ynTmbI+1dh
	 iFZAiOSB/v61PXs4IWBqjZBNB0cv7IeMF/Q08FAFrB6rD7kmjtHieutnFqIXBA+Bh2
	 20ZgfvOnjLLSFrZRNiU/ydvRdtrA33pzYMSh9P4NEj6n1ejVZoJV037W4WnmivAFSD
	 BbU1LO3iIyjqQ==
Message-ID: <f41b27dc-fd7a-4a39-b490-1a19b3947f90@kernel.org>
Date: Mon, 26 Jan 2026 09:35:41 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/42] Clarify module API boundaries
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260123185259.1215767-1-cel@kernel.org>
 <448bfee54bdf87e6f2fd8895697c9b4c001e70e2.camel@kernel.org>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <448bfee54bdf87e6f2fd8895697c9b4c001e70e2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18473-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 638EA89A28
X-Rspamd-Action: no action

On 1/26/26 7:51 AM, Jeff Layton wrote:
> On Fri, 2026-01-23 at 13:52 -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The first thirteen patches in this series refactor the lockd code
>> base to clearly separate its public API from internal implementation
>> details. The remainder are presented for context, but demonstrate
>> the intended purpose of the clean-up in the first thirteen.
>>
>> The lockd subsystem currently exposes internal implementation headers
>> through include/linux/lockd/, creating implicit API contracts that
>> complicate maintenance. External consumers such as NFSD and the NFS
>> client have developed dependencies on internal structures like struct
>> nlm_host, and wire protocol constants leak into high-level module
>> interfaces.
>>
>> These patches work to establish clean architectural boundaries. The
>> public API in include/linux/lockd/ is reduced to bind.h and nlm.h,
>> which define the contract between lockd and its consumers. Private
>> implementation details including XDR definitions, share management,
>> and host structures are relocated to fs/lockd/ where they belong.
>> Layering violations are corrected: the NFS client now uses accessor
>> helpers instead of dereferencing internal structures, and nlm_fopen()
>> returns errno values instead of wire protocol codes.
>>
>> These changes enable subsequent work to modernize the NLMv4 XDR
>> layer using xdrgen without risk of breaking external consumers.
>> This work appears in the remaining patches in this series, which
>> are presented here only to provide context for the API adjustments.
>> No need to review those closely just yet.
>>
>> The series is based on the public nfsd-testing branch.
>>
>> ---
>>
>> Changes since v1:
>> - Refine the pre-requisite header adjustments
>> - Reduce stack consumption by moving large structures to wrappers
>> - Additional extensive clean up
>>
>> Chuck Lever (42):
>>   lockd: Simplify cast_status() in svcproc.c
>>   lockd: Introduce nlm__int__deadlock
>>   lockd: Have nlm_fopen() return errno values
>>   lockd: Relocate nlmsvc_unlock API declarations
>>   NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt
>>   lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
>>   lockd: Move share.h from include/linux/lockd/ to fs/lockd/
>>   lockd: Relocate include/linux/lockd/lockd.h
>>   lockd: Remove lockd/debug.h
>>   lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
>>   lockd: Make linux/lockd/nlm.h an internal header
>>   lockd: Move nlm4svc_set_file_lock_range()
>>   lockd: Relocate svc_version definitions to XDR layer
>>   Documentation: Add the RPC language description of NLM version 4
>>   lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
>>   lockd: Refactor nlm4svc_callback()
>>   lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 TEST_RES procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 LOCK_RES procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_RES procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_RES procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_RES procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
>>   lockd: Convert server-side undefined procedures to xdrgen
>>   lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
>>   lockd: Prepare share helpers for xdrgen conversion
>>   lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
>>   lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
>>   lockd: Add LOCKD_SHARE_SVID constant for DOS sharing mode
>>   lockd: Remove C macros that are no longer used
>>   lockd: Remove dead code from fs/lockd/xdr4.c
>>
>>  Documentation/sunrpc/xdr/nlm4.x     |  211 ++++
>>  fs/lockd/Makefile                   |   30 +-
>>  fs/lockd/clnt4xdr.c                 |    5 +-
>>  fs/lockd/clntlock.c                 |    2 +-
>>  fs/lockd/clntproc.c                 |    2 +-
>>  fs/lockd/clntxdr.c                  |    3 +-
>>  fs/lockd/host.c                     |    2 +-
>>  {include/linux => fs}/lockd/lockd.h |   99 +-
>>  fs/lockd/mon.c                      |    2 +-
>>  {include/linux => fs}/lockd/nlm.h   |    8 +-
>>  fs/lockd/nlm4xdr_gen.c              |  724 +++++++++++
>>  fs/lockd/nlm4xdr_gen.h              |   32 +
>>  {include/linux => fs}/lockd/share.h |   19 +-
>>  fs/lockd/svc.c                      |   50 +-
>>  fs/lockd/svc4proc.c                 | 1783 ++++++++++++++++++---------
>>  fs/lockd/svclock.c                  |   12 +-
>>  fs/lockd/svcproc.c                  |   99 +-
>>  fs/lockd/svcshare.c                 |   40 +-
>>  fs/lockd/svcsubs.c                  |   32 +-
>>  fs/lockd/trace.h                    |    3 +-
>>  fs/lockd/xdr.c                      |    6 +-
>>  {include/linux => fs}/lockd/xdr.h   |   15 +-
>>  fs/lockd/xdr4.c                     |  347 ------
>>  fs/nfs/sysfs.c                      |   10 +-
>>  fs/nfsd/lockd.c                     |   51 +-
>>  fs/nfsd/nfsctl.c                    |    2 +-
>>  include/linux/lockd/bind.h          |   23 +-
>>  include/linux/lockd/debug.h         |   40 -
>>  include/linux/lockd/xdr4.h          |   43 -
>>  include/linux/sunrpc/xdrgen/nlm4.h  |  233 ++++
>>  30 files changed, 2750 insertions(+), 1178 deletions(-)
>>  create mode 100644 Documentation/sunrpc/xdr/nlm4.x
>>  rename {include/linux => fs}/lockd/lockd.h (84%)
>>  rename {include/linux => fs}/lockd/nlm.h (91%)
>>  create mode 100644 fs/lockd/nlm4xdr_gen.c
>>  create mode 100644 fs/lockd/nlm4xdr_gen.h
>>  rename {include/linux => fs}/lockd/share.h (58%)
>>  rename {include/linux => fs}/lockd/xdr.h (91%)
>>  delete mode 100644 fs/lockd/xdr4.c
>>  delete mode 100644 include/linux/lockd/debug.h
>>  delete mode 100644 include/linux/lockd/xdr4.h
>>  create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h
> 
> I went through the series and it looks good overall. I definitely like
> moving away from hand-rolled XDR handling. You can add this to the
> series:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 
> There is still the matter of the race vs. the shutdown file, but that's
> a preexisting problem.

So the first time around I didn't quite catch the gist of your proposal
to add a lockd API to deal with this. Obviously it makes sense that such
an API will also remove the direct access to the internal struct field.

So I've folded all that together into a replacement for 05/42.


> I presume you intend to let this sit in -next
> for a while? It's a big change so it'd be good to have a nice long test
> cycle with it.

I was thinking of applying at least 1 - 13 to nfsd-testing soon so it
will show up in nfsd-next as soon as the 7.0 merge window closes.


-- 
Chuck Lever

