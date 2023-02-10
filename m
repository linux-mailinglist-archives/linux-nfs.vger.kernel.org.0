Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD536919D0
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Feb 2023 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjBJIMm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Feb 2023 03:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBJIMl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Feb 2023 03:12:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1981858
        for <linux-nfs@vger.kernel.org>; Fri, 10 Feb 2023 00:12:15 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A7NnJc014779;
        Fri, 10 Feb 2023 08:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=XMQw6sLMP2eu11eDzWxz4uOAN5GjLqZynGSuYmX+Q+Y=;
 b=pKyydLlCSZqiaUi50D/IYUC0U1l0Ko7x0xDnT1uf4IAZU8UVhmJdW0wUbqNRkxQrhoxL
 0Uycbpjttr181oosSS2Q+t+iCynEJUBZd+JbdKqVVpICxYqZMqza7NcCGYFCn7TzazO8
 qRFKOvNzMQFSgBvq+8zYHhVfUn8p/2kOnLZiqUJhycV4kGby8CwsNM1hYpapKhKtfiJJ
 rtzYXKu2Zm8TBoAy33W989WGEHP7Ij6UgTcS69JKP07U/KPZLW8SG/3V9WsnHntWCd4q
 DrE+WNUPnStpIHHHopBrCMaUUawgKZIm9llygH0cDabPuvVI7t79e1SW05IGI3KHLgIs AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdvna7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:11:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31A6DYU8025694;
        Fri, 10 Feb 2023 08:11:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdth213p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 08:11:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A8B6Qv012955;
        Fri, 10 Feb 2023 08:11:06 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3nhdth213a-1;
        Fri, 10 Feb 2023 08:11:06 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 1/1] SUNRPC: increase max timeout for rebind to handle NFS server restart
Date:   Fri, 10 Feb 2023 00:10:56 -0800
Message-Id: <1676016656-26195-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_03,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100071
X-Proofpoint-ORIG-GUID: 8-YoakzK3e2FKWIlCoPGj52UsEKOOIJD
X-Proofpoint-GUID: 8-YoakzK3e2FKWIlCoPGj52UsEKOOIJD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Occasionally NLM lock and unlock request fail with EIO and ENOLCK
respectively. This usually happens when the NFS server is restarted
while NLM lock test is running.

Currently there is a 9 seconds limit for retrying the bind operation.
If the server is under load the port mapper might take more than 9
seconds to become ready after the NFS server restarted.

This patch increases the timeout for rebind from 9 to 30 seconds
allowing a bit more time for the port mapper to become ready.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 include/linux/sunrpc/clnt.h  | 3 +++
 include/linux/sunrpc/sched.h | 4 ++--
 net/sunrpc/clnt.c            | 2 +-
 net/sunrpc/sched.c           | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 770ef2cb5775..7f2dee56c121 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
 #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
 
+#define	RPC_CLNT_REBIND_DELAY		3
+#define	RPC_CLNT_REBIND_MAX_TIMEOUT	30
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
index 0b0b9f1eed46..6c89a1fa40bf 100644
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

