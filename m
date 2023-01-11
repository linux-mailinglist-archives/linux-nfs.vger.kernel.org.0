Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700366664B1
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 21:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAKURd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 15:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAKURb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 15:17:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6CE7654
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 12:17:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BJkvfS004100;
        Wed, 11 Jan 2023 20:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=OZnvQg/eL4Raax7SxFR3KFVi03f5WH25eG6kvVbFnzA=;
 b=Tzav8kEOvMY5eTaR5CPYiEDC/AxL2ug52tWSy28A/GMCyU1RQSyCpOVo37hw8nbPj4lb
 BdhZj4DKc/XDk7n8tpYxkctVQh7/y0DqBlP+JfOEAcy4nG0mQeuBt5v2cOysHxdCXjOG
 x0Fdx3PANDh+dqm59wCuHipY5mDYWy8jDX8w3h5URqy+Glr02p5XZ61FhB9fHYO6My6y
 IYkEKHz86EW+lqhUkyko3faER/TLCW3g4cX5kvjtovAS0TV/ij6vA9npK78fXn5tPJ3x
 RA/Ypy+PwLCv+DQzG8c4FnzopID3eFVbXbJbAWI6BZwuh5ZF6gYgMdjdbHpd/CduWVmh vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n23jhr2ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 20:17:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BJ9JJI005354;
        Wed, 11 Jan 2023 20:17:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4a84w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 20:17:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30BKHOJr030208;
        Wed, 11 Jan 2023 20:17:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n1k4a84vp-1;
        Wed, 11 Jan 2023 20:17:24 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shutdown time
Date:   Wed, 11 Jan 2023 12:17:09 -0800
Message-Id: <1673468229-20039-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110149
X-Proofpoint-GUID: A_t6u00n7OgPTs558U89EaZwn75SxTfC
X-Proofpoint-ORIG-GUID: A_t6u00n7OgPTs558U89EaZwn75SxTfC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently the nfsd-client shrinker is registered and unregistered at
the time the nfsd module is loaded and unloaded. The problem with this
is the shrinker is being registered before all of the relevant fields
in nfsd_net are initialized when nfsd is started. This can lead to an
oops when memory is low and the shrinker is called while nfsd is not
running.

This patch moves the  register/unregister of nfsd-client shrinker from
module load/unload time to nfsd startup/shutdown time.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
v2: reword change log for better description of the problem

 fs/nfsd/nfs4state.c | 22 +++++++++++-----------
 fs/nfsd/nfsctl.c    |  7 +------
 fs/nfsd/nfsd.h      |  6 ++----
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7b2ee535ade8..a7cfefd7c205 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4421,7 +4421,7 @@ nfsd4_state_shrinker_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return SHRINK_STOP;
 }
 
-int
+void
 nfsd4_init_leases_net(struct nfsd_net *nn)
 {
 	struct sysinfo si;
@@ -4443,16 +4443,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	atomic_set(&nn->nfsd_courtesy_clients, 0);
-	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
-	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
-	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
-	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
-}
-
-void
-nfsd4_leases_net_shutdown(struct nfsd_net *nn)
-{
-	unregister_shrinker(&nn->nfsd_client_shrinker);
 }
 
 static void init_nfs4_replay(struct nfs4_replay *rp)
@@ -8077,8 +8067,17 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
 
+	nn->nfsd_client_shrinker.scan_objects = nfsd4_state_shrinker_scan;
+	nn->nfsd_client_shrinker.count_objects = nfsd4_state_shrinker_count;
+	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
+
+	if (register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client"))
+		goto err_shrinker;
 	return 0;
 
+err_shrinker:
+	put_net(net);
+	kfree(nn->sessionid_hashtbl);
 err_sessionid:
 	kfree(nn->unconf_id_hashtbl);
 err_unconf_id:
@@ -8171,6 +8170,7 @@ nfs4_state_shutdown_net(struct net *net)
 	struct list_head *pos, *next, reaplist;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	unregister_shrinker(&nn->nfsd_client_shrinker);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d1e581a60480..c2577ee7ffb2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1457,9 +1457,7 @@ static __net_init int nfsd_init_net(struct net *net)
 		goto out_idmap_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
-	retval = nfsd4_init_leases_net(nn);
-	if (retval)
-		goto out_drc_error;
+	nfsd4_init_leases_net(nn);
 	retval = nfsd_reply_cache_init(nn);
 	if (retval)
 		goto out_cache_error;
@@ -1469,8 +1467,6 @@ static __net_init int nfsd_init_net(struct net *net)
 	return 0;
 
 out_cache_error:
-	nfsd4_leases_net_shutdown(nn);
-out_drc_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
@@ -1486,7 +1482,6 @@ static __net_exit void nfsd_exit_net(struct net *net)
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
-	nfsd4_leases_net_shutdown(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 93b42ef9ed91..fa0144a74267 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -504,8 +504,7 @@ extern void unregister_cld_notifier(void);
 extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
 #endif
 
-extern int nfsd4_init_leases_net(struct nfsd_net *nn);
-extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
+extern void nfsd4_init_leases_net(struct nfsd_net *nn);
 
 #else /* CONFIG_NFSD_V4 */
 static inline int nfsd4_is_junction(struct dentry *dentry)
@@ -513,8 +512,7 @@ static inline int nfsd4_is_junction(struct dentry *dentry)
 	return 0;
 }
 
-static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0; };
-static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
+static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
 
 #define register_cld_notifier() 0
 #define unregister_cld_notifier() do { } while(0)
-- 
2.9.5

