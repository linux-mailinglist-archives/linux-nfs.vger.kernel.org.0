Return-Path: <linux-nfs+bounces-20885-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AS1FlQf4Wl0pQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20885-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:41:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930941310F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F76D31A9AEA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603F3E1CFA;
	Thu, 16 Apr 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFvbphuu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297CC3E0223;
	Thu, 16 Apr 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360949; cv=none; b=P/cZuu/eREE+99uAm9i0BLNOOdA/lXKr6aX5M3r1iXBZBSYnNG/scbGhRTWmzxADh3h2kAhljww+CSyRIeECzVf9D5RlG5om4oUEjtPURNGr6roTC41hFs6Tb+oUKKyXo1D/1jypj0G1bhFYp0UZoZtNBprQqdkZmo1I2Hvf6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360949; c=relaxed/simple;
	bh=XjDY8pX1SvhyeaXF/SNjQwVDaDzVuDyjzYhQHrc++bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DW07cQiomh8MQJtKFEiQC+UtPvvFs/kGNZxLXKhJQBOo47OZTHWmY94GCyHiGisWCTgULzfvl69RYZMR3J5rtznHIywSNhcDqPKphN2sxyGNa8CFdto3S1/yiXdwDiGmEA8w5aP6XnGYNMffRUCBnpVwKJcUiMYF2bLZ9SjfjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFvbphuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A837C2BCC7;
	Thu, 16 Apr 2026 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360948;
	bh=XjDY8pX1SvhyeaXF/SNjQwVDaDzVuDyjzYhQHrc++bY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rFvbphuugrUTmeW5NaQjsuTqsYXcyYj+R4tu0DQScFP2Sslyc9EVsN8u6AIdGb38f
	 Zy1zA5t/qJUeNK9uxP8mfnwWioK4E1pQNRuxgSKlsO3ysPnf35o2bPsCwu9isTzN6r
	 Ov/Db67chWOldB4C3iZ7P5WciWq6hVRdF8yg/5kwG5yKpDCmhxBGi6pzjHGKwkbIIj
	 0pqO7WItiHltON8JLrneH+umbH6TX2/TScEu5eQa6g8HiOJAA6HgZjJU4x54MwBnaZ
	 uYTrVVFmkLrkqqLfrt7SXvj0nPJG5id2n2TACJYpC5MgeTPPYItEIdWv6MwSoz5yCD
	 ABZGQK2TUJ7RA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:14 -0700
Subject: [PATCH v2 13/28] nfsd: make nfsd4_callback_ops->prepare operation
 bool return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-13-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XjDY8pX1SvhyeaXF/SNjQwVDaDzVuDyjzYhQHrc++bY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3kF8bpcIb9ib8mi4RpaLW47vGpEj3slUp3z
 6NiL5Ih9XSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5AAKCRAADmhBGVaC
 FW/HD/0U47lATdOMiIaBzFo6qn1VdzvpT7WiuRxt14N+8yBzmwFr13YMPi9pZxavAZboaxjGjiL
 k1KC5qdt8KLL19v9NAlKBIhL7iMHXzmkoY3SX4s304UGKMPBOWLhyl+xx2ZIYzKw8xJ9CyOXl+L
 T/GBrndUQTSzOnmdHAvbX+3MsnfvDbKYIMND4ZXc2eheyKKv3ODMVsZ+TeAtOGcxx15/lOimjKQ
 t2tm+euZaopF/GCG+ZxGmntaMCCx/PgS3O3KBff1ktXey5zJTGlMt0A/JDIIS0fsGbqyD+4vDSy
 lJhsKpH/t+/+3M7inbdwR0800s43S7JKLPCtCDsuxsphJixmvleKiHkUCu1XzjJSNYPy6zucKxI
 DI4uJHqTX+JqqUqIGZ2BKuFTvHu+Vor/Z9Z6rFk0ulrMt1AKVNzBtrkxkOVz5vtLZXXvpTwIszK
 lmK7yISoDUslWU4spdXTYwaNJBE0HyEoMZIXVj3Gv3TNJ5vk7fMDwc6dhqcD2bnwlwQVGyA4dYe
 NeRborp/UsPJGYJlHfeppeEF3mXJG1H29S7YWFEY9LM2UDUYeBRZ5aAVgDnBmX1Kgf6ZE8N3XR2
 Noc6VYrvEO3nEk0dmqpIX5hgsrvvqJAEUVjFHdRoXZ0yOLmUa+duJXw2YscDp23//+ydiUaANk4
 yPmUz+nSaK0qJaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20885-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0930941310F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For a CB_NOTIFY operation, we need to stop processing the callback
if an allocation fails. Change the ->prepare callback operation to
return true if processing should continue, and false otherwise.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 5 ++++-
 fs/nfsd/nfs4layouts.c  | 3 ++-
 fs/nfsd/nfs4state.c    | 6 ++++--
 fs/nfsd/state.h        | 6 +++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50827405468d..25bbf5b8814d 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1715,7 +1715,10 @@ nfsd4_run_cb_work(struct work_struct *work)
 
 	if (!test_and_clear_bit(NFSD4_CALLBACK_REQUEUE, &cb->cb_flags)) {
 		if (cb->cb_ops && cb->cb_ops->prepare)
-			cb->cb_ops->prepare(cb);
+			if (!cb->cb_ops->prepare(cb)) {
+				nfsd41_destroy_cb(cb);
+				return;
+			}
 	}
 
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index c550b83f4432..8974e3d85d75 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -654,7 +654,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	}
 }
 
-static void
+static bool
 nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_layout_stateid *ls =
@@ -663,6 +663,7 @@ nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 	mutex_lock(&ls->ls_mutex);
 	nfs4_inc_and_copy_stateid(&ls->ls_recall_sid, &ls->ls_stid);
 	mutex_unlock(&ls->ls_mutex);
+	return true;
 }
 
 static int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6adce94e9fdb..c0046fc3c1b1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -357,12 +357,13 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
 	}
 }
 
-static void
+static bool
 nfsd4_cb_notify_lock_prepare(struct nfsd4_callback *cb)
 {
 	struct nfsd4_blocked_lock	*nbl = container_of(cb,
 						struct nfsd4_blocked_lock, nbl_cb);
 	locks_delete_block(&nbl->nbl_lock);
+	return true;
 }
 
 static int
@@ -5553,7 +5554,7 @@ bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp, struct inode *inode)
 	return timeo > 0;
 }
 
-static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
+static bool nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
@@ -5574,6 +5575,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
 	spin_unlock(&nn->deleg_lock);
+	return true;
 }
 
 static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 811c148f36fc..7d2afe7dcc3e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -98,9 +98,9 @@ struct nfsd4_callback {
 };
 
 struct nfsd4_callback_ops {
-	void (*prepare)(struct nfsd4_callback *);
-	int (*done)(struct nfsd4_callback *, struct rpc_task *);
-	void (*release)(struct nfsd4_callback *);
+	bool (*prepare)(struct nfsd4_callback *cb);
+	int (*done)(struct nfsd4_callback *cb, struct rpc_task *task);
+	void (*release)(struct nfsd4_callback *cb);
 	uint32_t opcode;
 };
 

-- 
2.53.0


