Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90C9565DC6
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jul 2022 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiGDTFx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jul 2022 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbiGDTFw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jul 2022 15:05:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58996B8F
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jul 2022 12:05:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264HH26V001698
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=/F+a2CLOEc4xzYXwnJGTx/kltOvaiNT20lWiN6Oz2hk=;
 b=ryRTRSC6mJbWwWa0/2CsQJeLB+pEbOCeCKojWZ92A/bLI+IwhhWJlc59NZY1sRoE6reu
 E0b/nnLWIYmJ2LEVGdpyf6B0DCRrVRjQp/DYmENT1naDZSbwPUz0BK0QbI5xXxhhtY/w
 SbuVXGD39etT7Lv6WxozNpyac8/hE6B4gf5WZ7GUelwFOeU5U/Vi1ZmM3ojvxZYLAPUx
 GJI8+jQHK+9l9DcIgIbcdpQHO3pBvrNqJjl97lj0C+1mQJgpfZb5hnzI1JdduCFp7gle
 dLowFq3AiR6kPJfG5oXPpiuLnghGWvWR/A8+bmo6tFAXBY6WFBoHX6lCkH3/W5jCIn0I Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2eju40sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 19:05:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264J1QVa022163
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7vt8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jul 2022 19:05:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 264J5mhs029031
        for <linux-nfs@vger.kernel.org>; Mon, 4 Jul 2022 19:05:49 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7vt8d-2;
        Mon, 04 Jul 2022 19:05:49 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFSD: keep track of the number of courtesy clients in the system
Date:   Mon,  4 Jul 2022 12:05:42 -0700
Message-Id: <1656961543-25210-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
References: <1656961543-25210-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: IRjG_ZaNaBzqW5NvfUQC9Dmtivb7rZIo
X-Proofpoint-ORIG-GUID: IRjG_ZaNaBzqW5NvfUQC9Dmtivb7rZIo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add counter nfscourtesy_client_count to keep track of the number
of courtesy clients in the system.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9409a0dc1b76..a34ffb0d8c77 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -126,11 +126,13 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 
 static struct workqueue_struct *laundry_wq;
+static atomic_t courtesy_client_count;
 
 int nfsd4_create_laundry_wq(void)
 {
 	int rc = 0;
 
+	atomic_set(&courtesy_client_count, 0);
 	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
 	if (laundry_wq == NULL)
 		rc = -ENOMEM;
@@ -169,7 +171,8 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 	if (is_client_expired(clp))
 		return nfserr_expired;
 	atomic_inc(&clp->cl_rpc_users);
-	clp->cl_state = NFSD4_ACTIVE;
+	if (xchg(&clp->cl_state, NFSD4_ACTIVE) != NFSD4_ACTIVE)
+		atomic_add_unless(&courtesy_client_count, -1, 0);
 	return nfs_ok;
 }
 
@@ -190,7 +193,8 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
-	clp->cl_state = NFSD4_ACTIVE;
+	if (xchg(&clp->cl_state, NFSD4_ACTIVE) != NFSD4_ACTIVE)
+		atomic_add_unless(&courtesy_client_count, -1, 0);
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -2226,6 +2230,8 @@ __destroy_client(struct nfs4_client *clp)
 	nfsd4_shutdown_callback(clp);
 	if (clp->cl_cb_conn.cb_xprt)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
+	if (clp->cl_state != NFSD4_ACTIVE)
+		atomic_add_unless(&courtesy_client_count, -1, 0);
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
@@ -5803,8 +5809,11 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			goto exp_client;
 		if (!state_expired(lt, clp->cl_time))
 			break;
-		if (!atomic_read(&clp->cl_rpc_users))
-			clp->cl_state = NFSD4_COURTESY;
+		if (!atomic_read(&clp->cl_rpc_users)) {
+			if (xchg(&clp->cl_state, NFSD4_COURTESY) ==
+							NFSD4_ACTIVE)
+				atomic_inc(&courtesy_client_count);
+		}
 		if (!client_has_state(clp) ||
 				ktime_get_boottime_seconds() >=
 				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
-- 
2.9.5

