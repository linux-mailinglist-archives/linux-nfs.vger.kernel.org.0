Return-Path: <linux-nfs+bounces-9775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2224A226DE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16230188764F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9C1E9B16;
	Wed, 29 Jan 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDz1mBkE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393E1E9B0C;
	Wed, 29 Jan 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192860; cv=none; b=pJA5qUjcxQxqlsmvE6JeHQpB/TBH6mgS7JCj4ijgUZzfrSpvNwsCRlRk9hT6qGw6ay/o2hUTnI4zjV2zoot5Yh6bD+xdJogZt562yuHYrC0XIP7d7NsI3lbXGie4zQ9r7PU2WucGn+Y6lKYm3MFalu6sPcYR3VM9kknENDYVu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192860; c=relaxed/simple;
	bh=SrBrOxdAiSSWt1qo1usHtLL4Asei1ZG+/Lci0b5nwTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jl49mvusyOmjJgWCCcpFKPXM5K6KATfKLT7u+1QQOFlsgUNtZc/GzbJjEuTpT1s3DqcfY/F8ZY0bXHV3TYYNhnIOEbE+QTNWFy19KUYrwk0vtUJnSR/PQEHe4Zb8A0WpJsh3jpoPPLS/zKFC+9m0eRXLREfNSDw4yjljAETUJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDz1mBkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E95C4CEE0;
	Wed, 29 Jan 2025 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192859;
	bh=SrBrOxdAiSSWt1qo1usHtLL4Asei1ZG+/Lci0b5nwTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SDz1mBkEdjN8LJnc518/r3Y4zbtqBJbQZuZv58YnDlG7985kNEpg2AG6DsxYGnScH
	 YfMQyyKUraESCFdoUSjutGce9MS0m77v6l5tEQICPI9z9tm/9BlJXuomzYDgTp5j0u
	 wxM1f1kwcxTyr4CRBhc60m98Q5q3ZgQoIuqu/7SVvvBSDYCzhpuiAEV3geBbPnQtz/
	 nvb3/Y4kpYnYd6a5GH4D3+dpewSxwm0jmpqM5CY+lv80ovOguN1r76o/x3y/1XJDe3
	 9/K9SpIMRxP+LR1xFmoBAp2RcU3DCeAkhf6sTqw76VLrRDAJmDbw7/DAp77llicIBv
	 E6mQcIsilYUWQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 18:20:46 -0500
Subject: [PATCH v3 6/6] nfsd: lift NFSv4.0 handling out of
 nfsd4_cb_sequence_done()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v3-6-506e71e39e6b@kernel.org>
References: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SrBrOxdAiSSWt1qo1usHtLL4Asei1ZG+/Lci0b5nwTQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfURknfUWccL+v4OnFGNFglYkLRu+jSZBu1p
 wPN5iqzYd2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q31AAKCRAADmhBGVaC
 FZ8SD/oCD5oHtaaQQ2OuTW5FWaDSUgPtiHyfqzIC23g9Dq0BHrMTYepPuRrTwM2BBWnD0J+CV/W
 WJpAvO60ZyLh9hSeF9sV/UMqhaDGCB/VhjiZrd8HXGuRKrnXv0ROoaGMNEc5OiCnDu7jz3ua7hv
 h7JU1xzHGx+yjTcWEnMKt/Jhe/bfI2OTm+4VZDMmxOeIvLXIiSfreKjs4LcfA86tvagW5Q/vIV2
 Wnk7ldklqW2XF7DcBG33RhVOY9kkimVn5tm11u3dDqORPR44ikgTnPKBqI5eZhVGRVzAQ+2yT/c
 wBvpj/Kcp7qNiivGE+IsLVCHg3xQnS9g+zgAiHwwtP6h0eEWa4DnyVnF1ZbNPhpi2BGto6s0BCJ
 ZtD7URMVP1t4ZifYDsXu5yf24FbAlyfKDDL9EIksyU7y/anC/n4yYQfKRpARa7vbjYMxw2Bl2O1
 VCoHZZT/rez0rz+JSruM/Lc4i0jJzbIcLRgD8C38MeqiJMJEkRFoIeIyIeDPJgVQg9ZGbPrWTse
 683oxsDzyQLigDgYkZAXF0/NT6YBEc43hOVoZAth1Kmkwa+9JwzZLRsrzZpB9nowKYY3E02sjsf
 VfvsAbPk2VAH3vcSR1VYJRjF41mdkUpyAkDjHuWJmOR6gYU95Scj5Koe5l4Bxc7le5iCxMcTFDI
 7uKFsJqu7hZG2ZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It's a bit strange to call nfsd4_cb_sequence_done() on a callback with no
CB_SEQUENCE. Lift the handling of restarting a call into a new helper,
and move the handling of NFSv4.0 into nfsd4_cb_done().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 53 ++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index c8834454bcc7b5044de42ec8622653a44dbb0812..bf7248f84913ebd9e8942195b24191e494027dbf 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1383,27 +1383,22 @@ static bool nfsd4_cb_session_changed(struct nfsd4_callback *cb)
 	return cb->cb_ses != rcu_access_pointer(cb->cb_clp->cl_cb_session);
 }
 
-static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+static void requeue_callback(struct rpc_task *task, struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
-	struct nfsd4_session *session = cb->cb_ses;
-	bool ret = false;
 
-	if (!clp->cl_minorversion) {
-		/*
-		 * If the backchannel connection was shut down while this
-		 * task was queued, we need to resubmit it after setting up
-		 * a new backchannel connection.
-		 *
-		 * Note that if we lost our callback connection permanently
-		 * the submission code will error out, so we don't need to
-		 * handle that case here.
-		 */
-		if (RPC_SIGNALLED(task))
-			goto requeue;
-
-		return true;
+	nfsd41_cb_release_slot(cb);
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		trace_nfsd_cb_restart(clp, cb);
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
 	}
+}
+
+static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
+{
+	struct nfsd4_session *session = cb->cb_ses;
+	bool ret = false;
 
 	if (cb->cb_held_slot < 0)
 		goto requeue;
@@ -1492,19 +1487,14 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 retry_nowait:
 	/*
 	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
-	 * (possibly) recreated. Restart the call completely in that case.
+	 * (possibly) recreated. Restart the whole callback in that case.
 	 */
 	if (!RPC_SIGNALLED(task)) {
 		rpc_restart_call_prepare(task);
 		return false;
 	}
 requeue:
-	nfsd41_cb_release_slot(cb);
-	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
-		trace_nfsd_cb_restart(clp, cb);
-		task->tk_status = 0;
-		cb->cb_need_restart = true;
-	}
+	requeue_callback(task, cb);
 	return false;
 }
 
@@ -1515,8 +1505,21 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 
 	trace_nfsd_cb_rpc_done(clp);
 
-	if (!nfsd4_cb_sequence_done(task, cb))
+	if (!clp->cl_minorversion) {
+		/*
+		 * If the backchannel connection was shut down while this
+		 * task was queued, we need to resubmit it after setting up
+		 * a new backchannel connection.
+		 *
+		 * Note that if we lost our callback connection permanently
+		 * the submission code will error out, so we don't need to
+		 * handle that case here.
+		 */
+		if (RPC_SIGNALLED(task))
+			requeue_callback(task, cb);
+	} else if (!nfsd4_cb_sequence_done(task, cb)) {
 		return;
+	}
 
 	if (cb->cb_status) {
 		WARN_ONCE(task->tk_status,

-- 
2.48.1


