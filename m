Return-Path: <linux-nfs+bounces-21215-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGsrJ41d8GlJSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21215-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:11:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA9747E80F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABF9C303A9E4
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1D3A6F04;
	Tue, 28 Apr 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6ctUkqq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F040399013;
	Tue, 28 Apr 2026 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360234; cv=none; b=CHPA4hD+3Jnz9M7cgJqP1UKUh0MgHzMlFtDb4Aj3bmWXudeAJ0T4eyt6846fVfy69dv+zv+gkoE+v3/O4wnd12raNVMsGITKoXR1mYiP95+BjS5k+cWdy/28tarfilhNBue3WKy8nxXOpFFecgpfSENT8nn8JHYdhx9xG88NPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360234; c=relaxed/simple;
	bh=u8nVDaJ9xrV6lyojNp3gPoVC+MwSz/nPHOAsTNCV76A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnqG3yt6jFW2eUCeSiFjR+qKzlIEvFcqPIHZVDEPrj7sWE7v8gFnxnDOb/3gHPredIV7gdppRbgbgb31k6ykaxnMtsFKvYLilWSX2y8f0lIfn7YGrUdvfox+3/1sXRo/20016q6GoJY7uNbVWFnu/9Y67urFUApwDJXogiVuXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6ctUkqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7AAC2BCAF;
	Tue, 28 Apr 2026 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360233;
	bh=u8nVDaJ9xrV6lyojNp3gPoVC+MwSz/nPHOAsTNCV76A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W6ctUkqqLjN9n0YFTBBoc53nQXofKEtOy/AIZNdsVUwHAmrr9V5ctXoS4lrl4JO30
	 Jes59W0uDn3O6+7vlRDf+8IZRYVRxZd2/phYhmBaUQXdCZXHRVFlwcovMIFYbLtDYF
	 KzlZPHtofzhZXLMEOXsNvNj8oY7Xt1qbnw9p5iK1u7RBxFv9uXFAqWomB28cAkyF7z
	 +h8DAPVpnv3jsSs6Kho7A4DL8Lo8ZmRt4F3Ti5+DAfUolWDAA9TTz3xFcpVtOJ5Gxe
	 x3N8DV8Pm9aibUCvTP50Ke9TyVsDasUf6yaY51UE7UDCaY7dGQa49A+CFsYwNutQYW
	 bMxvPwZ81G0sw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:47 +0100
Subject: [PATCH v3 03/28] filelock: add a tracepoint to start of
 break_lease()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-3-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=u8nVDaJ9xrV6lyojNp3gPoVC+MwSz/nPHOAsTNCV76A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1NEtJpHeRoTpnLNnDoZ4d7uPPGl/+Ed/sP6
 kDz9HajneKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdTQAKCRAADmhBGVaC
 FdXMD/wOt8JZs4fjCouGgGRfpPGSujCgzPUIUEXCp7aI7wxVFtQPEFvxj6mupxPYGFx/XmeJ1qw
 8bJEq+QacZ7UiKAM8wBLzUJgnRqgmbG0LmY2WhSN4bkR28VmhBrFA/iiQUz9Dn7quoSXlhi2MNx
 nSbM2EjQV281hWAVo017PDumUNMCdjiWFAbmz5UMwY8xfYfu3MERDyRdMcMDwhQrbJG9s0iToPL
 3+vdj4QS/7Ch14FbdLV40W00T7/dToqg1HgUO0Oc9sne+n1EfGMNE59PweqXbl+/cxsgRPV289n
 oytzZDe3M/1ZbWplXOO3UxqCnP6wrMt3NZ4rX4G3M4twgNH/C0djiazUPfCFnHJ0sic5pGvqyP7
 jFLO4e7gSeqp+QQKTU0pfxXMBYv95NIO6KIGQRK1plL2pASCdI12sCU8Zq2mX8kxXxAdUQwfaFK
 iY5FnUwNL8GszByE4qI6Qod8o8obj3CfL/2Xvz8Cw3Mni8iDw6Dbl4/FbyYJAMz02rCbK4tiIuQ
 XxBFc5OpR1PqH4i3g66neyWOOExNzicsBzp4oeQd58RTcEvl/DN8ZmGse0kNK7FIY+X4sg/T13X
 8ON7gVkzlQQpkJplRfTVthVp4bcl05JdDH7xNBQP0k20GnujYa4xPkglDJoqrrn1znE7SwsiXwJ
 3+gYAwunf8WwhGw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 1AA9747E80F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21215-lists,linux-nfs=lfdr.de];
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

...mostly to show the LEASE_BREAK_* flags.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      |  2 ++
 include/trace/events/filelock.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 8b5958f34b61..792c3920b33a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1651,6 +1651,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
 	int error = 0;
 
+	trace_break_lease(inode, flags);
+
 	type = break_lease_flags_to_type(flags);
 	if (!type)
 		return -EINVAL;
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index ef4bb0afb86a..fff0ee2d452d 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -120,6 +120,39 @@ DEFINE_EVENT(filelock_lock, flock_lock_inode,
 		TP_PROTO(struct inode *inode, struct file_lock *fl, int ret),
 		TP_ARGS(inode, fl, ret));
 
+#define show_lease_break_flags(val)					\
+	__print_flags(val, "|",						\
+		{ LEASE_BREAK_LEASE,		"LEASE" },		\
+		{ LEASE_BREAK_DELEG,		"DELEG" },		\
+		{ LEASE_BREAK_LAYOUT,		"LAYOUT" },		\
+		{ LEASE_BREAK_NONBLOCK,		"NONBLOCK" },		\
+		{ LEASE_BREAK_OPEN_RDONLY,	"OPEN_RDONLY" },	\
+		{ LEASE_BREAK_DIR_CREATE,	"DIR_CREATE" },		\
+		{ LEASE_BREAK_DIR_DELETE,	"DIR_DELETE" },		\
+		{ LEASE_BREAK_DIR_RENAME,	"DIR_RENAME" })
+
+TRACE_EVENT(break_lease,
+	TP_PROTO(struct inode *inode, unsigned int flags),
+
+	TP_ARGS(inode, flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->i_ino = inode->i_ino;
+		__entry->flags = flags;
+	),
+
+	TP_printk("dev=0x%x:0x%x ino=0x%lx flags=%s",
+		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+		  __entry->i_ino, show_lease_break_flags(__entry->flags))
+);
+
 DECLARE_EVENT_CLASS(filelock_lease,
 	TP_PROTO(struct inode *inode, struct file_lease *fl),
 

-- 
2.54.0


