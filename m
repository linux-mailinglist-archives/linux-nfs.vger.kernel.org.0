Return-Path: <linux-nfs+bounces-22237-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RfVOHx5IIGpd0AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22237-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:28:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A66392F5
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 17:28:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=lCjvA3r6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22237-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22237-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A725F320B017
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFAC3A3E96;
	Wed,  3 Jun 2026 15:09:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E2392C50
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 15:09:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499390; cv=none; b=b36qsEFJcpgBmSZcS+nTGVk/kvZ9OnZ7SU0fWbHHV26jSvAzV3S/0anMez69OBbOJJYnOXdhkhjUTpK0O4BMi8qEikBDkA83xFGPr4sZRJI3a9gMYgJfexHO6GxtFVcVrpPcNF0GvGVA29L2it4ocb7MubA9J1EIMCcbjiB3USE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499390; c=relaxed/simple;
	bh=1tvciB3go/Mpb0UXrzEw2vkh4hTJfWTqMX6h94T+2j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSnsF66jhyrkY2OQmhgjvBYBhB1HTzx/lrUHkXtvHnkoTjuL9CMqyhaVPFWqBTKsJsFOCHeSr3XwfMFMaeFsLs/FOIK2UE8VjCMGMg1m/xir1zoN2bs3IuQoVEUjL19CKSDQVZBKjU/LOor+IhAgDmPzvLLfDkmXGFLugR4siWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=lCjvA3r6; arc=none smtp.client-ip=209.85.160.49
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43cce34c881so2971480fac.2
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780499388; x=1781104188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbGyV64bg1x+CxDEaCkVtBaJd5BgglWhB8BbA+eER9k=;
        b=lCjvA3r6sOGie60QRZMfCWQP7ubwWJR1gDUZqLpuyEaZTkgYvH+KnWuN60J8Ksbih9
         ytfy0larRxfE42zoWjKTBnFeJcpHpahXfTFpGqMHyG2LAfA73UdCB1PR1rS66D8L6L5a
         l/XjkQFmsemq4pGBx+gdpLi983p/4uDDQ8svmzPyaOcVK5KtNhtJSqR5uPQBoMc+Nn80
         9fCqye9Gh9LZbiALoey2GDn41PY/prglblzlR6RaElSKXO2xYUx2wmJtBTos/OH3PCMI
         Mb+LeiBwiw8SA5vzZ+5stgm+XvhZ/dU40+jdGUnZMDu/IxLzQSMCREby9c5VV+50wCIe
         vlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499388; x=1781104188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RbGyV64bg1x+CxDEaCkVtBaJd5BgglWhB8BbA+eER9k=;
        b=leMBi1VC7KJiU8tgct1bLK4Y8m1FmwLzHLmCKjAw+wz9dXAKYiayHqwgIguHZDGFxC
         UcgEw4A5pnM61Z+28Ic0x/VWgNapx1Gg3lavF0iU5yASGjIqo6tp30pkCKKXZ4RQCGMe
         6MhR1/bBS/NRFjrUKkwrxtu1xLQ7YODZXPJnxWGdB9h0TF0LffKx8iI+Ed1sUSiluKEo
         tHm2mHdrVc1Mv2ZZpgc7dLJelQjpmYx9tTRe51olIvF15CCIkVNLirjmVmmu71/uPqpN
         WSoWKn54iFQL+2RfDZcXzlhosg6igDYt0Xl8CSEicZSWDpcBl2fr4loZ+POM0D2tZGhW
         ADAQ==
X-Gm-Message-State: AOJu0YwQmZopDOE6UngTE2oVTyZMsErPxPt+XZVs6+dV+hWHHlnM+9ar
	VBZJhnsp129z6XQVE8vBr2zUjRRW8735su41nkeUtjuuTLWSDnqihiOO37SZVYcrcUM=
X-Gm-Gg: Acq92OGO4hVf8yHOIjA54GMOvYZ56ihLTGGF2ostGVWJeBFp0xrJLHgDriynvv/jNfM
	Iw83s2PQu5dbp5Vye5OeT94DwPbbRRS2JVfd6NDAG5l2++b422NWJOQtCDoMkg3UR9c5QlitW6R
	mPeCnEz5tgRXHZ5sQBsAluENA/4j0Q9GY1PNYCcitEDDbQkWUeIwZ1tmKTZsrhqZfcHxRBJEXDA
	KIZrtYUFHGJzNkTIsm6Wp+79f298zNjgyMrFU5fv+G0XjkxIIJEnU7wTrn9HwA3Q+8AA3Hw00vI
	L7O0Ym+Cn3X8nFX4GkOZDD4oiP9Lg6sQSdJUUuDI3UMvMWnCXIr4EEkqOWZtyIsL+++t1hYyWUj
	2IDCV3VeUP6tQyJFI0SwFHtamiM0qxfcFNyX+2vEf6W7ux7+UnnMMv3hG4FbTi9yPA4V0l5AZ4G
	a3Arho/7hSzH9XcitwSJRNEtgj6XNGCFbHOMcEWLhhwx32G2OXIoy0DGrRVYQGuqEFN2wPgg==
X-Received: by 2002:a05:6871:2218:b0:439:f6c7:586c with SMTP id 586e51a60fabf-440dba78078mr2541072fac.25.1780499387586;
        Wed, 03 Jun 2026 08:09:47 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm2917634fac.16.2026.06.03.08.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:09:47 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@brahma.io>
Subject: [PATCH RFC 2/4] sunrpc: dispatch ready transports fairly per client
Date: Wed,  3 Jun 2026 11:09:40 -0400
Message-ID: <2397ad4a9949c55f84a93ec3fad82a77a0fc7544.1780498019.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780498019.git.bcodding@hammerspace.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22237-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE4A66392F5

Add an opt-in per-pool scheduler that groups ready transports into
buckets by their fairness key and dispatches round-robin across the
non-empty buckets, so each client gets one turn per round regardless of
how many connections it has queued.  Buckets are a fixed hash array: a
key collision merely shares a turn between two clients and never drops
work.  The structure is guarded by a single per-pool spinlock taken only
on this path -- when it is absent (sp_fairq == NULL) the existing
lockless lwq FIFO fast path runs unchanged.

svc_set_fairq() allocates or frees the per-pool state for a service and
must be called while the service is quiescent, before any thread is
started or transport queued.

Enqueue can run in softirq context (a socket data_ready callback), so
the lock disables bottom halves.  The sleep/wake handshake the lockless
path gets for free from lwq_enqueue()'s cmpxchg is preserved here by
issuing an explicit barrier before waking an idle thread, pairing with
the full barrier the sleeper executes when it adds itself to the idle
list.

Nothing selects fair queueing yet, so there is no functional change.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>
---
 include/linux/sunrpc/svc.h |   5 +
 net/sunrpc/svc.c           |   2 +
 net/sunrpc/svc_xprt.c      | 216 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 221 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4be6204f6630..7fb09d18492d 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -33,12 +33,16 @@
  * have one pool per NUMA node.  This optimisation reduces cross-
  * node traffic on multi-node NUMA NFS servers.
  */
+struct svc_fairq;
+
 struct svc_pool {
 	unsigned int		sp_id;		/* pool id; also node id on NUMA */
 	unsigned int		sp_nrthreads;	/* # of threads currently running in pool */
 	unsigned int		sp_nrthrmin;	/* Min number of threads to run per pool */
 	unsigned int		sp_nrthrmax;	/* Max requested number of threads in pool */
 	struct lwq		sp_xprts;	/* pending transports */
+	struct svc_fairq	*sp_fairq;	/* per-client fair-queue dispatch
+						 * state; NULL => sp_xprts FIFO */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
@@ -465,6 +469,7 @@ struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
 				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
+int		   svc_set_fairq(struct svc_serv *serv, bool enable);
 int		   svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
 					unsigned int min_threads, unsigned int max_threads);
 int		   svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 009373737ea9..d413eb669d85 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -656,6 +656,8 @@ svc_destroy(struct svc_serv **servp)
 	if (serv->sv_is_pooled)
 		svc_pool_map_put();
 
+	svc_set_fairq(serv, false);
+
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 63d1002e63e7..1e81a5c3accf 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -9,6 +9,7 @@
 #include <linux/sched/mm.h>
 #include <linux/errno.h>
 #include <linux/freezer.h>
+#include <linux/hash.h>
 #include <linux/slab.h>
 #include <net/sock.h>
 #include <linux/sunrpc/addr.h>
@@ -44,6 +45,193 @@ static int svc_conn_age_period = 6*60;
 static DEFINE_SPINLOCK(svc_xprt_class_lock);
 static LIST_HEAD(svc_xprt_class_list);
 
+/*
+ * Per-client fair-queue dispatch.
+ *
+ * The default dispatcher keeps all ready transports in one lockless FIFO
+ * (svc_pool.sp_xprts), so a client's share of nfsd service scales with its
+ * connection count.  When fair queueing is enabled (svc_set_fairq()), ready
+ * transports are instead grouped into buckets by their fairness key
+ * (svc_xprt_fairq_key()) and dispatched round-robin across the non-empty
+ * buckets, so each client gets one turn per round however many connections it
+ * holds.
+ *
+ * Buckets are a fixed hash array: distinct clients almost always land in
+ * distinct buckets, and a collision merely shares a turn between two clients,
+ * never drops work.  The structure is guarded by a single per-pool spinlock
+ * taken only on this opt-in path; the default FIFO fast path is untouched.
+ */
+#define SVC_FAIRQ_BITS		8
+#define SVC_FAIRQ_BUCKETS	(1U << SVC_FAIRQ_BITS)
+
+struct svc_fairq_bucket {
+	struct list_head	fb_xprts;	/* ready transports, FIFO order */
+	struct list_head	fb_active;	/* link in fq_active when non-empty */
+};
+
+struct svc_fairq {
+	spinlock_t		fq_lock;
+	unsigned int		fq_nr;		/* total transports queued */
+	struct list_head	fq_active;	/* non-empty buckets, RR order */
+	struct svc_fairq_bucket	fq_buckets[SVC_FAIRQ_BUCKETS];
+};
+
+static struct svc_fairq *svc_fairq_alloc(void)
+{
+	struct svc_fairq *fq;
+	unsigned int i;
+
+	fq = kzalloc(sizeof(*fq), GFP_KERNEL);
+	if (!fq)
+		return NULL;
+	spin_lock_init(&fq->fq_lock);
+	INIT_LIST_HEAD(&fq->fq_active);
+	for (i = 0; i < SVC_FAIRQ_BUCKETS; i++) {
+		INIT_LIST_HEAD(&fq->fq_buckets[i].fb_xprts);
+		INIT_LIST_HEAD(&fq->fq_buckets[i].fb_active);
+	}
+	return fq;
+}
+
+static void svc_fairq_free(struct svc_fairq *fq)
+{
+	kfree(fq);
+}
+
+/**
+ * svc_set_fairq - enable or disable per-client fair-queue dispatch
+ * @serv: service whose pools to (re)configure
+ * @enable: %true to group ready transports by client and dispatch round-robin
+ *
+ * Allocates (or frees) a fair-queue structure for every pool of @serv.  Must
+ * be called while the service is quiescent -- before any thread is started or
+ * transport queued -- because it changes how ready transports are tracked.
+ *
+ * Return: 0 on success, or -ENOMEM if a structure could not be allocated, in
+ * which case @serv is left with fair queueing disabled.
+ */
+int svc_set_fairq(struct svc_serv *serv, bool enable)
+{
+	unsigned int i;
+
+	/* Drop any existing fair-queue state. */
+	for (i = 0; i < serv->sv_nrpools; i++) {
+		svc_fairq_free(serv->sv_pools[i].sp_fairq);
+		serv->sv_pools[i].sp_fairq = NULL;
+	}
+	if (!enable)
+		return 0;
+
+	for (i = 0; i < serv->sv_nrpools; i++) {
+		serv->sv_pools[i].sp_fairq = svc_fairq_alloc();
+		if (!serv->sv_pools[i].sp_fairq)
+			goto out_free;
+	}
+	return 0;
+
+out_free:
+	while (i-- > 0) {
+		svc_fairq_free(serv->sv_pools[i].sp_fairq);
+		serv->sv_pools[i].sp_fairq = NULL;
+	}
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(svc_set_fairq);
+
+static struct svc_fairq_bucket *svc_fairq_bucket(struct svc_fairq *fq,
+						 struct svc_xprt *xprt)
+{
+	return &fq->fq_buckets[hash_long(svc_xprt_fairq_key(xprt),
+					 SVC_FAIRQ_BITS)];
+}
+
+/*
+ * Add a ready transport to its client's bucket, FIFO within the bucket.
+ * Enqueue can run in softirq context (socket data_ready), so all acquisitions
+ * of fq_lock disable bottom halves.
+ */
+static void svc_fairq_enqueue(struct svc_fairq *fq, struct svc_xprt *xprt)
+{
+	struct svc_fairq_bucket *b = svc_fairq_bucket(fq, xprt);
+
+	spin_lock_bh(&fq->fq_lock);
+	if (list_empty(&b->fb_xprts))
+		list_add_tail(&b->fb_active, &fq->fq_active);
+	list_add_tail(&xprt->xpt_fairq, &b->fb_xprts);
+	WRITE_ONCE(fq->fq_nr, fq->fq_nr + 1);
+	spin_unlock_bh(&fq->fq_lock);
+}
+
+/*
+ * Round-robin across clients: take the bucket at the head of the active list,
+ * pop its oldest transport, then rotate the bucket to the tail (or drop it if
+ * it has no more ready transports).  Each client thus gets one turn per cycle
+ * regardless of how many connections it has queued.
+ */
+static struct svc_xprt *svc_fairq_dequeue(struct svc_fairq *fq)
+{
+	struct svc_fairq_bucket *b;
+	struct svc_xprt *xprt = NULL;
+
+	spin_lock_bh(&fq->fq_lock);
+	if (!list_empty(&fq->fq_active)) {
+		b = list_first_entry(&fq->fq_active, struct svc_fairq_bucket,
+				     fb_active);
+		xprt = list_first_entry(&b->fb_xprts, struct svc_xprt,
+					xpt_fairq);
+		list_del(&xprt->xpt_fairq);
+		WRITE_ONCE(fq->fq_nr, fq->fq_nr - 1);
+		list_del_init(&b->fb_active);
+		if (!list_empty(&b->fb_xprts))
+			list_add_tail(&b->fb_active, &fq->fq_active);
+		svc_xprt_get(xprt);
+	}
+	spin_unlock_bh(&fq->fq_lock);
+	return xprt;
+}
+
+/*
+ * Lockless emptiness hint for the sleep/wake decision.  Correctness against a
+ * concurrent enqueue relies on the full barrier the sleeper executes
+ * (llist_add() of itself to sp_idle_threads) pairing with the smp_mb() that
+ * svc_xprt_enqueue() issues before waking an idle thread -- the same
+ * store-buffer pattern lwq_enqueue()'s cmpxchg provides on the default path.
+ */
+static bool svc_fairq_empty(struct svc_fairq *fq)
+{
+	return READ_ONCE(fq->fq_nr) == 0;
+}
+
+/* Remove and delete all queued transports belonging to @net (namespace down). */
+static void svc_fairq_clean_net(struct svc_fairq *fq, struct net *net)
+{
+	struct svc_xprt *xprt, *tmp;
+	unsigned int i;
+	LIST_HEAD(dying);
+
+	spin_lock_bh(&fq->fq_lock);
+	for (i = 0; i < SVC_FAIRQ_BUCKETS; i++) {
+		struct svc_fairq_bucket *b = &fq->fq_buckets[i];
+
+		list_for_each_entry_safe(xprt, tmp, &b->fb_xprts, xpt_fairq) {
+			if (xprt->xpt_net != net)
+				continue;
+			list_move_tail(&xprt->xpt_fairq, &dying);
+			WRITE_ONCE(fq->fq_nr, fq->fq_nr - 1);
+		}
+		if (list_empty(&b->fb_xprts))
+			list_del_init(&b->fb_active);
+	}
+	spin_unlock_bh(&fq->fq_lock);
+
+	while (!list_empty(&dying)) {
+		xprt = list_first_entry(&dying, struct svc_xprt, xpt_fairq);
+		list_del_init(&xprt->xpt_fairq);
+		set_bit(XPT_CLOSE, &xprt->xpt_flags);
+		svc_delete_xprt(xprt);
+	}
+}
+
 /* SMP locking strategy:
  *
  *	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
@@ -523,7 +711,19 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
 	xprt->xpt_qtime = ktime_get();
-	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
+	if (pool->sp_fairq) {
+		svc_fairq_enqueue(pool->sp_fairq, xprt);
+		/*
+		 * Order the enqueue before the idle-thread scan below, so a
+		 * thread that just found no work and added itself to the idle
+		 * list is guaranteed to be seen here.  lwq_enqueue()'s cmpxchg
+		 * supplies this barrier on the default path; the locked fair
+		 * enqueue is release-only, so issue it explicitly.
+		 */
+		smp_mb();
+	} else {
+		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
+	}
 
 	svc_pool_wake_idle_thread(pool);
 }
@@ -536,6 +736,9 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 {
 	struct svc_xprt	*xprt = NULL;
 
+	if (pool->sp_fairq)
+		return svc_fairq_dequeue(pool->sp_fairq);
+
 	xprt = lwq_dequeue(&pool->sp_xprts, struct svc_xprt, xpt_ready);
 	if (xprt)
 		svc_xprt_get(xprt);
@@ -759,8 +962,12 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
 		return false;
 
 	/* was a socket queued? */
-	if (!lwq_empty(&pool->sp_xprts))
+	if (pool->sp_fairq) {
+		if (!svc_fairq_empty(pool->sp_fairq))
+			return false;
+	} else if (!lwq_empty(&pool->sp_xprts)) {
 		return false;
+	}
 
 	/* are we shutting down? */
 	if (svc_thread_should_stop(rqstp))
@@ -1192,6 +1399,11 @@ static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
 		struct svc_pool *pool = &serv->sv_pools[i];
 		struct llist_node *q, **t1, *t2;
 
+		if (pool->sp_fairq) {
+			svc_fairq_clean_net(pool->sp_fairq, net);
+			continue;
+		}
+
 		q = lwq_dequeue_all(&pool->sp_xprts);
 		lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
 			if (xprt->xpt_net == net) {
-- 
2.53.0


