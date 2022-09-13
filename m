Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844CA5B7798
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiIMRU1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Sep 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiIMRUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Sep 2022 13:20:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3675097EDC
        for <linux-nfs@vger.kernel.org>; Tue, 13 Sep 2022 09:06:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEwqXO032638;
        Tue, 13 Sep 2022 16:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=Q5PX8fqQxPWwPTSctbE8dnGKD7fKgmCNV5L8mwkNNP4=;
 b=bsRMiwVkSsexb7rwx0GJ3/JbLn77V8BcJtRoqD5qTuCC0On691VI63l8KvmMNVS3Y3Gb
 +SZi0F7flsndgFRkq0dbhFAOhYdWUNeN6HJgM4zRyPN7aTHcGVECHADnRe8a+pg2WalP
 NnrE7jI0aJrvB0bRH/Oq0PiQMlqugAuKks4rc56kxo7XB67RbGa6bQUHlt1VGC77u1dR
 spwjzFLOPS94j2x5/4QdoU0jCdiZFTO5NzxpR0bS/DsAXm7JexCljJTT0XC+eJF8SxN4
 C/4e4DyHIK2RU7BpU099XDo6gXqaMHmCIdymy3kEzHJD4cagXGoEJJw3vyp1I3ufBANr Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4tfcc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:06:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEV9vx016690;
        Tue, 13 Sep 2022 16:06:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jj6b2r38u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:06:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DG6HDj023194;
        Tue, 13 Sep 2022 16:06:17 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jj6b2r38a-2;
        Tue, 13 Sep 2022 16:06:17 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 1/2] NFSD: keep track of the number of courtesy clients in the system
Date:   Tue, 13 Sep 2022 09:06:09 -0700
Message-Id: <1663085170-23136-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
References: <1663085170-23136-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130073
X-Proofpoint-ORIG-GUID: SsmVIfZhEIyzb7M8ShRTfJuJOkVm5IXv
X-Proofpoint-GUID: SsmVIfZhEIyzb7M8ShRTfJuJOkVm5IXv
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

