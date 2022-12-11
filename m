Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB8649605
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Dec 2022 20:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLKTW6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Dec 2022 14:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKTW6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Dec 2022 14:22:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A347114F
        for <linux-nfs@vger.kernel.org>; Sun, 11 Dec 2022 11:22:56 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BBJ0UJW031487;
        Sun, 11 Dec 2022 19:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=4OcYtDD4C+iFVECe43CdhAo6TQSZ24isFN+NajIJoVU=;
 b=CaKHJT4FP0diPAYQTIZjg3kTb1/zkS28QBD/x8+4bWcCl+arnmewg6tJ8IyvM/NspCt8
 DMcgS5NWRr2phwLPitxymRWJVUPxoPuVCqCRATcJ8hFxLdVfAcfudkZJV8aYhDi10KZG
 jtyKzbNQRkiwbkaS2X9X3ZRnnuF6JjrL6vjxWnWOIldxM/16sOPms2uyO3mB5lqeP0n+
 HjEWVmB0ZeZKs95+Lp86SJkkjb/sTCXvrERy6bmr0h5OPhs5dW0F2Sw5IYBBlu3QIftu
 g+da/qWptGqnahs7ub0DOtDlobpoI5TAFlxQJYzG8fBfyoh2XabXyPuRUdvkesmpBJZd Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcghchj9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Dec 2022 19:22:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BBIEN0g038901;
        Sun, 11 Dec 2022 19:22:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgj337n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Dec 2022 19:22:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BBJMiUJ020537;
        Sun, 11 Dec 2022 19:22:44 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3mcgj337mm-1;
        Sun, 11 Dec 2022 19:22:44 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     kolga@netapp.com, hdthky0@gmail.com, linux-nfs@vger.kernel.org,
        security@kernel.org
Subject: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Date:   Sun, 11 Dec 2022 11:22:29 -0800
Message-Id: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_10,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212110180
X-Proofpoint-ORIG-GUID: y9a-8GXj-cqBNN2t7FB7ccwNophFLZII
X-Proofpoint-GUID: y9a-8GXj-cqBNN2t7FB7ccwNophFLZII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Problem caused by source's vfsmount being unmounted but remains
on the delayed unmount list. This happens when nfs42_ssc_open()
return errors.
Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
for the laundromat to unmount when idle time expires.

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beb2bc4c328..756e42cf0d01 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
 	return status;
 }
 
-static void
-nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
-{
-	nfs_do_sb_deactive(ss_mnt->mnt_sb);
-	mntput(ss_mnt);
-}
-
 /*
  * Verify COPY destination stateid.
  *
@@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
 {
 }
 
-static void
-nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
-{
-}
-
 static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
 				   struct nfs_fh *src_fh,
 				   nfs4_stateid *stateid)
@@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
 		struct file *filp;
 
 		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
-				      &copy->stateid);
+					&copy->stateid);
+
 		if (IS_ERR(filp)) {
 			switch (PTR_ERR(filp)) {
 			case -EBADF:
@@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
 			default:
 				nfserr = nfserr_offload_denied;
 			}
-			nfsd4_interssc_disconnect(copy->ss_mnt);
+			/* ss_mnt will be unmounted by the laundromat */
 			goto do_callback;
 		}
 		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
@@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (async_copy)
 		cleanup_async_copy(async_copy);
 	status = nfserrno(-ENOMEM);
-	if (nfsd4_ssc_is_inter(copy))
-		nfsd4_interssc_disconnect(copy->ss_mnt);
+	/*
+	 * source's vfsmount of inter-copy will be unmounted
+	 * by the laundromat
+	 */
 	goto out;
 }
 
-- 
2.9.5

