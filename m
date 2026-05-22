Return-Path: <linux-nfs+bounces-21825-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAGBEA2yEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21825-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:44:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96A5B98DC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C781C3023DA7
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943ED384CF0;
	Fri, 22 May 2026 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7cHu2gY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F861383C65;
	Fri, 22 May 2026 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478975; cv=none; b=X+YJQ0qFnglyBdLPBt0sY2/rx1RBABPz6Vtsrhrq7LT7qqP7u1+5byjEovJq3eha3Nic+DPlqFIgRAc14xTZgvF4x1xu4b8faChAK/XaI9CwrI8MDY/zmXVcSUTcx/Va64XM6nqVed+NO3oC8Z/LS/9wFjUdR1JwB0bZaM33LWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478975; c=relaxed/simple;
	bh=iyMvf6KwHA7kA23c38ActRC5y2b23U/qezVxBFDbRRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBZOzCweTk74mejkzmsKQLsvHYXWLoTjr86RPxxps1yQ76Yi3LOMNCfhz7efE7EOrHAfxgDRX/zlubljiFqz5vgk6bShMiqy8MCsXL82yWT0XK1d7cDkO0eYWE0AeyYC8IAroXHNYUQhqwyEmULVrg6SyC/FM2cT45nsWBuwT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7cHu2gY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A041F00A3D;
	Fri, 22 May 2026 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478971;
	bh=+7uI3caDzWXGejXCsGzeDAn7nb4kbN6aZKDVE5PQHIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z7cHu2gYumy6C8vjSoA4YZgNyyNH8AN0x3qwqbECRQAJJjNe7kbcR8NDv50mAZSsi
	 6IzkLPkn/k9ojhxNTtpL927aBVEna1vof5mhhtwYAR4fzd+tZMwDNftM8cebPBjvS0
	 UuP6lCbWiTXcptjBmSuxnwsVI41euo0oLXGl/ZaUTYHMCTyq0Xrl0NdajqR+8D8Xi9
	 RbcY2bk/TRAE1PCZ7BV5cW6gYpFgQFIjAXxDfojL5neac1x+MxGpMdPn85y6jF7IUw
	 EwuGcJtOWcYqF3W1V7UaA6pOlO74+DZLO/f26lez/x8wDKosRgdkYDBr7MshwPZInM
	 +oIWqfMtivIuw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:16 -0400
Subject: [PATCH v5 11/21] nfsd: add tracepoint to dir_event handler
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-11-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iyMvf6KwHA7kA23c38ActRC5y2b23U/qezVxBFDbRRw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGg86+XPSB09vhwAaobm3TzqIcBD649E+K+h
 sRfqgHU6wOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxoAAKCRAADmhBGVaC
 FZ7TD/9+VuQQRZGCo1qWn7L1gwIGkx96s9EdaI7j8BAmEniThrIEIwl0U22KcQ34Shzk3V3evr4
 moV2XcBgz5GVwq3sILWIMoIqzo+kHwCYzzQ2BpnP+lblIkSEJL6W3anybqYPkK2ByHhVQd07wZM
 JblLCFx6io6KROqDmkdNPPKou7R3b4aZTHWk++ZftiT/+j2ETa4VCUCfLKvD5BEUDz0kubRxk1k
 vAMIpiVLp6ExorpQj0WMYNprxKbr/X/2zCzOyn1qs0j6gAhzWvHOkWnCWNcB1LdivURpayiHCZl
 d5/MzmI89h/nlbp0Ed2Mya3Q8yNiEQ5Ete5OERx2wzwxlTl+Zg1GKXNzqSxYDbgcPRAP/LtnVE3
 HvL0a5wxrndkxy3Q5GiIC2H/hPxioyzm6QFlNcdbS5659WhQvS5tb5zv/SZzrk6I+Suw/zEWlen
 pZM4EEIWvxCGRolKXzyLragVLqPQnyahowXYBAXLkviWIBGSGj+hIdcXCrJ7yTHhZwLsohg+OTW
 ziGo8/dqO3HA7+26fjpR7lhebvBzreQES8EzEdU07vNEMOXwUKlVc84dm11020o4s7WcawnDpVz
 cFBTuqFj4Mi/M2G/SggQJ8rW9IwUzocnPWhJEjHEvotAhjc9892Jb2qZ/UxdyEKHQZhlO7/CRPB
 6JClzUq5EYQFwow==
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
	TAGGED_FROM(0.00)[bounces-21825-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,goodmis.org:email]
X-Rspamd-Queue-Id: AB96A5B98DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add some extra visibility around the fsnotify handlers.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.h     | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 20477144475b..e00b4463c89d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -10035,6 +10035,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 	struct file_lock_core *flc;
 	struct nfsd_notify_event *evt;
 
+	trace_nfsd_handle_dir_event(mask, dir, name);
+
 	/* Normalize cross-dir rename events to create/delete */
 	if (mask & FS_MOVED_FROM) {
 		mask &= ~FS_MOVED_FROM;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ebf5677c4e73..3d0f0bd30d90 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
 #include <trace/misc/fs.h>
+#include <trace/misc/fsnotify.h>
 #include <trace/misc/nfs.h>
 #include <trace/misc/sunrpc.h>
 
@@ -1377,6 +1378,28 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 
+TRACE_EVENT(nfsd_handle_dir_event,
+	TP_PROTO(u32 mask, const struct inode *dir, const struct qstr *name),
+	TP_ARGS(mask, dir, name),
+	TP_STRUCT__entry(
+		__field(u32, mask)
+		__field(dev_t, s_dev)
+		__field(ino_t, i_ino)
+		__string_len(name, name ? name->name : NULL,
+				   name ? name->len : 0)
+	),
+	TP_fast_assign(
+		__entry->mask = mask;
+		__entry->s_dev = dir ? dir->i_sb->s_dev : 0;
+		__entry->i_ino = dir ? dir->i_ino : 0;
+		__assign_str(name);
+	),
+	TP_printk("inode=0x%x:0x%x:0x%lx mask=%s name=%s",
+			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+			__entry->i_ino, show_fsnotify_mask(__entry->mask),
+			__get_str(name))
+);
+
 DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	TP_PROTO(
 		const struct nfsd_file *nf

-- 
2.54.0


