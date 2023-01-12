Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B409F666767
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 01:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjALAHQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 19:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjALAHP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 19:07:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ABCCCD
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 16:07:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BMjGx2002849;
        Thu, 12 Jan 2023 00:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=3rTXiw3iaT7yp8XDVMZxwW+JhMSFqX6RzvcP17KjHk8=;
 b=VXwqER91E2gdYk72LRFqBR+lMRak3jdlllZaZZBYkw8DgJgBBoOW/4rjvQt6aAn1ufVI
 h/wjihKlEFjY1dRh+/LocaB/KdnzsBn/GdM1T5hIjy83k/knY0U5hwXwoOYT7Lj+pXNL
 miaQR2jQCN6PTFmfMyQccOinWJFM2rvwadvo2M4lTU/gm1RCW/mU4E0iQWobURPUASy8
 8OlziSbcOrUNFORZ3xRmpJdnCIKSlDl/Mi0D4W5XGsEZ9pGahrEudng1EISYE4R2DaiU
 iLKcKHsj6G6uHN2pVWEPWYV2OruieGXoWpsVgY8spno32H2PRkcaP1OK4oQkS5sGZRgQ mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0bts7en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 00:07:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BMh9Qo021747;
        Thu, 12 Jan 2023 00:07:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4pg8ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 00:07:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30C079f6030389;
        Thu, 12 Jan 2023 00:07:09 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n1k4pg8u6-1;
        Thu, 12 Jan 2023 00:07:09 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: replace delayed_work with work_struct for nfsd_client_shrinker
Date:   Wed, 11 Jan 2023 16:06:51 -0800
Message-Id: <1673482011-27110-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110177
X-Proofpoint-GUID: o-7dD4UV-kN6EtNILEXZQBUH8TE5ePE7
X-Proofpoint-ORIG-GUID: o-7dD4UV-kN6EtNILEXZQBUH8TE5ePE7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since nfsd4_state_shrinker_count always calls mod_delayed_work with
0 delay, we can replace delayed_work with work_struct to save some
space and overhead.

Also add the call to cancel_work after unregister the shrinker
in nfs4_state_shutdown_net.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/netns.h     | 2 +-
 fs/nfsd/nfs4state.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 8c854ba3285b..51a4b7885cae 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -195,7 +195,7 @@ struct nfsd_net {
 
 	atomic_t		nfsd_courtesy_clients;
 	struct shrinker		nfsd_client_shrinker;
-	struct delayed_work	nfsd_shrinker_work;
+	struct work_struct	nfsd_shrinker_work;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a7cfefd7c205..21bee33bc6dc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4411,7 +4411,7 @@ nfsd4_state_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 	if (!count)
 		count = atomic_long_read(&num_delegations);
 	if (count)
-		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
+		queue_work(laundry_wq, &nn->nfsd_shrinker_work);
 	return (unsigned long)count;
 }
 
@@ -6233,8 +6233,7 @@ deleg_reaper(struct nfsd_net *nn)
 static void
 nfsd4_state_shrinker_worker(struct work_struct *work)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
+	struct nfsd_net *nn = container_of(work, struct nfsd_net,
 				nfsd_shrinker_work);
 
 	courtesy_client_reaper(nn);
@@ -8064,7 +8063,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
-	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
+	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
 	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
@@ -8171,6 +8170,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	unregister_shrinker(&nn->nfsd_client_shrinker);
+	cancel_work(&nn->nfsd_shrinker_work);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
-- 
2.9.5

