Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07D623AF2
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Nov 2022 05:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiKJERe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 23:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKJERc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 23:17:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832B7CCC
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 20:17:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA4Cu04030278;
        Thu, 10 Nov 2022 04:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=KTzHq7l2v3aGbR0sRXVXF+1OHGlVMxLqedyhH/lRf74=;
 b=VXHufflCLMQNe7o4CFSu6SNt8Xtko51dgAGq1Q0RXbRefIGDTsWHzcbikY3kHi80xJP1
 XTflm1ZBTN+lx/FhkUtphM0BbykQh4h+CbZvPpACsJfeoqno67Yano58GG0pJIEBeUcN
 V/dbZfDH3ZEtloLTBA+ckWe/MYdVCDlvzeXGdbnH3rZsYOwPTzQLtlpRl5kmNI/Uu95q
 iWfYyUWZf8hLzLPLW+Wbz5SDNJ0yKvB8rUNeeviwBGh7vq+FQFCMRbZR7yi4vJraZXA1
 oJYJt/8qvdNkZd2BTmbjFQKsJLVTURXu5ikW8qXWAInKrODDXnfa/q7ZqGNqs5QgV8zU wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krt2pr0a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 04:17:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA2CRrm000328;
        Thu, 10 Nov 2022 04:17:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsfxc53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 04:17:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AA4HO7f005307;
        Thu, 10 Nov 2022 04:17:27 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kpcsfxc35-4;
        Thu, 10 Nov 2022 04:17:27 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/3] NFSD: add CB_RECALL_ANY tracepoints
Date:   Wed,  9 Nov 2022 20:17:11 -0800
Message-Id: <1668053831-7662-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
References: <1668053831-7662-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100030
X-Proofpoint-GUID: E35mWL4sVO24D6W5YIWEIIN2IFpAcLls
X-Proofpoint-ORIG-GUID: E35mWL4sVO24D6W5YIWEIIN2IFpAcLls
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add tracepoints to trace start and end of CB_RECALL_ANY operation.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.h     | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 813cdb67b370..eac7212c9218 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2859,6 +2859,7 @@ static int
 nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
 				struct rpc_task *task)
 {
+	trace_nfsd_cb_recall_any_done(cb, task);
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 		rpc_delay(task, 2 * HZ);
@@ -6242,6 +6243,7 @@ deleg_reaper(struct work_struct *deleg_work)
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
+		trace_nfsd_cb_recall_any(clp->cl_ra);
 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
 	}
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 06a96e955bd0..efc69c96bcbd 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -9,9 +9,11 @@
 #define _NFSD_TRACE_H
 
 #include <linux/tracepoint.h>
+#include <linux/sunrpc/xprt.h>
 
 #include "export.h"
 #include "nfsfh.h"
+#include "xdr4.h"
 
 #define NFSD_TRACE_PROC_RES_FIELDS \
 		__field(unsigned int, netns_ino) \
@@ -1510,6 +1512,57 @@ DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_notify_lock_done);
 DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_layout_done);
 DEFINE_NFSD_CB_DONE_EVENT(nfsd_cb_offload_done);
 
+TRACE_EVENT(nfsd_cb_recall_any,
+	TP_PROTO(
+		const struct nfsd4_cb_recall_any *ra
+	),
+	TP_ARGS(ra),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, ra_keep)
+		__field(u32, ra_bmval)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = ra->ra_cb.cb_clp->cl_clientid.cl_boot;
+		__entry->cl_id = ra->ra_cb.cb_clp->cl_clientid.cl_id;
+		__entry->ra_keep = ra->ra_keep;
+		__entry->ra_bmval = ra->ra_bmval[0];
+		memcpy(__entry->addr, &ra->ra_cb.cb_clp->cl_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client %08x:%08x addr=%pISpc ra_keep=%d ra_bmval=0x%x",
+		__entry->cl_boot, __entry->cl_id,
+		__entry->addr, __entry->ra_keep, __entry->ra_bmval
+	)
+);
+
+TRACE_EVENT(nfsd_cb_recall_any_done,
+	TP_PROTO(
+		const struct nfsd4_callback *cb,
+		const struct rpc_task *task
+	),
+	TP_ARGS(cb, task),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(int, status)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+	TP_fast_assign(
+		__entry->status = task->tk_status;
+		__entry->cl_boot = cb->cb_clp->cl_clientid.cl_boot;
+		__entry->cl_id = cb->cb_clp->cl_clientid.cl_id;
+		memcpy(__entry->addr, &cb->cb_clp->cl_addr,
+			sizeof(struct sockaddr_in6));
+	),
+	TP_printk("client %08x:%08x addr=%pISpc status=%d",
+		__entry->cl_boot, __entry->cl_id,
+		__entry->addr, __entry->status
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.9.5

