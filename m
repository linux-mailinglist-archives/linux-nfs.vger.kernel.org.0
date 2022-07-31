Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53568586145
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jul 2022 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiGaUUF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jul 2022 16:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiGaUUE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jul 2022 16:20:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C911C0D
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jul 2022 13:20:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26VB2wSm013313;
        Sun, 31 Jul 2022 20:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=9nsw4dRJ83hYwuf/Ki//YsDD2+vzLq7e9c75JFOxRJg=;
 b=MmTl9gGAn4XUji4RMeeakY32359blr6x8cnZe/OOguGclTUj38dHeiLflnY7bpZrRS/B
 U6YR93veKBpSSiLFsRRNukRR978D9sY3ctv3y/0ECt1ugpesNrUk/G0YzdJMSu44xMmE
 Zf9MxMVFkDhduDRRx7jvU+JntBwf8ztJvWfKa9yq4pApFwGZCxCZ5T1hj6w8EV4/ShJr
 xQYGvvZS1cgTL8E935bL1t4xL2bDbYsHIF+P4mHYfTiHiJlDdd7YH00Gf6vVoAVUPU69
 ZdE8kkPs2g3l+lVRR5MuxeTrf0eiUX1R9xkdVaJaWan3UYWyDPItpA61/mXW/b5juuhG Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9hsyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jul 2022 20:20:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26VHZRGT030892;
        Sun, 31 Jul 2022 20:20:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu30r6dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jul 2022 20:19:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26VKJxKa002522;
        Sun, 31 Jul 2022 20:19:59 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hmu30r6de-1;
        Sun, 31 Jul 2022 20:19:59 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, olga.kornievskaia@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSD: fix use-after-free on source server when doing inter-server copy
Date:   Sun, 31 Jul 2022 13:19:52 -0700
Message-Id: <1659298792-5735-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-31_15,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207310099
X-Proofpoint-ORIG-GUID: 1HJRM7MCeqj3S6-tc6WBz--D9CdhqCFl
X-Proofpoint-GUID: 1HJRM7MCeqj3S6-tc6WBz--D9CdhqCFl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use-after-free occurred when the laundromat tried to free expired
cpntf_state entry on the s2s_cp_stateids list after inter-server
copy completed. The sc_cp_list that the expired copy state was
inserted on was already freed.

When COPY completes, the Linux client normally sends LOCKU(lock_state x),
FREE_STATEID(lock_state x) and CLOSE(open_state y) to the source server.
The nfs4_put_stid call from nfsd4_free_stateid cleans up the copy state
from the s2s_cp_stateids list before freeing the lock state's stid.

However, sometimes the CLOSE was sent before the FREE_STATEID request.
When this happens, the nfsd4_close_open_stateid call from nfsd4_close
frees all lock states on its st_locks list without cleaning up the copy
state on the sc_cp_list list. When the time the FREE_STATEID arrives the
server returns BAD_STATEID since the lock state was freed. This causes
the use-after-free error to occur when the laundromat tries to free
the expired cpntf_state.

This patch adds a call to nfs4_free_cpntf_statelist in
nfsd4_close_open_stateid to clean up the copy state before calling
free_ol_stateid_reaplist to free the lock state's stid on the reaplist.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9409a0dc1b76..749f51dff5c7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6608,6 +6608,7 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 	struct nfs4_client *clp = s->st_stid.sc_client;
 	bool unhashed;
 	LIST_HEAD(reaplist);
+	struct nfs4_ol_stateid *stp;
 
 	spin_lock(&clp->cl_lock);
 	unhashed = unhash_open_stateid(s, &reaplist);
@@ -6616,6 +6617,8 @@ static void nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
 		if (unhashed)
 			put_ol_stateid_locked(s, &reaplist);
 		spin_unlock(&clp->cl_lock);
+		list_for_each_entry(stp, &reaplist, st_locks)
+			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
 		free_ol_stateid_reaplist(&reaplist);
 	} else {
 		spin_unlock(&clp->cl_lock);
-- 
2.9.5

