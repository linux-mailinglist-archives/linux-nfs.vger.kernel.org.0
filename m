Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41B6E80AA
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDSRxg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjDSRxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 13:53:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F903768C
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 10:53:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JETP69028184;
        Wed, 19 Apr 2023 17:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=7zAwBs8hme2oxNZ6rDzbY5BjhMNtCZl2+hVsU5+oVWM=;
 b=mu3hzqkvpqOnXFvzGNS3TxeVkgr9QEtR1oJ3Bbvh+ww9HaULJA/ydBwmvAxXyPGj41Nu
 cRoGB6nehAb476NDxyRUexk9BB7Buc1b71hz+R67w9bBSQXYKjXtNKJgXISECzeqOHQD
 jtN1BmSSc7gubm7DyrW3YD//+o/j3FjZ2AprRRVUXkme6khupUALoDd56re7eupFy+K6
 uI9a/gJNohZx306B3+8fhJaIPc/B+yrFwaR+486ZahrzoV2xnS23TI9bqlcC7PEjEUdE
 crd5y4aCZVbpobo5gQhz3MT6ZUXBDIUJI1uOyq++tiiMEP9O+wSd87/uwkZLzlfsRkdn iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfugy35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 17:53:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JHEQkM015649;
        Wed, 19 Apr 2023 17:53:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcd9g3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 17:53:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33JHrSnc013903;
        Wed, 19 Apr 2023 17:53:28 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pyjcd9g36-1;
        Wed, 19 Apr 2023 17:53:28 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop
Date:   Wed, 19 Apr 2023 10:53:18 -0700
Message-Id: <1681926798-13866-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_12,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=996 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190156
X-Proofpoint-GUID: ss7RYm_OPcLfTHYvWImwr1xaM49z18NK
X-Proofpoint-ORIG-GUID: ss7RYm_OPcLfTHYvWImwr1xaM49z18NK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following request sequence to the same file causes the NFS client and
server getting into an infinite loop with COMMIT and NFS4ERR_DELAY:

OPEN
REMOVE
WRITE
COMMIT

Problem reported by recall11, recall12, recall14, recall20, recall22,
recall40, recall42, recall48, recall50 of nfstest suite.

This patch restores the handling of race condition in nfsd_file_do_acquire
with unlink to that prior of the regression.

Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/filecache.c | 2 --
 1 file changed, 2 deletions(-)

V2: rebase with nfsd-next

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f40d8f3b35a4..ee9c923192e0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1099,8 +1099,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * then unhash.
 	 */
 	if (status != nfs_ok || inode->i_nlink == 0)
-		status = nfserr_jukebox;
-	if (status != nfs_ok)
 		nfsd_file_unhash(nf);
 	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
 	if (status == nfs_ok)
-- 
2.9.5

