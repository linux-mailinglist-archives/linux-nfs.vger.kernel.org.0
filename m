Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B655C6E6D5F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Apr 2023 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjDRUTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Apr 2023 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDRUTo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Apr 2023 16:19:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1675A24A
        for <linux-nfs@vger.kernel.org>; Tue, 18 Apr 2023 13:19:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IExN1w015315;
        Tue, 18 Apr 2023 20:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=09uCJge8MNNDCZzU8IPhafsgHg7sj7JTpq+OayJ91Tc=;
 b=qJBmbkhf0NzegdM2dG6ROAktQ0cD9uEPjRIccT2ATtU7AcfXssXwmeeOxF4c0znxD3wl
 EnE9Sbt5/Esi1rNXKefEKbKhhLflo4/lLRkAIzw62MjeXKP1OOERiykm+sd1n2xtqwMd
 vwc29OrTjvs16JzK0bqs6CF6gZ0xVc/9pOxDh95Lj1QwgJUdinuwaB/HBYSZt9jY0y9O
 Kz5qplW3Qu0aSGF++6KZ/UmgRQ2oJIDHcAYfV0craQNZ6jVTR4ME2YmmuKgTfOYmWR1D
 7UVkZt50uwhmiAL7Cw3I52bZuSCINvBGQMI+c8I8letWp92amoP/fyrvhSg49cR9ZbiK 1g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjh1prbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 20:19:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33IIkvCY015650;
        Tue, 18 Apr 2023 20:19:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcc23mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 20:19:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33IKJIiw020242;
        Tue, 18 Apr 2023 20:19:18 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pyjcc23m5-1;
        Tue, 18 Apr 2023 20:19:18 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     trondmy@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: remove the maximum number of retries in call_bind_status
Date:   Tue, 18 Apr 2023 13:19:02 -0700
Message-Id: <1681849142-28597-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180168
X-Proofpoint-GUID: hz-wsvEPLslvPttofqbB0R0CHB2WE4R2
X-Proofpoint-ORIG-GUID: hz-wsvEPLslvPttofqbB0R0CHB2WE4R2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently call_bind_status places a hard limit of 3 to the number of
retries on EACCES error. This limit was done to prevent NLM unlock
requests from being hang forever when the server keeps returning garbage.
However this change causes problem for cases when NLM service takes
longer than 9 seconds to register with the port mapper after a restart.

This patch removes this hard coded limit and let the RPC handles
the retry based on the standard hard/soft task semantics.

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

