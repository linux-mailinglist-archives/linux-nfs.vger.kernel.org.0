Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2E663979
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjAJGtA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 01:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAJGsw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 01:48:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA633D73
        for <linux-nfs@vger.kernel.org>; Mon,  9 Jan 2023 22:48:50 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A5PG5b002467;
        Tue, 10 Jan 2023 06:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=RQnA+Cgp0/JvlnXoNx+3Kf40HFea1yzRwEBQCkYStO8=;
 b=S4MoQfTes4Awaji2KsJ567cn0iDjvjluxzVaPt7wIdbkaUaCBDwsjbY9izQCQflrB+h1
 +RfvH8E4x+J3CYtOtyG09WdCpTvY2AkEBARSPFpoDXc3G8u0Lc24BocIxZdWhHlWjD44
 LL3VCkXPTqId3J+XucrIl7bl3UfB9Q/kS/REhsaGL5ALCjvaMsgOQ5VG56M0nBjEryR2
 YibRHnv9TAO3q31amLL6hYh6rrgVTyhUV/e+ySYHtf0irSkEa82NIpt2YHl0qibR2bu1
 U5hj7WyyHNM0NHrJiDpK3iwJTFP8wwSbnwVB9mG0bVxyH+oUcoqJ7LY1Z0Ype4TGpKEQ hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n0uc8gm5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 06:48:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30A6Oe4B032295;
        Tue, 10 Jan 2023 06:48:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n12qr0pjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 06:48:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30A6mjYs015841;
        Tue, 10 Jan 2023 06:48:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n12qr0pjb-1;
        Tue, 10 Jan 2023 06:48:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
Date:   Mon,  9 Jan 2023 22:48:30 -0800
Message-Id: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100044
X-Proofpoint-ORIG-GUID: x63Zu7d_Giwx1Pc2Tp0yaKocgYeCmZU8
X-Proofpoint-GUID: x63Zu7d_Giwx1Pc2Tp0yaKocgYeCmZU8
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

Replace mod_delayed_work with queue_delayed_work since we
don't expect to modify the delay of any pending work.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4state.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 8c854ba3285b..801d70926442 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -196,6 +196,7 @@ struct nfsd_net {
 	atomic_t		nfsd_courtesy_clients;
 	struct shrinker		nfsd_client_shrinker;
 	struct delayed_work	nfsd_shrinker_work;
+	bool			nfsd_shrinker_active;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ee56c9466304..e00551af6a11 100644
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
+		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
+	} else
+		spin_unlock(&nn->client_lock);
 	return (unsigned long)count;
 }
 
@@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *work)
 
 	courtesy_client_reaper(nn);
 	deleg_reaper(nn);
+	spin_lock(&nn->client_lock);
+	nn->nfsd_shrinker_active = 0;
+	spin_unlock(&nn->client_lock);
 }
 
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
-- 
2.9.5

