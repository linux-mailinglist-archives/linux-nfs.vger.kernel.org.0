Return-Path: <linux-nfs+bounces-22837-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yYPpCF9RPWrl1AgAu9opvQ
	(envelope-from <linux-nfs+bounces-22837-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 18:03:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 780226C7455
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 18:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="U/H2L9L7";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22837-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22837-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424CD3013AB8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C67347DD;
	Thu, 25 Jun 2026 15:59:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D539DBD3;
	Thu, 25 Jun 2026 15:59:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403176; cv=none; b=ON6BFn8wnudBS0xW23urJvn2JSXYcUngg+BCYP/52WtnTTJbN6FpZ+Pjta921rX6zMQMkmFIkBr0SFlfUVZ8qgqAGx38ZnaqmWsw//tNRLKB0dacwwg1JCS38DS3OUwTISdZKpC4K17kHwP4wX1J1675lv1zNYsRIbsfMVUuYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403176; c=relaxed/simple;
	bh=O8177/r+ZRF6LumEG0yEsC9akdg2bo3Vfcw/+iSzyCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CXaTMinz1VmUEGaMUnUmdFpc5t0MI4+z8h+IzB7rBde3dDf0+MH+YtnI6r9fSX4QprFSk5rkgY/AKWnY2fZgNR4crzr97TpJxTso7BI64roYXAuV/QmgIrvHXzIBzVzdAyoJGR85sFjlhGHpnLXFDdk+xL7BrH40zu9grEF+VEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/H2L9L7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E56D1F00A3A;
	Thu, 25 Jun 2026 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782403173;
	bh=KTPeIBMXNOYdTnoR73zQWWWnwBUY1pCca85qwIRX0U0=;
	h=From:Date:Subject:To:Cc;
	b=U/H2L9L7zOdYsDdA7z+ULDLCOFUBlUpEWjP329XZj2rzNZ+pMmeW3WFdQhMeqZDeo
	 Ym+p4GhWeJr4YAZXW3rZraJ6Lz96Sv2ETdnlVv3hNlcfsxQ6H0za2ceRyUrGejQEmH
	 4SJtuOUq55iQlCa1pBv0pHjwCXXhkwKx4dyNdUDFTVNKjrL9zY6gco9UsKN4ZI/esd
	 09I/ZtfLfa0EnUzzicxlTFXsmaoHquW1AhwJrDEesrGrk75ALaIasSwazjYpc5t8Sn
	 gqRrOQe1BzIz8IdDnpVdYgvciCoCoheBoeN8/M8BXJh7PEtp2gbKJmnwZMBAlhqGEe
	 gX6bqxcqsXTjw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jun 2026 11:59:18 -0400
Subject: [PATCH v2] sunrpc: hardcode pool_mode to pernode, remove other
 modes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZjSlhJdeQ/DQtoBGrFtpko0h
 LtbOYDL95L//gqZ2FOGc7UC0+Kzj6GAPFRgp1sYCb0rDFJII7RUmF+Bk8UU44yP6AgVmb4xSgp
 nNZRZYhr8e09eu8KTz8/In/1hqX/2T2ypsca+HaQg1bT61F/uxIHmY+QRum3bvh58mfCxAAAA
X-Change-ID: 20260423-sunrpc-pool-mode-3e6b56320dc4
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11594; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=O8177/r+ZRF6LumEG0yEsC9akdg2bo3Vfcw/+iSzyCY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqPVBdXmFYsY0lxHV55fxE7qh498FgUuobwN2Jo
 2tAiV9q4OmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaj1QXQAKCRAADmhBGVaC
 FXNHEAChAKoZQcTdnyiJEUzr0uarPaa5tuwGEIIlfuWyA97EXOTZ+XxWseMNDvQ0DNh0pciH6bM
 I9ip/Usm2aQ6DWw1uBiTusQatlC5kXiQPtd8r1w7Ha4QjRBPOp3J68FS5KTO8oimm4WAJ70t2Y7
 jDeFI8amvviSyyp/NhTg5JcjlpfzjF0ez1/ZK5ss800VC9tQ+kpbG0qhSFOtoRQn6YA8yLu4mrv
 YiD9CMHPWp92P8cmJsOxygUaWTOxig9PzaekZTbRtWZKrtTNEHltHPpg3d5P17NyVm1xaAggLTq
 44QC13sMprNh5/Wt3u8LgKz7LBDpMJyFMitG4Y6EF18aysiP1v+DkP0GKSVab7T0RODUBOves4M
 r2OP/omC1Qd2zT8hBGYb+YbJpfCb2otYOVecBj9k8v04ilHy/INvQ59b2ERkW3OyyWAOrzE0o+g
 QUfGYki7H3SUKHBCNhuW8XsGZEpO+dQ04SRes4IXUnJc9vO0DHkwDTYJZLwEPPD4plFFz3tupgb
 3/9EhN9+spIU2ka/z5yHotfwdOUb46hqD6GEpusiywLQ6s6h0zP6ODsOiJ7ixpV03A05YfXw4XR
 jqSG0IpZz65zz+aoQfVMsugm7QmEOmlK+Gg4Ev7DR0m1iuHEdL7G6FQiCZARMi+HhhFRBR1t07H
 0iL4jqGSqcOhz9w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22837-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 780226C7455

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
Simplify pool map functions to always use the pernode path.  If pool
map allocation fails, svc_pool_map_get() now returns 0 and service
creation fails, rather than silently falling back to a single global
pool.

The module parameter and netlink interfaces are preserved for backward
compatibility:
- Writing any previously-accepted value succeeds silently
- Reading always returns "pernode"
- Writing to the module parameter emits a deprecation notice

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This version is essentially the same as v1, but allows the kernel to
accept any previously-accepted setting for pool-mode, which should
alleviate concerns about breakage.
---
Changes in v2:
- Accept any previously-accepted setting for pool_mode
- Link to v1: https://lore.kernel.org/r/20260423-sunrpc-pool-mode-v1-1-b7f20e35749b@kernel.org
---
 net/sunrpc/svc.c | 238 +++++++++----------------------------------------------
 1 file changed, 37 insertions(+), 201 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dd80a2eaaa74..6e3d509bf95a 100644
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
@@ -58,62 +45,23 @@ enum {
 
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
+	if (!strncmp(val, "auto", 4) ||
+	    !strncmp(val, "global", 6) ||
+	    !strncmp(val, "percpu", 6) ||
+	    !strncmp(val, "pernode", 7))
+		return 0;
+	return -EINVAL;
 }
 EXPORT_SYMBOL(sunrpc_set_pool_mode);
 
@@ -122,84 +70,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
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
@@ -224,35 +120,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsigned int maxpools)
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
@@ -284,14 +152,13 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
  * Add a reference to the global map of cpus to pools (and
  * vice versa) if pools are in use.
  * Initialise the map if we're the first user.
- * Returns the number of pools. If this is '1', no reference
- * was taken.
+ * Returns the number of pools, or 0 on failure.
  */
 static unsigned int
 svc_pool_map_get(void)
 {
 	struct svc_pool_map *m = &svc_pool_map;
-	int npools = -1;
+	int npools;
 
 	mutex_lock(&svc_pool_map_mutex);
 	if (m->count++) {
@@ -299,22 +166,11 @@ svc_pool_map_get(void)
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
+	npools = svc_pool_map_init_pernode(m);
 	if (npools <= 0) {
-		/* default, or memory allocation failure */
-		npools = 1;
-		m->mode = SVC_POOL_GLOBAL;
+		m->count--;
+		mutex_unlock(&svc_pool_map_mutex);
+		return 0;
 	}
 	m->npools = npools;
 	mutex_unlock(&svc_pool_map_mutex);
@@ -346,14 +202,11 @@ static int svc_pool_map_get_node(unsigned int pidx)
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
@@ -372,27 +225,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
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
@@ -400,20 +241,12 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
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
@@ -617,6 +450,9 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
+	if (!npools)
+		return NULL;
+
 	serv = __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;

---
base-commit: 2bb83225da8ee0383d17783b5c903589696faf90
change-id: 20260423-sunrpc-pool-mode-3e6b56320dc4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


