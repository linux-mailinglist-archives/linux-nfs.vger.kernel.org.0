Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936296652E8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 05:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAKEoB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 23:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjAKEoA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 23:44:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BBB6396
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 20:43:58 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B31QWq017391;
        Wed, 11 Jan 2023 04:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=ilUc5kyQSkb2Oo0cvQtpqQ5xq6YCJs8EH6KQ/VjfV0U=;
 b=TKvC2TwLY9B4BZVMtRlSSEodIEM7/iHSbt+D3eTEOnNdqxHOucT0P1Kk0t/z9jj43Hq9
 1oltPqA6d4/Ouz40Xhh2VZqsrjXIkuqdogj/VB7gBjVHV8838Rbfh/khJcIjoYsMOe43
 2Jf4r7RY428oELRhLR9JFKTWSLAGKvVECO30Ou4a44ZdlIDYRJpA4763m2DQ2mkPyIih
 GvUdilwXX9VpQGU9wOvWncX0c3yDIfXGc6LGpGP6SVjtV+CMZMvkSX47TqXmpIBOWNHt
 jUyaa37nKT4GsmEtHv3tEmwiQjXTPGuRyOwYUASaU2bZvuMgzdbX0bfJUyngbt4UpQHU /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bj014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 04:43:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B41WXJ009269;
        Wed, 11 Jan 2023 04:43:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4np2kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 04:43:51 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30B4hoIO023362;
        Wed, 11 Jan 2023 04:43:50 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n1k4np2k4-1;
        Wed, 11 Jan 2023 04:43:50 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Date:   Tue, 10 Jan 2023 20:43:41 -0800
Message-Id: <1673412221-8037-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_01,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110035
X-Proofpoint-GUID: D1g5d54zjtYTCIXq6t3-NkBSml4tJp_Y
X-Proofpoint-ORIG-GUID: D1g5d54zjtYTCIXq6t3-NkBSml4tJp_Y
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

Replace mod_delayed_work in nfsd4_state_shrinker_count with queue_work.

Change nfsd_shrinker_work from delayed_work to work_struct since we
don't use the delay.

Cancel work_struct nfsd_shrinker_work after unregistering shrinker
in nfs4_state_shutdown_net

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
v2:
  . Replace mod_delayed_work in nfsd4_state_shrinker_count with queue_work
  . Change nfsd_shrinker_work from delayed_work to work_struct
  . Cancel work_struct nfsd_shrinker_work after unregistering shrinker

 fs/nfsd/netns.h     |  3 ++-
 fs/nfsd/nfs4state.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

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
index a7cfefd7c205..6508f9c79315 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 	struct nfsd_net *nn = container_of(shrink,
 			struct nfsd_net, nfsd_client_shrinker);
 
+	spin_lock(&nn->client_lock);
+	if (nn->nfsd_shrinker_active) {
+		spin_unlock(&nn->client_lock);
+		return 0;
+	}
 	count = atomic_read(&nn->nfsd_courtesy_clients);
 	if (!count)
 		count = atomic_long_read(&num_delegations);
-	if (count)
-		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
+	if (count) {
+		nn->nfsd_shrinker_active = true;
+		spin_unlock(&nn->client_lock);
+		queue_work(laundry_wq, &nn->nfsd_shrinker_work);
+	} else
+		spin_unlock(&nn->client_lock);
 	return (unsigned long)count;
 }
 
@@ -6233,12 +6242,14 @@ deleg_reaper(struct nfsd_net *nn)
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
+	nn->nfsd_shrinker_active = 0;
+	spin_unlock(&nn->client_lock);
 }
 
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
@@ -8064,7 +8075,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
-	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
+	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
 	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
@@ -8171,6 +8182,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	unregister_shrinker(&nn->nfsd_client_shrinker);
+	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
-- 
2.9.5

