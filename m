Return-Path: <linux-nfs+bounces-21821-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KUQCeSxEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21821-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:43:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47E5B98B0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6F2301C963
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF10381AFB;
	Fri, 22 May 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkL1Xrmg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653837FF5D;
	Fri, 22 May 2026 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478966; cv=none; b=dLlEvaixA7PFzbOEQsk3Apjg3cyw8eJaj9sbTgpljDcLwHRMSvVVcVtz5FWAH1th5sq5EmyZgruHpB3o1Xjy/3jkXeTxxIIwnNu1L/QSVj+Jae3REowur52WGNcUx8qoToerePM3f7ZXSlOfV3kQ7SfSZQyAtjzLQvWgi/b/jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478966; c=relaxed/simple;
	bh=mOrxF6IVpJybRN/IbPraRod+aftKc0lxwp5617dnXbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaYqo8wLkbwzgkaIcX/hM3JolEdncC79jZAEgedmCmS/h7cL+Zzvk1j+VjEpAGAwDHRO5aS5TIxDPmdPrIXWOFWlXB68nC7hBU78vidBMgMkcoNMbiO2+Ejcnguk2FFx0aGjXouYa49aU7yn8DqRAn5C/EJvg9opJ5Av3KqZtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkL1Xrmg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5861F000E9;
	Fri, 22 May 2026 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478961;
	bh=hqNJjDWV/78Ew+yDH7eabr77QKqzz4qmqwS/+2IAGJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AkL1XrmgdrBRleSlO+UsgJM8x8/yzeYu3mdSIWe9TWCFKcHSzZbj+r90zT2uK2XgC
	 RTBL+sAKZATiQYMVx9XRsQ+HnLtwmdsnwZAgsOcVV9xADflL6NY9rKvI19ZpU9LJ/x
	 ZtpJV3uFj3zAj8hkDmJo5CztRA3sWraWR0WGqsiozC89l0SrucDksR17iDKYnYxTtM
	 56v587zUcdp14FtAzx/UdjJjO65fMawAInI7faEb3D8Oe/F8MMABBN5hnbs6GEPz/Y
	 4gZe4EnLKx8wsSmVJQ9CCxVrmoUKmQjJK+s0zZ7SaarHCmDMtR+llVrNIzxudTI+DU
	 10pzyBQDF+goQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:11 -0400
Subject: [PATCH v5 06/21] nfsd: make nfsd4_callback_ops->prepare operation
 bool return
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-6-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mOrxF6IVpJybRN/IbPraRod+aftKc0lxwp5617dnXbo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGeBpTk6DkJHHU6ENiiNiPYDVR7iMLz1nH3I
 7drGIsZv7eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxngAKCRAADmhBGVaC
 Fc9uEACnBCfL3ZRrztDrXQ6Ljs6fnekCHFfTWhrYQidTtonzva26TxfuneV+SHjdhow1BGUWihu
 HnsdssdLj1dvfiwUXNoEiPZM8zoNm9EvGZep6VI2ZPty/gXaDs0HLrNRpLlZPrZG5p/z+7bMyZa
 Hu4DS5/jLUqAOTVzXM57tBkMk2rqDTKPTaYsh1roz4rPpwv+abkKcS0SbBqMoeASuO6b7TZfo/M
 NPdZcMzoFy6GGJk80SFOYHi+WULbtou1cezyGiq1PdCyXINA+gjRR1ZTr9/CNV8BuO+w1XfJ7bQ
 PRPctF3VPQ6+dGSpRYM2S01GcFXuPDxI9X6Kf3w0ytr1A8itCeVgiyPrcLv2i/jLhc3X1h0vhbJ
 IqW+lxTZQLsokH0XVZ6pCzOp/6NcCKk2yyoomenVyim6SWcdDuMUSIzAQujEgXmFjaiBrq/8gKm
 iCFO+ZRCxd1yJUn3lWjI9GArxBwRovs/KT7eEKcRPfKXfmVyRFeA3zEbYfQ9Wf9A+ICm79kv5aq
 gPGYIHX4lIh5S0HfpTDY7B6JmWeUjoLWb1C3Awr4I0vqPiVKfJktYn/WpI+lUYBgNsk62inLDql
 6BrikbmUn2RycvkEpdqwgMAraJJaKxyeFuUsYvMCMKt3ow0QwSdx+deqcJovMJ1hPW2igFp5ZNI
 8q1WByOSg31CRaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21821-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AF47E5B98B0
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
index f34320e4c2f4..e3984c90792e 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -652,7 +652,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 	}
 }
 
-static void
+static bool
 nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_layout_stateid *ls =
@@ -661,6 +661,7 @@ nfsd4_cb_layout_prepare(struct nfsd4_callback *cb)
 	mutex_lock(&ls->ls_mutex);
 	nfs4_inc_and_copy_stateid(&ls->ls_recall_sid, &ls->ls_stid);
 	mutex_unlock(&ls->ls_mutex);
+	return true;
 }
 
 static int
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index efbc99f0a965..3efc53f0dde6 100644
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
@@ -5562,7 +5563,7 @@ bool nfsd_wait_for_delegreturn(struct svc_rqst *rqstp, struct inode *inode)
 	return timeo > 0;
 }
 
-static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
+static bool nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 {
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 	struct nfsd_net *nn = net_generic(dp->dl_stid.sc_client->net,
@@ -5583,6 +5584,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
 	spin_unlock(&nn->deleg_lock);
+	return true;
 }
 
 static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index dec83e92650d..e1c40f8b5d01 100644
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
2.54.0


