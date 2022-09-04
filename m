Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B35AC5C5
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiIDR2F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIDR2E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 13:28:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6561533378
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 10:28:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284APboh017447;
        Sun, 4 Sep 2022 17:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=3O664cJB6mZ8JfJKOoTlDF8jbSwFQpSG01ayQaYB1hU=;
 b=dd/PkHA555r6x0leSmn8lLpx07e/Z8uvajedPC3xhPminUVwu000d+0AVBIrn6xVLQXN
 x6cE+fUemoBQxHgdGyTIhQT8H4XXz9tKzDefy59n3uqINqrN5ZEf1VIKDGY/xpwO7y4O
 0ooJ0x+uNQLulTjvQOsb7Pfdz8LM0KAAfhAi1aqPcZixmtzQK9Q7I7T9s5NQfVod05Ke
 OGGbA3ECHBQ4KWRl7OEkPcy/ih1D+MK6EjTL0h4CXrT7i7qUyZyJvhCGUHV9TzUc9B2d
 kjmIP4vpCb64gfRXq59+9IcQo+IjYQv0B3RxV809qpQ89MI8oCbgb6adYRlTZaZvzJAf gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2a0qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 17:27:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 284D6kIP034190;
        Sun, 4 Sep 2022 17:27:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc7bukg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 17:27:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 284HRuvn029092;
        Sun, 4 Sep 2022 17:27:58 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc7buk3-3;
        Sun, 04 Sep 2022 17:27:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 2/2] NFSD: add shrinker to reap courtesy clients on low memory condition
Date:   Sun,  4 Sep 2022 10:27:52 -0700
Message-Id: <1662312472-23981-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662312472-23981-1-git-send-email-dai.ngo@oracle.com>
References: <1662312472-23981-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209040089
X-Proofpoint-GUID: fYkMQj0ox1KUhhTduDyr3-c1gItkm5ee
X-Proofpoint-ORIG-GUID: fYkMQj0ox1KUhhTduDyr3-c1gItkm5ee
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the courtesy client shrinker to react to low memory condition
triggered by the memory shrinker.

Currently the laundromat starts reaping courtesy clients only when
the maximum number of clients is reached. This patch adds another
trigger condition for the laundromat to reap courtesy clients.

The low memory trigger is created and the laundromat is kick started
by the shrinker's count callback. The shrinker's scan callback is
not used for expiring the courtesy clients due to potential deadlocks.

The laundromat reschedules itself to run sooner if it detects low
memory condition persists and there are more coutersy clients to reap.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 43 +++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |  6 ++++--
 fs/nfsd/nfsd.h      |  6 ++++--
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 55c7006d6109..85e351f08e57 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -194,6 +194,8 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
+	atomic_t		nfsd_client_shrinker_cb_count;
+	struct shrinker		nfsd_client_shrinker;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3af4fc5241b2..a27553b42e72 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4347,7 +4347,25 @@ nfsd4_init_slabs(void)
 	return -ENOMEM;
 }
 
-void nfsd4_init_leases_net(struct nfsd_net *nn)
+static unsigned long
+nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	struct nfsd_net *nn = container_of(shrink,
+			struct nfsd_net, nfsd_client_shrinker);
+
+	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	return (unsigned long)atomic_read(&nn->nfsd_courtesy_clients);
+}
+
+static unsigned long
+nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return SHRINK_STOP;
+}
+
+int
+nfsd4_init_leases_net(struct nfsd_net *nn)
 {
 	struct sysinfo si;
 	u64 max_clients;
@@ -4368,6 +4386,17 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	atomic_set(&nn->nfsd_courtesy_clients, 0);
+	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
+	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
+	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
+	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
+	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
+}
+
+void
+nfsd4_leases_net_shutdown(struct nfsd_net *nn)
+{
+	unregister_shrinker(&nn->nfsd_client_shrinker);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -5876,12 +5905,15 @@ static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
-	unsigned int maxreap, reapcnt = 0;
+	unsigned int maxreap = 0, reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
 
-	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
-			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients ||
+			atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0) {
+		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
+		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
+	}
 	INIT_LIST_HEAD(reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -5947,6 +5979,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 		list_del_init(&clp->cl_lru);
 		expire_client(clp);
 	}
+	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0 &&
+			atomic_read(&nn->nfsd_courtesy_clients) > 0)
+		lt.new_timeo = NFSD_LAUNDROMAT_MINTIMEOUT;
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 917fa1892fd2..597a26ad4183 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct net *net)
 		goto out_idmap_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
+	retval = nfsd4_init_leases_net(nn);
+	if (retval)
+		goto out_drc_error;
 	retval = nfsd_reply_cache_init(nn);
 	if (retval)
 		goto out_drc_error;
-	nfsd4_init_leases_net(nn);
-
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
@@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd4_leases_net_shutdown(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 57a468ed85c3..d87a465aa950 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -498,7 +498,8 @@ extern void unregister_cld_notifier(void);
 extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
-extern void nfsd4_init_leases_net(struct nfsd_net *nn);
+extern int nfsd4_init_leases_net(struct nfsd_net *nn);
+extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
 
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
@@ -506,7 +507,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
 	return 0;
 }
 
-static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
+static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
+static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
 
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
-- 
2.9.5

