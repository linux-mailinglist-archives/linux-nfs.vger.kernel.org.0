Return-Path: <linux-nfs+bounces-13918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC57B38E89
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 00:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACE91C21D59
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Aug 2025 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1AD79F2;
	Wed, 27 Aug 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JjYONu57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EB28DF36
	for <linux-nfs@vger.kernel.org>; Wed, 27 Aug 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334329; cv=none; b=DwW6VyOYXh0Vc7InG0nOwtfZlPtCNHCJ15kzgZItKJVK6x738vP8p4kVbBCYWwMX6EScu81YbKeYeRy7aADD6oH7Z2tFq7tPL4gW2GoLwbsVst1rUZ6TzG2FTSQxLRV13OOJPeDyFX9ImkXSBVsqPLloiVyvUnaDcXmdOQE8tZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334329; c=relaxed/simple;
	bh=BL61Kbfg4cCtdQvrxTLprzFyCRSazg4W4TR/3Y7yh0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7BLSqJxdikw7poOWGPm+OzStsF0LmekF9eisdqL/ujwszwuFBukoMLOhyUb5S69l7+4M5vvjh9LvZ6QMUHD5AXuzclfHjVUg4SmaB9f64DnHeSlehcozewrfu9Mdt9lSbyMwv4F2S99NkG0xvrl03C6l3YgA7mNDOJxoZB6UF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JjYONu57; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLH7xr022753;
	Wed, 27 Aug 2025 22:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2+qAeFKCY1NcGOmHx4uOd52fekwnQ
	wZPxnjWYRzSygQ=; b=JjYONu57+jC1us5pca94iT2fAdCFyXk2WiKOtjlWMArg9
	tip/L2GsX2rYgVJQPoeD66Ui8n3w/GA/5FNQN+I5VTp7gFCwiQw3IRUG9splskXX
	z4D3/I9WrEm5VJXklcnIbVX2a07wYssvNFayJhdwLujllOTkQN6s/l9maZyql6xX
	CbYBcECvnmUGwZz1w0Pr8Yp18CEcTYGgMn0lwSrGx9ux8zVUnP/7t9QLX+/lxGZD
	F43p9+YGs8aQoanIdayxUBMU4BbtFSbHVEXXVRpuf0R5t18nHd/q3pCBvSaZdVgN
	FtJ1RPQ8TzkiFeV4xV3ibxI4HogYRtJYGFKBp7ZYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twe65q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 22:38:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RKITnc005065;
	Wed, 27 Aug 2025 22:38:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bavsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 22:38:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57RMchjV004445;
	Wed, 27 Aug 2025 22:38:43 GMT
Received: from vm-ol9.uk.oracle.com (dhcp-10-154-28-135.vpn.oracle.com [10.154.28.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48q43bavs5-1;
	Wed, 27 Aug 2025 22:38:43 +0000
From: Calum Mackay <calum.mackay@oracle.com>
To: trondmy@hammerspace.com, anna.schumaker@oracle.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: hold RPC client while gss_auth has a link to it
Date: Wed, 27 Aug 2025 23:38:17 +0100
Message-ID: <20250827223831.47513-1-calum.mackay@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270193
X-Proofpoint-ORIG-GUID: 0y1DAWGXd-D0gQiGUg0OUAgyHRwf7Fzm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX8vfUEumg7zUq
 9rsIhMLGw+CMEPVomth10UmQvEC91nqhxyLk4uy/U69hSe2iWDTJEYZjRfl7RHRD13fAXdELsIo
 +hz5Tt2uZ0VpJzF0BxPKuTO7pbWbaEJXR0py4g6Nhdr+e3nosF/kEUJI6nn5xh34PF7b6VhLxWy
 +L9hsJHQPfqkzaDBxTKKlKWsvn2bl+9zLUdOCp2VZFbGWucSA+iknuvz+JBwC9S+zANyH7/xiXN
 gBjnZ9GVNCd45PZz0vI5Ptr8ECVy08seTU1i7z8//b+c5jqaGdB2QTDdEvX7TSS9YuXX7XkhENr
 0tj0da3+2bAUa0V9uSuA3vIBXKJbEhHBUwcnM0qCQOY+LYDgYOuhOSuLVzSJL1GpNLOK7BhE0Ia
 +a/MKrMt
X-Proofpoint-GUID: 0y1DAWGXd-D0gQiGUg0OUAgyHRwf7Fzm
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68af88f4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=W1O9EEx6ZZkb28rqH8IA:9

We have seen crashes where the RPC client has been freed, while a gss_auth
still has a pointer to it. Subsequently, GSS attempts to send a NULL call,
resulting in a use-after-free in xprt_iter_get_next.

Fix that by having GSS take a reference on the RPC client, in
gss_create_new, and release it in gss_free.

The crashes we've seen have been on a v5.4-based kernel. They are not
reproducible on demand, happening once every few months under heavy load.

The crashing thread is an rpc_async_release worker:

xprt_iter_ops (net/sunrpc/xprtmultipath.c:184:43)
xprt_iter_get_next (net/sunrpc/xprtmultipath.c:527:35)
rpc_task_get_next_xprt (net/sunrpc/clnt.c:1062:9)
rpc_task_set_transport (net/sunrpc/clnt.c:1073:19)
rpc_task_set_transport (net/sunrpc/clnt.c:1066:6)
rpc_task_set_client (net/sunrpc/clnt.c:1081:3)
rpc_run_task (net/sunrpc/clnt.c:1133:2)
rpc_call_null_helper (net/sunrpc/clnt.c:2766:9)
rpc_call_null (net/sunrpc/clnt.c:2771:9)
gss_send_destroy_context (net/sunrpc/auth_gss/auth_gss.c:1274:10)
gss_destroy_cred (net/sunrpc/auth_gss/auth_gss.c:1341:3)
put_rpccred (net/sunrpc/auth.c:758:2)
put_rpccred (net/sunrpc/auth.c:733:1)
__put_nfs_open_context (fs/nfs/inode.c:1010:2)
put_nfs_open_context (fs/nfs/inode.c:1017:2)
nfs_pgio_data_destroy (fs/nfs/pagelist.c:562:3)
nfs_pgio_header_free (fs/nfs/pagelist.c:573:2)
nfs_read_completion (fs/nfs/read.c:200:2)
nfs_pgio_release (fs/nfs/pagelist.c:699:2)
rpc_release_calldata (net/sunrpc/sched.c:890:3)
rpc_free_task (net/sunrpc/sched.c:1171:2)
rpc_async_release (net/sunrpc/sched.c:1183:2)
process_one_work (kernel/workqueue.c:2295:2)
worker_thread (kernel/workqueue.c:2448:4)
kthread (kernel/kthread.c:296:9)
ret_from_fork+0x2b/0x36 (arch/x86/entry/entry_64.S:358)

Immediately before __put_nfs_open_context calls put_rpccred, above,
it calls nfs_sb_deactive, which frees the RPC client:

rpc_free_client+189 [sunrpc]
rpc_release_client+98 [sunrpc]
rpc_shutdown_client+98 [sunrpc]
nfs_free_client+123 [nfs]
nfs_put_client+217 [nfs]
nfs_free_server+81 [nfs]
nfs_kill_super+49 [nfs]
deactivate_locked_super+58
deactivate_super+89
nfs_sb_deactive+36 [nfs]

After the RPC client is freed here, __put_nfs_open_context calls
put_rpccred, which wants to destroy the cred, since its refcnt is now
zero. Since the cred is not marked as UPTODATE, gss_send_destroy_context
needs to send a NULL call to the server, to get it to release all state
for this context.  For this NULL call, we need an RPC client with an
associated xprt; whilst looking for one, we trip over the freed xpi,
that we freed earlier from nfs_sb_deactive.

Ensuring that the RPC client refcnt is incremented whilst gss_auth has a
pointer to it would ensure that the client can't be freed until gss_auth
has been freed.

Whilst the above occurred on a v5.4 kernel, I don't see anything obvious
that would stop this happening to current code.

Cc: stable@vger.kernel.org
Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5c095cb8cb20..8c2cc92c6cd6 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1026,6 +1026,13 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 
 	if (!try_module_get(THIS_MODULE))
 		return ERR_PTR(err);
+
+	/*
+	 * Make sure the RPC client can't be freed while gss_auth has
+	 * a link to it
+	 */
+	refcount_inc(&clnt->cl_count);
+
 	if (!(gss_auth = kmalloc(sizeof(*gss_auth), GFP_KERNEL)))
 		goto out_dec;
 	INIT_HLIST_NODE(&gss_auth->hash);
@@ -1098,6 +1105,8 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 	kfree(gss_auth->target_name);
 	kfree(gss_auth);
 out_dec:
+	if (refcount_dec_and_test(&clnt->cl_count))
+		rpc_free_client(clnt);
 	module_put(THIS_MODULE);
 	trace_rpcgss_createauth(flavor, err);
 	return ERR_PTR(err);
@@ -1106,13 +1115,18 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 static void
 gss_free(struct gss_auth *gss_auth)
 {
+	struct rpc_clnt *clnt = gss_auth->client;
+
 	gss_pipe_free(gss_auth->gss_pipe[0]);
 	gss_pipe_free(gss_auth->gss_pipe[1]);
 	gss_mech_put(gss_auth->mech);
 	put_net_track(gss_auth->net, &gss_auth->ns_tracker);
 	kfree(gss_auth->target_name);
-
 	kfree(gss_auth);
+
+	if (clnt != NULL && refcount_dec_and_test(&clnt->cl_count))
+		rpc_free_client(clnt);
+
 	module_put(THIS_MODULE);
 }
 
-- 
2.47.3


