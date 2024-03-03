Return-Path: <linux-nfs+bounces-2148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6B86F766
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 23:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F4528118E
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFDD43AB5;
	Sun,  3 Mar 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQzWl8lP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3679DA2
	for <linux-nfs@vger.kernel.org>; Sun,  3 Mar 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709504603; cv=none; b=o+Q7XZWA2Ba42TXRhE2cSzDOtdJeGEoNFILMQKtKq1V7UYtrERfqciqwgpOefkOfThswIAbBIun2IisEakKLwSQPgxSep+YWZ0dYNuM7PAM1yMNA64wVFQUZXwRwbpnspTyVixfrxPDFcR7XgfsEkswamd8ySK1BaET4zTGU1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709504603; c=relaxed/simple;
	bh=mzW8qMzzXnbECG/5Xh5kuqJdSFx5yM/Qn6rVmgkjjTk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H8eR991AkO787hCY4dbXKn/wmIokhfczy2FCcnmyxmtPsiPUxdB/H3TvRatMrXMV3E25ZpYz/X5hdURxRLiK7z8o+A2pQS8OWB6jZl49sIdiN6SDhn0+Bt4GUiMFMWNIA31g3WVk6UYMdQ2FOwgU2ipYx3urTImqUJaVGcdT22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQzWl8lP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 423JkcJh013573;
	Sun, 3 Mar 2024 22:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=0BoT7uweJ6gaWDzIeXutaI4036ZHrvm2AeYKImXMdWw=;
 b=HQzWl8lPmnaH4XyDZf3bM9xxUvP1ZbWbAmv+Di3yMlN5xSGLxVPJXr0qJJSsOsQC5kg3
 939xRn/IMvfG7woemE4Vx+wMqo3CZzlQp8Vx31ja+cbeYJVUTgsXE6TMHuK4KaocDf4q
 K2jnhguAJZAZvxoQaL5mvKP7GUalOo1NTmBvnXooypq34EtPgQ+ZVF4hLIHvwK/tAaKN
 5vloNKNsRe7iEvLOo5b0ReTMFVCmP3dqEnhiJleFzSxkDy6vwB/EuNhpqbbaSisK6Jgl
 jjY6OVEU5Ms6AKxZwxSoH/gfnd/GTmSPH2Dwe6pSC88VjdNrS32KzHJkT9xyNYI6dCT/ tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthea8rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Mar 2024 22:23:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 423Lwulp018948;
	Sun, 3 Mar 2024 22:23:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj4y0d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Mar 2024 22:23:16 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 423MNFRF022984;
	Sun, 3 Mar 2024 22:23:15 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wktj4y0ct-1;
	Sun, 03 Mar 2024 22:23:15 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of delegations reaches its limit
Date: Sun,  3 Mar 2024 14:23:02 -0800
Message-Id: <1709504582-8311-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_12,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403030190
X-Proofpoint-ORIG-GUID: VaFGL0A80qCKHvANmqCLZ9-oBiiHuqYA
X-Proofpoint-GUID: VaFGL0A80qCKHvANmqCLZ9-oBiiHuqYA
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The NFS server should ask clients to voluntarily return unused
delegations when the number of granted delegations reaches the
max_delegations. This is so that the server can continue to
grant delegations for new requests.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

v2: move declaration of deleg_reaper() up to other forward
    declarations in the file.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fdc95bfbfbb6..961000261b3e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -87,6 +87,7 @@ static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
 void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
+static void deleg_reaper(struct nfsd_net *nn);
 
 /* Locking: */
 
@@ -6550,6 +6551,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	/* service the server-to-server copy delayed unmount list */
 	nfsd4_ssc_expire_umount(nn);
 #endif
+	if (atomic_long_read(&num_delegations) >= max_delegations)
+		deleg_reaper(nn);
 out:
 	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 }
-- 
2.39.3


