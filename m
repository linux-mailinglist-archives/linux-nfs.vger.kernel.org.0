Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0D608EEC
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Oct 2022 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJVSJg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Oct 2022 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJVSJf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Oct 2022 14:09:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE94CE11
        for <linux-nfs@vger.kernel.org>; Sat, 22 Oct 2022 11:09:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29MEGPEM018078;
        Sat, 22 Oct 2022 18:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=THTj2eOEXKD18pTiin4OdTgbXKPUpu0ziiYsiJPzGY0=;
 b=Dj6++Rk+B3yhSJO1BpR4Pgab5oKU+x17yf+VdDVv9Dm578zOMNuZ0dc61xXirc2Q++MS
 EipLf4uV8Xu683/EnEeJ/3pLaYeUTzmUXHCgyRMMp0U/Wq5TPDSrgDXdLIKa5U2E8RV2
 M09LBA09sRMdAPOj5TjdIP++z/VGeBF+4k2jKo5woc/yTotJgSG7fq1vn8pbgWYdSjas
 xsHOg0qsFmhsUPu5BbVwIfieOuBFt2YuOKXvWkmceERkSmiDQe/sMOPH//7gkQ3DF2ba
 Stx2rcWP1Nn65MowA4u52ZYJShVRkXvboSHPRG5kNHEKl3fa1jgfbIhamBPz3v4ofkPO oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741guvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 18:09:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29M96EpF032049;
        Sat, 22 Oct 2022 18:09:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y2u3x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Oct 2022 18:09:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29MI9OHk026867;
        Sat, 22 Oct 2022 18:09:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kc6y2u3wv-3;
        Sat, 22 Oct 2022 18:09:24 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSD: add delegation shrinker to react to low memory condition
Date:   Sat, 22 Oct 2022 11:09:10 -0700
Message-Id: <1666462150-11736-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
References: <1666462150-11736-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210220114
X-Proofpoint-GUID: QrkyuaJsn6rZKEiPl_piGTUdpx6QKdQq
X-Proofpoint-ORIG-GUID: QrkyuaJsn6rZKEiPl_piGTUdpx6QKdQq
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
 fs/nfsd/nfs4state.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |  2 ++
 3 files changed, 78 insertions(+), 1 deletion(-)

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
index c60c937dece6..89d33d76f8d6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2916,6 +2916,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 		free_client(clp);
 		return NULL;
 	}
+	clp->cl_recall_any_time = 0;
 	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
 			NFSPROC4_CLNT_CB_RECALL_ANY);
 	return clp;
@@ -4392,11 +4393,32 @@ nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
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
@@ -4417,13 +4439,23 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
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
@@ -6162,6 +6194,45 @@ courtesy_client_reaper(struct work_struct *reaper)
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
+				clp->cl_recall_any_busy ||
+				(ktime_get_boottime_seconds() -
+					clp->cl_recall_any_time < 5)) {
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
+		clp->cl_recall_any_time = ktime_get_boottime_seconds();
+		nfsd4_run_cb(&clp->cl_recall_any);
+	}
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7985,6 +8056,7 @@ static int nfs4_state_create_net(struct net *net)
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
+	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
 	get_net(net);
 
 	return 0;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 49ca06169642..7d68d9a50901 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -415,6 +415,8 @@ struct nfs4_client {
 	bool			cl_recall_any_busy;
 	uint32_t		cl_recall_any_bm;
 	struct nfsd4_callback	cl_recall_any;
+	struct list_head	cl_recall_any_cblist;
+	time64_t		cl_recall_any_time;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

