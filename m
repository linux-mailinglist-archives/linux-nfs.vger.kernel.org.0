Return-Path: <linux-nfs+bounces-2483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774E88CBCE
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52731F85EB4
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41FD4EB22;
	Tue, 26 Mar 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caqakrHO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2A8529B
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476823; cv=none; b=uZHjA58GwQ5xyMtvV7M4xwjPKXEGFHO1slmdbkWIelaxerMpfAB/9Wxiqz9Xd9wyks0jE1XPApsTl/PNVVdTBxWxNa/ixtSjV7IZoJbY05y2qfa9ckaAwJfEQ16rcztQyp98dwP4mLeLkVw6HTPL6eQuK7QPbRpjKGJ1zv1YWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476823; c=relaxed/simple;
	bh=o51z9nZgPnQMKPvgnfxB2gPQxCELdDXTXN9msykDmr4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rgylTOp4m2caHwvyoFMN16VZMgvxL4mMgxGoPSwIe0erq0SjtJCtbX3poUbM3zZ5KQdojB3o0uNmDvMv4xOJCv2cKaGzwIz0ideVYU72R1iOpn4xrhwtcstXeo/5ZmqxkbeXbHBzqVHrzTXN43B69VHElpOH6xmPaY0o5b4QiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=caqakrHO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QI56Jw025593;
	Tue, 26 Mar 2024 18:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=JZ1CDjWEY8hqjcqFEp46R9xoaXAFsIGyoqtdw9FhdJI=;
 b=caqakrHO5SlhBkNNuaWEYolXevteaMGOTxNFO6M9BSfnF7K9s6ZucyADR38g2z1K1W4u
 pWi9u1+oS35BghX0oA8EHx7IwgbtXu02bSAoCJFzuHoABNVTW34rutdyxexFw9vqSK2O
 icGEfBbQpC5KaZLpeckC5KUTre+jSR7SGfRknXiwclpbo5enNEczBfJ9a/2DeCMHZG4u
 FvY9o3IIMJRhyv8/Gi7U/Fv+xNTQk8WuXfF/2Lzn/eN5WqgsLHP9as6peKDfXYGecacJ
 bE3IQoDwG3pGD/Rkrv8SwMBkr8teuhmNxXnEImKIOIcvItf+048cqCUvH8Ls/9F4RAaA og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct528s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 18:13:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QHk8TR031963;
	Tue, 26 Mar 2024 18:13:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh7cdkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 18:13:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QIDbDN018508;
	Tue, 26 Mar 2024 18:13:37 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x1nh7cdfy-1;
	Tue, 26 Mar 2024 18:13:37 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is about to be destroyed
Date: Tue, 26 Mar 2024 11:13:29 -0700
Message-Id: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260130
X-Proofpoint-GUID: 9-miPlEGjkqemx5TXvXka88ZV8oQnb7t
X-Proofpoint-ORIG-GUID: 9-miPlEGjkqemx5TXvXka88ZV8oQnb7t
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Currently when a nfs4_client is destroyed we wait for the cb_recall_any
callback to complete before proceed. This adds unnecessary delay to the
__destroy_client call if there is problem communicating with the client.

This patch addresses this issue by cancelling the CB_RECALL_ANY call from
the workqueue when the nfs4_client is about to be destroyed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 10 ++++++++++
 fs/nfsd/nfs4state.c    | 10 +++++++++-
 fs/nfsd/state.h        |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 87c9547989f6..e5b50c96be6a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1568,3 +1568,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
 		nfsd41_cb_inflight_end(clp);
 	return queued;
 }
+
+void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
+{
+	if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) &&
+			cancel_delayed_work(&clp->cl_ra->ra_cb.cb_work)) {
+		clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
+		atomic_add_unless(&clp->cl_rpc_users, -1, 0);
+		nfsd41_cb_inflight_end(clp);
+	}
+}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1a93c7fcf76c..0e1db57c9a19 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2402,6 +2402,7 @@ __destroy_client(struct nfs4_client *clp)
 	}
 	nfsd4_return_all_client_layouts(clp);
 	nfsd4_shutdown_copy(clp);
+	nfsd41_cb_recall_any_cancel(clp);
 	nfsd4_shutdown_callback(clp);
 	if (clp->cl_cb_conn.cb_xprt)
 		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
@@ -2980,6 +2981,12 @@ static void force_expire_client(struct nfs4_client *clp)
 	clp->cl_time = 0;
 	spin_unlock(&nn->client_lock);
 
+	/*
+	 * no need to send and wait for CB_RECALL_ANY
+	 * when client is about to be destroyed
+	 */
+	nfsd41_cb_recall_any_cancel(clp);
+
 	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
 	spin_lock(&nn->client_lock);
 	already_expired = list_empty(&clp->cl_lru);
@@ -6617,7 +6624,8 @@ deleg_reaper(struct nfsd_net *nn)
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+		if (!nfsd4_run_cb(&clp->cl_ra->ra_cb))
+			clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
 	}
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 01c6f3445646..259b4af7d226 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -735,6 +735,7 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
 extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
+extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
 extern int nfsd4_create_callback_queue(void);
 extern void nfsd4_destroy_callback_queue(void);
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
-- 
2.39.3


