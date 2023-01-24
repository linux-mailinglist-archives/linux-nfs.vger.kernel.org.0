Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE773678FF1
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 06:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjAXFcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 00:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAXFcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 00:32:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89855A6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Jan 2023 21:32:45 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O04dPJ013958;
        Tue, 24 Jan 2023 05:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=j7YDrHEpCZ+fTLBa/rk5IebBNfW7QWZm8nH/e68Ox8E=;
 b=EG16Qoddeb9Fby0KE/SkcoDQnG0UnnK46ZPk4SeDwLzRB2ZMWvIDamV6VuUDsfMrmDC3
 RlyNlX4NAv77RfNwBOZbAFvtGu3DRYR7mE2VVwx2cwtMbD/E4+7p5LSGugm4q5L299WK
 yRJBnjCi+GuSAMyGZuGXFYe4HOjQDKbiTmnE7c0IV0Gc0pMZiimbaN8GBj3lAQ7Fh3CY
 /BHHHVU4BH8qQznh7NxJWdgNsd1yIKsLgMAtSNPkKAaad2uklPCkzU4WEnEN9IZYhqFn
 EUnhk4Q+x04FfE1eTLqHLK4Mi79Q8uoC8uWF30wyTOp6vbKTRPOlEOUWOSLT6iOf5HNz Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fccj8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 05:32:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30O4rXBq023170;
        Tue, 24 Jan 2023 05:32:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g4g1en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 05:32:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30O5WXcA037909;
        Tue, 24 Jan 2023 05:32:33 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3n86g4g1eh-1;
        Tue, 24 Jan 2023 05:32:33 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix problems with cleanup on errors in nfsd4_copy
Date:   Mon, 23 Jan 2023 21:32:20 -0800
Message-Id: <1674538340-12882-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240049
X-Proofpoint-GUID: eeJZ8eeO0pPO2oACLu9QU2Uqbpyf2ly9
X-Proofpoint-ORIG-GUID: eeJZ8eeO0pPO2oACLu9QU2Uqbpyf2ly9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
cleanup for the async_copy which causes page fault since async_copy
is not yet initialized.

This patche sets async_copy to NULL to skip cleanup_async_copy
if async_copy is not yet initialized.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3b73e4d342bf..b4e7e18e1761 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1688,7 +1688,8 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 	if (!nfsd4_ssc_is_inter(copy))
 		nfsd_file_put(copy->nf_src);
 	spin_lock(&copy->cp_clp->async_lock);
-	list_del(&copy->copies);
+	if (!list_empty(&copy->copies))
+		list_del(&copy->copies);
 	spin_unlock(&copy->cp_clp->async_lock);
 	nfs4_put_copy(copy);
 }
@@ -1789,9 +1790,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_err;
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
+			goto no_mem;
+		if (!nfs4_init_copy_state(nn, copy)) {
+			kfree(async_copy->cp_src);
+no_mem:
+			kfree(async_copy);
+			async_copy = NULL;
 			goto out_err;
-		if (!nfs4_init_copy_state(nn, copy))
-			goto out_err;
+		}
+		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(copy->cp_res.cb_stateid));
-- 
2.9.5

