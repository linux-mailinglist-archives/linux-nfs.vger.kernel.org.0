Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C164AAA1
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 23:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiLLWu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 17:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiLLWu2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 17:50:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81713FBC
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 14:50:27 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwXZF002240;
        Mon, 12 Dec 2022 22:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=p1Z53agcC6OE7uYFsSrBblcE2YpjRb4nAM0qcwtJvy8=;
 b=qWmmn9MVD40Nx79XCS6JUCVT8wQ2dJnD+3P6mOLg+gTNwCcGRujOpfVfsIPYWytdOf8Q
 wNZLQxXp2Kv+yp62y8Vj9laI+lfGQJNrHFGpGxCfH5PqpM1sQkmv9iDuVdD+Vw3zynD8
 eCC6LjlUMWaltTwMqpktADQ5WQ5TbkG/CYc02vdVxWNwypjwG9a0OxUL/hCDoSIV9Qi6
 sAWbDRub9nSV8uiaPqUcL7xHws3CLTjIlcfR+W6Vx6XLa4qzX3EsgQpEyaRZ7SBZn0kZ
 +CRAVbJStY7tvzf4+lufXMjW4TXTPdOWVGIw8Ie2mGEZPqCQMJ83sdeGM7aneAtW7YSQ Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj5bv47f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 22:50:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCKnTUx017776;
        Mon, 12 Dec 2022 22:50:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb1j6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 22:50:21 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BCMkwbq008695;
        Mon, 12 Dec 2022 22:50:21 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3mcgjb1j5s-1;
        Mon, 12 Dec 2022 22:50:21 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     kolga@netapp.com, hdthky0@gmail.com, linux-nfs@vger.kernel.org,
        security@kernel.org
Subject: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Date:   Mon, 12 Dec 2022 14:50:11 -0800
Message-Id: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120197
X-Proofpoint-GUID: b6txxc7XFNxBApk0EYmUuBqgBFRWhHP0
X-Proofpoint-ORIG-GUID: b6txxc7XFNxBApk0EYmUuBqgBFRWhHP0
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

We don't need to call nfs_do_sb_deactive when nfs42_ssc_open
return errors since the file was not opened so nfs_server->active
was not incremented. Same as in nfsd4_copy, if we fail to
launch nfsd4_do_async_copy thread then there's no need to
call nfs_do_sb_deactive

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8beb2bc4c328..b79ee65ae016 100644
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
@@ -1771,7 +1759,7 @@ static int nfsd4_do_async_copy(void *data)
 			default:
 				nfserr = nfserr_offload_denied;
 			}
-			nfsd4_interssc_disconnect(copy->ss_mnt);
+			/* ss_mnt will be unmounted by the laundromat */
 			goto do_callback;
 		}
 		nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
@@ -1852,8 +1840,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

