Return-Path: <linux-nfs+bounces-23068-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZWmxF/KyS2ruYgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23068-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:51:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CFC711834
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:51:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FzvYL0TK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23068-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23068-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 059ED3122933
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4F420E66;
	Mon,  6 Jul 2026 13:29:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC933BE17F;
	Mon,  6 Jul 2026 13:29:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344578; cv=none; b=n1r2S8qIzDEZmbVY+jokK22zG7QFYE8CojI+o/Phl9Q7Nni2qIOMW+DKQU7YuTjxoZqTiaR3DIHkM6NyzgKJ5xBMDlEPUXNbP/RPL9QNvSPkXaindOlI1ZXlb810bc6h5J/wAcQ60RBve0x0B009eqS7hulI5XgVIPtJDn1PVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344578; c=relaxed/simple;
	bh=rgXp+/+d+Bu+07+ixXNyZCAHhJIujdXOAj8b1tktfts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVNXOn6bIJyNqESTOel780ycMq/2/qpuCji+EIqo2u40Kxs6XcLY23SfX5iaIwEOqZycJOFkQmHSarhno5Vfrw1UD+lgHMMX6u8lJnjXPx3Fd+IJ492f1os04FQU76ygSBPfpotENj+L8M5HyXAELk7aT7TIUizaXCP52aKDh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzvYL0TK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFA71F00ACA;
	Mon,  6 Jul 2026 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344573;
	bh=cxrovbcjyJuyX61kVcQXv4gJNrm0epTYH69LxMEP9Cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FzvYL0TKopQXgZ6O4rZ6laOBAX23F10oHSRZogiFCvDgI0uA/Yjuw95/e1QUNooWD
	 1IO7/cwuB0388Nf5kzGxbpFwZ4YnYUbhBW4zW7ReaG2dKID8ABorz46MDqy69Iz/V3
	 Zc9tZh6TXr68JVKLDENgoyFqjrMN4uTqZ1yNW/7xPA4tP7ALPH3FPuKNmL8QXR00OL
	 48mwcr2lKDgRQZyMZFtLi6zHAEJu4TceZDHfskRA17GaVzleFCTfqvnT5aqmbD16ty
	 bwgVOYV9bMzTSV4s3jsK8ze/Buv1sVPr7swTSUcrJoD9zZyyV8lbyJ9pFdYjTAKL8+
	 O/qBEsWiRByBQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 06 Jul 2026 09:29:25 -0400
Subject: [PATCH v5 5/5] sunrpc: derive the pool count instead of caching it
 in sv_nrpools
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-sunrpc-pool-mode-v5-5-6c4ee7cd89aa@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
In-Reply-To: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10483; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rgXp+/+d+Bu+07+ixXNyZCAHhJIujdXOAj8b1tktfts=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqS623npbc8drId+/HdXq8IVFV3G3K1jLxjvFrL
 E00guTBEeuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakuttwAKCRAADmhBGVaC
 Fa+kD/47t13WEiYbbXR3hdRw/ZNr/3GSgOlEX1kPes2Dho4BkZteN5Gpkv+7BC4mm3irRfj6y/q
 oBV31wjK13fujkBbmn/AURcFu1QuI9Sv5B60exib3vzFOnfEfpQ77PKmH9yC/ALDC/uXSjo8o8z
 91Lt3y/Ily0OA1eIo4927q7wi0hBLZkWssxmH5/wUii/HcMTPHSqBCUKgr4BXC+now7HV8up3fH
 2f5uv59H0dfnf/2/AUA5d4EsJuwuKhuCUDSUmOD7dO2SdO5JIfNJAE10Iv56ra4u8gftAyzmAM2
 uomfTfuISICZL7coYzmGCkbUuQg+dvKjRPSlKKYkARtevf1FUdgU6zxhpjRrsYInhXmxvZzDmbz
 jGtYzlZpyZsg9j7sbCTxeWtkHUfGZXMvGTqVOK3gadzwMDFbunYtkZHXlHZ/Bvs0cxVpDoMnzbB
 zNCT9NSJbqP7rRHaFF0KJEUnynDY36m4BlcsrnT68IziQdXPA1pjyTr4DMw8t9eeUzkHNkuwJ6a
 Ec6+TDL8QVcDJlEB0Gwr29s/H3YJz9yEbIl5a4HRD8rscks5vFh2Ha3tzyTkqqSlBngz9SHi21U
 JhIBfPuBQ03pWJHpDK2QGNvM3nrdkFb9IrpPEE0/+0RWB8VRDhOG+nxvxHZKaHgEcqbGqd3pjcM
 kcbnFvZuYGc5f5g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23068-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,ownmail.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ownmail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0CFC711834

Now that the pool mode is always pernode, svc_serv.sv_nrpools is
redundant with sv_is_pooled: an unpooled service always has a single
pool, and a pooled service has svc_pool_map.npools pools (which is one on
a single-node host). sv_nrpools cannot distinguish an unpooled service
from a pooled service that happens to have one pool, so it is sv_nrpools,
not sv_is_pooled, that carries no unique information.

Replace the cached field with a svc_serv_nrpools() helper that derives
the count from sv_is_pooled and the pool map, and convert all readers to
it. svc_pool_map is file-local to svc.c, so export the helper for the
svc_xprt.c and nfsd callers.

Reading svc_pool_map.npools without svc_pool_map_mutex is safe: the
mutex protects only svc_pool_map.count, and npools is already read
locklessly in svc_pool_for_cpu().

A pooled service holds a map reference for its whole lifetime, so npools
is stable while any reader could observe it.  The hot path
(svc_pool_for_cpu()) already dereferences svc_pool_map for to_pool, and
npools shares that cacheline, so there is no new locking or coherence
cost.

__svc_create() keeps using its local npools argument for the sv_pools[]
allocation, since sv_is_pooled is not set until svc_create_pooled() has
returned from it.

Doing this also removes a modulus operation from svc_pool_for_cpu(),
which should make for more efficient RPC queueing.

Assisted-by: Claude:claude-opus-4-8
Suggested-by: NeilBrown <neilb@ownmail.net>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c           |  2 +-
 fs/nfsd/nfssvc.c           | 10 ++++-----
 include/linux/sunrpc/svc.h |  2 +-
 net/sunrpc/svc.c           | 52 ++++++++++++++++++++++++++++++++--------------
 net/sunrpc/svc_xprt.c      |  6 +++---
 5 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index bc16fc7ca24f..0543e5bb842f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1526,7 +1526,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
 	rcu_read_lock();
 
-	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
+	for (i = 0; i < svc_serv_nrpools(nn->nfsd_serv); i++) {
 		struct svc_rqst *rqstp;
 		long thread_skip = 0;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a8ea4dbfa56b..2edf716ea022 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -655,7 +655,7 @@ int nfsd_nrpools(struct net *net)
 	if (nn->nfsd_serv == NULL)
 		return 0;
 	else
-		return nn->nfsd_serv->sv_nrpools;
+		return svc_serv_nrpools(nn->nfsd_serv);
 }
 
 int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
@@ -665,7 +665,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	int i;
 
 	if (serv)
-		for (i = 0; i < serv->sv_nrpools && i < n; i++)
+		for (i = 0; i < svc_serv_nrpools(serv) && i < n; i++)
 			nthreads[i] = serv->sv_pools[i].sp_nrthrmax;
 	return 0;
 }
@@ -699,8 +699,8 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	if (n == 1)
 		return svc_set_num_threads(nn->nfsd_serv, nn->min_threads, nthreads[0]);
 
-	if (n > nn->nfsd_serv->sv_nrpools)
-		n = nn->nfsd_serv->sv_nrpools;
+	if (n > svc_serv_nrpools(nn->nfsd_serv))
+		n = svc_serv_nrpools(nn->nfsd_serv);
 
 	/* enforce a global maximum number of threads */
 	tot = 0;
@@ -731,7 +731,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	}
 
 	/* Anything undefined in array is considered to be 0 */
-	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
+	for (i = n; i < svc_serv_nrpools(nn->nfsd_serv); ++i) {
 		err = svc_set_pool_threads(nn->nfsd_serv,
 					   &nn->nfsd_serv->sv_pools[i],
 					   0, 0);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 3a0152d926fb..3c885ab6ad41 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -85,7 +85,6 @@ struct svc_serv {
 
 	char *			sv_name;	/* service name */
 
-	unsigned int		sv_nrpools;	/* number of thread pools */
 	bool			sv_is_pooled;	/* is this a pooled service? */
 	struct svc_pool *	sv_pools;	/* array of thread pools */
 	int			(*sv_threadfn)(void *data);
@@ -480,6 +479,7 @@ void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
 void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
+unsigned int	   svc_serv_nrpools(const struct svc_serv *serv);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
 const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ece69cb0138a..800514a14f17 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -224,7 +224,7 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 	unsigned int node = m->pool_to[pidx];
 
 	/*
-	 * The caller checks for sv_nrpools > 1, which
+	 * The caller checks for more than one pool, which
 	 * implies that we've been initialized.
 	 */
 	WARN_ON_ONCE(m->count == 0);
@@ -234,6 +234,24 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 	set_cpus_allowed_ptr(task, cpumask_of_node(node));
 }
 
+/**
+ * svc_serv_nrpools - number of thread pools backing a service
+ * @serv: An RPC service
+ *
+ * Pooled services all share the global svc_pool_map, so their pool count
+ * is svc_pool_map.npools. Unpooled services have a single pool. Reading
+ * npools without svc_pool_map_mutex is safe: a pooled service holds a map
+ * reference for its whole lifetime, so npools is stable once set.
+ *
+ * Return value:
+ *   The number of pools in @serv
+ */
+unsigned int svc_serv_nrpools(const struct svc_serv *serv)
+{
+	return serv->sv_is_pooled ? svc_pool_map.npools : 1;
+}
+EXPORT_SYMBOL_GPL(svc_serv_nrpools);
+
 /**
  * svc_pool_for_cpu - Select pool to run a thread on this cpu
  * @serv: An RPC service
@@ -247,12 +265,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsigned int pidx)
 struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 {
 	struct svc_pool_map *m = &svc_pool_map;
+	unsigned int nrpools = svc_serv_nrpools(serv);
 	unsigned int pidx, i;
 
-	if (serv->sv_nrpools <= 1)
+	if (nrpools <= 1)
 		return serv->sv_pools;
 
-	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_nrpools;
+	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())];
+	if (pidx >= nrpools)
+		pidx = 0;
 
 	/*
 	 * It's possible to have a pool with no threads. Userland can just set
@@ -265,7 +286,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	 * populated pool, trading NUMA locality for a guarantee that the
 	 * transport is serviced.
 	 */
-	for (i = 0; i < serv->sv_nrpools; i++) {
+	for (i = 0; i < nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[pidx];
 
 		/* This is set under the sp_mutex and rarely ever changes. A
@@ -274,7 +295,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 		if (data_race(pool->sp_nrthreads))
 			return pool;
 
-		if (++pidx >= serv->sv_nrpools)
+		if (++pidx >= nrpools)
 			pidx = 0;
 	}
 
@@ -414,15 +435,13 @@ __svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
 
 	__svc_init_bc(serv);
 
-	serv->sv_nrpools = npools;
-	serv->sv_pools =
-		kzalloc_objs(struct svc_pool, serv->sv_nrpools);
+	serv->sv_pools = kzalloc_objs(struct svc_pool, npools);
 	if (!serv->sv_pools) {
 		kfree(serv);
 		return NULL;
 	}
 
-	for (i = 0; i < serv->sv_nrpools; i++) {
+	for (i = 0; i < npools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
 		dprintk("svc: initialising pool %u for %s\n",
@@ -520,7 +539,7 @@ svc_destroy(struct svc_serv **servp)
 
 	cache_clean_deferred(serv);
 
-	for (i = 0; i < serv->sv_nrpools; i++) {
+	for (i = 0; i < svc_serv_nrpools(serv); i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
 		svc_pool_destroy_counters(pool);
@@ -732,7 +751,7 @@ int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)
 	}
 
 	rqstp->rq_task = task;
-	if (serv->sv_nrpools > 1)
+	if (svc_serv_nrpools(serv) > 1)
 		svc_pool_map_set_cpumask(task, pool->sp_id);
 
 	svc_sock_update_bufs(serv);
@@ -858,8 +877,9 @@ int
 svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 		    unsigned int nrservs)
 {
-	unsigned int base = nrservs / serv->sv_nrpools;
-	unsigned int remain = nrservs % serv->sv_nrpools;
+	unsigned int nrpools = svc_serv_nrpools(serv);
+	unsigned int base = nrservs / nrpools;
+	unsigned int remain = nrservs % nrpools;
 	int i, err = 0;
 
 	/*
@@ -870,9 +890,9 @@ svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 	 * @nrservs.
 	 */
 	if (base == 0 && nrservs != 0)
-		remain = serv->sv_nrpools;
+		remain = nrpools;
 
-	for (i = 0; i < serv->sv_nrpools; ++i) {
+	for (i = 0; i < nrpools; ++i) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 		int threads = base;
 
@@ -906,7 +926,7 @@ unsigned int svc_serv_maxthreads(const struct svc_serv *serv)
 {
 	unsigned int i, max = 0;
 
-	for (i = 0; i < serv->sv_nrpools; i++)
+	for (i = 0; i < svc_serv_nrpools(serv); i++)
 		max += data_race(serv->sv_pools[i].sp_nrthrmax);
 	return max;
 }
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 63d1002e63e7..40040af588fb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1188,7 +1188,7 @@ static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
 	struct svc_xprt *xprt;
 	int i;
 
-	for (i = 0; i < serv->sv_nrpools; i++) {
+	for (i = 0; i < svc_serv_nrpools(serv); i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 		struct llist_node *q, **t1, *t2;
 
@@ -1517,7 +1517,7 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 		return SEQ_START_TOKEN;
 	if (!si->serv)
 		return NULL;
-	return pidx > si->serv->sv_nrpools ? NULL
+	return pidx > svc_serv_nrpools(si->serv) ? NULL
 		: &si->serv->sv_pools[pidx - 1];
 }
 
@@ -1535,7 +1535,7 @@ static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *pos)
 		pool = &serv->sv_pools[0];
 	} else {
 		unsigned int pidx = (pool - &serv->sv_pools[0]);
-		if (pidx < serv->sv_nrpools-1)
+		if (pidx < svc_serv_nrpools(serv) - 1)
 			pool = &serv->sv_pools[pidx+1];
 		else
 			pool = NULL;

-- 
2.55.0


