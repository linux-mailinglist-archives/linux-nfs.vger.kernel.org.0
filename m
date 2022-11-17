Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905C562D1D3
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 04:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiKQDpM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 22:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiKQDpK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 22:45:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D06BDE1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 19:45:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH1wIft006498;
        Thu, 17 Nov 2022 03:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=45QfRZ3o5t2VbHBg2Z/Kk9Dh1uMk0JYIwnFlZqHxNao=;
 b=jbVz/sBhRuPvGV5L6C8iiwtDNxjW5RMQiMeRREYFr23pf01TpPac7mVX/lzY3PCvJPdy
 5X5jAyg/9CITQ1mQvpDWHCDhVZMrDStmfcxFt+lOfI3bDQeNZwrFH4kL2faVXa8wsYxI
 EeJFEN/Vg/K9RS2Srv4JrUWVyVGl6LprSAWfpjw+abCAlNyiD6N/LRfXUuSTlIaluDjQ
 R5I/oDeYb1LA8R3G0x+laAJ15qj5bju1qvFnFEwhmpev9ulfSCZVooPq3pEuW4DW554/
 YwNc+pZpQXq+v8nCIbXd+cMO/Kf3HMoSAnhaR6xKQCRK+uR2kURh2+d2wX8d/SRsjsPS pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3htysh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH1SWq3016830;
        Thu, 17 Nov 2022 03:44:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1ya26x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH3iutf030624;
        Thu, 17 Nov 2022 03:44:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kuk1ya262-2;
        Thu, 17 Nov 2022 03:44:56 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/4] NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker
Date:   Wed, 16 Nov 2022 19:44:45 -0800
Message-Id: <1668656688-22507-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170024
X-Proofpoint-GUID: 6b2rdxvlZnUK1XnTqwCUY7hoFDylCcQD
X-Proofpoint-ORIG-GUID: 6b2rdxvlZnUK1XnTqwCUY7hoFDylCcQD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactoring courtesy_client_reaper to generic low memory
shrinker so it can be used for other purposes.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 836bd825ca4a..142481bc96de 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4347,7 +4347,7 @@ nfsd4_init_slabs(void)
 }
 
 static unsigned long
-nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
+nfsd_lowmem_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cnt;
 	struct nfsd_net *nn = container_of(shrink,
@@ -4360,7 +4360,7 @@ nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_control *sc)
 }
 
 static unsigned long
-nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_control *sc)
+nfsd_lowmem_shrinker_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	return SHRINK_STOP;
 }
@@ -4387,8 +4387,8 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfs4_max_clients = max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
 
 	atomic_set(&nn->nfsd_courtesy_clients, 0);
-	nn->nfsd_client_shrinker.scan_objects = nfsd_courtesy_client_scan;
-	nn->nfsd_client_shrinker.count_objects = nfsd_courtesy_client_count;
+	nn->nfsd_client_shrinker.scan_objects = nfsd_lowmem_shrinker_scan;
+	nn->nfsd_client_shrinker.count_objects = nfsd_lowmem_shrinker_count;
 	nn->nfsd_client_shrinker.seeks = DEFAULT_SEEKS;
 	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
 }
@@ -6125,17 +6125,24 @@ laundromat_main(struct work_struct *laundry)
 }
 
 static void
-courtesy_client_reaper(struct work_struct *reaper)
+courtesy_client_reaper(struct nfsd_net *nn)
 {
 	struct list_head reaplist;
-	struct delayed_work *dwork = to_delayed_work(reaper);
-	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
-					nfsd_shrinker_work);
 
 	nfs4_get_courtesy_client_reaplist(nn, &reaplist);
 	nfs4_process_client_reaplist(&reaplist);
 }
 
+static void
+nfsd4_lowmem_shrinker(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
+				nfsd_shrinker_work);
+
+	courtesy_client_reaper(nn);
+}
+
 static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid *stp)
 {
 	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
@@ -7958,7 +7965,7 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
 
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
-	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
+	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_lowmem_shrinker);
 	get_net(net);
 
 	return 0;
-- 
2.9.5

