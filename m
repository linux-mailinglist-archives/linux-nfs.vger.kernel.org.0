Return-Path: <linux-nfs+bounces-656-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CD815216
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E0D28721F
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428A48CE8;
	Fri, 15 Dec 2023 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7/gUHEs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F74879B
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK86xU018600;
	Fri, 15 Dec 2023 21:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=FMO8+QZuPvsTjEiPng0xTvGLmJ61p5PwJT51KIIg2nI=;
 b=Z7/gUHEsad55QvHX33FCuG7p49/OycA7oBcrgVNE82hsuWoA09zNV8+JpMRHM7N9R+PU
 kw6BKml9f9JsDSiz8CTp57uS6CLoYucKefVn7GEksie18sbyQVaDXAz5qf9kGK9MK7Qo
 /F5FyILlQyUpaiLzNb5/y1sWXRr0j5S9onA8hCOy2S3G3Q8mly+V/yAodGeMIizHRpJ+
 ChYp273Xjl/pbGP7+VVw8BXuBw7kdb8E1WAyVThIFj7GE1zXVvYL2yMUpOu8JU2BvPEt
 tTKKZtv7bPg31HFPdzX1bWuGBC2rqEhq2xge/szG1rfQ7whf6HmEl6fJbj4+01EhoWG2 uA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrvsgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFK43Dc029861;
	Fri, 15 Dec 2023 21:47:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepchqng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 21:47:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFLlSH2022773;
	Fri, 15 Dec 2023 21:47:29 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepchqn0-2;
	Fri, 15 Dec 2023 21:47:29 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nfs@stwm.de
Subject: [PATCH 1/3 v2] SUNRPC: remove printk when back channel request not found
Date: Fri, 15 Dec 2023 13:47:15 -0800
Message-Id: <1702676837-31320-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
References: <1702676837-31320-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150152
X-Proofpoint-GUID: oTOCS_UMH5XW1xZsPD67KVsPd9pOwGNE
X-Proofpoint-ORIG-GUID: oTOCS_UMH5XW1xZsPD67KVsPd9pOwGNE
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

If the client interface is down, or there is a network partition between
the client and server, that prevents the callback request to reach the
client TCP on the server will keep re-transmitting the callback for about
~9 minutes before giving up and closes the connection.

If the connection between the client and the server is re-established
before the connection is closed and after the callback timed out (9 secs)
then the re-transmitted callback request will arrive at the client. When
the server receives the reply of the callback, receive_cb_reply prints the
"Got unrecognized reply..." message in the system log since the callback
request was already removed from the server xprt's recv_queue.

Even though this scenario has no effect on the server operation, a
malicious client can take advantage of this behavior and send thousand
of callback replies with random XIDs to fill up the server's system log.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 net/sunrpc/svcsock.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 998687421fa6..3e89dc0afbef 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1060,7 +1060,7 @@ static int receive_cb_reply(struct svc_sock *svsk, struct svc_rqst *rqstp)
 	spin_lock(&bc_xprt->queue_lock);
 	req = xprt_lookup_rqst(bc_xprt, xid);
 	if (!req)
-		goto unlock_notfound;
+		goto unlock_eagain;
 
 	memcpy(&req->rq_private_buf, &req->rq_rcv_buf, sizeof(struct xdr_buf));
 	/*
@@ -1077,12 +1077,6 @@ static int receive_cb_reply(struct svc_sock *svsk, struct svc_rqst *rqstp)
 	rqstp->rq_arg.len = 0;
 	spin_unlock(&bc_xprt->queue_lock);
 	return 0;
-unlock_notfound:
-	printk(KERN_NOTICE
-		"%s: Got unrecognized reply: "
-		"calldir 0x%x xpt_bc_xprt %p xid %08x\n",
-		__func__, ntohl(calldir),
-		bc_xprt, ntohl(xid));
 unlock_eagain:
 	spin_unlock(&bc_xprt->queue_lock);
 	return -EAGAIN;
-- 
2.39.3


