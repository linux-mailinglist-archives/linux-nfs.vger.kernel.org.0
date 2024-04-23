Return-Path: <linux-nfs+bounces-2926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F558ADC1D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 05:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADB6B22B60
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 03:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B618049;
	Tue, 23 Apr 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MfsuSeQ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEE18032
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841971; cv=none; b=U/wzEW9zibXurPqrovbOUkKuz/d3HJ72awMkR46SwtJHODKnCA5+GkLegUi97aMrGVtHGBy7y3BDYcNmiWVFfPujvpMPdRmOs9JvBpFh1mpLdjteqEMaOyLi+WoOYmDlZ09h5q89klDG3EK7hQtrpp4KiOByPHL/330jxMI+bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841971; c=relaxed/simple;
	bh=XNYy8pHv+uAZYBhBjvEdvnQDVSnnNCcRz71hXeAoK64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lO05e979HzzzYhq4Q0J4hrscbZZVTDQDMM55peESif2tPeUWhkkOmZHo0353RVT+ckxhPgaqyBLMX2+ByVD3k1Bbc9IlxnqpP277hGI7PpTUKxvmnfmaoxwvQFbg+ipX+nJTTCvAJhKeVn32z6jVNsGxjqt6nfw1HApgH/LWsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MfsuSeQ8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnYQJ014574;
	Tue, 23 Apr 2024 03:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=bk52FxRYgHkhu6xrRwYC9Myf14j0v5s4Q9mU66bRe/s=;
 b=MfsuSeQ87fUCOszH3AOchEKshA7/4OfvhFcFjT9ImqJiknAXcwSAaju80OdTEXZceSP4
 x7La2CXoTy1hb6YXy/p4LS2fh2uvNMroqNeTEcdGRrr1nNuuHO7nVid9neZh59bMK6lU
 G5yvfaY026CM2+3OJnQyubcr6cM+s/hVwKBHeK6cKnOnBIKikzwp9/ieqPYJYtJzuBTX
 pCDDkXNO9075kkVgTLa6w40dRti+kSGwi0Nkt0o60h/YZeywDkefyVBeAcZeMmW2tcYB
 GubZNc1V6udcywtt3KcPzoolSdoIsu9sAeQHuC+wpAyVJfMiq7+adwP6XnAytqYo9Gn+ YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vc1pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MNuqPS000681;
	Tue, 23 Apr 2024 03:12:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456j423-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N3CjTl016779;
	Tue, 23 Apr 2024 03:12:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456j41v-2;
	Tue, 23 Apr 2024 03:12:45 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] NFSD: mark cl_cb_state as NFSD4_CB_DOWN if cl_cb_client is NULL
Date: Mon, 22 Apr 2024 20:12:31 -0700
Message-Id: <1713841953-19594-2-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-GUID: nC6HUwWZHMA9Pi7SoSB_VLcNWMXqwIVo
X-Proofpoint-ORIG-GUID: nC6HUwWZHMA9Pi7SoSB_VLcNWMXqwIVo
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

In nfsd4_run_cb_work if the rpc_clnt for the back channel is no longer
exists, the callback state in nfs4_client should be marked as NFSD4_CB_DOWN
so the server can notify the client to establish a new back channel
connection.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4callback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index cf87ace7a1b0..f8bb5ff2e9ac 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1491,9 +1491,14 @@ nfsd4_run_cb_work(struct work_struct *work)
 
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
-		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
+		if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 			nfsd41_destroy_cb(cb);
-		else {
+			clear_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags);
+
+			/* let client knows BC is down when it reconnects */
+			clear_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
+			nfsd4_mark_cb_down(clp);
+		} else {
 			/*
 			 * XXX: Ideally, we could wait for the client to
 			 *	reconnect, but I haven't figured out how
-- 
2.39.3


