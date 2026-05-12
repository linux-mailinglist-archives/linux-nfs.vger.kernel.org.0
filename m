Return-Path: <linux-nfs+bounces-21477-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7h9cGpSSAmpzugEAu9opvQ
	(envelope-from <linux-nfs+bounces-21477-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 04:38:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033D518FD0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 04:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B40D300517A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC536C5B4;
	Tue, 12 May 2026 02:38:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53698361DA7
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553486; cv=none; b=Uc9IAOJfBUni+AJe9I8K+G1GkWuR1eeX8X/jAO7vV9ZcwSzzBSZ4vHcAD2jkSi2M9buSlkeVLy+ir8OXyZeccBJG5c6fq0vWy7H28/psP0zioYV5IbDI1BRmv9QKsGv0EWsKjgsQSJCF0JAg6KKgzzZzsC8J/78gk/Dd3eK3Z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553486; c=relaxed/simple;
	bh=/v40FaGBy0JSemzSAo5hqReZUb+M0rW0aqFZ4ysK+/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWCvBT7gVzMe+GnnV9mcJ2IGW6zsSkd83Bd19A+0N36Hy2D9dp32CmfDSl7DbF6mRn7JOzUri4ldkhyANzOUxZWh7Vz1DjV3DpeDU2qLnPotHZdD56tH7ZAhXr+7lrij5xPBvw8Y7k+fbT15z7stAACDec8UHtiHT0TqozuGBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gF12w0tQHzYQv2h
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 10:37:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 29BD64056B
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 10:37:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgCXX1t_kgJqQxfuBw--.49822S4;
	Tue, 12 May 2026 10:37:55 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: chuck.lever@oracle.com,
	misanjum@linux.ibm.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	lilingfeng3@huawei.com,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
Date: Tue, 12 May 2026 10:33:22 +0800
Message-ID: <20260512023322.2828939-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXX1t_kgJqQxfuBw--.49822S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWxKFy7Zr47ZryDAw4xWFg_yoW3Jr4Upa
	yfCrW7GrZ5XF1DWw4UGa1UZ3W5K3ZYqw18u345C3yFvrn8tr18uF1Fvryq9FyYyrWkW397
	ur18tan8uw48CrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr4
	1l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIYhF
	DUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/
X-Rspamd-Queue-Id: 5033D518FD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21477-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.666];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.

Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
callbacks") describes an issue where calling svc_export_put, path_put,
and auth_domain_put directly can cause use-after-free (UAF) errors when
accessing ex_path or ex_client->name. However, after discussion in [1],
it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for the
lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.

Additionally, commit 48db892356d6 ("NFSD: Defer sub-object cleanup in
export put callbacks") introduces a regression that was already fixed by
commit 69d803c40ede ("nfsd: Revert "nfsd: release svc_expkey/svc_export
with rcu_work""). Therefore, reverting commit 48db892356d6 ("NFSD: Defer
sub-object cleanup in export put callbacks") is necessary to fix this
regression.

Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/ [1]
Fixes: 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/export.c | 63 +++++++-----------------------------------------
 fs/nfsd/export.h |  7 ++----
 fs/nfsd/nfsctl.c |  8 +-----
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 665153f1720e..0baa58d1dbfc 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -36,30 +36,19 @@
  * second map contains a reference to the entry in the first map.
  */
 
-static struct workqueue_struct *nfsd_export_wq;
-
 #define	EXPKEY_HASHBITS		8
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_release(struct work_struct *work)
+static void expkey_put(struct kref *ref)
 {
-	struct svc_expkey *key = container_of(to_rcu_work(work),
-					      struct svc_expkey, ek_rwork);
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree(key);
-}
-
-static void expkey_put(struct kref *ref)
-{
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
-
-	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
-	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
+	kfree_rcu(key, ek_rcu);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -364,13 +353,11 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_release(struct work_struct *work)
+static void svc_export_release(struct rcu_head *rcu_head)
 {
-	struct svc_export *exp = container_of(to_rcu_work(work),
-					      struct svc_export, ex_rwork);
+	struct svc_export *exp = container_of(rcu_head, struct svc_export,
+			ex_rcu);
 
-	path_put(&exp->ex_path);
-	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
@@ -382,8 +369,9 @@ static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
-	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
-	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
+	path_put(&exp->ex_path);
+	auth_domain_put(exp->ex_client);
+	call_rcu(&exp->ex_rcu, svc_export_release);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -1492,36 +1480,6 @@ const struct seq_operations nfs_exports_op = {
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
@@ -1583,9 +1541,6 @@ nfsd_export_shutdown(struct net *net)
 
 	cache_unregister_net(nn->svc_expkey_cache, net);
 	cache_unregister_net(nn->svc_export_cache, net);
-	/* Drain deferred export and expkey release work. */
-	rcu_barrier();
-	flush_workqueue(nfsd_export_wq);
 	cache_destroy_net(nn->svc_expkey_cache, net);
 	cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index b05399374574..d2b09cd76145 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -7,7 +7,6 @@
 
 #include <linux/sunrpc/cache.h>
 #include <linux/percpu_counter.h>
-#include <linux/workqueue.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -76,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_work		ex_rwork;
+	struct rcu_head		ex_rcu;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -93,7 +92,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_work		ek_rwork;
+	struct rcu_head		ek_rcu;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
@@ -111,8 +110,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 /*
  * Function declarations
  */
-int			nfsd_export_wq_init(void);
-void			nfsd_export_wq_shutdown(void);
 int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 39e7012a60d8..8a0199608479 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2310,12 +2310,9 @@ static int __init init_nfsd(void)
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
@@ -2344,8 +2341,6 @@ static int __init init_nfsd(void)
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_export_wq:
-	nfsd_export_wq_shutdown();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2366,7 +2361,6 @@ static void __exit exit_nfsd(void)
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
-	nfsd_export_wq_shutdown();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
-- 
2.52.0


