Return-Path: <linux-nfs+bounces-2482-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CA88CBCC
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 19:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB1D3406A4
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124EB8527A;
	Tue, 26 Mar 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QRgf3m02"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F54EB22
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476804; cv=none; b=QFgVVt+lz8l5k62CN75U+InuLtvMKXxlpgGBa+o+mkTIAtog3a+xfwNeNK7+Pr5x82aUQbh+sh19WDJ5oqUs6pJGgM2SoB6PLff3zN2EPMMOCsNG5LH65wczr5Q4IRjssOHy+Onh+SenkdgDnEw9RPUsBiTsB+VqQoHP40bK4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476804; c=relaxed/simple;
	bh=aLAxn/2iDIfZCjbIuZtldw8HHTb05p+XXbOeInd03x4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=iETzVf2+sdv5w4kcV7GXam5Hb5bnmbGt9LBkMDeHh68XxhVswXft9g4cn/JY/KaruKCG74VQmEIj+qCV9mG77EO+++ONcFa0gtRr1F2Or9udGjsY+JhDsrk8zR7x2UxKXkB45wrqL+ASXgXgbFsu94OKWnwYANgDDuOFZhqfvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QRgf3m02; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QI4v7E031787;
	Tue, 26 Mar 2024 18:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=3ROY4h6iaoGfytuAcICw3lGww2z9IKp2x4u7Aoipny8=;
 b=QRgf3m02G9p0iQuVqntZ4DbafLKJSskjxQC8R+O3dN7drQ6qQPUbtTPX8yAYxC5XItky
 doxJ6tK9LmbjuUbdPWOCTy0Lr3BP3jBakO2Y6BByyMQi/qbDVdDYKTi/9Ji/n7x7b0tx
 ULObFjnRWpUYv/pyOP1KVwWUtbub9+z2uLTAz9o+dzGCd/ZePT+VIy1ybT/bSivudyN6
 0miZkSJr8AXcZuwLGuW5QTc5rnVJQAGz9WGtzKE4sAdOkUW+6N3K7hBdq3e2SY0DjMYG
 eyhyBIxWU3gmB+jwuEtVsMDNhdKVQsB0HHy574hpQcMr0VJ/qjQJ/IEB/J5a4Fy3BFx7 zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2ds4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 18:13:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QHp6hx013925;
	Tue, 26 Mar 2024 18:13:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh7mhpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 18:13:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QIAQk6037540;
	Tue, 26 Mar 2024 18:13:15 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x1nh7mhph-1;
	Tue, 26 Mar 2024 18:13:15 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: cancel CB_RECAL call when nfs4_client is about to be destroyed
Date: Tue, 26 Mar 2024 11:12:58 -0700
Message-Id: <1711476778-26181-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260130
X-Proofpoint-GUID: srTBocsz5sZuceXGMSWQ2nWgoBRuCPqS
X-Proofpoint-ORIG-GUID: srTBocsz5sZuceXGMSWQ2nWgoBRuCPqS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Currently when a nfs4_client is destroyed we wait for the cb_recall
callback to complete before proceed. This adds unnecessary delay to the
__destroy_client call if there is problem communicating with the client.

This patch addresses this issue by cancelling the CB_RECALL call from
the workqueue when the nfs4_client is about to be destroyed.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 6 ++++++
 fs/nfsd/nfs4state.c    | 2 ++
 fs/nfsd/state.h        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e5b50c96be6a..da9211f6fbbb 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1578,3 +1578,9 @@ void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
 		nfsd41_cb_inflight_end(clp);
 	}
 }
+
+void nfsd4_cb_recall_cancel(struct nfs4_client *clp, struct nfs4_delegation *dp)
+{
+	if (cancel_delayed_work(&dp->dl_recall.cb_work))
+		nfsd41_cb_inflight_end(clp);
+}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0e1db57c9a19..f889e3addd71 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2378,6 +2378,8 @@ __destroy_client(struct nfs4_client *clp)
 	while (!list_empty(&reaplist)) {
 		dp = list_entry(reaplist.next, struct nfs4_delegation, dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
+		if (dp->dl_recalled)
+			nfsd4_cb_recall_cancel(clp, dp);
 		destroy_unhashed_deleg(dp);
 	}
 	while (!list_empty(&clp->cl_revoked)) {
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 259b4af7d226..8b29bd3bbf1d 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -736,6 +736,8 @@ extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
 extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
+extern void nfsd4_cb_recall_cancel(struct nfs4_client *clp,
+		struct nfs4_delegation *dp);
 extern int nfsd4_create_callback_queue(void);
 extern void nfsd4_destroy_callback_queue(void);
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
-- 
2.39.3


