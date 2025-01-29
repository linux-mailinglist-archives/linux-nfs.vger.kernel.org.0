Return-Path: <linux-nfs+bounces-9764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD66A2258E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E403A6B47
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00D1E0DFE;
	Wed, 29 Jan 2025 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ga6g8/kQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B019CC33
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185474; cv=none; b=i/AHlKaOyGZVXYGmh/ji1qQqSjHNfTNuZS/m2mdF07Tdf5g3GEkwYGSWXpotV2L3xNbPfrx8u2BYlP1g4i2vay6kCjjhpQb05GL2a4FmrsspLeVmhaw729/sQAZHTgKEx/xeXMqqGy7diWk3mtoeZ08uS4rv9lulwKb52fSzIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185474; c=relaxed/simple;
	bh=zYpjN003ooGMhIsaYEWnSVXobW+j3CeKLlDM9NaYoB4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kK+jAC+Rxp05tqjrFvQz2YsNymQU51GcgVO0GeXYRA/ObCwd1L1jkAP4JI4hTod9bseQEZLw0ReYf29Q9ociHo+N3A0woGqYqH5gwA2lPkyFfpzFRgURlhcueeidvnNbK/n2H/DpV1zUb1g4VLMH/f3uW/pTvy8WoikPxsJFKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ga6g8/kQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TLBkAo009896;
	Wed, 29 Jan 2025 21:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=WJUNcfu9
	4gFo7Ktu9QxwRishW8hquripr9RjYB4qGU8=; b=Ga6g8/kQZqWQgr8TpbhRb0SE
	CeBrxnFZ+jHrDPnTeEOmogEJEXqLCqIyeG8/YzHfUNLn3ZmdNHBMxlJGpnB10BHE
	XbKp9eVoN9V/Bygu/IaFUakL3Ijsp7gKaKDam05Tvw3RaieNjBOz7s3Jy3lXiw1e
	HnJ2uTndFLXa3Z8X4MIalOkLJj3eLzVIUJ/rLw+0oDZvJITLkSrkUc7Q91dRndFt
	sTz5YGjc45Wcjf8Lt2ygs5+joWAj7qPnzxMQRIeXtvlY5kWvFOtIgLJzJxxLDkX/
	RiJH4LRFQGh9Tl5GHs+gp+1S++fNgj1S6gz/r9hklYZsUMa/58PVLNhoeVJ7UA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ftmy8fr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 21:17:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TJeXkp035802;
	Wed, 29 Jan 2025 21:17:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdgbd5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 21:17:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TLDwPF009385;
	Wed, 29 Jan 2025 21:17:42 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44cpdgbd5m-1;
	Wed, 29 Jan 2025 21:17:42 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD: fix hang in nfsd4_shutdown_callback
Date: Wed, 29 Jan 2025 13:17:26 -0800
Message-Id: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290162
X-Proofpoint-ORIG-GUID: bXaFkLEJYzNJ2sHDLTbea-O8c4BNg9Az
X-Proofpoint-GUID: bXaFkLEJYzNJ2sHDLTbea-O8c4BNg9Az
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

If nfs4_client is in COURTESY state then there is no point to retry
the callback. This causes nfsd4_shutdown_callback to hang since
cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
notifies NFSD that the connection was closed.

This patch modifies nfsd4_cb_sequence_done to skip the restart the
RPC if nfs4_client is in  COURTESY state.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4..c90f94898cc5 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1372,6 +1372,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = false;
 		break;
 	case 1:
+		if (clp->cl_state == NFSD4_COURTESY) {
+			nfsd4_mark_cb_fault(cb->cb_clp);
+			ret = false;
+			break;
+		}
 		/*
 		 * cb_seq_status remains 1 if an RPC Reply was never
 		 * received. NFSD can't know if the client processed
-- 
2.43.5


