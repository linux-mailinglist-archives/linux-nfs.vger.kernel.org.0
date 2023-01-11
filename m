Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B566658F8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 11:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAKKYi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 05:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjAKKYg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 05:24:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDBEA8
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 02:24:35 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B9JvZl023216;
        Wed, 11 Jan 2023 10:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=ZS+zuDIOQNRrMa6NmribjjGQTK7f5enqiwwYlWzU/yU=;
 b=Lsjo27xCEEtbOWDp/YXM9CngbvUIYpRnjrxyrRLmRcqnXSugHIlpthQNc3ORVUKbem+T
 yt7AAMTmQho+oBQjUxT1WyBs6gS9OvdXMutQduMDvKIYp21NOvs10WtUKRziLnw/aKtv
 Y7MHiRqKQ0YqL8v/JlXRqRXUUPqV6qH7LVYZGLcixvhL7EVCJbhLaRbapIn8rArlDZ/E
 ZBRJ1LdI0yH2S9Qpk3I7sWOoIliguJk9mjhXF3oHyc3ct+uHIw42yecxoYqmJL9Lr1pM
 2aO/szAjliztl+7A4sTEXegWBLAziEfdEN625ZbVb+fnW7ZS6YbDX5/Zq3aW7S17EPiH Aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scfer4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:24:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B8OBoc034164;
        Wed, 11 Jan 2023 10:24:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4erwas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 10:24:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30BALMq6005944;
        Wed, 11 Jan 2023 10:24:28 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n1k4erwag-1;
        Wed, 11 Jan 2023 10:24:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Date:   Wed, 11 Jan 2023 02:24:18 -0800
Message-Id: <1673432658-4140-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110079
X-Proofpoint-GUID: P2wLBGro3ZZvuLQftTcgLitiXl81zFII
X-Proofpoint-ORIG-GUID: P2wLBGro3ZZvuLQftTcgLitiXl81zFII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently nfsd4_state_shrinker_worker can be schduled multiple times
from nfsd4_state_shrinker_count when memory is low. This causes
the WARN_ON_ONCE in __queue_delayed_work to trigger.

This patch allows only one instance of nfsd4_state_shrinker_worker
at a time using the nfsd_shrinker_active flag, protected by the
client_lock.

Change nfsd_shrinker_work from delayed_work to work_struct since we
don't use the delay.

Replace mod_delayed_work in nfsd4_state_shrinker_count with queue_work.

Cancel work_struct nfsd_shrinker_work after unregistering shrinker
in nfs4_state_shutdown_net

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
v2:
  . Change nfsd_shrinker_work from delayed_work to work_struct
  . Replace mod_delayed_work in nfsd4_state_shrinker_count with queue_work
  . Cancel work_struct nfsd_shrinker_work after unregistering shrinker
v3:
  . set nfsd_shrinker_active earlier in nfsd4_state_shrinker_count

 fs/nfsd/netns.h     |  3 ++-
 fs/nfsd/nfs4state.c | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 8c854ba3285b..b0c7b657324b 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -195,7 +195,8 @@ struct nfsd_net {
 
 	atomic_t		nfsd_courtesy_clients;
 	struct shrinker		nfsd_client_shrinker;
-	struct delayed_work	nfsd_shrinker_work;
+	struct work_struct	nfsd_shrinker_work;
+	bool			nfsd_shrinker_active;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a7cfefd7c205..35ec4cba88b3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4407,11 +4407,22 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 	struct nfsd_net *nn = container_of(shrink,
 			struct nfsd_net, nfsd_client_shrinker);
 
+	spin_lock(&nn->client_lock);
+	if (nn->nfsd_shrinker_active) {
+		spin_unlock(&nn->client_lock);
+		return 0;
+	}
+	nn->nfsd_shrinker_active = true;
 	count = atomic_read(&nn->nfsd_courtesy_clients);
 	if (!count)
 		count = atomic_long_read(&num_delegations);
-	if (count)
-		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
+	if (count) {
+		spin_unlock(&nn->client_lock);
+		queue_work(laundry_wq, &nn->nfsd_shrinker_work);
+	} else {
+		nn->nfsd_shrinker_active = false;
+		spin_unlock(&nn->client_lock);
+	}
 	return (unsigned long)count;
 }
 
@@ -6233,12 +6244,14 @@ deleg_reaper(struct nfsd_net *nn)
 static void
 nfsd4_state_shrinker_worker(struct work_struct *work)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
+	struct nfsd_net *nn = container_of(work, struct nfsd_net,
 				nfsd_shrinker_work);
 
 	courtesy_client_reaper(nn);
 	deleg_reaper(nn);
+	spin_lock(&nn->client_lock);
+	nn->nfsd_shrinker_active = false;
+	spin_unlock(&nn->client_lock);
 }
 
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
@@ -8064,7 +8077,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
-	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
+	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
 	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
@@ -8171,6 +8184,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	unregister_shrinker(&nn->nfsd_client_shrinker);
+	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
-- 
2.9.5

