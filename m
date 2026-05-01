Return-Path: <linux-nfs+bounces-21335-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kII9N0O+9GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21335-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:52:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A554AD662
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AC5303788E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7B3CEBBA;
	Fri,  1 May 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd92EvE6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99A3CD8C5;
	Fri,  1 May 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647093; cv=none; b=DGbl+NFzo35Kd8YIdksXLTQ5H1g1KisMZQABwgdv3FYlU5coKdl060fa7swdHk9D+aF/fNRjPZjt4eTBCad2a3BMmC3ZRw/sLzzi7wFamVtI095O1Ue/rWTuZDgwnu4a0jxs+00KTa57wt40eW9pj18ud/0xLjayRIiXur+cLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647093; c=relaxed/simple;
	bh=69P2lg2IQFIB3BrQK9DHI+1pCthUqibNJZ9MINjaf1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dx8AWwd/HtTP5N5WQfoN3IhvzDe3kOYmfNZkN4JCuqOHRaRvxLeFyFQSrTbNPpNqyuKvndV8xifAcWLpPzdeZLbEne6OnSl12dmOkUoDQWhHXD6K/WFSZf6kcXbwkZm44M3CkOGPR3mBtWebdZJRU7+qIi8d4aRZn0JtIc1ot1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd92EvE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E60C2BCB4;
	Fri,  1 May 2026 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647093;
	bh=69P2lg2IQFIB3BrQK9DHI+1pCthUqibNJZ9MINjaf1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kd92EvE62SRmaGLkCl8WPFJKZG10lsuzZ9GVcilm56u9g+rbqmWirooK+pstBc2FZ
	 OXbMNqpBPxHaRNodIkK5kil/ubU4Uk9aXMtksZxWbH8EE5tGyoHUjIENEF22V9gjUG
	 BX1hfnshlFFHQTxvSyCvWlNOljbitXGuJhLuyjFlfGuxrOcjU/hnQY3i5IiyR952q/
	 aTJw/SNiSBS1z0Tyzoowd3OzEAuWSw5EnMfFSgklzO57BSWzjbbvKPf1r5siz5OWxN
	 4h+kToxiHhZiIo00MuRxWDPdeqGBxF88zxgLGMqmsCOD0moaAb7KHnwH7J9bpTMU7K
	 c3GkXQQ05kVRQ==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 01 May 2026 10:51:08 -0400
Subject: [PATCH 2/6] SUNRPC: Provide a shared workqueue for cache release
 callbacks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cache-uaf-fix-v1-2-a49928bf4817@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
In-Reply-To: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11862;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=mPDAInV4wOnabNaiev670wLI8X52Ubl1nQ3gDsI7Ua8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9L3wB/cbkWCN1rTjHBsvSpYNqHB1X1OQUxGih
 4P58v2qFdyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafS98AAKCRAzarMzb2Z/
 l0HxD/48WphoeFNBdtdtTR2Xu1m2NmPogAapwmdleajZ9d50485FtJBEBABMQfsusCWiT/aul7U
 wtrsafYNGC1CjINnV8TmS0RFDoQMfkRx62j3jgfst5A3994BivfcAVJ/37mjrRIPKfySAiADmJe
 DXJRTuqhEkQub3iTMXt2FYfe6vMLD7Yj7LrtgYdKalHfqnwGpRMWmf1sI4gsgpoWXV4WAl+GUD3
 G19JVpXNUzAjxg6mvlXp2bkXtO2bKo+Jem4Sj11zeYFQB1AtvaZ20PtTVSRnim6JGsjVIfGB+9i
 8p0xSCaT/CLS8Xn5J1u1FM1PSNaVS0I/XH1qb8yG28uEiZjojRaxE/1LDw9vNWgOL57TvTLyr2X
 voGCTlzkmVISvNMSyYtsaxu655wXx7Koo5PasECT148iRGyoJBAqhClC5q8wE+nIUY4oWdjgH1P
 TnjLF3nwi+6KYHqKvOOxYXcQMekHHPF1r4Br7nrRrRW0MZRYZ3O+q8vPmsUsu3flpfHBK/1eSJh
 Y+XXqh5PLuRY1KjYOzzd1J8EYG0ftdGRAq9mmUoZpwyIeuFuO3dQmbIFk18z+ctUpd+/wwwCKPa
 kTQB1HVr4Qgq6p+TcPlHah2VbV2xkIzT/56Z1BRqlzxN4EDqo06oflcnOP64iRcmaMhmOaHO6FH
 CDVg2q9Ben/bMJA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 65A554AD662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21335-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Cache .put callbacks may need to release sub-objects whose
cleanup sleeps (path_put, auth_domain_put, put_group_info), which
precludes running the release from a call_rcu() softirq callback.
Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export
put callbacks") introduced nfsd_export_wq for that purpose, with
a dedicated workqueue chosen so that flush_workqueue() in the
per-namespace teardown path drains only NFSD export release work
rather than blocking on unrelated work queued to system_unbound_wq.

Subsequent patches in this series convert the sunrpc ip_map and
unix_gid put callbacks to the same queue_rcu_work() pattern, and
those would otherwise need their own per-cache workqueue for the
same reason. Hoist the workqueue up to the sunrpc layer so that
all four cache_detail put callbacks share a single workqueue,
managed entirely within net/sunrpc/cache.c.

Expose the workqueue through three helpers.
sunrpc_cache_queue_release() schedules a deferred release after
the next RCU grace period. sunrpc_cache_destroy_net()
encapsulates the cache_unregister_net() + drain +
cache_destroy_net() sequence that single-cache teardowns
otherwise have to open-code, putting the ordering rule in one
place. sunrpc_cache_drain() exposes the underlying
rcu_barrier() + flush_workqueue() primitive for the rare caller
that drains multiple cache_details together, such as
nfsd_export_shutdown(). Allocate the workqueue in
cache_initialize() and destroy it in a new cache_destroy()
called from cleanup_sunrpc(). Replace the local nfsd_export_wq
with the shared sunrpc helpers and drop the
nfsd_export_wq_init/shutdown helpers and their callers.

Assisted-by: Claude:claude-opus-4-7[1m]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c             | 41 +++-----------------------
 fs/nfsd/export.h             |  2 --
 fs/nfsd/nfsctl.c             |  8 +----
 include/linux/sunrpc/cache.h |  3 ++
 net/sunrpc/cache.c           | 70 +++++++++++++++++++++++++++++++++++++++++++-
 net/sunrpc/sunrpc.h          |  3 +-
 net/sunrpc/sunrpc_syms.c     | 23 +++++++++------
 7 files changed, 93 insertions(+), 57 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 15972919e1e9..3c4340e743fa 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -39,8 +39,6 @@
  * second map contains a reference to the entry in the first map.
  */
 
-static struct workqueue_struct *nfsd_export_wq;
-
 #define	EXPKEY_HASHBITS		8
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
@@ -62,7 +60,7 @@ static void expkey_put(struct kref *ref)
 	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
 	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
-	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
+	sunrpc_cache_queue_release(&key->ek_rwork);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -652,7 +650,7 @@ static void svc_export_put(struct kref *ref)
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
 	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
-	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
+	sunrpc_cache_queue_release(&exp->ex_rwork);
 }
 
 /**
@@ -2193,36 +2191,6 @@ const struct seq_operations nfs_exports_op = {
 	.show	= e_show,
 };
 
-/**
- * nfsd_export_wq_init - allocate the export release workqueue
- *
- * Called once at module load. The workqueue runs deferred svc_export and
- * svc_expkey release work scheduled by queue_rcu_work() in the cache put
- * callbacks.
- *
- * Return values:
- *   %0: workqueue allocated
- *   %-ENOMEM: allocation failed
- */
-int nfsd_export_wq_init(void)
-{
-	nfsd_export_wq = alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
-	if (!nfsd_export_wq)
-		return -ENOMEM;
-	return 0;
-}
-
-/**
- * nfsd_export_wq_shutdown - drain and free the export release workqueue
- *
- * Called once at module unload. Per-namespace teardown in
- * nfsd_export_shutdown() has already drained all deferred work.
- */
-void nfsd_export_wq_shutdown(void)
-{
-	destroy_workqueue(nfsd_export_wq);
-}
-
 /*
  * Initialize the exports module.
  */
@@ -2284,9 +2252,8 @@ nfsd_export_shutdown(struct net *net)
 
 	cache_unregister_net(nn->svc_expkey_cache, net);
 	cache_unregister_net(nn->svc_export_cache, net);
-	/* Drain deferred export and expkey release work. */
-	rcu_barrier();
-	flush_workqueue(nfsd_export_wq);
+	/* One drain covers both caches' deferred release work. */
+	sunrpc_cache_drain();
 	cache_destroy_net(nn->svc_expkey_cache, net);
 	cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index b05399374574..8969e81de448 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -111,8 +111,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 /*
  * Function declarations
  */
-int			nfsd_export_wq_init(void);
-void			nfsd_export_wq_shutdown(void);
 int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 064a2e749bc9..468aad8c3af9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2536,12 +2536,9 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = nfsd_export_wq_init();
-	if (retval)
-		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_export_wq;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2570,8 +2567,6 @@ static int __init init_nfsd(void)
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_export_wq:
-	nfsd_export_wq_shutdown();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2592,7 +2587,6 @@ static void __exit exit_nfsd(void)
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
-	nfsd_export_wq_shutdown();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 83c88dc82e69..84802438a5fc 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -237,11 +237,14 @@ extern int cache_check(struct cache_detail *detail,
 extern void cache_flush(void);
 extern void cache_purge(struct cache_detail *detail);
 #define NEVER (0x7FFFFFFF)
+extern void sunrpc_cache_queue_release(struct rcu_work *rwork);
+extern void sunrpc_cache_drain(void);
 extern int cache_register_net(struct cache_detail *cd, struct net *net);
 extern void cache_unregister_net(struct cache_detail *cd, struct net *net);
 
 extern struct cache_detail *cache_create_net(const struct cache_detail *tmpl, struct net *net);
 extern void cache_destroy_net(struct cache_detail *cd, struct net *net);
+extern void sunrpc_cache_destroy_net(struct cache_detail *cd, struct net *net);
 
 extern void sunrpc_init_cache_detail(struct cache_detail *cd);
 extern void sunrpc_destroy_cache_detail(struct cache_detail *cd);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 488a14961b19..733bcd3daa46 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1705,9 +1705,77 @@ static int create_cache_proc_entries(struct cache_detail *cd, struct net *net)
 	return -ENOMEM;
 }
 
-void __init cache_initialize(void)
+static struct workqueue_struct *sunrpc_cache_wq;
+
+/**
+ * sunrpc_cache_queue_release - schedule deferred cache release work
+ * @rwork: caller-initialized rcu_work to queue
+ *
+ * Run @rwork in process context after the next RCU grace period.
+ * Use this for cache .put callbacks whose cleanup may sleep
+ * (path_put(), auth_domain_put()).
+ */
+void sunrpc_cache_queue_release(struct rcu_work *rwork)
 {
+	queue_rcu_work(sunrpc_cache_wq, rwork);
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_queue_release);
+
+/**
+ * sunrpc_cache_drain - drain pending cache release work
+ *
+ * Wait for outstanding RCU callbacks to enqueue their release
+ * work, then flush that work to completion.
+ */
+void sunrpc_cache_drain(void)
+{
+	rcu_barrier();
+	flush_workqueue(sunrpc_cache_wq);
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_drain);
+
+/**
+ * sunrpc_cache_destroy_net - quiesce and tear down a per-net cache
+ * @cd: the cache_detail to release
+ * @net: the network namespace owning @cd
+ *
+ * Canonical teardown for caches whose .put callbacks use
+ * sunrpc_cache_queue_release(). Unregister @cd to stop new
+ * lookups, drain in-flight RCU callbacks and queued release
+ * work, then free @cd and its hash table. The drain ensures
+ * release workers complete while the cache_detail is still
+ * valid.
+ */
+void sunrpc_cache_destroy_net(struct cache_detail *cd, struct net *net)
+{
+	cache_unregister_net(cd, net);
+	sunrpc_cache_drain();
+	cache_destroy_net(cd, net);
+}
+EXPORT_SYMBOL_GPL(sunrpc_cache_destroy_net);
+
+/**
+ * cache_initialize - allocate sunrpc cache subsystem resources
+ */
+int __init cache_initialize(void)
+{
+	sunrpc_cache_wq = alloc_workqueue("sunrpc_cache",
+					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	if (!sunrpc_cache_wq)
+		return -ENOMEM;
 	INIT_DEFERRABLE_WORK(&cache_cleaner, do_cache_clean);
+	return 0;
+}
+
+/**
+ * cache_destroy - release sunrpc cache subsystem resources
+ *
+ * Caller must ensure no further sunrpc_cache_queue_release()
+ * calls can be scheduled before invoking this.
+ */
+void cache_destroy(void)
+{
+	destroy_workqueue(sunrpc_cache_wq);
 }
 
 int cache_register_net(struct cache_detail *cd, struct net *net)
diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index 7fa35ee8f9a4..75ee201e4800 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -41,7 +41,8 @@ struct svc_rqst;
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
 void auth_domain_cleanup(void);
-void __init cache_initialize(void);
+int __init cache_initialize(void);
+void cache_destroy(void);
 void svc_sock_update_bufs(struct svc_serv *serv);
 enum svc_auth_status svc_authenticate(struct svc_rqst *rqstp);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index ab88ce46afb5..d75ff1e592f2 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -97,24 +97,26 @@ init_sunrpc(void)
 	if (err)
 		goto out2;
 
-	cache_initialize();
-
-	err = register_pernet_subsys(&sunrpc_net_ops);
+	err = cache_initialize();
 	if (err)
 		goto out3;
 
-	err = register_rpc_pipefs();
+	err = register_pernet_subsys(&sunrpc_net_ops);
 	if (err)
 		goto out4;
 
-	err = rpc_sysfs_init();
+	err = register_rpc_pipefs();
 	if (err)
 		goto out5;
 
-	err = genl_register_family(&sunrpc_nl_family);
+	err = rpc_sysfs_init();
 	if (err)
 		goto out6;
 
+	err = genl_register_family(&sunrpc_nl_family);
+	if (err)
+		goto out7;
+
 	sunrpc_debugfs_init();
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	rpc_register_sysctl();
@@ -123,12 +125,14 @@ init_sunrpc(void)
 	init_socket_xprt();	/* clnt sock transport */
 	return 0;
 
-out6:
+out7:
 	rpc_sysfs_exit();
-out5:
+out6:
 	unregister_rpc_pipefs();
-out4:
+out5:
 	unregister_pernet_subsys(&sunrpc_net_ops);
+out4:
+	cache_destroy();
 out3:
 	rpcauth_remove_module();
 out2:
@@ -157,6 +161,7 @@ cleanup_sunrpc(void)
 	rpc_unregister_sysctl();
 #endif
 	rcu_barrier(); /* Wait for completion of call_rcu()'s */
+	cache_destroy();
 }
 MODULE_DESCRIPTION("Sun RPC core");
 MODULE_LICENSE("GPL");

-- 
2.53.0


