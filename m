Return-Path: <linux-nfs+bounces-8134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F188D9D301C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868BF1F232E6
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 21:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB90F1D31B6;
	Tue, 19 Nov 2024 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IyczYam3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784A1D27A0
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732052635; cv=none; b=W5FmA91v8nBvOaWcQO7Vnks0Hc9AMeVOF5AfJ34AI4ROzPXwQYFe20NCcZlWn2Vf7PRWDZ5TgE/8ZHt7l4BD9rnrSKFFtEk8fN+vn1ae6Ntxuw10g1nigUUj8TNOk2x0bIYodE9pDugeKMxMrOZqv1hQjL/Jevm2QjJ+I/ohT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732052635; c=relaxed/simple;
	bh=DTqq/iZ6LwOjnSnTyGIhtGPKzpcDdVfpKJsXYdKY8ss=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mHmWIOqoIbOHEjhTqOLyXeNPfiMMoZAKTwnt4pYbBUy8txVvLtKfEzyAFdcv6n3+8aPybZc7FSM3gKzRBJjh5PeXXx1SLPlmCTmAJ7WROPIjMfPm3stoemBUiqJCqnHY5bqEWEWkrRT7R322xk/DGpyjMdpbJT2GsqqttZNbci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IyczYam3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLYov9014636;
	Tue, 19 Nov 2024 21:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=ABXyU6KE
	pTAFnIF5ILTWBdjm2/BLOIH8YcHBbopH22g=; b=IyczYam3SPhDXzlrelRKjShs
	uVtoDccqJB4SV9amPjxuN3G6S+mZflJR/pYDv40gnGrsooZ7H5Zs0rN1tSPsVBVY
	vDgB4VRhNoHwnSNvU5Xp7oD7Uoz4agRsIetNY9P+OJYSTlI0Qrf30J16vDY3tSOu
	sVNIUHNz5kmGT8BsoHhN9vnyzJccokZqgWOLxV9dB4osy4FvyDG09TUruhRH8MhC
	cxRYaK2Rtlr2TGP+SJ+1icpq5OvB2wPSrjSSovqONv7Iujv0nMUjJZXFOPFO/rk/
	rtbeFfWVGc2e/CEb1JoA/EZlT4TQ6wdABz6u9q0YYW6jFBSb5IBiZDPBcNA99g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa64df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 21:43:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLHiKo037247;
	Tue, 19 Nov 2024 21:43:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu9bxr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 21:43:44 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AJLg8Te036080;
	Tue, 19 Nov 2024 21:43:43 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42xhu9bxr4-1;
	Tue, 19 Nov 2024 21:43:43 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@hammerspace.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: only put task on cl_tasks list after the RPC call slot is reserved.
Date: Tue, 19 Nov 2024 13:43:22 -0800
Message-Id: <1732052603-28539-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_13,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190157
X-Proofpoint-ORIG-GUID: dgUHUW7X6hY7lyswK_VmMSC1J1_zt2rP
X-Proofpoint-GUID: dgUHUW7X6hY7lyswK_VmMSC1J1_zt2rP
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Under heavy write load, we've seen the cl_tasks list grows to
millions of entries. Even though the list is extremely long,
the system still runs fine until the user wants to get the
information of all active RPC tasks by doing:

When this happens, tasks_start acquires the cl_lock to walk the
cl_tasks list, returning one entry at a time to the caller. The
cl_lock is held until all tasks on this list have been processed.

While the cl_lock is held, completed RPC tasks have to spin wait
in rpc_task_release_client for the cl_lock. If there are millions
of entries in the cl_tasks list it will take a long time before
tasks_stop is called and the cl_lock is released.

The spin wait tasks can use up all the available CPUs in the system,
preventing other jobs to run, this causes the system to temporarily
lock up.

This patch fixes this problem by delaying inserting the RPC
task on the cl_tasks list until the RPC call slot is reserved.
This limits the length of the cl_tasks to the number of call
slots available in the system.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 5321585c778f..fec976e58174 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -93,6 +93,7 @@ struct rpc_clnt {
 	const struct cred	*cl_cred;
 	unsigned int		cl_max_connect; /* max number of transports not to the same IP */
 	struct super_block *pipefs_sb;
+	atomic_t		cl_task_count;
 };
 
 /*
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0090162ee8c3..cc5014b58e3b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -958,12 +958,17 @@ void rpc_shutdown_client(struct rpc_clnt *clnt)
 
 	trace_rpc_clnt_shutdown(clnt);
 
+	clnt->cl_shutdown = 1;
 	while (!list_empty(&clnt->cl_tasks)) {
 		rpc_killall_tasks(clnt);
 		wait_event_timeout(destroy_wait,
 			list_empty(&clnt->cl_tasks), 1*HZ);
 	}
 
+	/* wait for tasks still in workqueue or waitqueue */
+	wait_event_timeout(destroy_wait,
+			   atomic_read(&clnt->cl_task_count) == 0, 1 * HZ);
+
 	rpc_release_client(clnt);
 }
 EXPORT_SYMBOL_GPL(rpc_shutdown_client);
@@ -1139,6 +1144,7 @@ void rpc_task_release_client(struct rpc_task *task)
 		list_del(&task->tk_task);
 		spin_unlock(&clnt->cl_lock);
 		task->tk_client = NULL;
+		atomic_dec(&clnt->cl_task_count);
 
 		rpc_release_client(clnt);
 	}
@@ -1189,10 +1195,7 @@ void rpc_task_set_client(struct rpc_task *task, struct rpc_clnt *clnt)
 		task->tk_flags |= RPC_TASK_TIMEOUT;
 	if (clnt->cl_noretranstimeo)
 		task->tk_flags |= RPC_TASK_NO_RETRANS_TIMEOUT;
-	/* Add to the client's list of all tasks */
-	spin_lock(&clnt->cl_lock);
-	list_add_tail(&task->tk_task, &clnt->cl_tasks);
-	spin_unlock(&clnt->cl_lock);
+	atomic_inc(&clnt->cl_task_count);
 }
 
 static void
@@ -1787,9 +1790,14 @@ call_reserveresult(struct rpc_task *task)
 	if (status >= 0) {
 		if (task->tk_rqstp) {
 			task->tk_action = call_refresh;
+
+			/* Add to the client's list of all tasks */
+			spin_lock(&task->tk_client->cl_lock);
+			if (list_empty(&task->tk_task))
+				list_add_tail(&task->tk_task, &task->tk_client->cl_tasks);
+			spin_unlock(&task->tk_client->cl_lock);
 			return;
 		}
-
 		rpc_call_rpcerror(task, -EIO);
 		return;
 	}
-- 
2.43.5


