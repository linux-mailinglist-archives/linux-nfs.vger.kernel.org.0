Return-Path: <linux-nfs+bounces-1288-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098A8386C7
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 06:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B67B230C0
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366EA525A;
	Tue, 23 Jan 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SV2mf9EY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DA5225
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988121; cv=none; b=phizXc6shKOH+QXsus9if85Vb2r8xooE+Z+7PXzFY8yOaS04wiUH33UtPk8TgU98PiJc3O//uHpuxjS1gQLdBplR/ZTAnnbqfto6mg252PF1qbLvC6naYthQaiqU+QNKUPhays5NIvdngug4D/1TqzP9qd/t6rG8P7vkOtBTcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988121; c=relaxed/simple;
	bh=5Aa+dyKO4s1UDk3GLepSSHg4GcaiPgPbHnivEhg9hpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGUJfC1AUgDH5IWKZNytSfy4cQLUCA7ukxJmtExLCamcCmDxFXNHU1QfnHasTnJg3yf9TrGyVMfVb5VlLOTqjOSohzkSxdHHPt8sqhfNKL9U8aTOADCBpdVFC+dQdm4HWibCrRRWIFSF1aIGF6VFD+Mmxr6XKLB9v5qtaIGqFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SV2mf9EY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N2TEcg001493;
	Tue, 23 Jan 2024 05:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=CdYrD1p+aqfk1fKfRLccQ7eSB1rGK5zkEy7baRGBlbQ=;
 b=SV2mf9EYAlXiipB2AcUkAOH7zMriLIlSJh+6XQzAuEMyIZVTHRJgwqiCD7by6JQl8YB+
 WgP6y/bDe6rZV53SL83QcKhSwFtEuny4/svZAIG6vBsveYLI9lWsz9feJdrDyVvfICxg
 iWQIAcjEwZal4lUW5XGAI/eferLnFrElsd2+BYaG3E4C+kXLQHT6He87eNUauRebtDem
 gtTuKpEyoUM+iQWJbT5E6o5Jczthnoro4KuBvEO01fGKdi6nAQH4ee9Pb9LgYKi3g3ax
 fXsHuEkcZqNLpVoc906f6zIUP2+JOvMnQuG9yi7Ve5W7w+ghwL5mb+N0RXxz+2a52KYa xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7n7wbv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 05:35:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N43krw013218;
	Tue, 23 Jan 2024 05:35:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3708knf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 05:35:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40N5ZBbi011717;
	Tue, 23 Jan 2024 05:35:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vs3708kmr-1;
	Tue, 23 Jan 2024 05:35:10 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: trond.myklebust@hammerspace.com, anna@kernel.org
Cc: samasth.norway.ananda@oracle.com, bcodding@redhat.com,
        linux-nfs@vger.kernel.org
Subject: [PATCH  1/1] NFSv4.1: Assign the right value for initval and retries for rpc timeout
Date: Mon, 22 Jan 2024 21:35:09 -0800
Message-ID: <20240123053509.3592653-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230038
X-Proofpoint-GUID: MCVLZdTRlYRWErReouKAGOeinLFowgs9
X-Proofpoint-ORIG-GUID: MCVLZdTRlYRWErReouKAGOeinLFowgs9

Make sure the rpc timeout was assigned with the correct value for
initial timeout and max number of retries.

Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for backchannel")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f60c93e5a25d..b969e505c7b7 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1598,10 +1598,10 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	/* Finally, send the reply synchronously */
 	if (rqstp->bc_to_initval > 0) {
 		timeout.to_initval = rqstp->bc_to_initval;
-		timeout.to_retries = rqstp->bc_to_initval;
+		timeout.to_retries = rqstp->bc_to_retries;
 	} else {
 		timeout.to_initval = req->rq_xprt->timeout->to_initval;
-		timeout.to_initval = req->rq_xprt->timeout->to_retries;
+		timeout.to_retries = req->rq_xprt->timeout->to_retries;
 	}
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req, &timeout);
-- 
2.42.0


