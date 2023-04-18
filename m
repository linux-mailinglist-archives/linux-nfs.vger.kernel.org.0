Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25076E6D82
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDRUbt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 16:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjDRUbs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 16:31:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D09F
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 13:31:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEwvsB016706;
        Tue, 18 Apr 2023 20:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=TTZk+7nGB66wPby4naHZatkt1jTQtbLnfnMMKtkLhBA=;
 b=HGvXZ8BNcNkBMPh0rMmqLK3hBhoixdp32ARv7JMQ19EfTpyWS+Xn9rRIOChwfOPoIjd3
 6iEM2tJ1loiBjmMJsN79knF4+/QH3cnyJdDSCqoJUBJwdvkFMHrlg0x+LZQB6cver7Rw
 8B3mRVWqtp+EE12ap7nMhj6J7Al2NRroC61Bqu+B5mYS20JTkfu9lkBmg5hXUN/hjsa3
 DRXkKPm0PGcxhPVXcSthTxoSsb4TrNLapEWt+B1ELXkoh6KBcpjFfbaofhtY5EZOOTGZ
 R6Lw/4g/nrIKkTl25PDaPpoUD2LW1j58nQjLpK44Za4APttYp51+SO4suRqnHpZrA+bT fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq46re3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 20:31:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIo8uC026315;
        Tue, 18 Apr 2023 20:31:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjccasf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 20:31:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33IKVhmM028087;
        Tue, 18 Apr 2023 20:31:43 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pyjccasem-1;
        Tue, 18 Apr 2023 20:31:42 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop
Date:   Tue, 18 Apr 2023 13:31:31 -0700
Message-Id: <1681849891-29377-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180169
X-Proofpoint-GUID: alMlRrmCPYMPzR3uewJ_5ZmkPbvPWwSV
X-Proofpoint-ORIG-GUID: alMlRrmCPYMPzR3uewJ_5ZmkPbvPWwSV
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
server to get into an infinite loop with COMMIT and NFS4ERR_DELAY:

OPEN
REMOVE
WRITE
COMMIT

Problem reported test recall11, recall12, recall14, recall20, recall22,
recall40, recall42, recall48, recall50 of nfstest suite.

This patch restores the handling of race condition in nfsd_file_do_acquire
with unlink to that prior of the regression.

Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/filecache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 6e8712bd7c99..63f7d9f4ea99 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1170,9 +1170,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * If construction failed, or we raced with a call to unlink()
 	 * then unhash.
 	 */
-	if (status == nfs_ok && key.inode->i_nlink == 0)
-		status = nfserr_jukebox;
-	if (status != nfs_ok)
+	if (status != nfs_ok || key.inode->i_nlink == 0)
 		nfsd_file_unhash(nf);
 	clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
 	smp_mb__after_atomic();
-- 
2.9.5

