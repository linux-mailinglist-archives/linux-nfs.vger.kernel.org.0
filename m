Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74A05A6CE4
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiH3TPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiH3TO6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 15:14:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F1DF64
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 12:14:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UHtNiL032440;
        Tue, 30 Aug 2022 19:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=EmpyzlL3nuknxQdSqOXda82Dr6QuQNOupqcP4MCw3MQ=;
 b=JRJRIhenW7kyMlk7X+bV7HCZfXTfLUzVgUhCbd+aKav+oVhuI7eewVVq3fY8/sAegjH9
 W/og91WRxCWLbt52cJiOJzEZdVeFwck+n4spJ3lR3wmV9EkOpxXa7D0d5KvQqycgtag9
 5IqMteoxD8GNWsKbdOeViPWU80WutJ/NFK+09gfMOxTqAyw35Je7gUqvDG7DP6pOBY3c
 5UlTeUHNa4JwVg9/sQrZl2StxNiZ8pf9DRTv9XCaKQNTntaQZW0zqcHKmN0TXyFAjG4e
 K+xwq9AOQdCscx0j6aMzfeVsjVrU/uLPOzC+BiXgx6upwNL7q91kAaufx/lRSaB9rZPX sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a227b75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:14:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXXJY035890;
        Tue, 30 Aug 2022 19:14:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4h625-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:14:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UJEn1x002516;
        Tue, 30 Aug 2022 19:14:50 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3j79q4h61f-3;
        Tue, 30 Aug 2022 19:14:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] NFSD: add shrinker to reap courtesy clients on low memory condition
Date:   Tue, 30 Aug 2022 12:14:25 -0700
Message-Id: <1661886865-30304-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661886865-30304-1-git-send-email-dai.ngo@oracle.com>
References: <1661886865-30304-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208300086
X-Proofpoint-GUID: 7jcMbmq4uSEDUhQ_R-SAd2NnQYrDXmuI
X-Proofpoint-ORIG-GUID: 7jcMbmq4uSEDUhQ_R-SAd2NnQYrDXmuI
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

On the shrinker's count callback, we increment a callback counter
and return the number of outstanding courtesy clients. When the
laundromat runs, it checks if this counter is not zero and starts
reaping old courtesy clients. The maximum number of clients to be
reaped is limited to NFSD_CIENT_MAX_TRIM_PER_RUN (128). This limit
is to prevent the laundromat from spending too much time reaping
the clients and not processing other tasks in a timely manner.

The laundromat is rescheduled to run sooner if it detects low
low memory condition and there are more clients to reap.

On the shrinker's scan callback, we return the number of clients
That were reaped since the last scan callback. We can not reap
the clients on the scan callback context since destroying the
client might require call into the underlying filesystem or other
subsystems which might allocate memory which can cause deadlock.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c    |  6 ++++--
 fs/nfsd/nfsd.h      |  9 +++++++--
 4 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 2695dff1378a..2a604951623f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -194,6 +194,9 @@ struct nfsd_net {
 	int			nfs4_max_clients;
 
 	atomic_t		nfsd_courtesy_client_count;
+	atomic_t		nfsd_client_shrinker_cb_count;
+	atomic_t		nfsd_client_shrinker_reapcount;
+	struct shrinker		nfsd_client_shrinker;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9675b5d8f408..73815c861bec 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4341,7 +4341,40 @@ nfsd4_init_slabs(void)
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
+	return (unsigned long)atomic_read(&nn->nfsd_courtesy_client_count);
+}
+
+static unsigned long
+nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	struct nfsd_net *nn = container_of(shrink,
+			struct nfsd_net, nfsd_client_shrinker);
+	unsigned long cnt;
+
+	cnt = atomic_read(&nn->nfsd_client_shrinker_reapcount);
+	atomic_set(&nn->nfsd_client_shrinker_reapcount, 0);
+	return cnt;
+}
+
+static int
+nfsd_register_client_shrinker(struct nfsd_net *nn)
+{
+	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
+	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
+	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
+	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
+}
+
+int
+nfsd4_init_leases_net(struct nfsd_net *nn)
 {
 	struct sysinfo si;
 	u64 max_clients;
@@ -4362,6 +4395,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	atomic_set(&nn->nfsd_courtesy_client_count, 0);
+	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
+	return nfsd_register_client_shrinker(nn);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -5870,12 +5905,17 @@ static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
-	unsigned int maxreap, reapcnt = 0;
+	unsigned int maxreap = 0, reapcnt = 0;
+	int cb_cnt;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
 
-	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
-			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
+	cb_cnt = atomic_read(&nn->nfsd_client_shrinker_cb_count);
+	if (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients ||
+							cb_cnt) {
+		maxreap = NFSD_CLIENT_MAX_TRIM_PER_RUN;
+		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
+	}
 	INIT_LIST_HEAD(reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -5900,6 +5940,8 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 		}
 	}
 	spin_unlock(&nn->client_lock);
+	if (cb_cnt)
+		atomic_add(reapcnt, &nn->nfsd_client_shrinker_reapcount);
 }
 
 static time64_t
@@ -5940,6 +5982,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 		list_del_init(&clp->cl_lru);
 		expire_client(clp);
 	}
+	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0)
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
index 57a468ed85c3..7e05ab7a3532 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -498,7 +498,11 @@ extern void unregister_cld_notifier(void);
 extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
-extern void nfsd4_init_leases_net(struct nfsd_net *nn);
+extern int nfsd4_init_leases_net(struct nfsd_net *nn);
+static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn)
+{
+	unregister_shrinker(&nn->nfsd_client_shrinker);
+};
 
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
@@ -506,7 +510,8 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
 	return 0;
 }
 
-static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
+static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
+static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) { };
 
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
-- 
2.9.5

