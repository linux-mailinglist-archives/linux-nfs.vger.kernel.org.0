Return-Path: <linux-nfs+bounces-21045-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI+ROj0w6mmVwQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21045-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 16:44:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55BC453D6A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A954A300DDCA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6F23375D5;
	Thu, 23 Apr 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXFM7s7J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE7332EA0;
	Thu, 23 Apr 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955162; cv=none; b=h5Tv2Tmm+q9pQp+lQfao0e8Qb+iGXfMJEL5zLHWrcRxGnrsqmD2Wm7AmsCupqEaJ0R+hVaILv6Oo2o9IaanOTviDy/Ie5XmsBehCwp/JwYSxXpD/Ay7nnvayoKoOxt2+Br5L4unABxpWfDqHmVDY/XGHERYY3nnf/mNICOzKx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955162; c=relaxed/simple;
	bh=i5Uv2iIDCeJThQoP5+VSP77Y7VwvmVtcVdXHiq4f/L8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=go/t1LGiH6JW3xGQEl49+LrGdaMTwwgF2ie47h7vSW332K9ReCrzmjua+G2i5/WsnwdKC8UHEjyRy4aIK4GV2M/LARBR4w8Sa9XUMr0Jxyfp+d8qDAe3qbgHT2ewWfxIfEJPDtzmeTicbd90vdh1pjJ7Dzyn4geo7lSS/Mnnjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXFM7s7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE3C2BCAF;
	Thu, 23 Apr 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776955161;
	bh=i5Uv2iIDCeJThQoP5+VSP77Y7VwvmVtcVdXHiq4f/L8=;
	h=From:Date:Subject:To:Cc:From;
	b=CXFM7s7JlcW5yM/NGkH3eL2AiRO1y2i+PFzgK0CT9Hl4CaEvjDEXMV+mJPo203NOs
	 Qtv+62wbeapTA49XIeYlHyP0SGOchRbFH1hvHIpk33K2NyRKoiY75iMtUvsSIMU/ym
	 JI9vyfjeWNdJFXt4N62HZga+U6Lg7EBW2XSN+xGvSl+xwtNMBL8aUU1mEnFqQ5A9OZ
	 CAv7AQ58TJd4tOk/xQhbxtFgXm85OQIFJFaiKIpboJsou3fabEviaOzw3ho5PLxPsc
	 0+kNxi8Dpg8FEpdqnKAJ0z89WDEqWySm9ARimJ+bUjYH1XiTrpJFWKpKterT7mW6H5
	 hZ1vnBxYcvvpg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Apr 2026 10:39:14 -0400
Subject: [PATCH RFC] sunrpc: hardcode pool_mode to pernode, remove other
 modes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-sunrpc-pool-mode-v1-1-b7f20e35749b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNj3eLSvKKCZN2C/Pwc3dz8lFRd41SzJFMzYyODlGQTJaC2gqLUtMw
 KsJHRSkFuzkqxtbUA89XUHmcAAAA=
X-Change-ID: 20260423-sunrpc-pool-mode-3e6b56320dc4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10979; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=i5Uv2iIDCeJThQoP5+VSP77Y7VwvmVtcVdXHiq4f/L8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp6i8Ywoas5K5lCeEmLUuiqIT7iyb5YKuuUjnEf
 gxFXwP2Y8OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeovGAAKCRAADmhBGVaC
 FY0LD/0chFulmep9KzdEhhhUQQBrXhvrN4KR93oAZ1AW6veSTEes4CTlKle8KH3odWb3MhoL3ip
 ora29G8oP0L6ihY1QPW9bAgWHtE/1qw+d7rkQAMZjsRH6Cg5Dee/Txe0uGopftWYQTC3Z4pzSJD
 6OIVD1nS6rzck8kOYLymTe8WMlm2SCUquwLOzIcWhwMWKXGbpE7DmpGj7Zcc7v+M9c1HbizZzLE
 WuAi8iRoSYX72jyQhXIH/DpfpQ7ia1fmD6X+u0vuxRW7tWZaDpV3UUbutO65RnqSqZLQGPYphmy
 tnv743y5WOgGmJlv3fg37/RUJ2ZTjqZTwUthcV1f/vfcL5db3+WzPDVfhQWHglrEEL2MpcNencP
 PIzT0bSw2/DX88g5UiPfnwo54SRRCqHyu6tlO+ErRBAOPfOGi6uqwFSDuU53yGPxcjx82JxcBBp
 UYT8JW1iv3ufDqaU1mUrNiJsU1j6HolJSXOaT/UUSJsFbMs6vq/Wzg5EvOt10WBFvGh7kCW1uZK
 NMe7p23eavzYs+1c56HinkdHoodsIEP1LArvtBZKm6/0CDFt3kBO4gIU8VxsasIDIkLrjm/IuZI
 zcu2eTp2iTf2Owbn9sWqMKidcrIm6xWQXatY4VjgkM04IhgU4ufTFu2NLebZajF6SdQ5DI+qsFn
 IPsS7WFEUvHX1mQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21045-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E55BC453D6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
was added when NUMA was new and the right default was unclear.  Today,
pernode is the right choice everywhere:

- On multi-NUMA hosts, it gives one pool per node with proper thread
  affinity and NUMA-local memory allocation.
- On single-node hosts, pernode degenerates to exactly one pool,
  identical to the old "global" mode -- svc_pool_for_cpu() short-
  circuits when sv_nrpools <= 1, no CPU affinity is set, and memory
  is allocated from the single node.

The percpu mode (one pool per CPU) created excessive pools relative to
the number of threads most deployments run, and was only auto-selected
in a narrow case (single node, >2 CPUs).

Remove the SVC_POOL_* enum, mode selection heuristic,
svc_pool_map_init_percpu(), and all mode-based switch statements.
Simplify pool map functions to always use the pernode path.

The module parameter and netlink interfaces are preserved for backward
compatibility:
- Writing "pernode" succeeds; any other value returns -EINVAL
- Reading always returns "pernode"
- Writing to the module parameter emits a deprecation notice

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
In hindsight, I wish I had proposed this before adding the pool-mode
settings to the new nfsd netlink interfaces.

If this is too radical as a single step, we just could switch the
default to "pernode", add a warning and leave the interfaces alone for
now. Or maybe do that and go ahead and remove the percpu setting?

Thoughts?
---
 net/sunrpc/svc.c | 231 +++++++------------------------------------------------
 1 file changed, 29 insertions(+), 202 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 576fa42e7abf..8ecdd95c4867 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -38,19 +38,6 @@
 
 static void svc_unregister(const struct svc_serv *serv, struct net *net);
 
-#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
-
-/*
- * Mode for mapping cpus to pools.
- */
-enum {
-	SVC_POOL_AUTO = -1,	/* choose one of the others */
-	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
-				 * (legacy & UP mode) */
-	SVC_POOL_PERCPU,	/* one pool per cpu */
-	SVC_POOL_PERNODE	/* one pool per numa node */
-};
-
 /*
  * Structure for mapping cpus to pools and vice versa.
  * Setup once during sunrpc initialisation.
@@ -58,62 +45,20 @@ enum {
 
 struct svc_pool_map {
 	int count;			/* How many svc_servs use us */
-	int mode;			/* Note: int not enum to avoid
-					 * warnings about "enumeration value
-					 * not handled in switch" */
 	unsigned int npools;
-	unsigned int *pool_to;		/* maps pool id to cpu or node */
-	unsigned int *to_pool;		/* maps cpu or node to pool id */
+	unsigned int *pool_to;		/* maps pool id to node */
+	unsigned int *to_pool;		/* maps node to pool id */
 };
 
-static struct svc_pool_map svc_pool_map = {
-	.mode = SVC_POOL_DEFAULT
-};
+static struct svc_pool_map svc_pool_map;
 
 static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count only */
 
-static int
-__param_set_pool_mode(const char *val, struct svc_pool_map *m)
-{
-	int err, mode;
-
-	mutex_lock(&svc_pool_map_mutex);
-
-	err = 0;
-	if (!strncmp(val, "auto", 4))
-		mode = SVC_POOL_AUTO;
-	else if (!strncmp(val, "global", 6))
-		mode = SVC_POOL_GLOBAL;
-	else if (!strncmp(val, "percpu", 6))
-		mode = SVC_POOL_PERCPU;
-	else if (!strncmp(val, "pernode", 7))
-		mode = SVC_POOL_PERNODE;
-	else
-		err = -EINVAL;
-
-	if (err)
-		goto out;
-
-	if (m->count == 0)
-		m->mode = mode;
-	else if (mode != m->mode)
-		err = -EBUSY;
-out:
-	mutex_unlock(&svc_pool_map_mutex);
-	return err;
-}
-
-static int
-param_set_pool_mode(const char *val, const struct kernel_param *kp)
-{
-	struct svc_pool_map *m = kp->arg;
-
-	return __param_set_pool_mode(val, m);
-}
-
 int sunrpc_set_pool_mode(const char *val)
 {
-	return __param_set_pool_mode(val, &svc_pool_map);
+	if (strncmp(val, "pernode", 7))
+		return -EINVAL;
+	return 0;
 }
 EXPORT_SYMBOL(sunrpc_set_pool_mode);
 
@@ -122,84 +67,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
  * @buf: where to write the current pool_mode
  * @size: size of @buf
  *
- * Grab the current pool_mode from the svc_pool_map and write
- * the resulting string to @buf. Returns the number of characters
+ * Write the pool_mode string to @buf. Returns the number of characters
  * written to @buf (a'la snprintf()).
  */
 int
 sunrpc_get_pool_mode(char *buf, size_t size)
 {
-	struct svc_pool_map *m = &svc_pool_map;
-
-	switch (m->mode)
-	{
-	case SVC_POOL_AUTO:
-		return snprintf(buf, size, "auto");
-	case SVC_POOL_GLOBAL:
-		return snprintf(buf, size, "global");
-	case SVC_POOL_PERCPU:
-		return snprintf(buf, size, "percpu");
-	case SVC_POOL_PERNODE:
-		return snprintf(buf, size, "pernode");
-	default:
-		return snprintf(buf, size, "%d", m->mode);
-	}
+	return snprintf(buf, size, "pernode");
 }
 EXPORT_SYMBOL(sunrpc_get_pool_mode);
 
 static int
-param_get_pool_mode(char *buf, const struct kernel_param *kp)
+param_set_pool_mode(const char *val, const struct kernel_param *kp)
 {
-	char str[16];
-	int len;
-
-	len = sunrpc_get_pool_mode(str, ARRAY_SIZE(str));
-
-	/* Ensure we have room for newline and NUL */
-	len = min_t(int, len, ARRAY_SIZE(str) - 2);
-
-	/* tack on the newline */
-	str[len] = '\n';
-	str[len + 1] = '\0';
-
-	return sysfs_emit(buf, "%s", str);
+	pr_notice("sunrpc: the pool_mode parameter is deprecated and will be removed in a future release.\n");
+	return sunrpc_set_pool_mode(val);
 }
 
-module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
-		  &svc_pool_map, 0644);
-
-/*
- * Detect best pool mapping mode heuristically,
- * according to the machine's topology.
- */
 static int
-svc_pool_map_choose_mode(void)
+param_get_pool_mode(char *buf, const struct kernel_param *kp)
 {
-	unsigned int node;
-
-	if (nr_online_nodes > 1) {
-		/*
-		 * Actually have multiple NUMA nodes,
-		 * so split pools on NUMA node boundaries
-		 */
-		return SVC_POOL_PERNODE;
-	}
-
-	node = first_online_node;
-	if (nr_cpus_node(node) > 2) {
-		/*
-		 * Non-trivial SMP, or CONFIG_NUMA on
-		 * non-NUMA hardware, e.g. with a generic
-		 * x86_64 kernel on Xeons.  In this case we
-		 * want to divide the pools on cpu boundaries.
-		 */
-		return SVC_POOL_PERCPU;
-	}
-
-	/* default: one global pool */
-	return SVC_POOL_GLOBAL;
+	return sysfs_emit(buf, "pernode\n");
 }
 
+module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
+		  NULL, 0644);
+
 /*
  * Allocate the to_pool[] and pool_to[] arrays.
  * Returns 0 on success or an errno.
@@ -224,35 +117,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsigned int maxpools)
 }
 
 /*
- * Initialise the pool map for SVC_POOL_PERCPU mode.
- * Returns number of pools or <0 on error.
- */
-static int
-svc_pool_map_init_percpu(struct svc_pool_map *m)
-{
-	unsigned int maxpools = nr_cpu_ids;
-	unsigned int pidx = 0;
-	unsigned int cpu;
-	int err;
-
-	err = svc_pool_map_alloc_arrays(m, maxpools);
-	if (err)
-		return err;
-
-	for_each_online_cpu(cpu) {
-		BUG_ON(pidx >= maxpools);
-		m->to_pool[cpu] = pidx;
-		m->pool_to[pidx] = cpu;
-		pidx++;
-	}
-	/* cpus brought online later all get mapped to pool0, sorry */
-
-	return pidx;
-};
-
-
-/*
- * Initialise the pool map for SVC_POOL_PERNODE mode.
+ * Initialise the pool map for one pool per NUMA node.
  * Returns number of pools or <0 on error.
  */
 static int
@@ -284,14 +149,13 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
  * Add a reference to the global map of cpus to pools (and
  * vice versa) if pools are in use.
  * Initialise the map if we're the first user.
- * Returns the number of pools. If this is '1', no reference
- * was taken.
+ * Returns the number of pools.
  */
 static unsigned int
 svc_pool_map_get(void)
 {
 	struct svc_pool_map *m = &svc_pool_map;
-	int npools = -1;
+	int npools;
 
 	mutex_lock(&svc_pool_map_mutex);
 	if (m->count++) {
@@ -299,23 +163,9 @@ svc_pool_map_get(void)
 		return m->npools;
 	}
 
-	if (m->mode == SVC_POOL_AUTO)
-		m->mode = svc_pool_map_choose_mode();
-
-	switch (m->mode) {
-	case SVC_POOL_PERCPU:
-		npools = svc_pool_map_init_percpu(m);
-		break;
-	case SVC_POOL_PERNODE:
-		npools = svc_pool_map_init_pernode(m);
-		break;
-	}
-
-	if (npools <= 0) {
-		/* default, or memory allocation failure */
+	npools = svc_pool_map_init_pernode(m);
+	if (npools <= 0)
 		npools = 1;
-		m->mode = SVC_POOL_GLOBAL;
-	}
 	m->npools = npools;
 	mutex_unlock(&svc_pool_map_mutex);
 	return npools;
@@ -346,14 +196,11 @@ static int svc_pool_map_get_node(unsigned int pidx)
 {
 	const struct svc_pool_map *m = &svc_pool_map;
 
-	if (m->count) {
-		if (m->mode == SVC_POOL_PERCPU)
-			return cpu_to_node(m->pool_to[pidx]);
-		if (m->mode == SVC_POOL_PERNODE)
-			return m->pool_to[pidx];
-	}
+	if (m->count)
+		return m->pool_to[pidx];
 	return numa_mem_id();
 }
+
 /*
  * Set the given thread's cpus_allowed mask so that it
  * will only run on cpus in the given pool.
@@ -372,27 +219,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 	if (m->count == 0)
 		return;
 
-	switch (m->mode) {
-	case SVC_POOL_PERCPU:
-	{
-		set_cpus_allowed_ptr(task, cpumask_of(node));
-		break;
-	}
-	case SVC_POOL_PERNODE:
-	{
-		set_cpus_allowed_ptr(task, cpumask_of_node(node));
-		break;
-	}
-	}
+	set_cpus_allowed_ptr(task, cpumask_of_node(node));
 }
 
 /**
  * svc_pool_for_cpu - Select pool to run a thread on this cpu
  * @serv: An RPC service
  *
- * Use the active CPU and the svc_pool_map's mode setting to
- * select the svc thread pool to use. Once initialized, the
- * svc_pool_map does not change.
+ * Use the active CPU and the svc_pool_map to select the svc thread
+ * pool to use. Once initialized, the svc_pool_map does not change.
  *
  * Return value:
  *   A pointer to an svc_pool
@@ -400,20 +235,12 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 {
 	struct svc_pool_map *m = &svc_pool_map;
-	int cpu = raw_smp_processor_id();
-	unsigned int pidx = 0;
+	unsigned int pidx;
 
 	if (serv->sv_nrpools <= 1)
 		return serv->sv_pools;
 
-	switch (m->mode) {
-	case SVC_POOL_PERCPU:
-		pidx = m->to_pool[cpu];
-		break;
-	case SVC_POOL_PERNODE:
-		pidx = m->to_pool[cpu_to_node(cpu)];
-		break;
-	}
+	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())];
 
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }

---
base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
change-id: 20260423-sunrpc-pool-mode-3e6b56320dc4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


