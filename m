Return-Path: <linux-nfs+bounces-18756-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIAkMli/hGnG4wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18756-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 17:03:36 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2FF4EDB
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 823B7309B19D
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A642DFEC;
	Thu,  5 Feb 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcZzRNri"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625042DFE2
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307053; cv=none; b=bdZzvDDX98Si3qn08f0Do78CFxWubqb55LqfN4sAM35J/xMAcsbatfdH7noHdzZxZQdZXwzlJHUxFZYLPb9zlolFQkhqlC5KWF2xJD5xVGLwFCZbr/CZVNXXBUQ7QVDsjuPRmSdjCbhEZ1vivRVn8yv363Xzd9+CjL+zZHSQ9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307053; c=relaxed/simple;
	bh=Orgo4oIj4N/29gL0WlGgRR14ni0CtwTjzh0Hy0NObIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSGlNgX/1w2rF4n0AVMlkR3ul7Ya6m3kR6mLt4z3GQAflV0lKzOJeOXUzA/IyyDpqJLUyQ421Yo73cRWWpKPjiUuSo1a2Peuj5C8qItzs4HQ4zQhbD2BnPkIr9FODZCVfn5qxYcvxRMJqBg6tyzBkl+K/3FoliXngHDr+mtPRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcZzRNri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB4EC2BC86;
	Thu,  5 Feb 2026 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307053;
	bh=Orgo4oIj4N/29gL0WlGgRR14ni0CtwTjzh0Hy0NObIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcZzRNri2hTvJNslnLVbRriGEbvolHH5gACkB5QSKkFV8Sl51l30wDzhHMwIchAD2
	 8Sn06aU3Rf5hLDhLlPWUApdNwJua4gsI5Q7CnUi8eEHS7JZJ+4zK3mzujGrsKCFb9I
	 N+Ip6lzdCT2CBS7ELPH/n+fk/M0o10BYT6G7TtEmkbyBQvzQtWumRsQd1Orn1HrTkh
	 sV9A52L3V3EHPkMbxtscsRKkoOMndE4YMBe28yNGvOQy0e5Jm0gOG586E9EJGX0lZl
	 AHvLfb6uTdw7+OroEhe7IVLX61WQau0QRMRsPJLmwkSi9OTP0d8WtK5pu235OG0Guf
	 6+luQnGkO/16Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	daire@dneg.com,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/7] workqueue: Automatic affinity scope fallback for single-pod topologies
Date: Thu,  5 Feb 2026 10:57:23 -0500
Message-ID: <20260205155729.6841-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205155729.6841-1-cel@kernel.org>
References: <20260205155729.6841-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18756-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,dneg.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BA2FF4EDB
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The default affinity scope WQ_AFFN_CACHE assumes systems have
multiple last-level caches. On systems where all CPUs share a
single LLC (common with Intel monolithic dies), this scope
degenerates to a single worker pool. All queue_work() calls then
contend on that pool's single lock, causing severe performance
degradation under high-throughput workloads.

For example, on a 12-core system with a single shared L3 cache
running NFS over RDMA with 12 fio jobs, perf shows approximately
39% of CPU cycles spent in native_queued_spin_lock_slowpath,
nearly all from __queue_work() contending on the single pool lock.

On such systems WQ_AFFN_CACHE, WQ_AFFN_SMT, and WQ_AFFN_NUMA
scopes all collapse to a single pod.

Add wq_effective_affn_scope() to detect when a selected affinity
scope provides only one pod despite having multiple CPUs, and
automatically fall back to a finer-grained scope. This enables lock
distribution to scale with CPU count without requiring manual
configuration via the workqueue.default_affinity_scope parameter or
per-workqueue sysfs tuning.

The fallback is conservative: it triggers only when a scope
degenerates to exactly one pod, and respects explicitly configured
(non-default) scopes.

Also update wq_affn_scope_show() to display the effective scope
when fallback occurs, making the behavior transparent to
administrators via sysfs (e.g., "default (cache -> smt)").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/workqueue.h |  8 ++++-
 kernel/workqueue.c        | 68 +++++++++++++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index dabc351cc127..1fca5791337d 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -128,10 +128,16 @@ struct rcu_work {
 	struct workqueue_struct *wq;
 };
 
+/*
+ * Affinity scopes are ordered from finest to coarsest granularity. This
+ * ordering is used by the automatic fallback logic in wq_effective_affn_scope()
+ * which walks from coarse toward fine when a scope degenerates to a single pod.
+ */
 enum wq_affn_scope {
 	WQ_AFFN_DFL,			/* use system default */
 	WQ_AFFN_CPU,			/* one pod per CPU */
-	WQ_AFFN_SMT,			/* one pod poer SMT */
+	WQ_AFFN_SMT,			/* one pod per SMT */
+	WQ_AFFN_CLUSTER,		/* one pod per cluster */
 	WQ_AFFN_CACHE,			/* one pod per LLC */
 	WQ_AFFN_NUMA,			/* one pod per NUMA node */
 	WQ_AFFN_SYSTEM,			/* one pod across the whole system */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 253311af47c6..32598b9cd1c2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -405,6 +405,7 @@ static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
 	[WQ_AFFN_DFL]		= "default",
 	[WQ_AFFN_CPU]		= "cpu",
 	[WQ_AFFN_SMT]		= "smt",
+	[WQ_AFFN_CLUSTER]	= "cluster",
 	[WQ_AFFN_CACHE]		= "cache",
 	[WQ_AFFN_NUMA]		= "numa",
 	[WQ_AFFN_SYSTEM]	= "system",
@@ -4753,6 +4754,39 @@ static void wqattrs_actualize_cpumask(struct workqueue_attrs *attrs,
 		cpumask_copy(attrs->cpumask, unbound_cpumask);
 }
 
+/*
+ * Determine the effective affinity scope. If the configured scope results
+ * in a single pod (e.g., WQ_AFFN_CACHE on a system with one shared LLC),
+ * fall back to a finer-grained scope to distribute pool lock contention.
+ *
+ * The search stops at WQ_AFFN_CPU, which always provides one pod per CPU
+ * and thus cannot degenerate further.
+ *
+ * Returns the scope to actually use, which may differ from the configured
+ * scope on systems where coarser scopes degenerate.
+ */
+static enum wq_affn_scope wq_effective_affn_scope(enum wq_affn_scope scope)
+{
+	struct wq_pod_type *pt;
+
+	/*
+	 * Walk from the requested scope toward finer granularity. Stop
+	 * when a scope provides more than one pod, or when CPU scope is
+	 * reached. CPU scope always provides nr_possible_cpus() pods.
+	 */
+	while (scope > WQ_AFFN_CPU) {
+		pt = &wq_pod_types[scope];
+
+		/* Multiple pods at this scope; no fallback needed */
+		if (pt->nr_pods > 1)
+			break;
+
+		scope--;
+	}
+
+	return scope;
+}
+
 /* find wq_pod_type to use for @attrs */
 static const struct wq_pod_type *
 wqattrs_pod_type(const struct workqueue_attrs *attrs)
@@ -4763,8 +4797,13 @@ wqattrs_pod_type(const struct workqueue_attrs *attrs)
 	/* to synchronize access to wq_affn_dfl */
 	lockdep_assert_held(&wq_pool_mutex);
 
+	/*
+	 * For default scope, apply automatic fallback for degenerate
+	 * topologies. Explicit scope selection via sysfs or per-workqueue
+	 * attributes bypasses fallback, preserving administrator intent.
+	 */
 	if (attrs->affn_scope == WQ_AFFN_DFL)
-		scope = wq_affn_dfl;
+		scope = wq_effective_affn_scope(wq_affn_dfl);
 	else
 		scope = attrs->affn_scope;
 
@@ -7206,16 +7245,27 @@ static ssize_t wq_affn_scope_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct workqueue_struct *wq = dev_to_wq(dev);
+	enum wq_affn_scope scope, effective;
 	int written;
 
 	mutex_lock(&wq->mutex);
-	if (wq->unbound_attrs->affn_scope == WQ_AFFN_DFL)
-		written = scnprintf(buf, PAGE_SIZE, "%s (%s)\n",
-				    wq_affn_names[WQ_AFFN_DFL],
-				    wq_affn_names[wq_affn_dfl]);
-	else
+	if (wq->unbound_attrs->affn_scope == WQ_AFFN_DFL) {
+		scope = wq_affn_dfl;
+		effective = wq_effective_affn_scope(scope);
+		if (wq_pod_types[effective].nr_pods >
+		    wq_pod_types[scope].nr_pods)
+			written = scnprintf(buf, PAGE_SIZE, "%s (%s -> %s)\n",
+					    wq_affn_names[WQ_AFFN_DFL],
+					    wq_affn_names[scope],
+					    wq_affn_names[effective]);
+		else
+			written = scnprintf(buf, PAGE_SIZE, "%s (%s)\n",
+					    wq_affn_names[WQ_AFFN_DFL],
+					    wq_affn_names[scope]);
+	} else {
 		written = scnprintf(buf, PAGE_SIZE, "%s\n",
 				    wq_affn_names[wq->unbound_attrs->affn_scope]);
+	}
 	mutex_unlock(&wq->mutex);
 
 	return written;
@@ -8023,6 +8073,11 @@ static bool __init cpus_share_smt(int cpu0, int cpu1)
 #endif
 }
 
+static bool __init cpus_share_cluster(int cpu0, int cpu1)
+{
+	return cpumask_test_cpu(cpu0, topology_cluster_cpumask(cpu1));
+}
+
 static bool __init cpus_share_numa(int cpu0, int cpu1)
 {
 	return cpu_to_node(cpu0) == cpu_to_node(cpu1);
@@ -8042,6 +8097,7 @@ void __init workqueue_init_topology(void)
 
 	init_pod_type(&wq_pod_types[WQ_AFFN_CPU], cpus_dont_share);
 	init_pod_type(&wq_pod_types[WQ_AFFN_SMT], cpus_share_smt);
+	init_pod_type(&wq_pod_types[WQ_AFFN_CLUSTER], cpus_share_cluster);
 	init_pod_type(&wq_pod_types[WQ_AFFN_CACHE], cpus_share_cache);
 	init_pod_type(&wq_pod_types[WQ_AFFN_NUMA], cpus_share_numa);
 
-- 
2.52.0


