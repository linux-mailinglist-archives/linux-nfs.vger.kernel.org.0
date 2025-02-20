Return-Path: <linux-nfs+bounces-10214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF13A3E15C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D6A17FA00
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FFF2144CF;
	Thu, 20 Feb 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L15M5AtL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A165214237;
	Thu, 20 Feb 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070052; cv=none; b=NWo0ieNfz4JI/NE7j1tKbCyvMtMPrS+pZiWgFFV5fBTRdaKoKG0aUC0IYzElWt5yy61N6Yj1O8rugopw+LUZZq++UToupcNyAU01ZpbNoB5ZgrYNDDFonPttIlR+gQX4KkROGSQmQrQO+MCtfKo/huZ8c13J7SUC3kY1YeXVv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070052; c=relaxed/simple;
	bh=g5VLUIvdnQKh6dDCL6AEV2BEFOeKTlGBSLsSlyN/ZSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeetMe+vwNShvR9+eP8QXnorcxe7jftMVcvxn46EPmNcYyAaYJ6X1o2yWYF1IAzjyz3kKJgSjS+e5EbbZyIVqOAzuO2ThAPycp8DnHpMbTGtATQwNgQQE41Lb48cweVrJd9FaVjNN6t0Lz6Wy1YAhGWlqa6ADjyDc9Rgq3+bDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L15M5AtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEC9C4CED1;
	Thu, 20 Feb 2025 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070051;
	bh=g5VLUIvdnQKh6dDCL6AEV2BEFOeKTlGBSLsSlyN/ZSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L15M5AtLAWtSYujJtZVFQl0dnEOB/gMYz0iurV9xWO3/p14/cuiKygLOHFWbrgyWO
	 8foFJdonCwM4+V1X74eEU7UM90B3/9eElQp3Yk9FLCdCuy6k/jbqmJQnQ7AYAKX5Vx
	 HPBKiXq2LL4SIXiyP/0QynekvcN7gKDj9zQEEvXDBe/HQxCqs35uNHpKyiahufZKAr
	 As8JzT2rxHfgIVH4n4EXMRgi3onjg5lsoaSEKEYS1AVAfsjSyAb/ewCEUsOVj9a4Rs
	 kbY8oxht/hfKqZz84g8cKaUpwS+U9A97A5lENGc5Q9ruccJIXz8QC8IjhLXitZJgjB
	 H1dklkOxfZJqg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 20 Feb 2025 11:47:16 -0500
Subject: [PATCH v2 4/5] nfsd: move cb_need_restart flag into cb_flags
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-nfsd-callback-v2-4-6a57f46e1c3a@kernel.org>
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
In-Reply-To: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=g5VLUIvdnQKh6dDCL6AEV2BEFOeKTlGBSLsSlyN/ZSQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnt1yeATJEvgxP1v06nxL7BrouhyUSv1lBo+nUQ
 Kv8iTKFDT6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7dcngAKCRAADmhBGVaC
 FcW0EADKpBsE7Uyy3HmcwVrxvoenvpRkdzjKCe0tVb84OEa3cE9oFV4mf5keAZivpyNv6xc56TQ
 xEoN3/dDojs7MGuFOhpLwtBTybLAf8AnmO98EofJV3V/FIiPKMbjCoo64+CF1+pshU4WDpjCNdl
 Q6Bcpw0i5aXioM5p+d9W2Cz0V07ZQvDOqjsVbwGBbv/G2nNTx/iV8SC0JzygLwgqPHxJ6bspPVp
 /2t61/7xALgeJKzoWZfULAx1OZ+ERgfldw3OAw3Ot2Tv3O/dMc4p5GFlHgLp9Bt3c1HHg/uq/Kq
 pOedamL11gSIkHAADdUP2Ad1nDuLEQIoOyxYff8IOy8038CyfbYn1q89Lc2ntc5dyl7dDC8ki01
 GxRJTOknfUmIIsRdpUek15sNa0As4bPn/xuNLS2CEilBaDCtE6bzX9VDml8xg73LZc4Gx/9A+9R
 vZ/YaC7tj8vomTWBNQg+xV4LAa1RkjhJvYi238hyyHVi6OTo09DMaG+LEb27HpI6J9/teIGEX3g
 DaU33Usxr4prixy5KaPuCsG9mXwHorkURCFLWH+mSkRzECmFlBZ9nkolS8/uw1JUzImPSFmwbas
 F/S1eJtk7+iX2CjAkPXbelwXYW4FnDe/z34lTaphumiCkH6oek4ZydRyQ21MBpO7x5ljQ3ecvZJ
 K/Xf6HJcuJCn3rw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Since there is now a cb_flags word, use a new NFSD4_CALLBACK_REQUEUE
flag in that instead of a separate boolean.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 10 ++++------
 fs/nfsd/state.h        |  2 +-
 fs/nfsd/trace.h        |  2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index bb2cb0d1b7885bf5f6be39221cb3dd95518326e5..018533bb83a3ca6fda46e072eebca6d2583c393a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1071,7 +1071,7 @@ static void nfsd4_requeue_cb(struct rpc_task *task, struct nfsd4_callback *cb)
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;
-		cb->cb_need_restart = true;
+		set_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags);
 	}
 }
 
@@ -1479,7 +1479,7 @@ static void nfsd4_cb_release(void *calldata)
 
 	trace_nfsd_cb_rpc_release(cb->cb_clp);
 
-	if (cb->cb_need_restart)
+	if (test_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags))
 		nfsd4_queue_cb(cb);
 	else
 		nfsd41_destroy_cb(cb);
@@ -1618,12 +1618,11 @@ nfsd4_run_cb_work(struct work_struct *work)
 		return;
 	}
 
-	if (cb->cb_need_restart) {
-		cb->cb_need_restart = false;
-	} else {
+	if (!test_and_clear_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags)) {
 		if (cb->cb_ops && cb->cb_ops->prepare)
 			cb->cb_ops->prepare(cb);
 	}
+
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
 	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
 	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
@@ -1641,7 +1640,6 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
-	cb->cb_need_restart = false;
 	cb->cb_held_slot = -1;
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b7d6be45ad022194e90cdf8d19c2879be08143ff..bdcbee1d328a2f68da2e7c733f50f8eee5775be7 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -69,13 +69,13 @@ struct nfsd4_callback {
 	struct rpc_message cb_msg;
 #define NFSD4_CALLBACK_RUNNING	BIT(0)	// Callback is running
 #define NFSD4_CALLBACK_WAKE	BIT(1)	// must wake_bit when clearing RUNNING
+#define NFSD4_CALLBACK_REQUEUE	BIT(2)	// requeue callback instead of destroying
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
index 49bbd26ffcdb36173047569b8d4b41efdec4880b..f26a42a37f452486e9683d7778016adf923f2995 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1613,7 +1613,7 @@ DECLARE_EVENT_CLASS(nfsd_cb_lifetime_class,
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		__entry->cb = cb;
 		__entry->opcode = cb->cb_ops ? cb->cb_ops->opcode : _CB_NULL;
-		__entry->need_restart = cb->cb_need_restart;
+		__entry->need_restart = test_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags);
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)
 	),

-- 
2.48.1


