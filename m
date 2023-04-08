Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5346DB89A
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Apr 2023 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDHDad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Apr 2023 23:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDHDab (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Apr 2023 23:30:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DC5CC09
        for <linux-nfs@vger.kernel.org>; Fri,  7 Apr 2023 20:30:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3383KKmM029956;
        Sat, 8 Apr 2023 03:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=4Ey3c+fRrNNTL8Pli8xGzfAIsRaE56UtjHNaZW4WhWo=;
 b=EjbqRXiCqM5h8UMofMPKV2IYt9PUNsD5u0CsyqlLafLkg4g6UU8GbRPkUC31u8Sl2dnC
 wS08uiKUqlplVJ6myxdRaSlq0B9Y/SHTNQQrlA8B6b71pu0ehfeME4FAXmrQgavKLmrZ
 DMJYDyI7cLHeADWPG/gfFLKNkU2mt1jy7z7kBU1eh7qKkgy+KUiE60J2GT0fLPV4RCiH
 mSKerz6iWu3y/YhbTZer3edF6BxkqAyI/P77rU8d+JSSJU2e39GTerYSIv91RUr7BZcT
 CNMVGSJrLiSz3KFCMr8c7B3P4tTLznMgdcujVxg71vRnDniclQUqUqfz76v4FVGlwdDw JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu05ar08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 03:30:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3383IURI038981;
        Sat, 8 Apr 2023 03:30:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ptxq7ucky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Apr 2023 03:30:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3383UOAI018893;
        Sat, 8 Apr 2023 03:30:24 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ptxq7ucjt-1;
        Sat, 08 Apr 2023 03:30:24 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS server restart
Date:   Fri,  7 Apr 2023 20:30:00 -0700
Message-Id: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304080030
X-Proofpoint-GUID: xQUogv82V2ZN9B5Wg-gXkUzHho9_hGY7
X-Proofpoint-ORIG-GUID: xQUogv82V2ZN9B5Wg-gXkUzHho9_hGY7
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently call_bind_status places a hard limit of 9 seconds for retries
on EACCES error. This limit was done to prevent the RPC request from
being retried forever if the remote server has problem and never comes
up

However this 9 seconds timeout is too short, comparing to other RPC
timeouts which are generally in minutes. This causes intermittent failure
with EIO on the client side when there are lots of NLM activity and the
NFS server is restarted.

Instead of removing the max timeout for retry and relying on the RPC
timeout mechanism to handle the retry, which can lead to the RPC being
retried forever if the remote NLM service fails to come up. This patch
simply increases the max timeout of call_bind_status from 9 to 90 seconds
which should allow enough time for NLM to register after a restart, and
not retrying forever if there is real problem with the remote system.

Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
Reported-by: Helen Chao <helen.chao@oracle.com>
Tested-by: Helen Chao <helen.chao@oracle.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 include/linux/sunrpc/clnt.h  | 3 +++
 include/linux/sunrpc/sched.h | 4 ++--
 net/sunrpc/clnt.c            | 2 +-
 net/sunrpc/sched.c           | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 770ef2cb5775..81afc5ea2665 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
 #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
 
+#define	RPC_CLNT_REBIND_DELAY		3
+#define	RPC_CLNT_REBIND_MAX_TIMEOUT	90
+
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
 				const struct rpc_program *, u32);
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index b8ca3ecaf8d7..e9dc142f10bb 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -90,8 +90,8 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
+	unsigned char		tk_rebind_retry;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index fd7e1c630493..222578af6b01 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
 		if (task->tk_rebind_retry == 0)
 			break;
 		task->tk_rebind_retry--;
-		rpc_delay(task, 3*HZ);
+		rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
 		goto retry_timeout;
 	case -ENOBUFS:
 		rpc_delay(task, HZ >> 2);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index be587a308e05..5c18a35752aa 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
+	task->tk_rebind_retry = RPC_CLNT_REBIND_MAX_TIMEOUT /
+					RPC_CLNT_REBIND_DELAY;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
-- 
2.9.5

