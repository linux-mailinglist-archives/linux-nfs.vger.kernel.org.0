Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F162D1D6
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 04:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKQDpQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 22:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiKQDpL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 22:45:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714D2DAB6
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 19:45:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH1uoKf025212;
        Thu, 17 Nov 2022 03:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=59zWsvl1R0n4V5CvDvszGOHTVh3N7VHVhn5mJhjar4Y=;
 b=2vXpWpQBJ1cy3eALT3ez3EY7euqw6nrletir1jQwQYSLzmEIlSLuwpQeYBf6YmPvs3O3
 kAUEMyMK/KIEhjEz+8vIhCrMAsdAl/ImzKqywlrgiaItHCYgl05iIm3lIQrm5xdkt+OM
 sC6xQl0LXSetEdEVn+g+Mh+H3WckDZGYFfUJMtvVZgiThxwRoyraR6wRsX1CmR4QBcuD
 quy1oGcZQY+JW0B8utQRImf9lupfWhrt8VNtDMewKwe4W7E/6j3beWAJDJVFFynUnAQ/
 JOvjmjgqQog7C+0QkLaFPVUpu3U34qwDHNYnivevcoNrdwHzVMbGHMrpRXUlsxCaX3un /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n17swd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH1I7Dk016882;
        Thu, 17 Nov 2022 03:44:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1ya27f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH3iutj030624;
        Thu, 17 Nov 2022 03:44:57 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kuk1ya262-4;
        Thu, 17 Nov 2022 03:44:57 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 3/4] NFSD: add delegation reaper to react to low memory condition
Date:   Wed, 16 Nov 2022 19:44:47 -0800
Message-Id: <1668656688-22507-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170024
X-Proofpoint-GUID: 2DC_SrdSru4N2zSuMy-jDEmSt0rWeYky
X-Proofpoint-ORIG-GUID: 2DC_SrdSru4N2zSuMy-jDEmSt0rWeYky
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The delegation reaper is called by nfsd memory shrinker's on
the 'count' callback. It scans the client list and sends the
courtesy CB_RECALL_ANY to the clients that hold delegations.

To avoid flooding the clients with CB_RECALL_ANY requests, the
delegation reaper sends only one CB_RECALL_ANY request to each
client per 5 seconds.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/state.h     |  8 +++++
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 142481bc96de..13f326ae928c 100644
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
 
@@ -4349,14 +4388,16 @@ nfsd4_init_slabs(void)
 static unsigned long
 nfsd_lowmem_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	int cnt;
+	int count;
 	struct nfsd_net *nn = container_of(shrink,
 			struct nfsd_net, nfsd_client_shrinker);
 
-	cnt = atomic_read(&nn->nfsd_courtesy_clients);
-	if (cnt > 0)
+	count = atomic_read(&nn->nfsd_courtesy_clients);
+	if (!count)
+		count = atomic_long_read(&num_delegations);
+	if (count)
 		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
-	return (unsigned long)cnt;
+	return (unsigned long)count;
 }
 
 static unsigned long
@@ -6134,6 +6175,45 @@ courtesy_client_reaper(struct nfsd_net *nn)
 }
 
 static void
+deleg_reaper(struct nfsd_net *nn)
+{
+	struct list_head *pos, *next;
+	struct nfs4_client *clp;
+	struct list_head cblist;
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
+
+	while (!list_empty(&cblist)) {
+		clp = list_first_entry(&cblist, struct nfs4_client,
+					cl_ra_cblist);
+		list_del_init(&clp->cl_ra_cblist);
+		clp->cl_ra->ra_keep = 0;
+		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
+						BIT(RCA4_TYPE_MASK_WDATA_DLG);
+		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+	}
+}
+
+static void
 nfsd4_lowmem_shrinker(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -6141,6 +6221,7 @@ nfsd4_lowmem_shrinker(struct work_struct *work)
 				nfsd_shrinker_work);
 
 	courtesy_client_reaper(nn);
+	deleg_reaper(nn);
 }
 
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
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

