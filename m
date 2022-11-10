Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABB9623AF1
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Nov 2022 05:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKJERd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 23:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKJERc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 23:17:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370853AC
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 20:17:31 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA4AIel014859;
        Thu, 10 Nov 2022 04:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=lwfx0sNxgNjJP4TMlmjwcxm/GaOqbFpKMPYx8s8bEK4=;
 b=BCQzbuPfU6qnSoLek7Rs74vjesGciTgP56XYcaUnNDhhmg4h0ltV29GphuX4EpRD1bAA
 9FpO7eHb2ddUJjvP22G4dx1DLQ1cDr0/aDb/L4ndsc3XIFrvw5XKGZthi7C9d/1smrFZ
 d9vMNWEOGN2vYWeLgl7DlBTcFvthXZoxbmFSqq2yyYysZK3RKNzeaHrQnhiMEWYfxCLa
 rV7TiGsrePp1YCSwarwoAkvimPe9J1u+u3DBWfkLzT2k6UkYaHYW1r48Q3jL3J9Vy0HO
 gZvD+23ugRY7rNfSQcOyJ2PlJOQ6FE0lmOhDvjzJyvkS3vxObYwdFuKyXYZKDYRMvP8F JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krt1pr0xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 04:17:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA1YMeQ000309;
        Thu, 10 Nov 2022 04:17:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsfxc4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 04:17:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AA4HO7d005307;
        Thu, 10 Nov 2022 04:17:26 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcsfxc35-3;
        Thu, 10 Nov 2022 04:17:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/3] NFSD: add delegation shrinker to react to low memory condition
Date:   Wed,  9 Nov 2022 20:17:10 -0800
Message-Id: <1668053831-7662-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100030
X-Proofpoint-GUID: 85-sw0h0JKbr0hWDERdKMny01WZ6Q5az
X-Proofpoint-ORIG-GUID: 85-sw0h0JKbr0hWDERdKMny01WZ6Q5az
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The delegation shrinker is scheduled to run on every shrinker's
'count' callback. It scans the client list and sends the
courtesy CB_RECALL_ANY to the clients that hold delegations.

To avoid flooding the clients with CB_RECALL_ANY requests, the
delegation shrinker is scheduled to run after a 5 seconds delay.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |   3 ++
 fs/nfsd/nfs4state.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |   8 ++++
 3 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 8c854ba3285b..394a05fb46d8 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -196,6 +196,9 @@ struct nfsd_net {
 	atomic_t		nfsd_courtesy_clients;
 	struct shrinker		nfsd_client_shrinker;
 	struct delayed_work	nfsd_shrinker_work;
+
+	struct shrinker		nfsd_deleg_shrinker;
+	struct delayed_work	nfsd_deleg_shrinker_work;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4e718500a00c..813cdb67b370 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2131,6 +2131,7 @@ static void __free_client(struct kref *k)
 	kfree(clp->cl_nii_domain.data);
 	kfree(clp->cl_nii_name.data);
 	idr_destroy(&clp->cl_stateids);
+	kfree(clp->cl_ra);
 	kmem_cache_free(client_slab, clp);
 }
 
@@ -2854,6 +2855,36 @@ static const struct tree_descr client_files[] = {
 	[3] = {""},
 };
 
+static int
+nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
+				struct rpc_task *task)
+{
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+
+	spin_lock(&nn->client_lock);
+	clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
+	put_client_renew_locked(clp);
+	spin_unlock(&nn->client_lock);
+}
+
+static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
+	.done		= nfsd4_cb_recall_any_done,
+	.release	= nfsd4_cb_recall_any_release,
+};
+
 static struct nfs4_client *create_client(struct xdr_netobj name,
 		struct svc_rqst *rqstp, nfs4_verifier *verf)
 {
@@ -2891,6 +2922,14 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 		free_client(clp);
 		return NULL;
 	}
+	clp->cl_ra = kzalloc(sizeof(*clp->cl_ra), GFP_KERNEL);
+	if (!clp->cl_ra) {
+		free_client(clp);
+		return NULL;
+	}
+	clp->cl_ra_time = 0;
+	nfsd4_init_cb(&clp->cl_ra->ra_cb, clp, &nfsd4_cb_recall_any_ops,
+			NFSPROC4_CLNT_CB_RECALL_ANY);
 	return clp;
 }
 
@@ -4365,11 +4404,32 @@ nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return SHRINK_STOP;
 }
 
+static unsigned long
+nfsd_deleg_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	unsigned long cnt;
+	struct nfsd_net *nn = container_of(shrink,
+				struct nfsd_net, nfsd_deleg_shrinker);
+
+	cnt = atomic_long_read(&num_delegations);
+	if (cnt)
+		mod_delayed_work(laundry_wq,
+			&nn->nfsd_deleg_shrinker_work, 0);
+	return cnt;
+}
+
+static unsigned long
+nfsd_deleg_shrinker_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return SHRINK_STOP;
+}
+
 int
 nfsd4_init_leases_net(struct nfsd_net *nn)
 {
 	struct sysinfo si;
 	u64 max_clients;
+	int retval;
 
 	nn->nfsd4_lease = 90;	/* default lease time */
 	nn->nfsd4_grace = 90;
@@ -4390,13 +4450,24 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
 	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
 	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
-	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
+	retval = register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
+	if (retval)
+		return retval;
+	nn->nfsd_deleg_shrinker.scan_objects = nfsd_deleg_shrinker_scan;
+	nn->nfsd_deleg_shrinker.count_objects = nfsd_deleg_shrinker_count;
+	nn->nfsd_deleg_shrinker.seeks = DEFAULT_SEEKS;
+	retval = register_shrinker(&nn->nfsd_deleg_shrinker, "nfsd-delegation");
+	if (retval)
+		unregister_shrinker(&nn->nfsd_client_shrinker);
+	return retval;
+
 }
 
 void
 nfsd4_leases_net_shutdown(struct nfsd_net *nn)
 {
 	unregister_shrinker(&nn->nfsd_client_shrinker);
+	unregister_shrinker(&nn->nfsd_deleg_shrinker);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -6135,6 +6206,47 @@ courtesy_client_reaper(struct work_struct *reaper)
 	nfs4_process_client_reaplist(&reaplist);
 }
 
+static void
+deleg_reaper(struct work_struct *deleg_work)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+	struct list_head cblist;
+	struct delayed_work *dwork = to_delayed_work(deleg_work);
+	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
+					nfsd_deleg_shrinker_work);
+
+	INIT_LIST_HEAD(&cblist);
+	spin_lock(&nn->client_lock);
+	list_for_each_safe(pos, next, &nn->client_lru) {
+		clp = list_entry(pos, struct nfs4_client, cl_lru);
+		if (clp->cl_state != NFSD4_ACTIVE ||
+			list_empty(&clp->cl_delegations) ||
+			atomic_read(&clp->cl_delegs_in_recall) ||
+			test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) ||
+			(ktime_get_boottime_seconds() -
+				clp->cl_ra_time < 5)) {
+			continue;
+		}
+		list_add(&clp->cl_ra_cblist, &cblist);
+
+		/* release in nfsd4_cb_recall_any_release */
+		atomic_inc(&clp->cl_rpc_users);
+		set_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
+		clp->cl_ra_time = ktime_get_boottime_seconds();
+	}
+	spin_unlock(&nn->client_lock);
+	list_for_each_safe(pos, next, &cblist) {
+		clp = list_entry(pos, struct nfs4_client, cl_ra_cblist);
+		list_del_init(&clp->cl_ra_cblist);
+		clp->cl_ra->ra_keep = 0;
+		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
+						BIT(RCA4_TYPE_MASK_WDATA_DLG);
+		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+	}
+
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7958,6 +8070,7 @@ static int nfs4_state_create_net(struct net *net)
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
+	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
 	get_net(net);
 
 	return 0;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6b33cbbe76d3..12ce9792c5b6 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -368,6 +368,7 @@ struct nfs4_client {
 #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
+#define	NFSD4_CLIENT_CB_RECALL_ANY	(6)
 	unsigned long		cl_flags;
 	const struct cred	*cl_cb_cred;
 	struct rpc_clnt		*cl_cb_client;
@@ -411,6 +412,10 @@ struct nfs4_client {
 
 	unsigned int		cl_state;
 	atomic_t		cl_delegs_in_recall;
+
+	struct nfsd4_cb_recall_any	*cl_ra;
+	time64_t		cl_ra_time;
+	struct list_head	cl_ra_cblist;
 };
 
 /* struct nfs4_client_reset
@@ -642,6 +647,9 @@ enum nfsd4_cb_op {
 	NFSPROC4_CLNT_CB_RECALL_ANY,
 };
 
+#define	RCA4_TYPE_MASK_RDATA_DLG	0
+#define	RCA4_TYPE_MASK_WDATA_DLG	1
+
 /* Returns true iff a is later than b: */
 static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
 {
-- 
2.9.5

