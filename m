Return-Path: <linux-nfs+bounces-2928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E358ADC1E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 05:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0790EB22E5C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 03:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D412B95;
	Tue, 23 Apr 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J4zZE9UV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78618AEA
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841974; cv=none; b=ejEAKNfGlSCD/NSE2yL1tsgtidzXUS2ZB9f6hMyhduTUhtjI9P+fWWHraDX1gLEH9XdAxQ5rQ/MEdUXBhxSqBuilFqG68pYAVjUS/932NkrEtTZHCiaERF29ArXXHplCooujnQ6u4I9+QTkrpWdcGR9udDM3Q4l/TMG3Xmg64Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841974; c=relaxed/simple;
	bh=uP8Sm4oox1+7eFiaWyhvpapyngvEENKfoCQ98NRkui4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q446v3NwvbyY0ZX02w3LjI+4gbtCNSTqg4Si2OOWIaLoASzT6LkvfR/4J16IvX4C0acsG1bHoFUMfx9Q7v0uHN8dtuNZkPYHZmQPdnJOlKXYna92MEldgweZV5etKaVm3B7kBfaLn927GmQ6RmXz9NSZAkIfAgxddShAQGnlGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J4zZE9UV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnDjL004994;
	Tue, 23 Apr 2024 03:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=P/ZIaaLDX4qzY6jqjEyZORqbCzF+h4KbHKsXQdbppvA=;
 b=J4zZE9UVgGNwIkFLMqHsROXybHB7PtlJBe87tNufsYq0VQwJ8sMiW99EjRJfyuj3ZfM3
 sOZ5iBk3pddqOmhWzhRGg6hrRTiVrsVh4ecS2NopgZkA1Cj6dsu9cixMhgZSVq4Ys7ja
 1jQiXXG7yhqj4o2oWnZ4FIn/3vE2nmtEUWrDaaoZtloR3rI3yUUWTrO19il9u0omQgtC
 xc/BY95rU1ph4bmPTuKHEmWWetXHIIfh9BCDg7akLo6ZNPtsAMvGJd7k6Qxnglp7XZj5
 KmEc0iRKj2kiyKLFI3pQrGHwi7CjFECJ9Ms+gnl5dSQxncZTqzb5Q/XmghjEDFp//BSD sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md44ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43N122mo040616;
	Tue, 23 Apr 2024 03:12:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456j42b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:12:46 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N3CjTp016779;
	Tue, 23 Apr 2024 03:12:46 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm456j41v-4;
	Tue, 23 Apr 2024 03:12:46 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/3] NFSD: drop TCP connections when NFSv4 client enters courtesy state
Date: Mon, 22 Apr 2024 20:12:33 -0700
Message-Id: <1713841953-19594-4-git-send-email-dai.ngo@oracle.com>
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
X-Proofpoint-ORIG-GUID: FTYDd-LsA8ce2POKhtkZD6adPLUlk3M4
X-Proofpoint-GUID: FTYDd-LsA8ce2POKhtkZD6adPLUlk3M4
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
 fs/nfsd/nfs4state.c | 32 ++++++++++++++++++++++++++++++--
 fs/nfsd/state.h     |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..d9f6e7dbb2e1 100644
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
@@ -6376,10 +6392,13 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 	unsigned int maxreap, reapcnt = 0;
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	struct list_head conn_reaplist;
+	bool drop;
 
 	maxreap = (atomic_read(&nn->nfs4_client_count) >= nn->nfs4_max_clients) ?
 			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
 	INIT_LIST_HEAD(reaplist);
+	INIT_LIST_HEAD(&conn_reaplist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
@@ -6387,16 +6406,22 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			goto exp_client;
 		if (!state_expired(lt, clp->cl_time))
 			break;
+		drop = false;
 		if (!atomic_read(&clp->cl_rpc_users)) {
-			if (clp->cl_state == NFSD4_ACTIVE)
+			if (clp->cl_state == NFSD4_ACTIVE) {
 				atomic_inc(&nn->nfsd_courtesy_clients);
+				drop = true;
+			}
 			clp->cl_state = NFSD4_COURTESY;
 		}
 		if (!client_has_state(clp))
 			goto exp_client;
 		if (!nfs4_anylock_blockers(clp))
-			if (reapcnt >= maxreap)
+			if (reapcnt >= maxreap) {
+				if (drop)
+					list_add(&clp->cl_conn_lru, &conn_reaplist);
 				continue;
+			}
 exp_client:
 		if (!mark_client_expired_locked(clp)) {
 			list_add(&clp->cl_lru, reaplist);
@@ -6404,6 +6429,9 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
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


