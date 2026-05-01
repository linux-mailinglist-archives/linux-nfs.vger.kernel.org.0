Return-Path: <linux-nfs+bounces-21333-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCsgCPW99GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21333-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:51:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E24AD615
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CFCE3011798
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852BF3CCFAC;
	Fri,  1 May 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewa+g0MK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179C282F06;
	Fri,  1 May 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647090; cv=none; b=cS5oQ8Lyta3CieRCjYHPcdq2DOOAMh4F7lU6mpJZKHy8bq5Fh8NN4RkuN6NIsVAsouc0ncZM75QlfQk5ukHPRdUdk3w/lkcnUz2+Xj4dIZMPon4BJEx/VkeT5Wz9kfPNiCknLixFlVn9//60Zc1SachK5KSM1IpFJKMsgHZNsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647090; c=relaxed/simple;
	bh=SNs+jOeLk7gIMEEAJYWCC2bIpE4D7lFY/byWgaXHaio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lK6yvWuE1Iyvi17hbya2ZnhdL6f6X7SC0ER6dAAheygqFurIGJHhdrLvFYVi0a2RLTfRuJL6LcE6Thh3BjLrmO2TxW/dsmcC7bAhMavQGwHgMtfabgOyFSRAkLYRoCaitRRSHXzqFVmLiUvV34DkT2/aFCBskfb1SjESVEU6xSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewa+g0MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF56C2BCB4;
	Fri,  1 May 2026 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647090;
	bh=SNs+jOeLk7gIMEEAJYWCC2bIpE4D7lFY/byWgaXHaio=;
	h=From:Subject:Date:To:Cc:From;
	b=Ewa+g0MKEpW9ixH4w+q/KbTgY8IDFIl5YcW7fat4l4TfDvh+irGlObX1LCOoCRXhK
	 5XVd2Zf6P62kvptz77Fi8sM9kv9uhLdjCUYm61o5lkah0gZqj4E/pkeJ7sC20y0Nhi
	 JiVUSVS1uwYYLq8EKrVMwXYWOmQLFr7V7D9/DzUhAZzu3yDMUQ/pgLwZ/r3GQoTvSt
	 8rRitnPP48BUWSXk2jEuBWMy3BHQqSpESABJgHRKeT4ugLpk89rYZBLOZzxTv8NFMv
	 bwpHWFdV5vkU/4BTw6qr7c/1wpsUs3cjlY0M2f7WEfflKBAGXwasNMooq1oWO1jVsl
	 IoYct0R9amKTQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
Date: Fri, 01 May 2026 10:51:06 -0400
Message-Id: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANq99GkC/yWMQQrDMAwEvxJ0rkCJSwL9SulBVuTYPbjFSkIh5
 O+12+MMu3OAaUlqcOsOKLonS69cob90IJHzopjmyjDQMNLVEQpLVNw4YEgf5N4RURgncRPUz7t
 o1b/e/fFn2/xTZW2RtvBsir5wlthUDjbjqramvMB5fgFCxxI0kAAAAA==
X-Change-ID: 20260430-cache-uaf-fix-a13000f67c37
To: Misbah Anjum N <misanjum@linux.ibm.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=SNs+jOeLk7gIMEEAJYWCC2bIpE4D7lFY/byWgaXHaio=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9L3gdmsF0fj1gXJLUgau6PlHPtwmaZVGhZVJr
 7RaeL40ssGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafS94AAKCRAzarMzb2Z/
 l0AVD/9VTfN8bZ8SF+VFYMTuSYe37Tm6Li3xK6dbsZF7cICO03jNy++pMQ64Gk0MBCMpnGrr6oi
 TuEP72N4wTgLO18bN6mQoaNJcxkC+n4loA6Bf/b9w1y37VYXomz//Hya1g9d0A1GWcnu6Ozm8ev
 1cLWL9vSefM0cZmn7LcD0hmWZmM+V7Y/NT6bv4e5+KeVpPvsM+CJn762KuaOrSrW6ASxmMzeRnQ
 l1NPkOG9CgziJIeBevu7rACfdCdACcKeSDBi4HbJTo9FMk3ZgxovJBfgOD1K4hXmY1FEjZwwrNu
 vnazdCyxhViTpExMdfRWC59fJ8jyzCbwYCGlO/Czz9dCLFre94XNd3fBC95kPxUJIqjZy+69LQC
 9eeHs/imu8qluVimate7KCSVV/VYDSz5QHoYd8xqqrnkkAbhdMyGaUDBEiXf/y+NPNtP0rUml5g
 mzqHalsTX0dM/8SU/YXrJo0RgWoaZxZTC0eEIroPZgvuFvRy/SCNeARrBkIvf/MwwZZIkUtQJax
 m6LfTFkplE0+zM8aQgWDDoKrTOZFwyKCFDFi+VkDxt/jQq6kWigJgUoPdgXbdLytNcsN+YtJkRQ
 X68XtkEr3Sx9tf1xQ2mWUlZnDVsyIhwHzLUEBpxFIuMS4DxBNMJVnYZJJnvQLUuCgjKv4Fi9Ib3
 XRJ3zimqzRMxS3Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A88E24AD615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21333-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid]

Misbah Anjum reported a use-after-free in cache_check_rcu()
reached through e_show() while sosreport was reading
/proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
landed in v7.0:

  48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
  e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd")

The original e_show() repro is now fixed.  However, the same
sosreport workload still reproduces a closely related fault on
post-v7.0 mainline (Misbah, ppc64le) and on master.20260424
(internal report, aarch64).  In both cases the fault is in
cache_check_rcu() reached through c_show() rather than e_show(),
and the cache_head pointer is plain garbage:

  pc : cache_check_rcu+0x40 [sunrpc]
  lr : c_show+0x60 [sunrpc]
  ...faulting on h->flags off h = 0x0000000200000000

c_show() is the generic show callback used by
/proc/net/rpc/<cd>/content for every per-net cache_detail
(auth.unix.ip, auth.unix.gid, nfsd.fh, nfsd.export).  Two
bugs combine in that path:

1. cache_unregister_net() / cache_destroy_net() free cd and
   cd->hash_table synchronously when the namespace exits.  The
   /proc/net/rpc/.../content open path takes only a module
   reference, so a fd kept open across a netns exit walks a
   freed hash_table and returns garbage cache_head pointers.
   This is the same hazard that e7fcf179b82d closed for the
   /proc/fs/nfs/exports file alone.

2. ip_map_put() drops auth_domain_put() before kfree_rcu(), so
   sub-objects can be freed before the RCU grace period -- the
   same hazard that 48db892356d6 fixed for svc_export_put() and
   expkey_put().  unix_gid_put() does not have this bug
   structurally (its put_group_info() runs inside the call_rcu()
   callback) but it uses a separate idiom from the other three
   caches.

This series replaces the v1 narrow fixes with shared
infrastructure that covers all four cache_detail .put paths
and all three per-cache file types:

Patch 1 hoists nfsd_export_wq up to the sunrpc layer as
sunrpc_cache_wq, exposed through sunrpc_cache_queue_release()
and sunrpc_cache_drain() so all four put callbacks share one
workqueue and one drain primitive.

Patch 2 converts ip_map_put() to the queue_rcu_work() pattern,
moving auth_domain_put() into a deferred ip_map_release() that
runs after the RCU grace period.

Patch 3 unifies unix_gid_put() onto the same pattern for
consistency (not a bug fix on its own).

Patch 4 takes a get_net(cd->net) in content_open(), cache_open(),
and open_flush() and drops it in the matching release helpers,
so cache_destroy_net() cannot run while a sunrpc cache fd is
open.

Series has been compile-tested only.

---
Chuck Lever (6):
      SUNRPC: Move cache_initialize() declaration to sunrpc-private header
      SUNRPC: Provide a shared workqueue for cache release callbacks
      SUNRPC: Defer ip_map sub-object cleanup past RCU grace period
      SUNRPC: Use shared release pattern for the unix_gid cache
      SUNRPC: Hold cd->net for the lifetime of cache files
      NFSD: Convert nfsd_export_shutdown() to sunrpc_cache_destroy_net()

 fs/nfsd/export.c             | 45 ++--------------------
 fs/nfsd/export.h             |  2 -
 fs/nfsd/nfsctl.c             |  8 +---
 include/linux/sunrpc/cache.h |  3 +-
 net/sunrpc/cache.c           | 90 ++++++++++++++++++++++++++++++++++++++++++--
 net/sunrpc/sunrpc.h          |  2 +
 net/sunrpc/sunrpc_syms.c     | 23 ++++++-----
 net/sunrpc/svcauth_unix.c    | 46 ++++++++++++----------
 8 files changed, 135 insertions(+), 84 deletions(-)
---
base-commit: f3a313ecd1fdab1f5da119db355363b13af6fcac
change-id: 20260430-cache-uaf-fix-a13000f67c37

Best regards,
--  
Chuck Lever


