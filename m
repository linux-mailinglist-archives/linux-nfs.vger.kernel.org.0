Return-Path: <linux-nfs+bounces-2921-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A538AD6AE
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4319CB233FF
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 21:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11F1D545;
	Mon, 22 Apr 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZgRTJZk+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E731CFBB
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821496; cv=none; b=gB3qguln4lgzpQW0pqT3yX63eJ8LHWP5wwJp+xSsfLblNRDfcsKZ+6w6wWP5++n3ma4JcbHkbuut/hxSBxXsBlGF3m4zKbsadTfrcnknX6c2tFDoPUKOjWjhfkjM0mUdqPUeRyQjvOw1mzT9QyeIA5amhTdMHnXqPzRCLcP/9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821496; c=relaxed/simple;
	bh=x8zoHojn+iHM6vkKecYSIV9ZsY8kZLMpui6U3ax4B/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MRMoXUdZTotbJZgBr+U0ixV/gM3fVS2bzTRlT79BOb8zmEP3GxPdNNN16TApY9RftMN3j6sM8m5nvd6prDFVwBfsU9VaOx8izMcFZftBiDpXZq25eW/mFj4JxfKjLRq7zpcA6E8u7jjwKN+RaEdyJse0vW4nUFVAE29FBpvLusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZgRTJZk+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHmq7E009992;
	Mon, 22 Apr 2024 21:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=9cPEBkqW+/jLWEdbH4b+49hLGtY/MMrwbsKgchs6lYg=;
 b=ZgRTJZk+WMcOH7BmAsIyJTGb/YRZx9Ova1RCeC2s7AEorfXRC7dSXfgi2znrhoUmLTyX
 FvBEjIlfIQkrSiX9UwpLH4ZWwWaxuXnRNk1M9Do/4Y7pzNljWuhjTu9CixQyzxYw2TKu
 mk6IyfuBgPA9hhZkx5XFKY7uqVwwtnhHhoxJCa0OY95cetbap2asXfkQ65JhC7n1BRys
 IbiQhrIazQe1IPDLXPFvBgJdVGw09yYZvgmkpFQeTZ04AKYOBjQOGwkBod9mpAIBj4fd
 6U4/L4uMKTZ2ygK8RBY2EGzLPJxPHB51v/g695DcLf4cIKnhKt+qgFCZcDvM53+gxuNU rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aukr1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 21:31:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MKghDe033819;
	Mon, 22 Apr 2024 21:31:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456980w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 21:31:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MLUw1N008733;
	Mon, 22 Apr 2024 21:31:30 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456980c-2;
	Mon, 22 Apr 2024 21:31:29 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD: mark cl_cb_state as NFSD4_CB_DOWN if cl_cb_client is NULL
Date: Mon, 22 Apr 2024 14:31:13 -0700
Message-Id: <1713821475-21474-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713821475-21474-1-git-send-email-dai.ngo@oracle.com>
References: <1713821475-21474-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_15,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220090
X-Proofpoint-ORIG-GUID: HpzilLy8HcWF1C-V3aoia0MgItEvP_QY
X-Proofpoint-GUID: HpzilLy8HcWF1C-V3aoia0MgItEvP_QY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

In nfsd4_run_cb_work if the rpc_clnt for the back channel is no longer
exists, the callback state in nfs4_client should be marked as NFSD4_CB_DOWN
so the server can notify the client to establish a new back channel
connection when it reconnects.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index cf87ace7a1b0..f8bb5ff2e9ac 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1491,9 +1491,14 @@ nfsd4_run_cb_work(struct work_struct *work)
 
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
-		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
+		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 			nfsd41_destroy_cb(cb);
-		else {
+			clear_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
+
+			/* let client knows BC is down when it reconnects */
+			clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
+			nfsd4_mark_cb_down(clp);
+		} else {
 			/*
 			 * XXX: Ideally, we could wait for the client to
 			 *	reconnect, but I haven't figured out how
-- 
2.39.3


