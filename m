Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F65B8C52
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 17:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiINPym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 11:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiINPyl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 11:54:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED9E65FF
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 08:54:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EFkNqs015178;
        Wed, 14 Sep 2022 15:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=ULalCUJ5mTCefd1Pn13LhFhOJQ9ZG+J1nS6v/wwzngo=;
 b=jmkRmmx0Nr8qAFPR7eq65zjybPLlHP57y3ys7Tesay184CM122ZsmHDXu8FqJZTT3afq
 VHCC71ddy+tK1R/TzcYVf17uke5sgDJeZPPRyJTn+NItAdo+4rz3IyWRD9ld6hOgdqUp
 Z0c1Mkjn64r5F9Hvq2yat/+fC/so3ua4mBFyCwXhYzYVH3MuicMBp3j4vlmDL385aYcY
 TbOgac00lkksdVWABdnrYDpq2LoGjwxzUQDd2wkqtPVs27BFzq3Arn/GjPfrrWmqQa12
 u289RI2Ao9Ap30+vMGFF21mZuWCYdma5irFQTtl7uEZsYUuNCGXGB3G4gK3/vrwuojU6 wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydtsn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:54:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDZbhe035392;
        Wed, 14 Sep 2022 15:54:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjykyt0y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 15:54:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28EFp3ZI025970;
        Wed, 14 Sep 2022 15:54:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jjykyt0xj-3;
        Wed, 14 Sep 2022 15:54:33 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 2/2] NFSD: add shrinker to reap courtesy clients on low memory condition
Date:   Wed, 14 Sep 2022 08:54:26 -0700
Message-Id: <1663170866-21524-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663170866-21524-1-git-send-email-dai.ngo@oracle.com>
References: <1663170866-21524-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_07,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140077
X-Proofpoint-ORIG-GUID: HbC046I6TsU60xQhSLs9ID_KlCHGK2O9
X-Proofpoint-GUID: HbC046I6TsU60xQhSLs9ID_KlCHGK2O9
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

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/nfsd/nfsctl.c    |  6 ++--
 fs/nfsd/nfsd.h      |  7 ++--
 4 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 55c7006d6109..8c854ba3285b 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -194,6 +194,8 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_clients;
+	struct shrinker		nfsd_client_shrinker;
+	struct delayed_work	nfsd_shrinker_work;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2827329704ea..62b848bb55df 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4347,7 +4347,27 @@ nfsd4_init_slabs(void)
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
@@ -4368,6 +4388,16 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	atomic_set(&nn->nfsd_courtesy_clients, 0);
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
@@ -5909,10 +5939,49 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
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
+static void
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
@@ -5941,12 +6010,8 @@ nfs4_laundromat(struct nfsd_net *nn)
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
@@ -6029,6 +6094,18 @@ laundromat_main(struct work_struct *laundry)
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
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7845,6 +7922,7 @@ static int nfs4_state_create_net(struct net *net)
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

