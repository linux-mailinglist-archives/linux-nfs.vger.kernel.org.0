Return-Path: <linux-nfs+bounces-22110-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO4QJ0NHG2qwAgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22110-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:23:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36761334C
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BE5130226B6
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2A2594B9;
	Sat, 30 May 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0aFIdPO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87622A80D
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780172482; cv=none; b=pW5z4q/DTyhSpSU4JrtBNDyvmvSTlBpJLyB6DIof7Hga7kd3kYdZ7leeqpZhsWUdbHql06o3i1fGkdsrv5GL0Lbvvs32VJRb1rXuGiGkFfeJBzDUtekvS04tZG5EBuO66xTystdGPQY6aKQiOlxjorxLgz8eC95pyISfP+E17uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780172482; c=relaxed/simple;
	bh=vxiS7Tvv/j0/4KVeIxBIaEycvR+dMtfdOORKZ9cdPk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGqTvC1ongJSVwzQptZu0sHX333CzZi0MAL/Au/ozwbZOPY4P7fqI+KusshRjE/0yjUJO2RVUAzLMhu3ksnGH3kZXekD2VxbvEv70pVQv4s4PVcw60aetH5/+j95h4Zo4AV7Ti5rGPWZe3haQG3lTkNuAkjg5ZBqyXgM0ERtT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0aFIdPO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59011F00898;
	Sat, 30 May 2026 20:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780172481;
	bh=1IJmPrhdOCJhNj3w/IxQ7xTcuOfs2fvHIQYAB6iiO0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f0aFIdPOiKvIh1qmWBo9innzFdfSkIminevvDlsaCV+zOLaOMJc93yfSsKwOfzSX2
	 zGlywlfTXqr1v6PI1CoGM8LsSNsfGOLJSxhQBrC/1YisgbFjUzPEF7My8ewQ8kpz5o
	 68T4O1RN4x5x3zAgtTGWMvpCbDwy2YfsVfv7MP2lTDfTlWOa+D1ezDRZcuAhn7TNWO
	 Ix2GeSz5uZV5Bz24NNtNzzGN+VdvQ8jOYEHFiYV8x1JppgK1SnhbvK1UMGH/8hMsUt
	 hVaHtz+CsMEpqGy36+M/uoYhXmazw3DDvctUt6/RX4yHJ9KQPm3UzVSGEZVFWHe1/v
	 uRA/nJb8GQ57g==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 30 May 2026 16:21:08 -0400
Subject: [PATCH 2/2] SUNRPC: Check svc pool percpu counter allocation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-tier2-local-v1-2-fc294d34848a@oracle.com>
References: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
In-Reply-To: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3428;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=39hdxInLW+G9zk3BS4VgmlNW1RvrZrO2x5QW6LQgxrg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqG0a+rWIpaNvQZREHrPQiPg2Fw7lbb0X1DK+vQ
 ikgv2zHnl6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahtGvgAKCRAzarMzb2Z/
 l66ZD/4/oXoodU7N3wPy7dOhZ3csVW6JrCqrSuevCn0gAVEEjnP7mN2qAzaP3xIqAobEtJnMn0i
 apU8NqX1lSw+40UB7hf9jQvYu2idPBbVeNqk/e1nmGZXrxgNyzcCtVO+GD0Rtr6Geb9T00LpAdd
 A9tAZ/OmhygVjmEpQIKnwbVYQLLvLyGBhRvGS0ZmEV8Q/dGc2HVCM0bmvket7crFVpM52mj/VLp
 tAWjMuNlmxNzdEEPGTIpbBNIid9jLcRYdLBeFXsdulKDe3VQpVavzitkp+YVkWxg04sOUE/Cw19
 fLheNHWztLAzw8VtUBs14QNdAePsNUfm7vRmF+eXkkqB+z0AyIPxKQoK8+SMZu3S1n1m+PhCKyc
 Yx2E4JvFYRda5oiI8RowU0sCSRtI8Vdtr+VosoVdmbKtyj/IphFcVGoX0AJxo0dFzrgTkVNHJwp
 AXfU9PtWtGlxd1p1sjBUD+jV10RWP7yQXoDpVVcLlhMWK30AtdjmqiX7wnzHJFxJN/T1+n9+5sB
 V5se+YWMdJqqY+KLFmZYVyEiQUm07zqVh9577+P75Y1mogZqdzZuoP9dNUbpC+DKIAFFeHRNk4T
 6ZZsU5+bxAgkgT9/EwJyjqvXW3L7kMV16AUeg6x1EczOBA2N1CVX8Gw/zxrT2Kk09YNs0QmFzrS
 cYrAfG6W2M3sowA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22110-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: EC36761334C
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

Initialize the three adjacent pool counters with one checked
percpu_counter_init_many() call and fail __svc_create() when the
allocation fails, unwinding the counters for pools already set up. Use
the matching percpu_counter_destroy_many() at teardown so the single
per-cpu allocation is freed exactly once.

Fixes: ccf08bed6e7a ("SUNRPC: Replace pool stats with per-CPU variables")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae9ec4bf34f7..aeb6e631848c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -476,6 +476,22 @@ __svc_init_bc(struct svc_serv *serv)
 }
 #endif
 
+enum {
+	SVC_POOL_COUNTERS = 3,
+};
+
+static int svc_pool_init_counters(struct svc_pool *pool)
+{
+	return percpu_counter_init_many(&pool->sp_messages_arrived, 0,
+					GFP_KERNEL, SVC_POOL_COUNTERS);
+}
+
+static void svc_pool_destroy_counters(struct svc_pool *pool)
+{
+	percpu_counter_destroy_many(&pool->sp_messages_arrived,
+				    SVC_POOL_COUNTERS);
+}
+
 /*
  * Create an RPC service
  */
@@ -540,12 +556,18 @@ __svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
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
@@ -624,9 +646,7 @@ svc_destroy(struct svc_serv **servp)
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


