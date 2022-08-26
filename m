Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9345A324D
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Aug 2022 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbiHZXBd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 19:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345237AbiHZXBb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 19:01:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A7E831C
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 16:01:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QMY5Nl022517
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 23:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=JuJzh7MywdIDV7Qq/JegSTYQ5hs9tMHamqPWU5qMuuA=;
 b=ReoG+at0aGT9hTK9SbS9koZ/YJBlb9m4P+x0sO+ttTFXThXUggjmV08DeaXUzozDVAWD
 3yTdETkoLTxPMe6KT7gnq18sBAvW6G/SlGp/TBJ700KeJ/D7PBzdsINjzfUJkubezqLM
 R4RdOpu1DEoPOdeMEuR79jk4yxf6sjw+kjfIz7WmN1dkbw03Aw2FND8v7xWRGU9pIwOh
 uDObfz9J8+rAi/MKDaSNIHN5N/YVHw8yoxoMXu2R1bCNIrxr/u56yxsTX0BrVZW9uFkA
 5YMmoVw+BydKIr9vlnOJN9XF5F/KgfDe+KmbUGyMXVu4lPCSllnChMHXrRlzb/i/eCgb ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w242tsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 23:01:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QJohlQ033639
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 23:01:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6rjcbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 23:01:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27QN1SqC005764
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 23:01:28 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3j5n6rjcb7-2;
        Fri, 26 Aug 2022 23:01:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSD: keep track of the number of courtesy clients in the system
Date:   Fri, 26 Aug 2022 16:01:25 -0700
Message-Id: <1661554886-26025-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661554886-26025-1-git-send-email-dai.ngo@oracle.com>
References: <1661554886-26025-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260090
X-Proofpoint-ORIG-GUID: tWBfKimp4uhVrrEQjqgWgkVyUhoGuDBy
X-Proofpoint-GUID: tWBfKimp4uhVrrEQjqgWgkVyUhoGuDBy
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
 fs/nfsd/nfs4state.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

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
index c5d199d7e6b4..3d8d7ebb5b91 100644
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
@@ -5864,7 +5870,7 @@ static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
-	unsigned int maxreap, reapcnt = 0;
+	unsigned int oldstate, maxreap, reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
 
@@ -5878,8 +5884,12 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			goto exp_client;
 		if (!state_expired(lt, clp->cl_time))
 			break;
-		if (!atomic_read(&clp->cl_rpc_users))
-			clp->cl_state = NFSD4_COURTESY;
+		oldstate = NFSD4_ACTIVE;
+		if (!atomic_read(&clp->cl_rpc_users)) {
+			oldstate = xchg(&clp->cl_state, NFSD4_COURTESY);
+			if (oldstate == NFSD4_ACTIVE)
+				atomic_inc(&nn->nfsd_courtesy_client_count);
+		}
 		if (!client_has_state(clp))
 			goto exp_client;
 		if (!nfs4_anylock_blockers(clp))
-- 
2.9.5

