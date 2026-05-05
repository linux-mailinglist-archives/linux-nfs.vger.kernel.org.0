Return-Path: <linux-nfs+bounces-21390-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNdHBOjO+WlHEQMAu9opvQ
	(envelope-from <linux-nfs+bounces-21390-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 13:05:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1DA4CC24A
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F8D3020A5F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C5381AF2;
	Tue,  5 May 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8vHvdRa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3837F8A9;
	Tue,  5 May 2026 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978419; cv=none; b=FpukNLTZYnLiA83T+kGvWMidPRgWERpU2aqWzkliWbmjNSUQRhpZHjWDM8OaAJnoCOBAcbmVlQ9aN5wyEMnUOXYYlElqg3/D9i13skF2mN2q/ddbmC6X2BGkVAspOE7IKEcd+yzr2owC7VtAEsE6zxU2DnryJ0bigy/4wZ8ez0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978419; c=relaxed/simple;
	bh=KnbhoE0I3ur7S4TEiFuzxCqvEtZyRA7GqwIvsBNPZNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIaRY2RwJAqDFlmZ0LIVOA1mP6QYsUsoQdQVgRvQ04QZkEZMGSDiqMG2C0LKw6rsGmqmLaEUiAHv/4d3jmfD+UzqzAO1tpUdqSqQokrO79rqe0tQrZ4lAGczSce0ox+nqueOjZcJ/InJ5MQyPuFlDA8nIACGosFUQYt1XZjPAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8vHvdRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D83EC2BCB4;
	Tue,  5 May 2026 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777978419;
	bh=KnbhoE0I3ur7S4TEiFuzxCqvEtZyRA7GqwIvsBNPZNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s8vHvdRak07XxK44RE8ppW82HVQsCQKcP+fKBxBOr1EsyVdnhK6GSs8k/Y0PxWtZY
	 F6lTsJPDCSvxl0nmZM6yCrSDgCFf5+/peU9RzxB8JF1FBqYHPTwoeOCqfWWYrkeiNA
	 y0enlnuqWncFo4TSbyMuXIWGhU9LpujvxWIqVhvx+V3rse4PrcK/sO6Cx0Ai6Lu1a3
	 /lpewou5wRo7loNYjLa/sNUUQ15qX35aUjAg0LX9Utr5ujemSKuAG7SzMGLzkbopAr
	 Y7AaYQOLdKQzkdlzmjQKWvgCJ1PdVwMdp0xp9B7Mci3gYOzgjT3/y7XJIOhUQLA90H
	 wqQwSnlNBigOw==
Message-ID: <8d3fbb91-65c4-4d15-ac38-3e6372eb0ffa@kernel.org>
Date: Tue, 5 May 2026 12:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
To: Calum Mackay <calum.mackay@oracle.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 alexandr.alexandrov@oracle.com
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <daa6461b-d8d6-42ad-adac-ac0df58c3b6e@oracle.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <daa6461b-d8d6-42ad-adac-ac0df58c3b6e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C1DA4CC24A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21390-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/5/26 12:49 PM, Calum Mackay wrote:
> On 01/05/2026 3:51 pm, Chuck Lever wrote:
>> Misbah Anjum reported a use-after-free in cache_check_rcu()
>> reached through e_show() while sosreport was reading
>> /proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
>> landed in v7.0:
>>
>>    48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks")
>>    e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/
>> fs/nfs/exports fd")
>>
>> The original e_show() repro is now fixed.  However, the same
>> sosreport workload still reproduces a closely related fault on
>> post-v7.0 mainline (Misbah, ppc64le) and on master.20260424
>> (internal report, aarch64).  In both cases the fault is in
>> cache_check_rcu() reached through c_show() rather than e_show(),
>> and the cache_head pointer is plain garbage:
>>
>>    pc : cache_check_rcu+0x40 [sunrpc]
>>    lr : c_show+0x60 [sunrpc]
>>    ...faulting on h->flags off h = 0x0000000200000000
>>
>> c_show() is the generic show callback used by
>> /proc/net/rpc/<cd>/content for every per-net cache_detail
>> (auth.unix.ip, auth.unix.gid, nfsd.fh, nfsd.export).  Two
>> bugs combine in that path:
>>
>> 1. cache_unregister_net() / cache_destroy_net() free cd and
>>     cd->hash_table synchronously when the namespace exits.  The
>>     /proc/net/rpc/.../content open path takes only a module
>>     reference, so a fd kept open across a netns exit walks a
>>     freed hash_table and returns garbage cache_head pointers.
>>     This is the same hazard that e7fcf179b82d closed for the
>>     /proc/fs/nfs/exports file alone.
>>
>> 2. ip_map_put() drops auth_domain_put() before kfree_rcu(), so
>>     sub-objects can be freed before the RCU grace period -- the
>>     same hazard that 48db892356d6 fixed for svc_export_put() and
>>     expkey_put().  unix_gid_put() does not have this bug
>>     structurally (its put_group_info() runs inside the call_rcu()
>>     callback) but it uses a separate idiom from the other three
>>     caches.
>>
>> This series replaces the v1 narrow fixes with shared
>> infrastructure that covers all four cache_detail .put paths
>> and all three per-cache file types:
>>
>> Patch 1 hoists nfsd_export_wq up to the sunrpc layer as
>> sunrpc_cache_wq, exposed through sunrpc_cache_queue_release()
>> and sunrpc_cache_drain() so all four put callbacks share one
>> workqueue and one drain primitive.
>>
>> Patch 2 converts ip_map_put() to the queue_rcu_work() pattern,
>> moving auth_domain_put() into a deferred ip_map_release() that
>> runs after the RCU grace period.
>>
>> Patch 3 unifies unix_gid_put() onto the same pattern for
>> consistency (not a bug fix on its own).
>>
>> Patch 4 takes a get_net(cd->net) in content_open(), cache_open(),
>> and open_flush() and drops it in the matching release helpers,
>> so cache_destroy_net() cannot run while a sunrpc cache fd is
>> open.
>>
>> Series has been compile-tested only.
>>
>> ---
>> Chuck Lever (6):
>>        SUNRPC: Move cache_initialize() declaration to sunrpc-private
>> header
>>        SUNRPC: Provide a shared workqueue for cache release callbacks
>>        SUNRPC: Defer ip_map sub-object cleanup past RCU grace period
>>        SUNRPC: Use shared release pattern for the unix_gid cache
>>        SUNRPC: Hold cd->net for the lifetime of cache files
>>        NFSD: Convert nfsd_export_shutdown() to sunrpc_cache_destroy_net()
>>
>>   fs/nfsd/export.c             | 45 ++--------------------
>>   fs/nfsd/export.h             |  2 -
>>   fs/nfsd/nfsctl.c             |  8 +---
>>   include/linux/sunrpc/cache.h |  3 +-
>>   net/sunrpc/cache.c           | 90 ++++++++++++++++++++++++++++++++++
>> ++++++++--
>>   net/sunrpc/sunrpc.h          |  2 +
>>   net/sunrpc/sunrpc_syms.c     | 23 ++++++-----
>>   net/sunrpc/svcauth_unix.c    | 46 ++++++++++++----------
>>   8 files changed, 135 insertions(+), 84 deletions(-)
>> ---
>> base-commit: f3a313ecd1fdab1f5da119db355363b13af6fcac
>> change-id: 20260430-cache-uaf-fix-a13000f67c37
>>
>> Best regards,
>> -- 
>> Chuck Lever
>>
>>
> 
> Looks good Chuck, thanks very much.
> 
> With these patches, testing shows no crashes, sosreport no longer hangs,
> no seq_file errors.
> 
> Tested-by: Alexandr Alexandrov <alexandr.alexandrov@oracle.com>
> 
> cheers,
> c.
> 

Excellent; pushed with Jeff's R-b and Alexandr's T-b.


-- 
Chuck Lever

