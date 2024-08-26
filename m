Return-Path: <linux-nfs+bounces-5754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E895F21A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 14:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8522841DA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CA18CC0A;
	Mon, 26 Aug 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGc9QE9S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017B18C907;
	Mon, 26 Aug 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676616; cv=none; b=oC4hruiAOWpHUKrn5MCDlBOQQqPzl3aG3nzT/7xt4Keb/Yhc+EkT1EzOWzvz9z6ra8sl4EUzM1ON2XR4pJTLOy3UPQkmz9zBWcxEfZl6peGLwMa1b4vhbDzr91kE+qVZZGiWTKuQsg3Z4bnzxa+IfUkhbXl8bVfKA79YUN4k6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676616; c=relaxed/simple;
	bh=MQR0S4IRyQKASIeLaUjbSY5DKEzIU5scNL67pkVOjw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2WCFp9rqU1CTT+2ng8neY6dVp16fUyRdpACTj0NyrydwjEvYUPgpFxzwbn8w/R0KcmlnoUzPnn29daY4BoejJDfdrGRx9+46/CMGcdziI4O7PcyEqmx6djYzFNY7SNnD/H+isBa1NRheIx22ZSAi69h2SXWji0Mm38SFMzU30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGc9QE9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E654C4FEEE;
	Mon, 26 Aug 2024 12:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676616;
	bh=MQR0S4IRyQKASIeLaUjbSY5DKEzIU5scNL67pkVOjw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UGc9QE9Shj8Qt8nDb5If7BLMGFbRAb0rfDfCmWNbOlXJTlLw8AwiUbiikGldBKsAH
	 2nXH7bm69V/y5lOZOU6EskaVqvcA6f4TGrClumwcv+3cocwvE3TCc3p12o/LXxB/Fa
	 FvSFL1TJ9O9Of3a9lSUIHS+QrcWVUxvszydDhEMB4Fytq0eFyhFp4w6fl8geeA4QWO
	 vybvJk8RQTvu/Ls0nkqia27cULIdOLDFfCSBywGqppLX8S7jsWZFF44Sa/r8UDSup8
	 aTNt/mVmUBH0i+kxh+Nz+r1sr/R6p+qtqhuggWQZiHaPLIkICA46ROKAqkg4Y/2Iv5
	 Ii8rpvEL8oznQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:50:12 -0400
Subject: [PATCH 2/3] nfsd: track the main opcode for callbacks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-nfsd-cb-v1-2-82d3a4e5913b@kernel.org>
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
In-Reply-To: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4974; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MQR0S4IRyQKASIeLaUjbSY5DKEzIU5scNL67pkVOjw4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHoFMymKvgN8Wk/PUtgebDOEWq7hp7p9WMmuA
 IOx/CQ+JeiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx6BQAKCRAADmhBGVaC
 FW1ED/91j6Sbg9mPHztH1MYax9ESJyc1+MXdUSWHeyOmg74MRwYy/KY1xphea/FV0K0To2UXtpb
 owNAcnalPyPhtrWNrBWNzna7OBU3wvAvP/N+1BtweuaqgRQLXyel0VUDmXGvrQH+dUbbtkShehT
 9xdHe14gOzivgho6JCN+u0wiOFpII3lgw+56JtR6Dp7w15ZCmptAtEokIq/+p3RKBQ6KppvDY+J
 Di5VedHF2mMDfQljJ9u+jrJjRWpslhgCt6X7wKDyduC1KNEw3mMSbwtuatEb+VhkkbyvEzayZJ1
 C3Hoqw7tb9jXmsBL5rRXaRqCvHmfqWtEjzvrEEapg6NAja4cAK86a6l8lUFo1ayIq1lnI8EjUVd
 FvpVcpuPkb1jjY4ayC/Vr8HwX+LbyIC9ww5MrZSdAOCBRUhiODMHcWM/yMjH+j6JHwnQvIzm6Fz
 behHkY5yTQ6uIqYKaApM9M4x1oJRlsb9CoCuvBrAxvmJ0un+IqHGzMFoGPSdWr0HHZ/+AkzI6u7
 5OH2YbsnUNVFlt5ttCARM1mI7ryFRyPZMWVZhMQy2gJpiTsWH0XH12/2jex06VAQ3BUAGcShLBC
 hz8uHPU8GbkZCNT+mpFhmTxXya7TC2DagV40k1g39LLtb00QbA4VcS2F7qe4VYD6m4VKWJI3h50
 WTRCbuPs4drR+1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Keep track of the "main" opcode for the callback, and display it in the
tracepoint. This makes it simpler to discern what's happening when there
is more than one callback in flight.

The one special case is the CB_NULL RPC. That's not a CB_COMPOUND
opcode, so designate the value 0 for that.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c |  1 +
 fs/nfsd/nfs4proc.c    |  3 ++-
 fs/nfsd/nfs4state.c   |  4 ++++
 fs/nfsd/state.h       |  1 +
 fs/nfsd/trace.h       | 23 +++++++++++++++++++----
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 4f3072b5979a..fbfddd3c4c94 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -740,6 +740,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_layout_ops = {
 	.prepare	= nfsd4_cb_layout_prepare,
 	.done		= nfsd4_cb_layout_done,
 	.release	= nfsd4_cb_layout_release,
+	.opcode		= OP_CB_LAYOUTRECALL,
 };
 
 static bool
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e39cf2e502a..1dac934686b1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1621,7 +1621,8 @@ static int nfsd4_cb_offload_done(struct nfsd4_callback *cb,
 
 static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
 	.release = nfsd4_cb_offload_release,
-	.done = nfsd4_cb_offload_done
+	.done = nfsd4_cb_offload_done,
+	.opcode = OP_CB_OFFLOAD,
 };
 
 static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..2843f623163d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -400,6 +400,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops = {
 	.prepare	= nfsd4_cb_notify_lock_prepare,
 	.done		= nfsd4_cb_notify_lock_done,
 	.release	= nfsd4_cb_notify_lock_release,
+	.opcode		= OP_CB_NOTIFY_LOCK,
 };
 
 /*
@@ -3083,11 +3084,13 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
 	.done		= nfsd4_cb_recall_any_done,
 	.release	= nfsd4_cb_recall_any_release,
+	.opcode		= OP_CB_RECALL_ANY,
 };
 
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 	.done		= nfsd4_cb_getattr_done,
 	.release	= nfsd4_cb_getattr_release,
+	.opcode		= OP_CB_GETATTR,
 };
 
 static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
@@ -5215,6 +5218,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 	.prepare	= nfsd4_cb_recall_prepare,
 	.done		= nfsd4_cb_recall_done,
 	.release	= nfsd4_cb_recall_release,
+	.opcode		= OP_CB_RECALL,
 };
 
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ffc217099d19..14f9df2bc1ba 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -79,6 +79,7 @@ struct nfsd4_callback_ops {
 	void (*prepare)(struct nfsd4_callback *);
 	int (*done)(struct nfsd4_callback *, struct rpc_task *);
 	void (*release)(struct nfsd4_callback *);
+	uint32_t opcode;
 };
 
 /*
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..476f278e7115 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1553,6 +1553,19 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		__entry->error)
 );
 
+/* Not a real opcode, but there is no 0 operation. */
+#define _CB_NULL	0
+
+#define show_nfsd_cb_opcode(val)					\
+	__print_symbolic(val,						\
+		{ _CB_NULL,			"CB_NULL" },		\
+		{ OP_CB_GETATTR,		"CB_GETATTR" },		\
+		{ OP_CB_RECALL,			"CB_RECALL" },		\
+		{ OP_CB_LAYOUTRECALL,		"CB_LAYOUTRECALL" },	\
+		{ OP_CB_RECALL_ANY,		"CB_RECALL_ANY" },	\
+		{ OP_CB_NOTIFY_LOCK,		"CB_NOTIFY_LOCK" },	\
+		{ OP_CB_OFFLOAD,		"CB_OFFLOAD" })
+
 DECLARE_EVENT_CLASS(nfsd_cb_lifetime_class,
 	TP_PROTO(
 		const struct nfs4_client *clp,
@@ -1563,6 +1576,7 @@ DECLARE_EVENT_CLASS(nfsd_cb_lifetime_class,
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
 		__field(const void *, cb)
+		__field(u32, opcode)
 		__field(bool, need_restart)
 		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
 	),
@@ -1570,14 +1584,15 @@ DECLARE_EVENT_CLASS(nfsd_cb_lifetime_class,
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
 		__entry->cb = cb;
+		__entry->opcode = cb->cb_ops ? cb->cb_ops->opcode : _CB_NULL;
 		__entry->need_restart = cb->cb_need_restart;
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)
 	),
-	TP_printk("addr=%pISpc client %08x:%08x cb=%p%s",
-		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
-		__entry->cb, __entry->need_restart ?
-			" (need restart)" : " (first try)"
+	TP_printk("addr=%pISpc client %08x:%08x cb=%p%s opcode=%s",
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id, __entry->cb,
+		__entry->need_restart ?  " (need restart)" : " (first try)",
+		show_nfsd_cb_opcode(__entry->opcode)
 	)
 );
 

-- 
2.46.0


