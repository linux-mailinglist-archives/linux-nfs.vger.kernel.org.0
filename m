Return-Path: <linux-nfs+bounces-9559-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128FA1AB57
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF61882075
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB7A1F9F68;
	Thu, 23 Jan 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5ks7UsZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731031F9EB0;
	Thu, 23 Jan 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663949; cv=none; b=U7c94jpuu0mdK5ch6FqZ7A7bE9iCFIg9977frjy0p7ZghVwnN1oCfVIz+CVoRMvCrdF8HJzWQdHsCrM4+GV2hUyOD9XG7z0hPpjOYkYSstsQs/Hdh6J8m6zIE83YT5mRYmas+/QxvLMDfdn46a4EQGyZVvsJNV+S+KFp/wnLPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663949; c=relaxed/simple;
	bh=Qnukw/y6SmhC6BP978MjrTw53VXu6P0IVIZTvDDS2dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duk6h96A2xCKxY1ZTfdXZPO1mslIy7CYQP1Ed5ops6appw5pTpu4a9xwwdM7KLiLsxwRzyCMWtcmiyNGjYxljOjNcwubX/yICCTyFYIgCfdQjc4nqRRnvC+5zHsU0OGxeRYHikpY5OBBdJO7sRFDurrIoDx1xVdCTwgKpHeblTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5ks7UsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2F8C4CED3;
	Thu, 23 Jan 2025 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663948;
	bh=Qnukw/y6SmhC6BP978MjrTw53VXu6P0IVIZTvDDS2dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t5ks7UsZ19jOQIdn9Q2LnJqeNS7Ip0Jt878uSDGo6ykQbpu4CqaqHocW2eeO9nvM8
	 nUBZawOKTMrO2n6OMTHGmE+FpoxwlWz3/qHzo3Tzsd47tIPxynRtXog7FpEBjtWgLy
	 fe8y8cNQ0jKB23Yk6/hy8uYCFeDbr2qn0HFfqYJybu6ZWuLP8AIOZRWUCe+8gY7QOa
	 NX1sldoZ9yY5IuVTMuzIxhbYT/tjKtytXOiBdJtnaWaEOdguK4Hb4dv7JRXg8SoNLg
	 rybBDy7nAnEAn0A5uWKtTd4Z1nuF7eHwqG7mHVKmgYNhMjUlaNuLlxkPjUR3NjLAIQ
	 Zx3VAjmrOXqBw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:25 -0500
Subject: [PATCH 8/8] sunrpc: make rpc_restart_call() and
 rpc_restart_call_prepare() void return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-8-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3777; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Qnukw/y6SmhC6BP978MjrTw53VXu6P0IVIZTvDDS2dk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW97m4QSygqMJ5dDLdJRaEWVrK06Onf+Zhd8
 tFg4whoxumJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KlvQAKCRAADmhBGVaC
 FYpQEACGlDfgXBIUvtsMSc/clx3k3QWIpZ6+GIpeGKjMEgLJDjqgU8esUFM7ZA2T5knnKR3UTIc
 UvH5dPHr/QryGH32tTqt4DrtjB7dnrL/UrV8N9mU5hAtiB8oboxN3LTAAyD0kQEc+SeIT3arhKO
 /tMd4XT17unRR4vxQjgqh+2lkmfFO+3WKiUn/SUpftKn4ZoimUJRRzAgmfjbHfzCMSRlTE262nJ
 KkBVOWroNTU2EhAga8HYIeahYarrpjzdb1KlSqhVgT2SC/PjE1pdFyKiH8+QisJeYO59SFfz1vV
 K8Ni6U44MlOunHjaRXslC6N+1f9EwSq5Jd+jcKEEDW+31zXgH7e+MykFe0gk0HPS6Fc0zq5gLHI
 UM9mAWtf26Pf4/iaVcE4syKGASWG5D9mGgBJJKeoYUO7ShlAen6Ca6xtPPO2pvlxziXQYXODD1i
 DvdL4XHN5H3nGHlOWljhAF+GqOBXQrqpPKD0s9S1uTu2ORIayuOCYvt2z0TMeWoLxpA1EaT1iwy
 NxJy6sFxNQo0xJA1m27vGRe4WA6CxCQQ6SHFhdOxTCINNtHHUxwM+dBz4XpyrK1Cdmqcv9ZqYmp
 APFt5k/RBpiDR/BCsDXIR5F3INoOn16bpktuoJUuqtiXUT4qsBPnr5yoqtpuUWObR1GT53ZsxXa
 FlMiys1e5JphwYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These functions always return 1. Make them void return and fix up the
places that check the return code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c           | 12 +++++-------
 fs/nfsd/nfs4callback.c      |  5 +----
 include/linux/sunrpc/clnt.h |  4 ++--
 net/sunrpc/clnt.c           |  7 +++----
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b45b26cebae06c5bbe932895af9a56..cda20bfeca56db1ef8c51e524d08908b93bfeba6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -968,15 +968,13 @@ static int nfs41_sequence_process(struct rpc_task *task,
 retry_new_seq:
 	++slot->seq_nr;
 retry_nowait:
-	if (rpc_restart_call_prepare(task)) {
-		nfs41_sequence_free_slot(res);
-		task->tk_status = 0;
-		ret = 0;
-	}
+	rpc_restart_call_prepare(task);
+	nfs41_sequence_free_slot(res);
+	task->tk_status = 0;
+	ret = 0;
 	goto out;
 out_retry:
-	if (!rpc_restart_call(task))
-		goto out;
+	rpc_restart_call(task);
 	rpc_delay(task, NFS4_POLL_RETRY_MAX);
 	return 0;
 }
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 415fc8aae0f47c36f00b2384805c7a996fb1feb0..fa8049d031f7dd15dfb901263ae1bf7aa2f2dd41 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1404,9 +1404,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
 		nfsd41_cb_release_slot(cb);
-		if (!rpc_restart_call(task))
-			goto out;
-
+		rpc_restart_call(task);
 		rpc_delay(task, 2 * HZ);
 		return false;
 	default:
@@ -1414,7 +1412,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-out:
 	return ret;
 need_restart:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 5321585c778fcc1fef0e0420cb481786c02a7aac..e56f15c97fa24c735090c21c51ef312bfd877cfd 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -213,8 +213,8 @@ int		rpc_call_sync(struct rpc_clnt *clnt,
 			      const struct rpc_message *msg, int flags);
 struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred,
 			       int flags);
-int		rpc_restart_call_prepare(struct rpc_task *);
-int		rpc_restart_call(struct rpc_task *);
+void		rpc_restart_call_prepare(struct rpc_task *task);
+void		rpc_restart_call(struct rpc_task *task);
 void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
 struct net *	rpc_net_ns(struct rpc_clnt *);
 size_t		rpc_max_payload(struct rpc_clnt *);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 0090162ee8c350568c91f1bcd951675ac3ae141c..3d2989120599ccee32e8827b1790d4be7d7a565a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1670,20 +1670,19 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
 }
 EXPORT_SYMBOL_GPL(rpc_force_rebind);
 
-static int
+static void
 __rpc_restart_call(struct rpc_task *task, void (*action)(struct rpc_task *))
 {
 	task->tk_status = 0;
 	task->tk_rpc_status = 0;
 	task->tk_action = action;
-	return 1;
 }
 
 /*
  * Restart an (async) RPC call. Usually called from within the
  * exit handler.
  */
-int
+void
 rpc_restart_call(struct rpc_task *task)
 {
 	return __rpc_restart_call(task, call_start);
@@ -1694,7 +1693,7 @@ EXPORT_SYMBOL_GPL(rpc_restart_call);
  * Restart an (async) RPC call from the call_prepare state.
  * Usually called from within the exit handler.
  */
-int
+void
 rpc_restart_call_prepare(struct rpc_task *task)
 {
 	if (task->tk_ops->rpc_call_prepare != NULL)

-- 
2.48.1


