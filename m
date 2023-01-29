Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5867FCC3
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Jan 2023 05:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjA2Eo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Jan 2023 23:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Eo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 Jan 2023 23:44:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B234122A3E
        for <linux-nfs@vger.kernel.org>; Sat, 28 Jan 2023 20:44:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30T4WX5F027455;
        Sun, 29 Jan 2023 04:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=xVN0zEHcec2q1uG12e445ikulqX0pLq2RFabtDKC9Zs=;
 b=YKGPiYImOSHhkIgrp/sRr3e+dih0W4heN10YkE29KnbHRNJH2y3pzwQc685rhnz5GcjB
 Ez+9N+7vUw9VpYojmvNT4k6nDoEusnC6KvDCJWEGyO46ZCt67OawH34Qx3PUIdLfFX4M
 cG7aEYsI0G+frnDXt2xEJdYiZ18RU1Z/1iwTYP4OiZbRP4A/X9SvLp8LShdgdYw9644M
 6EF3un74yWji77fhbgTPrJl6kLsCGpnz1FPyxxIGSvnsSJtlFKduf/VTLmMesmL3qZNE
 wkYwP6qGzcAeHBmui6nY4NOCS4/4GBfltU2v4WhgQPjTrmvrqX7pPt93K4qisgEoYQdc mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhh0hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 04:44:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30T3NcR0000797;
        Sun, 29 Jan 2023 04:44:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct52urc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 04:44:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30T4iex3034353;
        Sun, 29 Jan 2023 04:44:40 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct52urc2-1;
        Sun, 29 Jan 2023 04:44:40 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: fix problems with cleanup on errors in nfsd4_copy
Date:   Sat, 28 Jan 2023 20:44:21 -0800
Message-Id: <1674967461-1366-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_03,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290046
X-Proofpoint-ORIG-GUID: Tn_D9n1wG3-1by08xs-VjsYhgoCjXcyX
X-Proofpoint-GUID: Tn_D9n1wG3-1by08xs-VjsYhgoCjXcyX
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

This patch rearranges the order of initializing the fields in
async_copy and adds checks in cleanup_async_copy to skip un-initialized
fields.

Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4proc.c  | 12 ++++++++----
 fs/nfsd/nfs4state.c |  5 +++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 57f791899de3..0754b38d3a43 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1687,9 +1687,12 @@ static void cleanup_async_copy(struct nfsd4_copy *copy)
 {
 	nfs4_free_copy_state(copy);
 	release_copy_files(copy);
-	spin_lock(&copy->cp_clp->async_lock);
-	list_del(&copy->copies);
-	spin_unlock(&copy->cp_clp->async_lock);
+	if (copy->cp_clp) {
+		spin_lock(&copy->cp_clp->async_lock);
+		if (!list_empty(&copy->copies))
+			list_del(&copy->copies);
+		spin_unlock(&copy->cp_clp->async_lock);
+	}
 	nfs4_put_copy(copy);
 }
 
@@ -1786,12 +1789,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		INIT_LIST_HEAD(&async_copy->copies);
+		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
 		if (!async_copy->cp_src)
 			goto out_err;
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
-		refcount_set(&async_copy->refcount, 1);
 		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
 			sizeof(copy->cp_res.cb_stateid));
 		dup_copy_fields(copy, async_copy);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ace02fd0d590..c39e43742dd6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -975,7 +975,6 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 
 	stid->cs_stid.si_opaque.so_clid.cl_boot = (u32)nn->boot_time;
 	stid->cs_stid.si_opaque.so_clid.cl_id = nn->s2s_cp_cl_id;
-	stid->cs_type = cs_type;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->s2s_cp_lock);
@@ -986,6 +985,7 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	idr_preload_end();
 	if (new_id < 0)
 		return 0;
+	stid->cs_type = cs_type;
 	return 1;
 }
 
@@ -1019,7 +1019,8 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
 {
 	struct nfsd_net *nn;
 
-	WARN_ON_ONCE(copy->cp_stateid.cs_type != NFS4_COPY_STID);
+	if (copy->cp_stateid.cs_type != NFS4_COPY_STID)
+		return;
 	nn = net_generic(copy->cp_clp->net, nfsd_net_id);
 	spin_lock(&nn->s2s_cp_lock);
 	idr_remove(&nn->s2s_cp_stateids,
-- 
2.9.5

