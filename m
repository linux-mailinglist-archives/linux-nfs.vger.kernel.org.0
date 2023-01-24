Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21937678FF6
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 06:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjAXFes (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 00:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjAXFeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 00:34:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56930184
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 21:34:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O04ndn028979;
        Tue, 24 Jan 2023 05:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=S8UbccwX/BCQSQNMMpvA0t5dsmqjVyNyD3Mw+X3SKmg=;
 b=1zF7qTFvrJIFiTYzlMAsJnFye1eQifVp85776y6w/YYgl/jkdJ6bTfkTczDSrpzkBCbd
 HCi1Af7zshzqtIalHm3liLssRW6uMMra5P3uKW7r6NHtFF3y164bdoUGQPegX4IsmR05
 uoQs8c4YCqEzPht8an9k40c3nCDFZHekAU/i2+EfkDIf3k4YIXYQh8EJMJS+faaww7dI
 +dL9nk5ZkqTay2BukQBdV5Bd4LO7UdSeHOcPB4wO1oylPSTnSmAGpkPz4HyUloxjEEwK
 EDuFcTaey/BQ58ts5tIOz04DuCSL3w+93iW4JSgIYR123On3wER+BzqqGO2oKyy9E/4o zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n0vjw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 05:34:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30O4OUXc023164;
        Tue, 24 Jan 2023 05:34:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4g2wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 05:34:25 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30O5YP1s003801;
        Tue, 24 Jan 2023 05:34:25 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g4g2wp-1;
        Tue, 24 Jan 2023 05:34:25 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix leak referent count of nfsd4_ssc_umount_item in nfsd4_copy
Date:   Mon, 23 Jan 2023 21:34:13 -0800
Message-Id: <1674538453-12998-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240050
X-Proofpoint-GUID: _DIU9LRK8yMtYWzRRasCSGIHcfSicDs_
X-Proofpoint-ORIG-GUID: _DIU9LRK8yMtYWzRRasCSGIHcfSicDs_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The reference count of nfsd4_ssc_umount_item is not decremented
on error conditions. This prevents the laundromat from unmounting
the vfsmount of the source file.

This patch decrements the reference count of nfsd4_ssc_umount_item
on error.

Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b4e7e18e1761..889b603619c3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1821,13 +1821,17 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out:
 	return status;
 out_err:
+	if (nfsd4_ssc_is_inter(copy)) {
+		/*
+		 * Source's vfsmount of inter-copy will be unmounted
+		 * by the laundromat. Use copy instead of async_copy
+		 * since async_copy->ss_nsui might not be set yet.
+	 	*/
+		refcount_dec(&copy->ss_nsui->nsui_refcnt);
+	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
 	status = nfserrno(-ENOMEM);
-	/*
-	 * source's vfsmount of inter-copy will be unmounted
-	 * by the laundromat
-	 */
 	goto out;
 }
 
-- 
2.9.5

