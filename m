Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961C5A6CE2
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 21:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiH3TO6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiH3TO5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 15:14:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D427674
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 12:14:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UHtkf4000518;
        Tue, 30 Aug 2022 19:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=kx07QSiLZO+txINdrdb2bj8WETd+aZRLFm1Vd7swOOw=;
 b=xC7IOOvIdFSpKNUWLUhgHU0L6+6Q1c7dBjJkX2LwW2mGIoXQCRU+a1KW4AShwOcXAYG3
 Qzn0ojH1PERSEt/tCN3QFpqQ082edSqOfmIRaf84uz2QNA8/C0xOBQXFhjizIb2Cv0pt
 aOjFkrvCkvNsG3Ywu8NbZOcukRBvNO2/U3+HlS6bFhWnOOP1CtnNcJo3zaRRM74y4hCF
 583bLdaWUggX16ZjtcyUHAQe4Ql6tf/S+8Wh4Da8RVd8qY6mFBzOzuVh46x94bQRqoD5
 AxHAeF0+2APKgFPGCDOmKYkRFz/g5jQBW4ZkNWdDsTnnxdl5s/u+S3pyfDcIOmDEZ6ky zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt7adx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:14:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXXtP035953;
        Tue, 30 Aug 2022 19:14:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4h61v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 19:14:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27UJEn1v002516;
        Tue, 30 Aug 2022 19:14:49 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3j79q4h61f-2;
        Tue, 30 Aug 2022 19:14:49 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] NFSD: keep track of the number of courtesy clients in the system
Date:   Tue, 30 Aug 2022 12:14:24 -0700
Message-Id: <1661886865-30304-2-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-ORIG-GUID: uE94wHZGyBF2j6YQGbtVa-JxQ23CJlYP
X-Proofpoint-GUID: uE94wHZGyBF2j6YQGbtVa-JxQ23CJlYP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add counter nfs4_courtesy_client_count to nfsd_net to keep track
of the number of courtesy clients in the system.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 14 +++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ffe17743cc74..2695dff1378a 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -192,6 +192,8 @@ struct nfsd_net {
 
 	atomic_t		nfs4_client_count;
 	int			nfs4_max_clients;
+
+	atomic_t		nfsd_courtesy_client_count;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5d199d7e6b4..9675b5d8f408 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -169,7 +169,8 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 	if (is_client_expired(clp))
 		return nfserr_expired;
 	atomic_inc(&clp->cl_rpc_users);
-	clp->cl_state = NFSD4_ACTIVE;
+	if (xchg(&clp->cl_state, NFSD4_ACTIVE) != NFSD4_ACTIVE)
+		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
 	return nfs_ok;
 }
 
@@ -190,7 +191,8 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
-	clp->cl_state = NFSD4_ACTIVE;
+	if (xchg(&clp->cl_state, NFSD4_ACTIVE) != NFSD4_ACTIVE)
+		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -2233,6 +2235,8 @@ __destroy_client(struct nfs4_client *clp)
 	if (clp->cl_cb_conn.cb_xprt)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
+	if (clp->cl_state != NFSD4_ACTIVE)
+		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
@@ -4356,6 +4360,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	max_clients = (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
 	max_clients *= NFS4_CLIENTS_PER_GB;
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
+
+	atomic_set(&nn->nfsd_courtesy_client_count, 0);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -5879,7 +5885,9 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 		if (!state_expired(lt, clp->cl_time))
 			break;
 		if (!atomic_read(&clp->cl_rpc_users))
-			clp->cl_state = NFSD4_COURTESY;
+			if (xchg(&clp->cl_state, NFSD4_COURTESY) ==
+							NFSD4_ACTIVE)
+				atomic_inc(&nn->nfsd_courtesy_client_count);
 		if (!client_has_state(clp))
 			goto exp_client;
 		if (!nfs4_anylock_blockers(clp))
-- 
2.9.5

