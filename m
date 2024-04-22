Return-Path: <linux-nfs+bounces-2920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906948AD6AC
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 23:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48541283A62
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50331D539;
	Mon, 22 Apr 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PkQiDeX+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AD1CD02
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821496; cv=none; b=t1KExqQiOq0OfRiHK+KYZ+62fk6IsQpKc2lIZi+w3flHQ/RgLd2gYrtJawOovVps2g+vx6Pt7biFtbl51HU++Cmoyhcuc9+YoZHRi7A425y/AVnl+qZKxNirKmHgWfYwvqXSvFgPeFM+Qu1SVAThEregLnFCmRl3o8cenGr8Mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821496; c=relaxed/simple;
	bh=EEpN2IVPeRGDsVdmNTqhTaKeC+LFSoCabTpuJjAzso8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LUpipSRjZeT9BMtEXhHajsvcWK1H+IA2nPRf/BjS5T+uBadprQgqbS10XICe80oEWDhGlp5ELHVcoLL9FzIdcsb9IXOeqH1/ZQamaxGIHA973Q2oEujOu6OvvdfUANVHXTEkNfb+HkeTh1EEwnetGTii22AKDYx4TmzM2v2l4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PkQiDeX+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnYDP014570;
	Mon, 22 Apr 2024 21:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Y6IXh1fGe9oBDPKPRIDJs5XLFAYSZhQ5kGSQx2V4JkU=;
 b=PkQiDeX+GN+kzE+7xN3KKVAnKJ8S7utgliD9VKY7lny1u+/TLW7/nP8PotLahafDwEvJ
 MGKJ2enzvsUQRxW4OV1QUY9FkipM8Bpoojbv2+ZA7gi7VdGEwhTKt4uOVU3En1fXFHRb
 6zpRe3QF6v8/vrYWC8TH2HSFlfSCFymdWmN9WNWXwYPv4/6CIRzJAPUko9UOHR73aYal
 wvp0/0K9HMKtrOxLPJYKutiP0aJm74R2z503nL59weMlYK0ynRz5QYZiQdQN24bbI7pR
 IgUvS51Fn6QZ+YBaIdNr7ZyLrlJ/hrpJUXp2B6/XXKf+O0u1ArP2IOyFp5h6Rqv19Olw JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vbpfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 21:31:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MKQdKl035034;
	Mon, 22 Apr 2024 21:31:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456981m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 21:31:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MLUw1R008733;
	Mon, 22 Apr 2024 21:31:30 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456980c-4;
	Mon, 22 Apr 2024 21:31:30 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSD: drop TCP connections when NFSv4 client enters courtesy state
Date: Mon, 22 Apr 2024 14:31:15 -0700
Message-Id: <1713821475-21474-4-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713821475-21474-1-git-send-email-dai.ngo@oracle.com>
References: <1713821475-21474-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_15,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220090
X-Proofpoint-GUID: iDnvM26bYnEx2WhJ01YMVEyA5Ee2sf2n
X-Proofpoint-ORIG-GUID: iDnvM26bYnEx2WhJ01YMVEyA5Ee2sf2n
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

When a v4.0 client enters courtesy state all its v4 states remain valid
and its fore and back channel TCP connection remained in ESTABLISHED
state until the TCP keep-alive mechanism timed out and shuts down the
back channel connection. The fore channel connection remains in ESTABLISHED
state between 6 - 12 minutes before the NFSv4 server's 6-minute idle timer
(svc_age_temp_xprts) shuts down the idle connection.

Since NFSv4.1 mount uses the same TCP connection for both fore and back
channel connection there is no TCP keep-alive packet sent from the server
to the client. The server's idle timer does not shutdown an idle v4.1
connection since the svc_xprt->xpt_ref is more than 1:  1 for sv_tempsocks
list, one for the session's nfsd4_conn and 1 for the back channel.

To conserve system resources in large configuration where there are lots
of idle clients, this patch drops the fore and back channel connection
of NFSv4 client as soon as it enters the courtesy state. The fore and back
channel connections are automatically re-established when the courtesy
client reconnects.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 26 +++++++++++++++++++++++++-
 fs/nfsd/state.h     |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..bafd3f664ff3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6369,6 +6369,22 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
 	return false;
 }
 
+static void nfsd4_drop_conns(struct nfsd_net *nn, struct nfs4_client *clp)
+{
+	struct svc_xprt *xprt;
+
+	/* stop requeueing callback in nfsd4_run_cb_work */
+	nfsd4_kill_callback(clp);
+
+	spin_lock_bh(&nn->nfsd_serv->sv_lock);
+	list_for_each_entry(xprt, &nn->nfsd_serv->sv_tempsocks, xpt_list) {
+		if (rpc_cmp_addr((struct sockaddr *)&clp->cl_addr,
+				(struct sockaddr *)&xprt->xpt_remote))
+			svc_xprt_deferred_close(xprt);
+	}
+	spin_unlock_bh(&nn->nfsd_serv->sv_lock);
+}
+
 static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
@@ -6376,10 +6392,12 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 	unsigned int maxreap, reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	struct list_head conn_reaplist;
 
 	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
 			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
 	INIT_LIST_HEAD(reaplist);
+	INIT_LIST_HEAD(&conn_reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
@@ -6395,8 +6413,11 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 		if (!client_has_state(clp))
 			goto exp_client;
 		if (!nfs4_anylock_blockers(clp))
-			if (reapcnt >= maxreap)
+			if (reapcnt >= maxreap) {
+				if (clp->cl_cb_client)
+					list_add(&clp->cl_conn_lru, &conn_reaplist);
 				continue;
+			}
 exp_client:
 		if (!mark_client_expired_locked(clp)) {
 			list_add(&clp->cl_lru, reaplist);
@@ -6404,6 +6425,9 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 		}
 	}
 	spin_unlock(&nn->client_lock);
+
+	list_for_each_entry(clp, &conn_reaplist, cl_conn_lru)
+		nfsd4_drop_conns(nn, clp);
 }
 
 static void
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index cde05c26afd8..fe7b5bd6460b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -420,6 +420,7 @@ struct nfs4_client {
 	int			cl_cb_state;
 	struct nfsd4_callback	cl_cb_null;
 	struct nfsd4_session	*cl_cb_session;
+	struct list_head	cl_conn_lru;
 
 	/* for all client information that callback code might need: */
 	spinlock_t		cl_lock;
-- 
2.39.3


