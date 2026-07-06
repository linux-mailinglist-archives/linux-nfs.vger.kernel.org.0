Return-Path: <linux-nfs+bounces-23066-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j3aHNm2wS2o+YgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23066-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:41:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BE71161B
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dYHn4nkO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23066-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23066-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4156230363CD
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D03414A2F;
	Mon,  6 Jul 2026 13:29:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76F2BEC5F;
	Mon,  6 Jul 2026 13:29:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344576; cv=none; b=rgNhlyb3ww1ikEBGJ3vb6IA9P5BxrU1BNZrjgBQPvlbgsshAf5qI4oyILCN4dkL81VWFhZ1cdrVng6Zes4Q7WU5omFAUYyp2FxYcuMga6/RH7NjXUWEmX7bromswDsFKw12OHc2UWd+KeBeWBs5mA+yO76WQ1hPcabP8YfQufNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344576; c=relaxed/simple;
	bh=CV0Z3rbDTj8mQRY+XLMhr0oDwrc3n8e2H48wYRpgVVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIIl4kkdDdz/jCYIhLJXcOIOUWCsdyPMNltWLLswVlGmV49DTTXM/vrM88zTOikNRsOsDiV1waC+w4R+7n/mr8L9Cjhc3L51rR8wuoI5DRu8Kznbq3mOOfi+tu/9iWGElNtG763ugLBO9belsUqDJ4858qi3gz19x/upptTnotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYHn4nkO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C8C1F00A3F;
	Mon,  6 Jul 2026 13:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344570;
	bh=4FF1WaNh41nqfSf62wYOnG5yaYUd+CgTSuBz6DIi6Kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dYHn4nkOXBV0XH2Sf88+QJi3SkcdAdCsLXkMt+ZWz+UbLybd1oPjpvEmaLY/MNLot
	 whMlXmfcQQ4qcZeRzyJ2SvHfvtsHOH7mUVCK2HVFFtIbP5v/hBkJyehFQmHr2L5hEd
	 rDc1hF51UdOObu1qUTSmE71+O2tChezjKwepDlUj6iepW8hcVEsCwC/TsZRsHYbu5k
	 hkSDK2ZMikuyFiWQTB/LW+pUKI8UEjqPbFg4G9vNiiVMimw4M9/zbucN3mh92HBHjq
	 7dAYHdsVBd/ZfKnd/JNwaZaLdkBDNI3VJMlKIIFTcpVq6kXiTqVwKP5H6R6HPmky34
	 SqfnbUqaKBbXw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 06 Jul 2026 09:29:22 -0400
Subject: [PATCH v5 2/5] sunrpc: hardcode pool_mode to pernode, remove other
 modes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-sunrpc-pool-mode-v5-2-6c4ee7cd89aa@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
In-Reply-To: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15674; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CV0Z3rbDTj8mQRY+XLMhr0oDwrc3n8e2H48wYRpgVVI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqS622F+HJnC0Da0uPX/NmE9nyzugiVQFCtvpFR
 b/EvENuTsSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakuttgAKCRAADmhBGVaC
 FdNSD/wIVcUlLGCmhtruujH4X2gQVGsi8jAhg/RcNycsAQi7PRIgmMaSFGZZAODtAm89cG61CVF
 AbUWPOH7j3Vcp3F8jrv81HsGe7tUlaf9N3K1AXN8xaiKiEdIKVPchYhl+58TJjlsBwvyNP+h1Xt
 Ihn9K5oym5jag4g1h+F99FTHlB/k+gXYY/ObnCwhK6Cx/kksa0O1OUvhkxfwSn8YpZJR7pH9Nrp
 Cm09vDAL1UsVZhkjZCNvS6NwUiBE7WKxKOkSLOO53zrPdIqkp5fJVPr6brdVf3CvsS1YLlycO5p
 sZbgkBmaKZs2Ls2qjiJLwyVIYSGGJTa+Y2jKN8yd/MMgGY3vGjubf7jtlYPHMpWToOT629sAqGW
 AH16v61RF1MIF/iRD1I1CGeF5TxhqKDXR7zCzYnD9dsa38r0wk9uWXRAxdnySs+vH8qSf5NPi3y
 sGsMi7GptJqpoHV4ke+Kj9NlH/y/uYKXJZDZX7luyN1SW/sXxdkrLZMDc2I9uxVGd4kLNZ5hCol
 EzIcRBOucpjUZnasKTg2HN1rHwfulL5qg5NSvhYh31gnbFHt6y7LS9sWMCPcVEV50fw5p8wRQNV
 AEbf3AdsbKT+4Ov/sPAO+dtdezWENZehO4t6QQP4iOsatk4ym2BygRECIQvoSw/AYrkRRTINdwb
 Nfd7o+K5ZE589bA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23066-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D4BE71161B

The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
was added when NUMA was new and the right default was unclear.  The
default has always been "global" (a single pool for the whole service);
the other modes were only used when an admin explicitly set the
pool_mode parameter or asked for "auto", which then picked a mode from
the host topology.  Today, pernode is the right choice everywhere:

- On multi-NUMA hosts, it gives one pool per node with proper thread
  affinity and NUMA-local memory allocation.
- On single-node hosts, pernode degenerates to exactly one pool,
  identical to the old "global" mode -- svc_pool_for_cpu() short-
  circuits when sv_nrpools <= 1, no CPU affinity is set, and memory
  is allocated from the single node.

The percpu mode (one pool per CPU) created excessive pools relative to
the number of threads most deployments run, and was only auto-selected
in a narrow case (single node, >2 CPUs).

Note that this changes the default behaviour on multi-NUMA hosts: a
service that previously ran with a single global pool now gets one pool
per NUMA node by default.  This in turn means a host running fewer
threads than it has NUMA nodes can end up with pools that have no
threads.  svc_pool_for_cpu() already falls back to a populated pool in
that case, so transports are still serviced.

Remove the SVC_POOL_* enum, mode selection heuristic,
svc_pool_map_init_percpu(), and all mode-based switch statements.
Simplify pool map functions to always use the pernode path.  If pool
map allocation fails, svc_pool_map_get() now returns 0 and service
creation fails, rather than silently falling back to a single global
pool.

With the mode check gone, svc_pool_map_get_node() would dereference the
shared pool_to[] for every service that starts a thread.  Only services
created via svc_create_pooled() hold a map reference that keeps that
array allocated, so gate the lookup in svc_new_thread() on sv_is_pooled:
unpooled services (e.g. lockd, the NFS callback) use NUMA_NO_NODE and
never consult the map.  The kmalloc_node() callers in
svc_prepare_thread() already accept NUMA_NO_NODE, but __folio_alloc_node()
requires a valid node id, so resolve NUMA_NO_NODE to numa_mem_id() for
the scratch folio allocation.

The module parameter and netlink interfaces are preserved for backward
compatibility:
- Writing any of the four documented mode names still succeeds silently
- Reading always returns "pernode"
- Writing to the module parameter emits a deprecation notice

Update Documentation/admin-guide/kernel-parameters.txt to mark the
pool_mode parameter deprecated and describe the new behaviour.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  20 +-
 net/sunrpc/svc.c                                | 265 ++++++------------------
 2 files changed, 65 insertions(+), 220 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..441b78867478 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7441,19 +7441,13 @@ Kernel parameters
 
 	sunrpc.pool_mode=
 			[NFS]
-			Control how the NFS server code allocates CPUs to
-			service thread pools.  Depending on how many NICs
-			you have and where their interrupts are bound, this
-			option will affect which CPUs will do NFS serving.
-			Note: this parameter cannot be changed while the
-			NFS server is running.
-
-			auto	    the server chooses an appropriate mode
-				    automatically using heuristics
-			global	    a single global pool contains all CPUs
-			percpu	    one pool for each CPU
-			pernode	    one pool for each NUMA node (equivalent
-				    to global on non-NUMA machines)
+			Deprecated.  The NFS server now always uses one
+			service thread pool per NUMA node (equivalent to a
+			single global pool on non-NUMA machines).  All of
+			the previously accepted values (auto, global,
+			percpu, pernode) are still accepted for backward
+			compatibility but are ignored: the mode is always
+			pernode, and reads always return "pernode".
 
 	sunrpc.tcp_slot_table_entries=
 	sunrpc.udp_slot_table_entries=
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index fa8056fb0b4d..b942845f82a3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -38,82 +38,36 @@
 
 static void svc_unregister(const struct svc_serv *serv, struct net *net);
 
-#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
-
 /*
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
-/*
- * Structure for mapping cpus to pools and vice versa.
+ * Structure for mapping nodes to pools and vice versa.
  * Setup once during sunrpc initialisation.
  */
 
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
+/*
+ * Pool modes that were historically accepted. They no longer select
+ * anything: the pool mode is always pernode. The names are retained
+ * only so that writing a previously-valid value still succeeds.
+ */
+static const char * const pool_mode_names[] = {
+	"auto", "global", "percpu", "pernode",
+};
 
 int sunrpc_set_pool_mode(const char *val)
 {
-	return __param_set_pool_mode(val, &svc_pool_map);
+	int idx = sysfs_match_string(pool_mode_names, val);
+
+	return idx < 0 ? idx : 0;
 }
 EXPORT_SYMBOL(sunrpc_set_pool_mode);
 
@@ -122,84 +76,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
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
+	pr_notice_once("sunrpc: the pool_mode module parameter is deprecated and no longer has any effect; the pool mode is always 'pernode'\n");
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
@@ -224,35 +126,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsigned int maxpools)
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
@@ -281,17 +155,16 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
 
 
 /*
- * Add a reference to the global map of cpus to pools (and
+ * Add a reference to the global map of nodes to pools (and
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
@@ -299,22 +172,11 @@ svc_pool_map_get(void)
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
+		m->count = 0;
+		mutex_unlock(&svc_pool_map_mutex);
+		return 0;
 	}
 	m->npools = npools;
 	mutex_unlock(&svc_pool_map_mutex);
@@ -322,7 +184,7 @@ svc_pool_map_get(void)
 }
 
 /*
- * Drop a reference to the global map of cpus to pools.
+ * Drop a reference to the global map of nodes to pools.
  * When the last reference is dropped, the map data is
  * freed; this allows the sysadmin to change the pool.
  */
@@ -346,14 +208,11 @@ static int svc_pool_map_get_node(unsigned int pidx)
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
@@ -372,27 +231,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
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
@@ -400,22 +247,12 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 {
 	struct svc_pool_map *m = &svc_pool_map;
-	int cpu = raw_smp_processor_id();
-	unsigned int pidx = 0;
-	unsigned int i;
+	unsigned int pidx, i;
 
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
-	pidx %= serv->sv_nrpools;
+	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_nrpools;
 
 	/*
 	 * It's possible to have a pool with no threads. Userland can just set
@@ -644,6 +481,9 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
+	if (!npools)
+		return NULL;
+
 	serv = __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
@@ -778,7 +618,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
-	rqstp->rq_scratch_folio = __folio_alloc_node(GFP_KERNEL, 0, node);
+	/* __folio_alloc_node() rejects NUMA_NO_NODE; let it pick for us */
+	rqstp->rq_scratch_folio =
+		__folio_alloc_node(GFP_KERNEL, 0,
+				   node == NUMA_NO_NODE ? numa_mem_id() : node);
 	if (!rqstp->rq_scratch_folio)
 		goto out_enomem;
 
@@ -867,7 +710,15 @@ int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)
 	int node;
 	int err = 0;
 
-	node = svc_pool_map_get_node(pool->sp_id);
+	/*
+	 * Only pooled services hold a reference to the pool map, so only they
+	 * may consult it. Unpooled services (e.g. lockd, the NFS callback)
+	 * leave placement to the allocator.
+	 */
+	if (serv->sv_is_pooled)
+		node = svc_pool_map_get_node(pool->sp_id);
+	else
+		node = NUMA_NO_NODE;
 
 	rqstp = svc_prepare_thread(serv, pool, node);
 	if (!rqstp)

-- 
2.55.0


