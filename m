Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D06B1146
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCHSpp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 13:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCHSpo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 13:45:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BECB32B2
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 10:45:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HibZf022874
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 18:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=nI5n8zRCNTyfxPVzhG3h6fM+H6Y2vGxn9fzkbcuC+N8=;
 b=u7wxzofwgq6+4zjaPdTNG7kDftKQYtoluOBSvGwcnokBegESlraEWwo7VhskZ7AW1BCZ
 QKs9579hlEUmPp327ZPkPOaPOm0LELGaVtKyQGBF56N1AYvq+2/E7OOT+xyzB6gZKWhv
 si+KgwxlPbC69Uv/yHusFRalwYE7mk5XFtQdtwUeTrNELOzfthv9Ixmm1DanzHPpImbZ
 6HRAJAhEhmvFGa9HZrhHA8tOjhPU3z6qkIW+T2jZgT7Qh4G9CLoyW7ycOSOf9sQEatYR
 o1LtfpzdQqyy9md+Mal757+20NL7E2yXzi3lhrmSm0qyzD6ZbbkFE1dDwIW97w5in/nG OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p41620tkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 18:45:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IPCL6026602
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 18:45:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9u3x9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 08 Mar 2023 18:45:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328Iexon016377
        for <linux-nfs@vger.kernel.org>; Wed, 8 Mar 2023 18:45:39 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6g9u3x9b-1;
        Wed, 08 Mar 2023 18:45:39 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     helen.chao@oracle.com
Subject: [PATCH] SUNRPC: remove the maximum number of retries in call_bind_status
Date:   Wed,  8 Mar 2023 10:45:32 -0800
Message-Id: <1678301132-24496-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080160
X-Proofpoint-GUID: CzAEbTG5drgPUNk9Iz91-piEoCnCU8zL
X-Proofpoint-ORIG-GUID: CzAEbTG5drgPUNk9Iz91-piEoCnCU8zL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently call_bind_status places a hard limit of 3 to the number of
retries on EACCES error. This limit was done to accommodate the behavior
of a buggy server that keeps returning garbage when the NLM daemon is
killed on the NFS server. However this change causes problem for other
servers that take a little longer than 9 seconds for the port mapper to
become ready when the NFS server is restarted.

This patch removes this hard coded limit and let the RPC handles
the retry according to whether the export is soft or hard mounted.

To avoid the hang with buggy server, the client can use soft mount for
the export.

Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
Reported-by: Helen Chao <helen.chao@oracle.com>
Tested-by: Helen Chao <helen.chao@oracle.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 include/linux/sunrpc/sched.h | 3 +--
 net/sunrpc/clnt.c            | 3 ---
 net/sunrpc/sched.c           | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index b8ca3ecaf8d7..8ada7dc802d3 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -90,8 +90,7 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0b0b9f1eed46..63b438d8564b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
 			status = -EOPNOTSUPP;
 			break;
 		}
-		if (task->tk_rebind_retry == 0)
-			break;
-		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
 	case -ENOBUFS:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index be587a308e05..c8321de341ee 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
-- 
2.9.5

