Return-Path: <linux-nfs+bounces-2927-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C68ADC1C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 05:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED1C282AAB
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355B1946B;
	Tue, 23 Apr 2024 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HZq8F+NM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74018641
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841972; cv=none; b=TAaZWEQl5D21ymOfMWF6tQcADm8R+C9zq2axJpsKsNKVbABCIESK12DrdbRKyDiHrexK7ZYkINHmJh3Ti63pcEDbQ7WrgaNvbe8Y3Bvbh9zWeSz4fs8E1eiqr50WVCQjcBrk3MBl9A7KIOPM+gbgfavTm45slUQIGko2QOrcwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841972; c=relaxed/simple;
	bh=n2iABvu4jzNMv28Q0kHWlr62XDxaaIVOyXfwMIVxwG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AuUCmR8WYPmU8UHaBbkW2Z3QEp6HfQ8lgS3xyAKCgrha1Z6ybiJOVJvdFPF+8aRJKKSnHQGTCYrYIp89S7jvcX8ZtzovsOYUyT0hHaPGgQiNrhB3uLXA5ZYhcUNTyq3PxIOJuEy5OgfWBMnDmyFUMCAsYSULx4IPAzQxL2EK+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HZq8F+NM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnOpT013920;
	Tue, 23 Apr 2024 03:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=hR/6xUHOjAJUSUlB/K9DyntUMzRZrTpcVkIhovIouEY=;
 b=HZq8F+NMQklBIp1PCjr4/RULgh6UjBh8VE11oy9njSzLH/1MCXZa2r2BGuKroqqAsBXI
 psIzn3IfrKnjj38ZrNuqm+D76e8PHXGvYPTBlYxzfRblW1ODVNmVFOt0w5ikPDCCPiZ8
 DZacJ4GWk7grsduSPTP3kWcvQhD7yO1lIOBWqdEPtGr4UUfFNT+DOo2ffHX/2p3hDRBS
 hsfQIqr/AeaaXxfC/Jelu4YTOgOucSzBGtdGn1Knmz7moPTsEjvbaKp6TnbG1mVl1jRC
 gecsDKAfRF/uQFJQDQCI05VEQcQP4vpLqiS1utowe+6vWgWZOvGCEJyr+4wyL8CkDuG8 VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2c4gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43N33Adt040597;
	Tue, 23 Apr 2024 03:12:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456j427-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N3CjTn016779;
	Tue, 23 Apr 2024 03:12:46 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456j41v-3;
	Tue, 23 Apr 2024 03:12:46 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] NFSD: add helper to set NFSD4_CLIENT_CB_KILL to stop the callback
Date: Mon, 22 Apr 2024 20:12:32 -0700
Message-Id: <1713841953-19594-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
References: <1713841953-19594-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230008
X-Proofpoint-GUID: cdvjtLScPs6ts16PghJncsJY81uchQb8
X-Proofpoint-ORIG-GUID: cdvjtLScPs6ts16PghJncsJY81uchQb8
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Add helper for nfs4state functions to set NFSD4_CLIENT_CB_KILL
to stop the callback.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 5 +++++
 fs/nfsd/state.h        | 1 +
 2 files changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f8bb5ff2e9ac..4c3a4d5df626 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1562,3 +1562,8 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
 		nfsd41_cb_inflight_end(clp);
 	return queued;
 }
+
+void nfsd4_kill_callback(struct nfs4_client *clp)
+{
+	set_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f42d8d782c84..cde05c26afd8 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -757,6 +757,7 @@ struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 #ifdef CONFIG_NFSD_V4
 void nfsd4_revoke_states(struct net *net, struct super_block *sb);
+void nfsd4_kill_callback(struct nfs4_client *clp);
 #else
 static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 {
-- 
2.39.3


