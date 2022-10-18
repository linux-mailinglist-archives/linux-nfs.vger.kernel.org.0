Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F061B6023AD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJRFP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 01:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJRFPz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 01:15:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E195AC2
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 22:15:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYXgv019054
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=+QabVqoqeBS4LgVntTxDGS2ICkxmmbJG2VbE7z7s3tY=;
 b=GaS3F6K5YcDb5pib0f5qyQrrPsPEV7k5te/uwVMq8FECaQRVJO3aAPz/b1uXrKnpCNJj
 ukpbTOCcpbcyhtvRLEUwnGxGRHSyyoMkPsntQmFogsPovO/LaHZVds2brGRl8RsYt52e
 Z1ZdpxYvSby3Bt458Oa1uzi662jsuZTE+2ydyAyjuSx/Ctu152uIRtC/zpv3zW77B+Ir
 pP7KhoofYOkQUDt0AZmFCasQbOyoin0gPOOvPK6Zsiyiku/gsQnOCwyeViMzeVm0Y5mr
 Iul8NRLH1sj1dVStprM5KdyFNy62pSAnwbgdUOoKt0WKo0bvYaSMBEArveRlt/XPtOVm Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtdvcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29I13KoV017267
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu6rg0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29I5Fpl8031322
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 05:15:52 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8hu6rg01-3;
        Tue, 18 Oct 2022 05:15:52 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: add delegation shrinker to react to low memory condition
Date:   Mon, 17 Oct 2022 22:15:39 -0700
Message-Id: <1666070139-18843-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180029
X-Proofpoint-ORIG-GUID: 6WI0TUWzM9z92UGJt0BAJHzYObSYiUBr
X-Proofpoint-GUID: 6WI0TUWzM9z92UGJt0BAJHzYObSYiUBr
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
 fs/nfsd/netns.h     |  3 +++
 fs/nfsd/nfs4state.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |  1 +
 3 files changed, 73 insertions(+), 1 deletion(-)

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
index c60c937dece6..bdaea0e6e72f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4392,11 +4392,32 @@ nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
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
+			&nn->nfsd_deleg_shrinker_work, 5 * HZ);
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
@@ -4417,13 +4438,23 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
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
 }
 
 void
 nfsd4_leases_net_shutdown(struct nfsd_net *nn)
 {
 	unregister_shrinker(&nn->nfsd_client_shrinker);
+	unregister_shrinker(&nn->nfsd_deleg_shrinker);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -6162,6 +6193,42 @@ courtesy_client_reaper(struct work_struct *reaper)
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
+				list_empty(&clp->cl_delegations) ||
+				atomic_read(&clp->cl_delegs_in_recall) ||
+				clp->cl_recall_any_busy) {
+			continue;
+		}
+		clp->cl_recall_any_busy = true;
+		list_add(&clp->cl_recall_any_cblist, &cblist);
+
+		/* release in nfsd4_cb_recall_any_release */
+		atomic_inc(&clp->cl_rpc_users);
+	}
+	spin_unlock(&nn->client_lock);
+	list_for_each_safe(pos, next, &cblist) {
+		clp = list_entry(pos, struct nfs4_client, cl_recall_any_cblist);
+		list_del_init(&clp->cl_recall_any_cblist);
+		clp->cl_recall_any_bm = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
+						BIT(RCA4_TYPE_MASK_WDATA_DLG);
+		nfsd4_run_cb(&clp->cl_recall_any);
+	}
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7985,6 +8052,7 @@ static int nfs4_state_create_net(struct net *net)
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
+	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
 	get_net(net);
 
 	return 0;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 49ca06169642..05b572ce6605 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -415,6 +415,7 @@ struct nfs4_client {
 	bool			cl_recall_any_busy;
 	uint32_t		cl_recall_any_bm;
 	struct nfsd4_callback	cl_recall_any;
+	struct list_head	cl_recall_any_cblist;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

