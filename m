Return-Path: <linux-nfs+bounces-10186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E585A3AAE2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B21D1716BD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FF1D63C2;
	Tue, 18 Feb 2025 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuSVORij"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF11D61B7;
	Tue, 18 Feb 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914152; cv=none; b=TzC2Ql7qJ2kSYnHZpXcJpjAJXUGNeHYcqk+R/w2t9Bktj6GbavJwONsx1nGUTKxFLsrIIo9BNV9bvufSJIL6s1O3QoY7kznlWzJVKE5d/l7YwlvCBtE+mayWyV1yFuXOtsgYzAJDm9gOvZEo6B0CwvmhrtXe0h8n06QfxQp3XE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914152; c=relaxed/simple;
	bh=ReRXsXNJmQD4dXv+Zb3a5U4yhOcrKkTYpzeFoSc49Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HweIcjcYMCfNR1Yd5rH/vlEx5cu0ZIs0sN4+gYzeTjfUbt7jS+0Fr/Kua92Hvowbpza1Fpi1/HLuPlg6TpMAEAXwexmVJ0Rne3er43HvdGIiUNf/9TDYVZ+dEn+OOoZXfcXR2yqboDW2s0we4gjbV/hQncRfQFOKgVrtgBNAdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuSVORij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2C1C4CEEC;
	Tue, 18 Feb 2025 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914151;
	bh=ReRXsXNJmQD4dXv+Zb3a5U4yhOcrKkTYpzeFoSc49Vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cuSVORijZAhgbhkBYvcJsGGxPe5gKfXjkIC8tSsb+d/2zJJU24S4zpHfUbaOqx301
	 mKHGxk2e1a8R7RlnZXnDDngWOu59DcWdM9j1qXzWfYo3gRa5YahGFEXy1l35A2D+7J
	 CbSsmUctdsHGRHBpNjtlzeqf8NpC/OQJWGAjL3ecy9nUVYkjNQeKLZ1yXv7MpDY/Zx
	 dbSME4zrdZpcO/X+V1dwB5i3LSWpL04U/mVDwkeuR/pJV+rcg+pioSJmTxl/WKRRoG
	 h0li/fqgGhksxZ4T6TNU9Tzr2KuxeVdwGWa/fxnMdmXVPg+bQczuLxbwOHoBV9F24L
	 2XDYaxb+FBjHA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 18 Feb 2025 16:28:59 -0500
Subject: [PATCH 3/3] nfsd: move cb_need_restart flag into cb_flags
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-nfsd-callback-v1-3-14f966967dd8@kernel.org>
References: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
In-Reply-To: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3096; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ReRXsXNJmQD4dXv+Zb3a5U4yhOcrKkTYpzeFoSc49Vc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBntPujiwG8OGwdxHvjObLQUjESPO9LVn8dpGxKB
 erNetxdOr6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7T7owAKCRAADmhBGVaC
 FV8BEADHPWIp2iI6ajMePfbpbfMQKcPCClow4ru/Chv29zXJt5nTYkavEVWcULdoJOyUNX8gEhr
 sXvdxyNPnzo3/eIHwQp0H5p3aPuh0p7KtO1YHIiiQIlyNDNnSlj4ZdvhMbElYbUVR3i85g3y7a3
 C9KSzoYQH0ycZXjwxb5qKICr31kaIRnTrzgkfiU79kkot1rf9cLe84j/4ixgkrPTzTsoa+lfW/9
 0wmY3yfWBjnBIOL7JfphU+R1vZz8yec60Z1GlwNl7lHKgwltUbSnIDG340w4mRsiyOUT0QhPFl6
 pOChmBxFhR4zIuqRQVe5f5k3SXwH3kjltIQeRWncZN2gbItOA3xDo+WK/Lnpglh0ZF/ViEdzYuc
 WvWsAQEAbzo0vaqcQ3QGTu0YXqAGm8Pl9gk6E+/jlyCE/xnjHDCmxNCMlL8AgPfguVAT8f8xP5W
 HDzBmHfIaPBeHwRQBsuPMOBN++KXTZVxfNwtyyp5YFPhbmhZ0gH24DgYK2wdAr2KTlVKyLRmBdO
 pzxLKg1DENK/TOX4nolqUjxUxRh4o4jcKEY/6n4VtH+IdBvKUf9LEdayfCTP46AUulZU7cyW/bZ
 AN+wVMsivyPu3h6cEfLpRw8HX8/tzRv18600DFGDFjCYU3eKhWA0LjFUZLBgbyssIp7sA9s+wsj
 jLIfz4dXY3cHteg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Since there is now a cb_flags word, use a new NFSD4_CALLBACK_RESTART
flag in that instead of a separate boolean.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 10 ++++------
 fs/nfsd/state.h        |  2 +-
 fs/nfsd/trace.h        |  2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1f26c811e5f73c2e745ee68d0b6e668d1dd7c704..0b94fccbabb49097e23881ab170d38e0eeef90e2 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1071,7 +1071,7 @@ static void nfsd4_requeue_cb(struct rpc_task *task, struct nfsd4_callback *cb)
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;
-		cb->cb_need_restart = true;
+		set_bit(NFSD4_CALLBACK_RESTART, &cb->cb_flags);
 	}
 }
 
@@ -1475,7 +1475,7 @@ static void nfsd4_cb_release(void *calldata)
 
 	trace_nfsd_cb_rpc_release(cb->cb_clp);
 
-	if (cb->cb_need_restart)
+	if (test_bit(NFSD4_CALLBACK_RESTART, &cb->cb_flags))
 		nfsd4_queue_cb(cb);
 	else
 		nfsd41_destroy_cb(cb);
@@ -1614,12 +1614,11 @@ nfsd4_run_cb_work(struct work_struct *work)
 		return;
 	}
 
-	if (cb->cb_need_restart) {
-		cb->cb_need_restart = false;
-	} else {
+	if (!test_and_clear_bit(NFSD4_CALLBACK_RESTART, &cb->cb_flags)) {
 		if (cb->cb_ops && cb->cb_ops->prepare)
 			cb->cb_ops->prepare(cb);
 	}
+
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
 	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
 	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
@@ -1637,7 +1636,6 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
-	cb->cb_need_restart = false;
 	cb->cb_held_slot = -1;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index d1a8f074885aa6576843baf46de3a55de530d8d9..f75b77dceb47c0b3795df9dbf9131b8c0ce4525f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -68,13 +68,13 @@ struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
 #define NFSD4_CALLBACK_RUNNING	BIT(0)
+#define NFSD4_CALLBACK_RESTART	BIT(1)
 	unsigned long cb_flags;
 	const struct nfsd4_callback_ops *cb_ops;
 	struct work_struct cb_work;
 	int cb_seq_status;
 	int cb_status;
 	int cb_held_slot;
-	bool cb_need_restart;
 };
 
 struct nfsd4_callback_ops {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 49bbd26ffcdb36173047569b8d4b41efdec4880b..00140556d50aab4bab8900fb1890cd920d5124c6 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1613,7 +1613,7 @@ DECLARE_EVENT_CLASS(nfsd_cb_lifetime_class,
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		__entry->cb = cb;
 		__entry->opcode = cb->cb_ops ? cb->cb_ops->opcode : _CB_NULL;
-		__entry->need_restart = cb->cb_need_restart;
+		__entry->need_restart = test_bit(NFSD4_CALLBACK_RESTART, &cb->cb_flags);
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)
 	),

-- 
2.48.1


