Return-Path: <linux-nfs+bounces-19041-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG94JqCFl2mwzgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19041-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:50:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448D162F39
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F1F3011C4E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2096308F13;
	Thu, 19 Feb 2026 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzhixSyw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE472D9EC2
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771537822; cv=none; b=aeTBq2u9dcJ2n74yEOkxjEknDTR0V1gSJLPfj6afng1JpD/LeqWsbFmYjs9IzNGRZv5oUb+kFFnmaYo5hu+hfZpkc8+bOPScMqy90uIFtdMNZFg84yWeMkLqj/zF4REQ3Jwu0MDhoQ7b2MbzUAmqHVQJhgnNI+Bb22cPY1Ik1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771537822; c=relaxed/simple;
	bh=m3r3ufDQt6mV/rA3SJWun6C1S3qh7O/dez2C7u71iVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SINKsihAzYVo9rmLR2lsRatxgyr+7JetUDDyXkBupLnwE+12v+GsS2dorDgl1nKMONrSgfMM2OHHyGu6Kv8+5lzlrPA9PYqejqco78UgONNMlA9j6mL+fJlIrwsXTa8jg/9Q06Fy6eKubac49Dadov7u3mduOnX+lhHq69np9PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzhixSyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956F2C19424;
	Thu, 19 Feb 2026 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771537822;
	bh=m3r3ufDQt6mV/rA3SJWun6C1S3qh7O/dez2C7u71iVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzhixSywfMJ3mCwyMqLzIZ4H7aQhAtb2gnVdPTdp3Eex7N3Og5yOZngXt4eMPc3eX
	 JNBk0QPp0b/26KsnsmgZwI0/Dt/XsclrdL8H3DIUd/jAdPAhkdLuYL/qzsVFHDgg9W
	 mqOk2TmOd8bgyemcfPJ49Nikcl/GMtOgBG2VjMd8d4rLWb26KiAk0q4dipHj1pqQKE
	 dJMOn2Z7/2tMpvUhtiDiQS3v2v+X/0iCan+7aTDMzOpnNfx7tLTols1J8kyQhyiIFR
	 ooPlWjFcg0dblIMxgxw2J4kn8Cpyqd6XYtvxk3Wr05Cekd66K88RPnofKoyk/gUK/X
	 CHpV/JrKMZ4uA==
From: Chuck Lever <cel@kernel.org>
To: misanjum@linux.ibm.com,
	NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/2] NFSD: Defer sub-object cleanup in export put callbacks
Date: Thu, 19 Feb 2026 16:50:16 -0500
Message-ID: <20260219215017.1769-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219215017.1769-1-cel@kernel.org>
References: <20260219215017.1769-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19041-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.ibm.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 1448D162F39
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_export_put() calls path_put() and auth_domain_put() immediately
when the last reference drops, before the RCU grace period. RCU
readers in e_show() and c_show() access both ex_path (via
seq_path/d_path) and ex_client->name (via seq_escape) without
holding a reference. If cache_clean removes the entry and drops the
last reference concurrently, the sub-objects are freed while still
in use, producing a NULL pointer dereference in d_path.

Commit 2530766492ec ("nfsd: fix UAF when access ex_uuid or
ex_stats") moved kfree of ex_uuid and ex_stats into the
call_rcu callback, but left path_put() and auth_domain_put() running
before the grace period because both may sleep and call_rcu
callbacks execute in softirq context.

Replace call_rcu/kfree_rcu with queue_rcu_work(), which defers the
callback until after the RCU grace period and executes it in process
context where sleeping is permitted. This allows path_put() and
auth_domain_put() to be moved into the deferred callback alongside
the other resource releases. Apply the same fix to expkey_put(),
which has the identical pattern with ek_path and ek_client.

A dedicated workqueue scopes the shutdown drain to only NFSD
export release work items; flushing the shared
system_unbound_wq would stall on unrelated work from other
subsystems. nfsd_export_shutdown() uses rcu_barrier() followed
by flush_workqueue() to ensure all deferred release callbacks
complete before the export caches are destroyed.

Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Closes: https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com/
Fixes: c224edca7af0 ("nfsd: no need get cache ref when protected by rcu")
Fixes: 1b10f0b603c0 ("SUNRPC: no need get cache ref when protected by rcu")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c | 63 +++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/export.h |  7 ++++--
 fs/nfsd/nfsctl.c |  8 +++++-
 3 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 04b18f0f402f..53fe66784ed2 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -36,19 +36,30 @@
  * second map contains a reference to the entry in the first map.
  */
 
+static struct workqueue_struct *nfsd_export_wq;
+
 #define	EXPKEY_HASHBITS		8
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_put(struct kref *ref)
+static void expkey_release(struct work_struct *work)
 {
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+	struct svc_expkey *key = container_of(to_rcu_work(work),
+					      struct svc_expkey, ek_rwork);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree_rcu(key, ek_rcu);
+	kfree(key);
+}
+
+static void expkey_put(struct kref *ref)
+{
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
+
+	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
+	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -353,11 +364,13 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_release(struct rcu_head *rcu_head)
+static void svc_export_release(struct work_struct *work)
 {
-	struct svc_export *exp = container_of(rcu_head, struct svc_export,
-			ex_rcu);
+	struct svc_export *exp = container_of(to_rcu_work(work),
+					      struct svc_export, ex_rwork);
 
+	path_put(&exp->ex_path);
+	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
@@ -369,9 +382,8 @@ static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
-	path_put(&exp->ex_path);
-	auth_domain_put(exp->ex_client);
-	call_rcu(&exp->ex_rcu, svc_export_release);
+	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
+	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -1481,6 +1493,36 @@ const struct seq_operations nfs_exports_op = {
 	.show	= e_show,
 };
 
+/**
+ * nfsd_export_wq_init - allocate the export release workqueue
+ *
+ * Called once at module load. The workqueue runs deferred svc_export and
+ * svc_expkey release work scheduled by queue_rcu_work() in the cache put
+ * callbacks.
+ *
+ * Return values:
+ *   %0: workqueue allocated
+ *   %-ENOMEM: allocation failed
+ */
+int nfsd_export_wq_init(void)
+{
+	nfsd_export_wq = alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
+	if (!nfsd_export_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * nfsd_export_wq_shutdown - drain and free the export release workqueue
+ *
+ * Called once at module unload. Per-namespace teardown in
+ * nfsd_export_shutdown() has already drained all deferred work.
+ */
+void nfsd_export_wq_shutdown(void)
+{
+	destroy_workqueue(nfsd_export_wq);
+}
+
 /*
  * Initialize the exports module.
  */
@@ -1542,6 +1584,9 @@ nfsd_export_shutdown(struct net *net)
 
 	cache_unregister_net(nn->svc_expkey_cache, net);
 	cache_unregister_net(nn->svc_export_cache, net);
+	/* Drain deferred export and expkey release work. */
+	rcu_barrier();
+	flush_workqueue(nfsd_export_wq);
 	cache_destroy_net(nn->svc_expkey_cache, net);
 	cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index d2b09cd76145..b05399374574 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -7,6 +7,7 @@
 
 #include <linux/sunrpc/cache.h>
 #include <linux/percpu_counter.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -75,7 +76,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_head		ex_rcu;
+	struct rcu_work		ex_rwork;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -92,7 +93,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_head		ek_rcu;
+	struct rcu_work		ek_rwork;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
@@ -110,6 +111,8 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 /*
  * Function declarations
  */
+int			nfsd_export_wq_init(void);
+void			nfsd_export_wq_shutdown(void);
 int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 664a3275c511..4166f59908f4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2308,9 +2308,12 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
+	retval = nfsd_export_wq_init();
+	if (retval)
+		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_lockd;
+		goto out_free_export_wq;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2339,6 +2342,8 @@ static int __init init_nfsd(void)
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
+out_free_export_wq:
+	nfsd_export_wq_shutdown();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2359,6 +2364,7 @@ static void __exit exit_nfsd(void)
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
+	nfsd_export_wq_shutdown();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
-- 
2.53.0


