Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373075AC5C4
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Sep 2022 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiIDR2L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 4 Sep 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiIDR2I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 4 Sep 2022 13:28:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14233378
        for <linux-nfs@vger.kernel.org>; Sun,  4 Sep 2022 10:28:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 284CRoXU007403;
        Sun, 4 Sep 2022 17:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Q5PX8fqQxPWwPTSctbE8dnGKD7fKgmCNV5L8mwkNNP4=;
 b=YGSotrya+9QipdmmQK4eMKaFC07pYN8aYJ+1CUCIou0CLKBZtbr9oxL0TAEqWrUQyMBC
 HxEbqvw05SmezOE00Py2neaW+dMwWv/FvSMOgnUBJaU4z4KoihsGSlmAUUdxIpI6J6x7
 VpROqBn+eRq+vBI6QKYReAsweq3XzKyGI4fWryL05GkHhRkRSkZXTZWp9b01zdjCM/7B
 fGi3XC3192I6EpgB1F1uaAU06Ywx11hqAVdsg8j3lQfraSTkkcyJ+l2Cr7nwC0pAkxGE
 zKdFs5LD1kkHBbrAEwu0+HHV9i/cyun043lb/Gdgn75VrBvR1CP2X4U14BPPgLCIfqWa gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyfthx7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 17:27:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 284DjZXA033803;
        Sun, 4 Sep 2022 17:27:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc7bukb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 04 Sep 2022 17:27:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 284HRuvl029092;
        Sun, 4 Sep 2022 17:27:57 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc7buk3-2;
        Sun, 04 Sep 2022 17:27:57 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/2] NFSD: keep track of the number of courtesy clients in the system
Date:   Sun,  4 Sep 2022 10:27:51 -0700
Message-Id: <1662312472-23981-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662312472-23981-1-git-send-email-dai.ngo@oracle.com>
References: <1662312472-23981-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-04_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209040089
X-Proofpoint-ORIG-GUID: DBNCRNifyK_nIAyiYmKrKd00ET-PGH2d
X-Proofpoint-GUID: DBNCRNifyK_nIAyiYmKrKd00ET-PGH2d
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
 fs/nfsd/nfs4state.c | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ffe17743cc74..55c7006d6109 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -192,6 +192,8 @@ struct nfsd_net {
 
 	atomic_t		nfs4_client_count;
 	int			nfs4_max_clients;
+
+	atomic_t		nfsd_courtesy_clients;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5d199d7e6b4..3af4fc5241b2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -160,6 +160,13 @@ static bool is_client_expired(struct nfs4_client *clp)
 	return clp->cl_time == 0;
 }
 
+static inline void nfsd4_decr_courtesy_client_count(struct nfsd_net *nn,
+					struct nfs4_client *clp)
+{
+	if (clp->cl_state != NFSD4_ACTIVE)
+		atomic_add_unless(&nn->nfsd_courtesy_clients, -1, 0);
+}
+
 static __be32 get_client_locked(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
@@ -169,6 +176,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 	if (is_client_expired(clp))
 		return nfserr_expired;
 	atomic_inc(&clp->cl_rpc_users);
+	nfsd4_decr_courtesy_client_count(nn, clp);
 	clp->cl_state = NFSD4_ACTIVE;
 	return nfs_ok;
 }
@@ -190,6 +198,7 @@ renew_client_locked(struct nfs4_client *clp)
 
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
+	nfsd4_decr_courtesy_client_count(nn, clp);
 	clp->cl_state = NFSD4_ACTIVE;
 }
 
@@ -2233,6 +2242,7 @@ __destroy_client(struct nfs4_client *clp)
 	if (clp->cl_cb_conn.cb_xprt)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
 	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
+	nfsd4_decr_courtesy_client_count(nn, clp);
 	free_client(clp);
 	wake_up_all(&expiry_wq);
 }
@@ -4356,6 +4366,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	max_clients = (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
 	max_clients *= NFS4_CLIENTS_PER_GB;
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
+
+	atomic_set(&nn->nfsd_courtesy_clients, 0);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -5878,8 +5890,11 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			goto exp_client;
 		if (!state_expired(lt, clp->cl_time))
 			break;
-		if (!atomic_read(&clp->cl_rpc_users))
+		if (!atomic_read(&clp->cl_rpc_users)) {
+			if (clp->cl_state == NFSD4_ACTIVE)
+				atomic_inc(&nn->nfsd_courtesy_clients);
 			clp->cl_state = NFSD4_COURTESY;
+		}
 		if (!client_has_state(clp))
 			goto exp_client;
 		if (!nfs4_anylock_blockers(clp))
-- 
2.9.5

