Return-Path: <linux-nfs+bounces-9806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438BA23649
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 22:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7477E1885A3C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116D1AF0CA;
	Thu, 30 Jan 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dbgXX1+L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73161AC884
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271097; cv=none; b=aCisgLummCNhS4McgZmgnpzosOoJ9E6zQ+Qvw92c0u5hPxx8dd9O6HyztJKkEl3niwuTw35vb6aoHQfthZo8T4yypbOfrp6wfnt2J5vnqxLcLI741EAZ/qs/tzZF24EcBzvmrfGn6BSf5mQBxu8h9Xa6zPOKVP942mHxJ676dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271097; c=relaxed/simple;
	bh=Q+5bH8fTnow1uLjHZweTXv3FKjGDYF5QObfGwURk1bw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=avkwpI4RGZMkhrMZeidLTaHyMjVOkXAtXfD2I0yD6KFH5Pxp0d4X6BAW8bOqG1nH+/e0RdUBIaTV3NuReWeoslrvk/dXmxvhkhPU6cK7QcsRY3oSTBiqCeIE3QbpZ9z3/7GttGRByKopKbWkj8wG7/hfUI+IF9PWAPxiXLIWd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dbgXX1+L; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UL1UK6003214;
	Thu, 30 Jan 2025 21:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=+Ib3IlmC
	X43rZ2+CVGV+lw+Wp59sfV/HCm1Vi6EXjxk=; b=dbgXX1+LMCqLp6So60sG7i/S
	vsxHtmBruyd+AtEdpBQl9m7WyVxEuCOPfDEQoIXXowVx3ygap7QGxEBxJHPsT+SP
	4G2H2RvRjUoLV4BHBv/iP4wgRTYpiHQxpAVfAtDU6+cp8cSxjj7b+t48Hd9Q+uYL
	PGG7+vrkTahmymvhV+qAUAugPnj/g+fmNfezuUmdAVkI40VWvI/yyB8ZuwhGdlLw
	/MJUnhFUDt92oWlaVLUC1Dm1wfbubBtl9iaNLOFSYlOOV15FJXZilOO9BavJAdII
	Mbk0+NF8ZRxn8gi+oU9KYzphSCHXkweqFoe4hpJQH+VC0jSNTXuGmboBcJqCYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ggaqg379-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:04:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKsibs016732;
	Thu, 30 Jan 2025 21:04:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44ggvjgb2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:04:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50UL4jes009207;
	Thu, 30 Jan 2025 21:04:45 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44ggvjgb15-1;
	Thu, 30 Jan 2025 21:04:44 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/1] NFSD: fix hang in nfsd4_shutdown_callback
Date: Thu, 30 Jan 2025 13:04:26 -0800
Message-Id: <1738271066-6727-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300162
X-Proofpoint-ORIG-GUID: ZuU99TYiPMm8sGUhg3z2DjnYWNKsSgRn
X-Proofpoint-GUID: ZuU99TYiPMm8sGUhg3z2DjnYWNKsSgRn
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

If nfs4_client is in courtesy state then there is no point to send
the callback. This causes nfsd4_shutdown_callback to hang since
cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
notifies NFSD that the connection was dropped.

This patch modifies nnfsd4_run_cb_work to skip the RPC call if
nfs4_client is in courtesy state.

Fixes: 66af25799940 ("NFSD: add courteous server support for thread with only delegation")
Cc: stable@vger.kernel.org
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4..cf6d29828f4e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1583,8 +1583,11 @@ nfsd4_run_cb_work(struct work_struct *work)
 		nfsd4_process_cb_update(cb);
 
 	clnt = clp->cl_cb_client;
-	if (!clnt) {
-		/* Callback channel broken, or client killed; give up: */
+	if (!clnt || clp->cl_state == NFSD4_COURTESY) {
+		/*
+		 * Callback channel broken, client killed or
+		 * nfs4_client in courtesy state; give up.
+		 */
 		nfsd41_destroy_cb(cb);
 		return;
 	}
-- 
2.43.5


