Return-Path: <linux-nfs+bounces-8981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7BA06698
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B25E167779
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14D20103D;
	Wed,  8 Jan 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LrrDHX04"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0B1DFE06
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369314; cv=none; b=ST+dDwCQPT37gsTHqAMBXLsbgWE3R/rI5/+OLN5ty4NiSq4vm8+4cYGWL0w9GSQSV+OBZ1qmFzi5VP4PbfC//MAZ4OrX+3SXuw2GX59VktLnTZ1GriWGU+yEMrBPUp4bGZBGcERYHswDFagt+TMj3Iswk4jSHKB5Xc94FICZeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369314; c=relaxed/simple;
	bh=OXo8r1k4n0kDJJ9cl6bCLf+fFRmeOjCtfVEXC1wUd9w=;
	h=From:To:Subject:Date:Message-Id; b=oRBf3sY2hHx1Y553gOMwHhwZXeyEuJ9lHQPKNx0gLv1PnQQjaVLdy9k699s6Qfqq0lIzdOWNV1UiZ0eVE57pPwJIep1AJ3GLH3XQYUV1Lox9oMfgW3fwSrdJc+Vm5+qKSRVsIL0X9uLxKguo3SuPHsvDaDVe5ZRKpML86VaMBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LrrDHX04; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMxYa013209
	for <linux-nfs@vger.kernel.org>; Wed, 8 Jan 2025 20:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:message-id:subject:to; s=corp-2023-11-20; bh=k1+/Nzkjq
	CcUMQL8PCbLoAAathI8OUbTPwZWOTVr/LI=; b=LrrDHX04wYWhaRQ1ACNjeoK3C
	Mlo4cSiCrXNsbGWS3GBZIGfLLgy4jBuSxIoTJ7l9jpO6SYTs191oCrHsDbIs0BM4
	jS9uS84qYfjT5lNOT8x+/SyRqtVwrdTjYyWwb0Y2UGCNQxaQhlpnpftKIuMW3x0m
	nSUAmfuGXWtkPDkyQD55iU6zza2QRNJn1yLWp9EuGKq7PhNw6RsAIabHRjLMNzx5
	Pxr+e62lXHzV8ddpcDhDcIFNNQhM7oX+Hv/j0vcB4mSBFyGRKQJ+fl5sNaSA1Por
	lmeM84SP6kh4+2bcbs2rXsG3gQMwBxkRwWithMNLUMOhtg1RGrFtp55CyK1dA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhsqgwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Wed, 08 Jan 2025 20:48:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508J8MgV020693
	for <linux-nfs@vger.kernel.org>; Wed, 8 Jan 2025 20:48:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea85yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Wed, 08 Jan 2025 20:48:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 508KmU4u016794
	for <linux-nfs@vger.kernel.org>; Wed, 8 Jan 2025 20:48:30 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43xuea85xp-1;
	Wed, 08 Jan 2025 20:48:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: do not retry on EKEYEXPIRED when user TGT ticket expired
Date: Wed,  8 Jan 2025 12:48:12 -0800
Message-Id: <1736369292-23095-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080169
X-Proofpoint-GUID: xvJ1AKtJ_cxNht705GleE9D5kjODZEvO
X-Proofpoint-ORIG-GUID: xvJ1AKtJ_cxNht705GleE9D5kjODZEvO
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When a user TGT ticket expired, gssd returns EKEYEXPIRED to the RPC
layer for the upcall to create the security context. The RPC layer
then retries the upcall twice before returning the EKEYEXPIRED to
the NFS layer.

This results in three separate TCP connections to the NFS server being
created by gssd for each RPC request. These connections are not used
and left in TIME_WAIT state.

Note that for RPC call that uses machine credential, gssd automatically
renews the ticket. But for a regular user the ticket needs to be
renewed by the user before access to the krb5 share is allowed.

This patch removes the retries by RPC on EKEYEXPIRED so that these
unused TCP connections are not created.

Reproducer:

$ kinit -l 1m
$ sleep 65
$ cd /mnt/krb5share
$ netstat -na |grep TIME_WAIT

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 net/sunrpc/clnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0090162ee8c3..cd5c84a07005 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1854,13 +1854,13 @@ call_refreshresult(struct rpc_task *task)
 		fallthrough;
 	case -EAGAIN:
 		status = -EACCES;
-		fallthrough;
-	case -EKEYEXPIRED:
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
 		trace_rpc_retry_refresh_status(task);
 		return;
+	case -EKEYEXPIRED:
+		break;
 	case -ENOMEM:
 		rpc_delay(task, HZ >> 4);
 		return;
-- 
2.43.5


