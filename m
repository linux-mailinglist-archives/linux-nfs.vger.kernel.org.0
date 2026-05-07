Return-Path: <linux-nfs+bounces-21433-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ9SFCdb/GndOQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21433-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:28:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9CC4E5E0F
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF89130A8710
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC1388E6C;
	Thu,  7 May 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qjnZu6OM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058503AB292;
	Thu,  7 May 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144971; cv=none; b=cUsfTxUEVhUtx+A7IEIFpfaSfKSCMChjFBJn16fhqaYjMvdjqoI+Mk5nzl2+AuXdd/2yuQgxvdMLQQ6wMOs40uXt4309rt01XeWTuNIkpNMEJOj6/6XB/uWxVvmplBKltJwF6uD+kXvlpBoiUQLUL8kzPuRxSJiSCER3hX3Nww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144971; c=relaxed/simple;
	bh=e5gzppYZPcS5dgDQ9E0pGKVskGCZgt14n+rbjsI9EL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZN8qefSU75vFaljW9V1UePKv1WPRkY+pqGPqcwTpvBDfbA5v8qCC1Dll3LcbFRD2Zg8ua4Q+51oSEoApexgIyp7AUUe9Xarf97HKQmj9Jlkf/sFEE/odXwaUNuBRtM9fNsN79VX6brgDlrXsKUyqn9F/v7FySLCwmpZ9R2i63bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qjnZu6OM; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q+dNpQAHxK3ZqDkbf2W7j1K89TN8Q2JWBVNsN0RFFOg=;
	b=qjnZu6OMYaAb9QIOniSS0Yq7DJC0Wp74C0B/kwIRbCVtsyGmEFR5Zpkp/aBnir5RAV15HjvkG
	taxjyQq7duMVbq4q4auPUrOKEIJBAr5C3nWUqM1AQKGJEJkKE8N/ewqVdV38MxUSHik8QAwaFhg
	uag4C+7/zay4nYOCJoLybwE=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gB5pZ3jGvz1K96s;
	Thu,  7 May 2026 17:01:42 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 8933F40571;
	Thu,  7 May 2026 17:09:14 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 17:09:13 +0800
Message-ID: <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
Date: Thu, 7 May 2026 17:09:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
To: Chuck Lever <cel@kernel.org>, Misbah Anjum N <misanjum@linux.ibm.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>, yangerkun
	<yangerkun@huawei.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: AA9CC4E5E0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21433-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Action: no action

Hi,

在 2026/5/1 22:51, Chuck Lever 写道:
> Misbah Anjum reported a use-after-free in cache_check_rcu()
> reached through e_show() while sosreport was reading
> /proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
> landed in v7.0:
> 
>    48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>    e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd")

Back to the problem fixed by this patches, I'm a little confused why
this UAF can be trigged.

Before this patches, svc_export_put show as follow:

  368 static void svc_export_put(struct kref *ref)
  369 {
  370         struct svc_export *exp = container_of(ref, struct 
svc_export, h.ref);
  371
  372         path_put(&exp->ex_path);
  373         auth_domain_put(exp->ex_client);
  374         call_rcu(&exp->ex_rcu, svc_export_release);
  375 }

The auth_domain_put function releases ->name using call_rcu, and
path_put may release the dentry also via call_rcu. All of this seems to
prevent e_show from causing a UAF. Could you point out which line in
d_path triggers the issue?

Thanks,
Erkun.


> 
> The original e_show() repro is now fixed.  However, the same
> sosreport workload still reproduces a closely related fault on
> post-v7.0 mainline (Misbah, ppc64le) and on master.20260424
> (internal report, aarch64).  In both cases the fault is in
> cache_check_rcu() reached through c_show() rather than e_show(),
> and the cache_head pointer is plain garbage:
> 
>    pc : cache_check_rcu+0x40 [sunrpc]
>    lr : c_show+0x60 [sunrpc]
>    ...faulting on h->flags off h = 0x0000000200000000
> 
> c_show() is the generic show callback used by
> /proc/net/rpc/<cd>/content for every per-net cache_detail
> (auth.unix.ip, auth.unix.gid, nfsd.fh, nfsd.export).  Two
> bugs combine in that path:
> 
> 1. cache_unregister_net() / cache_destroy_net() free cd and
>     cd->hash_table synchronously when the namespace exits.  The
>     /proc/net/rpc/.../content open path takes only a module
>     reference, so a fd kept open across a netns exit walks a
>     freed hash_table and returns garbage cache_head pointers.
>     This is the same hazard that e7fcf179b82d closed for the
>     /proc/fs/nfs/exports file alone.
> 
> 2. ip_map_put() drops auth_domain_put() before kfree_rcu(), so
>     sub-objects can be freed before the RCU grace period -- the
>     same hazard that 48db892356d6 fixed for svc_export_put() and
>     expkey_put().  unix_gid_put() does not have this bug
>     structurally (its put_group_info() runs inside the call_rcu()
>     callback) but it uses a separate idiom from the other three
>     caches.
> 
> This series replaces the v1 narrow fixes with shared
> infrastructure that covers all four cache_detail .put paths
> and all three per-cache file types:
> 
> Patch 1 hoists nfsd_export_wq up to the sunrpc layer as
> sunrpc_cache_wq, exposed through sunrpc_cache_queue_release()
> and sunrpc_cache_drain() so all four put callbacks share one
> workqueue and one drain primitive.
> 
> Patch 2 converts ip_map_put() to the queue_rcu_work() pattern,
> moving auth_domain_put() into a deferred ip_map_release() that
> runs after the RCU grace period.
> 
> Patch 3 unifies unix_gid_put() onto the same pattern for
> consistency (not a bug fix on its own).
> 
> Patch 4 takes a get_net(cd->net) in content_open(), cache_open(),
> and open_flush() and drops it in the matching release helpers,
> so cache_destroy_net() cannot run while a sunrpc cache fd is
> open.
> 
> Series has been compile-tested only.
> 
> ---
> Chuck Lever (6):
>        SUNRPC: Move cache_initialize() declaration to sunrpc-private header
>        SUNRPC: Provide a shared workqueue for cache release callbacks
>        SUNRPC: Defer ip_map sub-object cleanup past RCU grace period
>        SUNRPC: Use shared release pattern for the unix_gid cache
>        SUNRPC: Hold cd->net for the lifetime of cache files
>        NFSD: Convert nfsd_export_shutdown() to sunrpc_cache_destroy_net()
> 
>   fs/nfsd/export.c             | 45 ++--------------------
>   fs/nfsd/export.h             |  2 -
>   fs/nfsd/nfsctl.c             |  8 +---
>   include/linux/sunrpc/cache.h |  3 +-
>   net/sunrpc/cache.c           | 90 ++++++++++++++++++++++++++++++++++++++++++--
>   net/sunrpc/sunrpc.h          |  2 +
>   net/sunrpc/sunrpc_syms.c     | 23 ++++++-----
>   net/sunrpc/svcauth_unix.c    | 46 ++++++++++++----------
>   8 files changed, 135 insertions(+), 84 deletions(-)
> ---
> base-commit: f3a313ecd1fdab1f5da119db355363b13af6fcac
> change-id: 20260430-cache-uaf-fix-a13000f67c37
> 
> Best regards,
> --
> Chuck Lever
> 
> 
> 


