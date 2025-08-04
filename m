Return-Path: <linux-nfs+bounces-13410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F29B1A945
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FF7A9F7F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C821B4F2C;
	Mon,  4 Aug 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EPYtk8gO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEA1CEACB
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333219; cv=none; b=o9/RJY+78eyRf8oXRO0lsePc7TDpm20BozR3nlCs920ngcs6Un4Nlp/BbxVDByN6LdPM/8N4HdJCEgaYJ9Is+rxq5njTt8QvYNFaqcB9N1tNLI/nWJWSDLVCctG3MTlAbp+y9LcN+ODYYpAxOdAJ5xPpTpcNJcGqCHhCv3vTu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333219; c=relaxed/simple;
	bh=DtG9x0/KImLxol+9hSaAJb6yxYkmTmF8Y5QaVf6hMjY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L0eUdX5bdDGW/oYHr393eHdwz6CENO0ConiCs7O4Vdh55WbRswAK8XGKJUWa8jF2cZdEox48b5Qq1rRsDl5/2P2UlkYTHGRiDyhzdRXF0AnhUle4ppD5PdNhBgbP4E7eOLWi58g0DCsNGB5fdQQHMYSWoayO78nMZleSju3YZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EPYtk8gO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6ZvS009202;
	Mon, 4 Aug 2025 18:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2025-04-25; bh=bG/Xv44Z
	/P8SzgOw9zeQsJ/9RNRwiy3u+JHRDLcoUmc=; b=EPYtk8gOXSjntxnUdgoj6Av6
	QQ7eADlRaEp79sCNLHUEMUQhy3V1tjlEZ3Nvb72C2eQdPDvyqcsGuY/PyiJ9Oc8n
	1MY0oW6/0vqzbvAiFHWAMsq4AnNcVEwi1rOQJpjuqe4RM5uRH61kUzuoad3W/YdX
	yGP5WbuUAtSTBoOST0poE7nbSSbcjfwotVemLD2hanFGssF/YhCr4CPihch3jeYI
	jP0IsctpJBDgf7Jw9xxl3M6DPYIwBPVkJZlClZIHTw78FypZfJECiM5y2XLZMjDG
	whuBSTOpZkVo8p0dTNp4xMyQRCM0+SDRs5VujLbUEGy9o8N2aktVXDRq6hHGNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489b7xk85r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 18:46:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 574I2b3c013447;
	Mon, 4 Aug 2025 18:46:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7mrsunk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 18:46:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 574Iki4F011322;
	Mon, 4 Aug 2025 18:46:44 GMT
Received: from ca-common-sca.us.oracle.com (ca-common-sca.us.oracle.com [10.132.20.202])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48a7mrsumr-1;
	Mon, 04 Aug 2025 18:46:44 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] SUNRPC: call_connect_status needs to destroy transport on ETIMEDOUT before retry
Date: Mon,  4 Aug 2025 11:46:38 -0700
Message-Id: <1754333198-62658-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040108
X-Authority-Analysis: v=2.4 cv=MdNsu4/f c=1 sm=1 tr=0 ts=68910016 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=v5Xu6_3S6vMue248_I4A:9 cc=ntf
 awl=host:13596
X-Proofpoint-ORIG-GUID: ZGN4QMmuWzG2AJeXfWzo8DMQacV-Q3mr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEwOSBTYWx0ZWRfX4XZ0hRZuQVz4
 pvSYmznegzGzdL0u5W6zkt65onDmR8vECmUEap6Rfv+SwNCtDKEn+3NFM7/8w0SHew9xAQghqcg
 Q7MT0RoI2iZc9PyDZUangWfzNlyZgccoAeq+AUaxXTIimflmUVNs3XJGHEzrE4aY41snLmPnJAm
 S+H1s/ST+T8EpDBuC5jVSiBDYUecZyeJj/Y+1i4qAoVs9Q2XmNIdlxtzog8HZyjXBJjUp9HTOz4
 t3V3Nv/7uNBzR+/wij17fKgdb2V5ebIPJVxFh2evZl1EM5UDQulQ5o4meEdaKtoM3AT4Y60fJ53
 3pY3nFiDXhy7y6CLawTKxrbfF6Rq6I37QrGKXT5itUCWOGLAEQWGbiaKHuLlVyPulzJkTQ6kPt9
 ZKc80Fz8l2H3VgzBWrUQsXSgm1SGc3CwTtydBbo1VTkONWZp0oDN/vTYwMWckYxjm68jJt4E
X-Proofpoint-GUID: ZGN4QMmuWzG2AJeXfWzo8DMQacV-Q3mr
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


