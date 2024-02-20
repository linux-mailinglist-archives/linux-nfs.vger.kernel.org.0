Return-Path: <linux-nfs+bounces-2040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A290B85CC5D
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Feb 2024 00:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F381F2235F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Feb 2024 23:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2695154C0A;
	Tue, 20 Feb 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJRxEGQi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940F154448
	for <linux-nfs@vger.kernel.org>; Tue, 20 Feb 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473525; cv=none; b=NTpnYZftCnylgL58uKxNFen/ENwmrQE6UTfmNlUnubN7LbuIS1J/xvXdXvetCwomiLC+QVyDhvt8EmhFIS84NRKmU9Mcf5+VdkiNzqZKxTZnAv/tJQ+97ViHtlHDYovVPJNgOuXlduXYN7KVHxdYIPC9U4cpvntWUkEKM+FBWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473525; c=relaxed/simple;
	bh=UalBFzrGK+FKFTA9BMghsr7+F+E3eQWfBzVmy+hnpSc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S6EHYr2TfLfvkkoOI3L/63IPvOIFGTEMfj4WIXt+wD6D/gk+M/6idH7TSJUdxJ2NVT8i3jdfAgQW9eds3/HfzBNmavdRoFTxWzoczMMd1S6eaenqqX7KZBq/x2swS5e037iGj08zw83ezae+NFbjCZ3pF3RxTO48RIzIfFRMdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JJRxEGQi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKXcJ0004113;
	Tue, 20 Feb 2024 23:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=T41Oac/KGK8ZKJOojQooTZD6x28YT0A5J215wt955hY=;
 b=JJRxEGQis479sidJFXjZxifp7ML8I6N9uQNFmCaik2R7VWuc58mr8+qcAAPhjWVJ/8rz
 O+kZAZ7qY7EMEHwvOmQXaa/FgrOyLr4kmPqKTOwY1Je3aBNELT0fEOkA6bTGz6SOst6I
 vhAJJLq7L7RiQOnL2lz+ZQzW0CjyGNTNkKjGCWFM+48xkzvpuqD5PtWXtJBrNgP59Zr5
 P6C7g/WYReU6I5E+L6uUBkd/gXbU/OkjaVKu5FVLt4Lx14WshDEooTwcOc5brfMn7Gxf
 f5BCN3Clz94ykK54KRlSsms9MlwTylAV7hVbL2YPlcPr7TVd731s7VUNrQwcPeQjXSV/ Vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc8cws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:58:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KMPfXs006745;
	Tue, 20 Feb 2024 23:58:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88c8jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:58:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KNwcEm019304;
	Tue, 20 Feb 2024 23:58:38 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak88c8j6-1;
	Tue, 20 Feb 2024 23:58:38 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: send OP_CB_RECALL_ANY to clients when number of delegations reaches its limit
Date: Tue, 20 Feb 2024 15:58:28 -0800
Message-Id: <1708473508-19620-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200172
X-Proofpoint-GUID: PYVlQY7g0zL5Gh9Vgh3coH3N0wUneWeb
X-Proofpoint-ORIG-GUID: PYVlQY7g0zL5Gh9Vgh3coH3N0wUneWeb
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The NFS server should ask clients to voluntarily return unused
delegations when the number of granted delegations reaches the
max_delegations. This is so that the server can continue to
hand out delegations for new requests.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fdc95bfbfbb6..a0bd6f6b994d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -130,6 +130,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
 
 static struct workqueue_struct *laundry_wq;
+static void deleg_reaper(struct nfsd_net *nn);
 
 int nfsd4_create_laundry_wq(void)
 {
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


