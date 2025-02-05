Return-Path: <linux-nfs+bounces-9878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0119BA28D64
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8442C3AA2C7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308641547F3;
	Wed,  5 Feb 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeTECVX7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA31514EE;
	Wed,  5 Feb 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763936; cv=none; b=FXwrclEU6hxwt6VOgj3qk5WmQ5ZE5CFelnuW+HAbo5NU4JyZK0qALg7WZrMHwcKT04tkViGeg+WuYjNLHbjp3QxKwwwUs0Wzvk7VxrVGIoIrSjI5jUmJ14NQBygqk/YyC+LjagHyoEWD0Lann8oNLo1upo4IQF+Eani5+K79z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763936; c=relaxed/simple;
	bh=nP2k8nWYeVcsHZzQn7j6eBKTfNrH/wJKi5bSx4FWzKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nm15SXxPW2Vz9WukrJJ380Lz6CYf8bIqorRLSaIHoJr/xnH8LD5kpK+kWRZgS/hwgWcgO0Fmpl85VjoSrnQX7eGODmdJV7b3RMMRtvjrx7aIHA+s37pgSVuTapdazMJrL20+TYGIAjxrMQM5tvsoYi5/cxEt+YhjL/LyEyTo0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeTECVX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A7C4CED1;
	Wed,  5 Feb 2025 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738763934;
	bh=nP2k8nWYeVcsHZzQn7j6eBKTfNrH/wJKi5bSx4FWzKg=;
	h=From:Date:Subject:To:Cc:From;
	b=TeTECVX7Ce9fhF0dv3nKDx9VV5QEKovCn8AL2wLetR8xO30jS4MUdpg9/24rIwAUG
	 FjZKDHAtqo4Irs7CkRHnUbiSKKw2B6oWssq+M58JvR47qi4t9sJ9ks4fC4739lm6mV
	 PaTFSHtk1IKaMDZGRLXF0U2jXZt4EhIj2ZghDq6GbVGLVnI9T1xKclzgqeWo86urT/
	 GVZ1L2RTgPE4dbLkOcJAmvRsvJmmRIHvEBKUCzhIPVJyO0JEF21CW6kdLKhB5hwfNk
	 IwUfYRfz4QC0Pgg+nDDMabElx403KmEhHxaBV4gtclbYXAhpGu8GAEQs5jXHt7JBhq
	 Xr03VZS7EvQnA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 05 Feb 2025 08:58:49 -0500
Subject: [PATCH] sunrpc: make rpc_restart_call() and
 rpc_restart_call_prepare() void return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-sunrpc-6-15-v1-1-57c723b72214@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJhuo2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNT3eLSvKKCZF0zXUNT3TRDS0sTMwMTw5S0RCWgjoKi1LTMCrBp0bG
 1tQDSAmaBXQAAAA==
X-Change-ID: 20250205-sunrpc-6-15-f19946041dfa
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3996; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nP2k8nWYeVcsHZzQn7j6eBKTfNrH/wJKi5bSx4FWzKg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBno26d6y7M7VaK2d6SMV7SGNPowX8/ww058cGgU
 GiBFtjAOmmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6NunQAKCRAADmhBGVaC
 FbEvEACviWNU7iaaNKJID9L5+iU9MFKe1eX87PKLObk7CgMQR3AVsF//29wvkrEtxS2HfPh2ZnG
 To8pdcXkhOH6434ldWglwYq/sB67WLe+T2+oUt6yVsSmk3MTzdflmxGP9B8Ps6JY9sC640OsZf1
 73/z6h9ICxkJSHDXB/XLVJ8+1B7b+ekEKVQzeREVnVm2E9mgWz4d3wOwv3ACZU4Kb2xpYvO7qft
 BAn7lYUJzE3pUn0lnP3tU8e2pmMAGPCTky4+cDikQoOSO9Uv1P0NZCxLZuYaeDqslyzu9dqCSJL
 1P1ubihWHJjJJjm52mGWguI7lH7oj+Vj4vvBnIbC55SV4O43fWQTwqFgI+3D/tinGYWWzDG42a0
 YJqvZqLvglcq5mjG2+aZklWnrqQtQapdEf27LnGD7gTRf8cpU87Y496Yh4rEmJv5FvR3XCCgK2p
 2zB+wUyQCZwQi3269wW/57dXJ3I86sYI4lFjwk1tgPdRVsZhYo1mssvfczW4+FiDidDk+L42MGo
 0D2UFhgIpu6t+5dEDyMiNRhfneCwgV1D54inhFeOLV6odP+33DVeJTpCsbIkPf2NZ6Fjf80JZ3S
 hWb38Qn7Wy+p3WraEPtv7J2y0WKUEwlpaariAF0hdsJJq25N+iFTcGf6tHtKY6Grb7kKOVHi/j9
 ImsFfN3C+9LGclQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

These functions always return 1. Make them void return and fix up the
places that check the return code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c           | 12 +++++-------
 fs/nfsd/nfs4callback.c      |  8 +++-----
 include/linux/sunrpc/clnt.h |  4 ++--
 net/sunrpc/clnt.c           |  7 +++----
 4 files changed, 13 insertions(+), 18 deletions(-)

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
index c083e539e898ba6593bc0d6185ccb8692aae6a95..b6d30111f7c85b0814ebd0821c4967574ca97e56 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1350,9 +1350,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		goto need_restart;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
-
+		rpc_restart_call(task);
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1374,8 +1372,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 out:
 	return ret;
 retry_nowait:
-	if (rpc_restart_call_prepare(task))
-		ret = false;
+	rpc_restart_call_prepare(task);
+	ret = false;
 	goto out;
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

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250205-sunrpc-6-15-f19946041dfa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


