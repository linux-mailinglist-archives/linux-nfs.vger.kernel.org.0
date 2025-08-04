Return-Path: <linux-nfs+bounces-13414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A7B1A95D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D5518A2B81
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A310942;
	Mon,  4 Aug 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UpGmkjWt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4AEEB2
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334524; cv=none; b=YmFa6E8JSPdYAyGpqBYvfdrsygZlT6IuT9axTXrBFvOs5a0+Q2TjGWSg/JQ4KP127mtJ2MZU7WeVt0zj7beRH+LwI7PAYf6FyPWB5wDo0IPdZcu+iYFpBiTvg6hMeerVzVa7p93jKz9ju+m54g/x7bSMWy1aqzkSQfni2qwzCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334524; c=relaxed/simple;
	bh=DtG9x0/KImLxol+9hSaAJb6yxYkmTmF8Y5QaVf6hMjY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ay+VzhDiDWj6HQ9JF92+lwg4VMFQ1DXlUOYzyN87thtYyzIws4dBZc+NpyIwoyhd9aG3BvivA8K8WgwwNC2H5gX3a3OsqQxhfUklpvzuShtVVMbcZ/u5jnv14EF+r9hiPWQKTf0tsPsiewQIXPoPEJCouNI4fOZZRIF2fFp2bg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UpGmkjWt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6apr031666;
	Mon, 4 Aug 2025 19:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=bG/Xv44Z
	/P8SzgOw9zeQsJ/9RNRwiy3u+JHRDLcoUmc=; b=UpGmkjWtodnFjjC2DvTd6212
	tQrgr8b/FV/uRCSI9p7AGth3ZNyTvsJYWhwv89vBSKfFx4waxwwY54pmUEQatq27
	nFP1SZQziYWByqsDtcqwqZxOPO84Y7Ec4Vpu0GqVUGyqYs1eXxb38VN9Rb5DVdYG
	OuAdDmEwUVyC2zIbKrBeoVh/vcQBRcEHzbSIX1VLaAF/m1GM66cOOXYf6TGzL2le
	zl8F2dmkXZt0ao3/9SRrrtHt3+EfVdiUY7EILsVXY0lMP+TZz/PudpC4iOu4tLl4
	Rq8k6xAO8IafgZxCYSCSiBqfEQQQzcp/LJG+84rLvozzykjqkmdnHGE7L+Yfgg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489ajdk91p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 19:08:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574HJVYS031908;
	Mon, 4 Aug 2025 19:08:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jv1ccb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 19:08:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 574J8anr040239;
	Mon, 4 Aug 2025 19:08:36 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48a7jv1cah-1;
	Mon, 04 Aug 2025 19:08:36 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy transport on ETIMEDOUT before retry
Date: Mon,  4 Aug 2025 12:08:25 -0700
Message-Id: <1754334505-65027-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040112
X-Proofpoint-GUID: hNWY-L1bhPHWE8OCmlMPmIr0T7TMHhTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDExMSBTYWx0ZWRfX7PyWufvmlVmW
 qJbaUpS18+ZG9WlgGIMINwJuCfxPQ6zs8wlzB6B2WCs7Vz4Spq2fz1xSSsL/tccYirj3mVMPT3J
 iCix/Lhchkzj/yOeu4q4F/UBWdzPaEvx6kNq5dDDTpYXWeLO6nVjQCUWLPQpxT1iorSpwwIfo04
 QNxbfsMDpPhy0yjBw8iepyWZkPC7BzQoojczkGMSD4QhUqipzmv6tMkEJn44xkHDa1dplh190/f
 BZYeL5MULxL41LoLZNyKQCaEe25K766aeFUwxNA5GKRUMA4udunuMF0B+nesPIFgGSiG3PRoKFn
 fEJwqSY6Qc8aGLEGASkDqBNBa0ks2CHf88z0e9GgKAvyOUQXMKHE+a+msE4im3jS7AUef7Tf/4A
 XvkHQjtaZuL55IqDq9E//EVzg8h6VvVPg3m50jSqPa0HpA4HBeK3XxeB9U4kCEiVf/YCQuNL
X-Proofpoint-ORIG-GUID: hNWY-L1bhPHWE8OCmlMPmIr0T7TMHhTe
X-Authority-Analysis: v=2.4 cv=FIobx/os c=1 sm=1 tr=0 ts=68910536 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=v5Xu6_3S6vMue248_I4A:9
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

Currently, when an RPC connection times out during the connect phase,
the task is retried by placing it back on the pending queue and waiting
again. In some cases, the timeout occurs because TCP is unable to send
the SYN packet. This situation most often arises on bare metal systems
at boot time, when the NFS mount is attempted while the network link
appears to be up but is not yet stable.

This patch addresses the issue by updating call_connect_status to destroy
the transport on ETIMEDOUT error before retrying the connection. This
ensures that subsequent connection attempts use a fresh transport,
reducing the likelihood of repeated failures due to lingering network
issues.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 21426c3049d3..701b742750c5 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2215,6 +2215,7 @@ call_connect_status(struct rpc_task *task)
 	case -EHOSTUNREACH:
 	case -EPIPE:
 	case -EPROTO:
+	case -ETIMEDOUT:
 		xprt_conditional_disconnect(task->tk_rqstp->rq_xprt,
 					    task->tk_rqstp->rq_connect_cookie);
 		if (RPC_IS_SOFTCONN(task))
@@ -2225,7 +2226,6 @@ call_connect_status(struct rpc_task *task)
 	case -EADDRINUSE:
 	case -ENOTCONN:
 	case -EAGAIN:
-	case -ETIMEDOUT:
 		if (!(task->tk_flags & RPC_TASK_NO_ROUND_ROBIN) &&
 		    (task->tk_flags & RPC_TASK_MOVEABLE) &&
 		    test_bit(XPRT_REMOVE, &xprt->state)) {
-- 
2.43.5


