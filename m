Return-Path: <linux-nfs+bounces-22126-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fg8BSaEG2owDwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22126-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 02:43:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F36140A3
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 02:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3284302D30E
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 00:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D123D281;
	Sun, 31 May 2026 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvxA22k0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D622A1D4
	for <linux-nfs@vger.kernel.org>; Sun, 31 May 2026 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188191; cv=none; b=e/82oSB6YNmPT+Pm78CvF5jyFRpnJafAa4vwXhNf41XXeRoIhREduHE3PBC6neLojPb3DVTu/2iPMWXLFb2ihumbp9IiIayIYiQBt8/jBTVTdKNwg4lWlczexLkLUjY33O311PV7MdoZHI4LWhsEBWjne0+zM7uD+165oDTCDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188191; c=relaxed/simple;
	bh=4b6naZAuRdGhWThScT042kd2wO6vlEZQ8Mz3NeKI6lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYXysFbucOrOHueh7+POoYf+ku9Za4vz/b2OwwSUDwr+XtQC75eB3CleMZpp9GQYsGWVM9Utzsmjb6PTJGKQ+9cUa2lN+HyHyAnXrIjTk+qB8PcpKvAbUMxkhAzZdtTAk7ZlpneoHa04yuxu6dLq6QZ/8fcuy8e9dRjcgVNxAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvxA22k0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE51F00893;
	Sun, 31 May 2026 00:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780188189;
	bh=W3Nf3SNz6mqaAtkX5lbSa+4RMSyrP26ZIAUjKmKnJ8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kvxA22k00mMAw6YZqOnxpLODi6i3LQHOKwMsyIWvo4HEQQJ5NM1e6qWghu0cQFwaM
	 Ia8zEnWabS3OgYoEHEclLdtQr53VPlXAczHfT8ZrSLGxDZgN7DoPyqVreAGojf8B87
	 WblSI9gi2HbvDKhjrANsdXT6KI/uqmyHfJou+MXN3+xcWsTgJl+bWw6nNMOJUIOrMM
	 de4z4g4yiOCSBa30CZ+D3v+Qs/ewZYCceCLstcsS9kVzHkVBc87iDirmRWPVrBhELY
	 jsNtyMYgjGMcBOi76BzEz5SIeP9RKSTI4tEHg4gIxt+pVv2OgEFumKzIZlbOM77UeI
	 2AwSuaZshJrZQ==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 30 May 2026 20:42:53 -0400
Subject: [PATCH v2 2/2] SUNRPC: Check svc pool percpu counter allocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-tier2-local-v2-2-5a0fd532db57@oracle.com>
References: <20260530-tier2-local-v2-0-5a0fd532db57@oracle.com>
In-Reply-To: <20260530-tier2-local-v2-0-5a0fd532db57@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3852;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=UApWqvK+kFwrS52OZiN9tN2/nJSMZo/RVdBjfmiafTg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqG4QbMoh82oG0u79BhzczCHi531ixDL2uiIU7M
 mOIldz7iWSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahuEGwAKCRAzarMzb2Z/
 l1cvD/4weYo6R2Ko0b3JiucBbLa3X+SM+Q510LsoOOwr5Bku/E4UY5SYBOFbeQKifWNQGaQF4Yx
 nHIsZ8Q1FsS29z6g1M/VKB/B5DislzZ5R1peaakkgi+EkUNZJYsueVXNtCj7F0NanEYiUmM560Y
 Br95lzp0lFkOCW8tD+JdmWr17ulvHGm6PLKswz+PvYhVHnVp0HAd3HG6dhjgtanvybvAZLUd11U
 C1ZBRvKcxCUnhoK9LnwMshVeglIgJZNWdmlAjPsszMmiQIbwopxjZ2VRfgotiEQKBK8a25d3NeS
 IKEsEZl5sM9QKm63K2BLCmyc+GL031mzumLfzyjhsryPkNuo2+IXvWL6NGwM3L/QEAFb6CI6vNn
 f00qSulm0TclNYhhCo0P6dL/RLUM9Ld1kr+hcF7Ap87u7VzqqWC/Q4Hu5UsbYwEZBs7B+ZzFZRP
 GeYzMtPWvQdU0PFGV6Cmx9mC36wiC3B3dNkLzl/kNsZKkjTHpj3GNbB+bNMDgfKwOU1OvM0Yg4Q
 GUEpiVb2XFLVXNWVN39qoDR9FHAVrAv8HLkYwf5oCTb86EsnRkD9G8gnS3XcONnFqX3hkrjk/IK
 SPuxbReB7SWBO2zmijWEdximAiu3qUyAA8KPp6/Raa6EV5ixlUWL1iEnBDeT7o3ADV/Q8BkPGrv
 vIA5jr81pw0w7oA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22126-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A7F36140A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

__svc_create() initializes three per-pool percpu_counter stats and
ignores every return value. On SMP, percpu_counter_init() fails when
__alloc_percpu_gfp() cannot satisfy the allocation, leaving the failed
counter with fbc->counters == NULL and its embedded raw_spinlock_t,
list_head, and count never initialized. __svc_create() returns the
half-constructed svc_serv to nfsd, lockd, or the NFS callback service
anyway.

Once that service is live, the hot-path increments in
svc_xprt_enqueue(), svc_handle_xprt(), and
svc_pool_wake_idle_thread() reach a counter whose backing pointer is
NULL. The pointer is a per-cpu offset, so the access does not fault:
it resolves to offset zero of the current CPU's per-cpu area and
silently corrupts whatever variable lives there. A
/proc/fs/nfsd/pool_stats read walks the same NULL per-cpu storage and
returns garbage, and on CONFIG_DEBUG_SPINLOCK or lockdep it splats on
the never-initialized lock.

Creating the broken service requires a percpu allocation failure during
RPC server startup, so it is reachable only by a local administrator
under memory pressure or fault injection; a remote peer cannot induce
the bad state on its own.

Check each percpu_counter_init() return value in __svc_create() and
fail when an allocation fails, unwinding the counters already set up
in the current pool and in every pool initialized before it. A
discrete percpu_counter_destroy() per counter at teardown frees each
per-cpu allocation exactly once.

Fixes: ccf08bed6e7a ("SUNRPC: Replace pool stats with per-CPU variables")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae9ec4bf34f7..009373737ea9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -476,6 +476,35 @@ __svc_init_bc(struct svc_serv *serv)
 }
 #endif
 
+static int svc_pool_init_counters(struct svc_pool *pool)
+{
+	int err;
+
+	err = percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
+	if (err)
+		return err;
+	err = percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
+	if (err)
+		goto err_sockets;
+	err = percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
+	if (err)
+		goto err_threads;
+	return 0;
+
+err_threads:
+	percpu_counter_destroy(&pool->sp_sockets_queued);
+err_sockets:
+	percpu_counter_destroy(&pool->sp_messages_arrived);
+	return err;
+}
+
+static void svc_pool_destroy_counters(struct svc_pool *pool)
+{
+	percpu_counter_destroy(&pool->sp_messages_arrived);
+	percpu_counter_destroy(&pool->sp_sockets_queued);
+	percpu_counter_destroy(&pool->sp_threads_woken);
+}
+
 /*
  * Create an RPC service
  */
@@ -540,12 +569,18 @@ __svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
 		INIT_LIST_HEAD(&pool->sp_all_threads);
 		init_llist_head(&pool->sp_idle_threads);
 
-		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
-		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
-		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
+		if (svc_pool_init_counters(pool))
+			goto out_err;
 	}
 
 	return serv;
+
+out_err:
+	while (i--)
+		svc_pool_destroy_counters(&serv->sv_pools[i]);
+	kfree(serv->sv_pools);
+	kfree(serv);
+	return NULL;
 }
 
 /**
@@ -624,9 +659,7 @@ svc_destroy(struct svc_serv **servp)
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
-		percpu_counter_destroy(&pool->sp_messages_arrived);
-		percpu_counter_destroy(&pool->sp_sockets_queued);
-		percpu_counter_destroy(&pool->sp_threads_woken);
+		svc_pool_destroy_counters(pool);
 	}
 	kfree(serv->sv_pools);
 	kfree(serv);

-- 
2.54.0


