Return-Path: <linux-nfs+bounces-22888-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5+4JM1u9Q2rZgAoAu9opvQ
	(envelope-from <linux-nfs+bounces-22888-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 14:58:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C40196E484B
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 14:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Q5zy0bB/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22888-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22888-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52E5730717C5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E5411674;
	Tue, 30 Jun 2026 12:48:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B6411672;
	Tue, 30 Jun 2026 12:48:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823732; cv=none; b=KRqXV80bHc32b/0Jlt9PDHkEfBJa6uev5fjrzE0O96NZIF2is1V+oIlHahCz9fq1WpZAzIn1CKs4CTh4Fbx4+EhSW/1YNHASrEYdrR9DN6p1BRinppugXzV+/+Wp/H/pX/oBFc/z9oNUqVlWk4G06Lkd4Fb5pMonjyEpk92Ix+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823732; c=relaxed/simple;
	bh=DLembs2KsulvsiI4ZHQLxvjicweq8u7kYy3s6HFFEmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYcWR6OYYbT+LspSWuiCxx6wGGUws0BjpdUnFF5+VLYdtByR9EVr6ndSu/n7EU35VoGvAuzPaGHL5hruA6IBPrqpw794HU0ITl5Np2TeSOgI81RHd7TgQQw6aCbu0jXALTzK1iQoPpsBVeUZSc1YYi82i+4p6CIfL44GzIvGLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5zy0bB/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCE61F000E9;
	Tue, 30 Jun 2026 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823730;
	bh=PfKy2Q298N1Frsyoz/1Bob8hdbhUypxEFV9nYQcw6uE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5zy0bB/JJiCtgLWhsuSLGVLwOVsWBHXfrDrjhPD9iCcBL89aTpNaGNQ6Xske3jnZ
	 7KSF9UBooD4pkCwFra4M4vOHWE6s7FBE35oZ23uDuPVnZSq31okhcOK57QQQj+SDKu
	 AfWJ36pWU7STKcs3af46q2e4RjbbmEjNxcWuv0+j5bArCdWg3dlPEWQuyz7PIa0fzA
	 hLQg3yDKRtSRNEoBVJsgAxrdLEnbzSir33rxxqs01t88isKBR1cDICt00/3cP8P6HM
	 FMJ52+KQj0YtBTZHjWVyV4G7ouW2u6dXmmu1iuCaJ2r1VDDAKaiVwf4H87ZxxiCS1s
	 /YvxCXhmAJTmQ==
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5/4] sunrpc: protect the svc_pool_map pool_to[] array with RCU
Date: Tue, 30 Jun 2026 08:48:47 -0400
Message-ID: <20260630124847.289974-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org>
References: <20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22888-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C40196E484B

svc_pool_map_get_node() reads the global svc_pool_map without holding
svc_pool_map_mutex and dereferences m->pool_to[]. The array was both
published and torn down without any synchronisation against that
lockless reader:

 - svc_pool_map_get() incremented m->count to one before
   svc_pool_map_init_pernode() allocated and filled the arrays, so a
   reader observing the map as "in use" could see a NULL (or partially
   built) pool_to[] and oops.

 - svc_pool_map_put() freed the arrays as soon as the last reference
   went away, so a reader that had already started dereferencing
   pool_to[] could use it after free.

svc_new_thread() takes this lockless path for every service, including
unpooled ones that hold no map reference, so the reader genuinely can
run concurrently with another service's startup or shutdown.

Publish pool_to[] with rcu_assign_pointer() only after it is fully
built in a private allocation, and have svc_pool_map_get_node()
dereference it under rcu_read_lock(). On teardown, clear the pointer
and defer the free past a grace period with kfree_rcu_mightsleep().

svc_pool_map_set_cpumask() also reads pool_to[], but its caller holds a
map reference (it checks sv_nrpools > 1) so the array is stable; it uses
rcu_dereference_protected() rather than taking the read lock.

to_pool[] needs no such treatment: it is only read by services that
hold a map reference, so it cannot be freed under a reader.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 net/sunrpc/svc.c | 91 +++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

Sashiko pointed out this (preexisting) problem during review of the
other 4 in the series. I figure we might as well fix it too while we're
in here.

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4fff0725ef8f..ebd953248e34 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -46,13 +46,13 @@ static void svc_unregister(const struct svc_serv *serv, struct net *net);
 struct svc_pool_map {
 	int count;			/* How many svc_servs use us */
 	unsigned int npools;
-	unsigned int *pool_to;		/* maps pool id to node */
+	unsigned int __rcu *pool_to;	/* maps pool id to node */
 	unsigned int *to_pool;		/* maps node to pool id */
 };
 
 static struct svc_pool_map svc_pool_map;
 
-static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count only */
+static DEFINE_MUTEX(svc_pool_map_mutex);/* serialises svc_pool_map updates */
 
 /*
  * Pool modes that were historically accepted. They no longer select
@@ -102,32 +102,12 @@ param_get_pool_mode(char *buf, const struct kernel_param *kp)
 module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
 		  NULL, 0644);
 
-/*
- * Allocate the to_pool[] and pool_to[] arrays.
- * Returns 0 on success or an errno.
- */
-static int
-svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsigned int maxpools)
-{
-	m->to_pool = kcalloc(maxpools, sizeof(unsigned int), GFP_KERNEL);
-	if (!m->to_pool)
-		goto fail;
-	m->pool_to = kcalloc(maxpools, sizeof(unsigned int), GFP_KERNEL);
-	if (!m->pool_to)
-		goto fail_free;
-
-	return 0;
-
-fail_free:
-	kfree(m->to_pool);
-	m->to_pool = NULL;
-fail:
-	return -ENOMEM;
-}
-
 /*
  * Initialise the pool map for one pool per NUMA node.
  * Returns number of pools or <0 on error.
+ *
+ * pool_to[] is published with rcu_assign_pointer() only once fully built,
+ * so a lockless reader sees either NULL or a complete map.
  */
 static int
 svc_pool_map_init_pernode(struct svc_pool_map *m)
@@ -135,21 +115,30 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
 	unsigned int maxpools = nr_node_ids;
 	unsigned int pidx = 0;
 	unsigned int node;
-	int err;
+	unsigned int *to_pool, *pool_to;
 
-	err = svc_pool_map_alloc_arrays(m, maxpools);
-	if (err)
-		return err;
+	to_pool = kcalloc(maxpools, sizeof(*to_pool), GFP_KERNEL);
+	if (!to_pool)
+		return -ENOMEM;
+	pool_to = kcalloc(maxpools, sizeof(*pool_to), GFP_KERNEL);
+	if (!pool_to) {
+		kfree(to_pool);
+		return -ENOMEM;
+	}
 
 	for_each_node_with_cpus(node) {
 		/* some architectures (e.g. SN2) have cpuless nodes */
 		BUG_ON(pidx > maxpools);
-		m->to_pool[node] = pidx;
-		m->pool_to[pidx] = node;
+		to_pool[node] = pidx;
+		pool_to[pidx] = node;
 		pidx++;
 	}
 	/* nodes brought online later all get mapped to pool0, sorry */
 
+	m->npools = pidx;
+	m->to_pool = to_pool;
+	rcu_assign_pointer(m->pool_to, pool_to);
+
 	return pidx;
 }
 
@@ -178,7 +167,6 @@ svc_pool_map_get(void)
 		mutex_unlock(&svc_pool_map_mutex);
 		return 0;
 	}
-	m->npools = npools;
 	mutex_unlock(&svc_pool_map_mutex);
 	return npools;
 }
@@ -195,11 +183,21 @@ svc_pool_map_put(void)
 
 	mutex_lock(&svc_pool_map_mutex);
 	if (!--m->count) {
+		unsigned int *pool_to;
+
+		/* Protected by svc_pool_map_mutex */
+		pool_to = rcu_dereference_protected(m->pool_to, 1);
+
+		/*
+		 * Defer the pool_to[] free past a grace period; a lockless
+		 * reader may still hold it. to_pool[] has no such readers, so
+		 * free it directly.
+		 */
+		rcu_assign_pointer(m->pool_to, NULL);
 		kfree(m->to_pool);
 		m->to_pool = NULL;
-		kfree(m->pool_to);
-		m->pool_to = NULL;
 		m->npools = 0;
+		kfree_rcu_mightsleep(pool_to);
 	}
 	mutex_unlock(&svc_pool_map_mutex);
 }
@@ -207,10 +205,15 @@ svc_pool_map_put(void)
 static int svc_pool_map_get_node(unsigned int pidx)
 {
 	const struct svc_pool_map *m = &svc_pool_map;
+	const unsigned int *pool_to;
+	int node = numa_mem_id();
 
-	if (m->count)
-		return m->pool_to[pidx];
-	return numa_mem_id();
+	rcu_read_lock();
+	pool_to = rcu_dereference(m->pool_to);
+	if (pool_to)
+		node = pool_to[pidx];
+	rcu_read_unlock();
+	return node;
 }
 
 /*
@@ -221,17 +224,19 @@ static inline void
 svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 {
 	struct svc_pool_map *m = &svc_pool_map;
-	unsigned int node = m->pool_to[pidx];
+	const unsigned int *pool_to;
 
 	/*
-	 * The caller checks for sv_nrpools > 1, which
-	 * implies that we've been initialized.
+	 * The caller checks for sv_nrpools > 1, so its service holds a
+	 * reference to the map: pool_to[] is allocated and cannot be freed
+	 * under us. No RCU read lock is needed; the held reference keeps the
+	 * array stable.
 	 */
-	WARN_ON_ONCE(m->count == 0);
-	if (m->count == 0)
+	pool_to = rcu_dereference_protected(m->pool_to, 1);
+	if (WARN_ON_ONCE(!pool_to))
 		return;
 
-	set_cpus_allowed_ptr(task, cpumask_of_node(node));
+	set_cpus_allowed_ptr(task, cpumask_of_node(pool_to[pidx]));
 }
 
 /**
-- 
2.54.0


