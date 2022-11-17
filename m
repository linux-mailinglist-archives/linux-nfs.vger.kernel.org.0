Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9719A62D1D5
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 04:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiKQDpP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Nov 2022 22:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiKQDpK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Nov 2022 22:45:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B726BDF9
        for <linux-nfs@vger.kernel.org>; Wed, 16 Nov 2022 19:45:02 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH1wjkX006514;
        Thu, 17 Nov 2022 03:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=l54oJ88i+fLePgcDBvWBKS6hlTX/rW3eo5HtSkiPv7s=;
 b=qaliFYkNZ4wOVQrsJWh72vwqBfc26QG4m198lw73XTgKl5jK3amICERhZQrS6mckifqj
 +HVDwuGQkVnKyXUBNeBCu/bPAThc9bFM3xt+Oky8/kj/jY7oyKyyEAp2Y0cteufpsaGY
 V3UfeK9mvm3+pg36d0w0gCgZeIUp7pmaynrk8Rs8rFyoWcWQJjjBM22NRPAOcEs9drBj
 ORj33ZtS5IiSJV9Bj7B9W0w0lcnfhN9sG4frsLCkuaF7jX5OpvRQsQp3mJODECBYcsDV
 KGzBJCmXo2+CsKH/k3CfEDwWgnpZR7pmtVWpE2yvNmUyaJcPSUR7qVyM4zfIw7MSvywX lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3htyshc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH3iT7o016812;
        Thu, 17 Nov 2022 03:44:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk1ya27n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 03:44:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AH3iutl030624;
        Thu, 17 Nov 2022 03:44:58 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kuk1ya262-5;
        Thu, 17 Nov 2022 03:44:58 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 4/4] NFSD: add CB_RECALL_ANY tracepoints
Date:   Wed, 16 Nov 2022 19:44:48 -0800
Message-Id: <1668656688-22507-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170024
X-Proofpoint-GUID: FQPpjg3fAj4KS3ZEZs6-C1WYzDGhPyjd
X-Proofpoint-ORIG-GUID: FQPpjg3fAj4KS3ZEZs6-C1WYzDGhPyjd
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
 fs/nfsd/trace.h     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 13f326ae928c..935d669e2526 100644
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
@@ -6209,6 +6210,7 @@ deleg_reaper(struct nfsd_net *nn)
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
+		trace_nfsd_cb_recall_any(clp->cl_ra);
 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
 	}
 }
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 06a96e955bd0..bee951c335f1 100644
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
@@ -1471,6 +1473,53 @@ TRACE_EVENT(nfsd_cb_offload,
 		__entry->fh_hash, __entry->count, __entry->status)
 );
 
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
+		__sockaddr(addr, sizeof(struct sockaddr_storage))
+	),
+	TP_fast_assign(
+		__entry->cl_boot = ra->ra_cb.cb_clp->cl_clientid.cl_boot;
+		__entry->cl_id = ra->ra_cb.cb_clp->cl_clientid.cl_id;
+		__entry->ra_keep = ra->ra_keep;
+		__entry->ra_bmval = ra->ra_bmval[0];
+		__assign_sockaddr(addr, &ra->ra_cb.cb_clp->cl_addr,
+				  sizeof(struct sockaddr_storage))
+	),
+	TP_printk("Client %08x:%08x addr=%pISpc ra_keep=%d ra_bmval=0x%x",
+		__entry->cl_boot, __entry->cl_id,
+		__get_sockaddr(addr), __entry->ra_keep, __entry->ra_bmval
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
+	),
+	TP_fast_assign(
+		__entry->status = task->tk_status;
+		__entry->cl_boot = cb->cb_clp->cl_clientid.cl_boot;
+		__entry->cl_id = cb->cb_clp->cl_clientid.cl_id;
+	),
+	TP_printk("client %08x:%08x status=%d",
+		__entry->cl_boot, __entry->cl_id, __entry->status
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_cb_done_class,
 	TP_PROTO(
 		const stateid_t *stp,
-- 
2.9.5

