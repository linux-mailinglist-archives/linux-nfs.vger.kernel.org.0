Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB95B77AB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiIMRUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 13:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiIMRUJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 13:20:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92498CB6
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 09:06:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DF8S2P004844;
        Tue, 13 Sep 2022 16:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=82x8KA4nnAn+F5OlrTTJdXfCvMfLmn93JL/ez7RHFps=;
 b=Z5lrm7M9KKdv7nadcKgtGISAB4VJfarF0Yjo2LbjM1kTQmjp7lok2JvrTGi6wA0dgXZm
 J8uerYefboxSB0zawYp9euBRvLeR8oj4ogI9XwtuH9BviJjuwgpO05KTL0/GMd9CyiPy
 Yinxv0pcDia2euPGyKtokBzuP9ATcFjX9KdItLcxQE3syRAUJAWKR8FNs7xbe0nzn1QH
 ifXl/zbg7+eDwyfb218ZLmQLeJyr1y0DK3VgWVyXnpWxCHuhDjI3ngxIyLeSl3qBkdKT
 j4CCAXr1m0CAFnSa2/mFM8shdeaEUKqI0v6zLmh2ziUb0mnqKXKdOIqVzqPkEn4rj9hY mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgjf9y7j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:06:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEV9hC016688;
        Tue, 13 Sep 2022 16:06:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jj6b2r394-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:06:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DG6HDl023194;
        Tue, 13 Sep 2022 16:06:18 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jj6b2r38a-3;
        Tue, 13 Sep 2022 16:06:17 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 2/2] NFSD: add shrinker to reap courtesy clients on low memory condition
Date:   Tue, 13 Sep 2022 09:06:10 -0700
Message-Id: <1663085170-23136-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
References: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130073
X-Proofpoint-GUID: 4_G605GDs2v4mIC6LLCMzqlfc-Q5ogk-
X-Proofpoint-ORIG-GUID: 4_G605GDs2v4mIC6LLCMzqlfc-Q5ogk-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add courtesy_client_reaper to react to low memory condition triggered
by the system memory shrinker.

The delayed_work for the courtesy_client_reaper is scheduled on
the shrinker's count callback using the laundry_wq.

The shrinker's scan callback is not used for expiring the courtesy
clients due to potential deadlocks.

The courtesy_client_reaper rechedules itself to run if low memory
condition persits and there are more courtesy clients in the system.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |   3 ++
 fs/nfsd/nfs4state.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfsctl.c    |   6 ++--
 fs/nfsd/nfsd.h      |   7 ++--
 4 files changed, 106 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 55c7006d6109..37457b104eee 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -194,6 +194,9 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
+	atomic_t		nfsd_client_shrinker_cb_count;
+	struct shrinker		nfsd_client_shrinker;
+	struct delayed_work	nfsd_shrinker_work;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3af4fc5241b2..fed4ca3fb581 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4347,7 +4347,28 @@ nfsd4_init_slabs(void)
 	return -ENOMEM;
 }
 
-void nfsd4_init_leases_net(struct nfsd_net *nn)
+static unsigned long
+nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cnt;
+	struct nfsd_net *nn = container_of(shrink,
+			struct nfsd_net, nfsd_client_shrinker);
+
+	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
+	cnt = atomic_read(&nn->nfsd_courtesy_clients);
+	if (cnt > 0)
+		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
+	return (unsigned long)cnt;
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
@@ -4368,6 +4389,17 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
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
@@ -5909,10 +5941,50 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 	spin_unlock(&nn->client_lock);
 }
 
+static void
+nfs4_get_courtesy_client_reaplist(struct nfsd_net *nn,
+				struct list_head *reaplist)
+{
+	unsigned int maxreap = 0, reapcnt = 0;
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
+	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
+	INIT_LIST_HEAD(reaplist);
+
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state == NFSD4_ACTIVE)
+			break;
+		if (reapcnt >= maxreap)
+			break;
+		if (!mark_client_expired_locked(clp)) {
+			list_add(&clp->cl_lru, reaplist);
+			reapcnt++;
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
+
+static inline void
+nfs4_process_client_reaplist(struct list_head *reaplist)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+
+	list_for_each_safe(pos, next, reaplist) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		trace_nfsd_clid_purged(&clp->cl_clientid);
+		list_del_init(&clp->cl_lru);
+		expire_client(clp);
+	}
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
-	struct nfs4_client *clp;
 	struct nfs4_openowner *oo;
 	struct nfs4_delegation *dp;
 	struct nfs4_ol_stateid *stp;
@@ -5941,12 +6013,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	}
 	spin_unlock(&nn->s2s_cp_lock);
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
-	list_for_each_safe(pos, next, &reaplist) {
-		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		trace_nfsd_clid_purged(&clp->cl_clientid);
-		list_del_init(&clp->cl_lru);
-		expire_client(clp);
-	}
+	nfs4_process_client_reaplist(&reaplist);
+
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
@@ -6029,6 +6097,23 @@ laundromat_main(struct work_struct *laundry)
 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
 }
 
+static void
+courtesy_client_reaper(struct work_struct *reaper)
+{
+	struct list_head reaplist;
+	struct delayed_work *dwork = to_delayed_work(reaper);
+	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
+					nfsd_shrinker_work);
+
+	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
+	nfs4_process_client_reaplist(&reaplist);
+	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0 &&
+			atomic_read(&nn->nfsd_courtesy_clients) > 0) {
+		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work,
+				NFSD_CLIENT_SHRINKER_MINTIMEOUT * HZ);
+	}
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7845,6 +7930,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
+	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
 	get_net(net);
 
 	return 0;
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
index 57a468ed85c3..cd92f615faa3 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -343,6 +343,7 @@ void		nfsd_lockd_shutdown(void);
 #define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 #define	NFSD_CLIENT_MAX_TRIM_PER_RUN	128
 #define	NFS4_CLIENTS_PER_GB		1024
+#define	NFSD_CLIENT_SHRINKER_MINTIMEOUT	1   /* seconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
@@ -498,7 +499,8 @@ extern void unregister_cld_notifier(void);
 extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
-extern void nfsd4_init_leases_net(struct nfsd_net *nn);
+extern int nfsd4_init_leases_net(struct nfsd_net *nn);
+extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
 
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
@@ -506,7 +508,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
 	return 0;
 }
 
-static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
+static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
+static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
 
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
-- 
2.9.5

