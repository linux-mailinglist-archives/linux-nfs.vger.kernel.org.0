Return-Path: <linux-nfs+bounces-20701-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MENzCnIG1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20701-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:28:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1793AF176
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B48430CB87A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412863BB9F3;
	Tue,  7 Apr 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/lmwWIz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA953B7B7B;
	Tue,  7 Apr 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568175; cv=none; b=GUj2BNS5D3Q0bEFkwmFTo+1oFSO/WeyFG2UJGqoA7WxxX4xkr9SiMVUL7IN2TTizbKAoqZAixreHWDRpUJn+k3PFpKnaQBeqrG8f2jZ1x5syCsDr3eGvHU4Pc1ZyE66hWPlHXO+jpMmmNHs8rDK/m9h5vs8ad93kU0Hzrw2VfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568175; c=relaxed/simple;
	bh=g1I47p9tYcaU/TzDYfO6i1CSHlKcg5dHhdBE+M75uqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnGL961P/GS/vRieZsYLbfv4dWPsUNiGNkWcjlK7Kn8EElS4zZsd2iG6EjA4r31Ho0xBA33G95iNFA4WryxmD8upCWAYZNoNyuOulNDUI8LVwxlvUSW/wrwZeHtSxAh9VbkDHtNUnN2gFwzxhUknpysy+NjC8c5v/sWvv9CKOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/lmwWIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3B9C116C6;
	Tue,  7 Apr 2026 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568174;
	bh=g1I47p9tYcaU/TzDYfO6i1CSHlKcg5dHhdBE+M75uqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z/lmwWIzkqrMJOz9N7Ckzmze88VfU9EqebQ7b0wavxOZE3WIY3lVafy27a4HbyiL1
	 HVZl43I7yDxgKqzJ5foPmKQz1AVK7LT9itVaDWUL4CSBQTVSnwe8bIx7MG3DKcSWlE
	 9M+5sf0pDujkeq32I6lIYU2YjLDc0aQWhJ0FsPRqQfadxI3o/cT5w6tyr97LqLZQVc
	 o5t+pyAxDchv2FQ3Q+b2FhEYbNJKuXx9HoeUJnUBl5HsJcu4Gz+/flHbuAKmuzTdoE
	 gcbOYqry/GQzPO1u+rvDOwKs34uMl1fGCg0bvDUHD85/0q/fcwYbw6vZ6DWpNBsYCA
	 ZOWoQZp2v9YwA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:27 -0400
Subject: [PATCH 14/24] nfsd: add tracepoint to dir_event handler
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-14-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=g1I47p9tYcaU/TzDYfO6i1CSHlKcg5dHhdBE+M75uqM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUHhVJtZw/rVGCFdLIokYltsEfMeXjinHD3c
 U/vqhnACuqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFBwAKCRAADmhBGVaC
 FcCfD/95Un4hir96q/sORwpTWijQdhjwl/7B9+xLgnGjF3V9L2UT902waAysGgx7EJKP+WfAmok
 8kYyd+DhxZrN+R6yuqCpauSVRfxlAcsFnUVCJ64HuYFiu7QCo6VTvFRzDk1TswPz6wDf8wEKJZc
 9oolXdWHoE7V67fgx0qY5/RN0RR2k4hOofTYlFm660TxB6/jCOCZA1YS+qXfbjIvfeBKtiEcqed
 rKmZCyoN5iMy0XJ0WdE6inJnVq4uLwCVrpfeRFdLxYZoN9JNuHq0YoJDd07Djlj5rA3lxZMBJUX
 H4SbhJY6JQs7bElnUouTAnIl7w9H6YMnHLQIJfIbdJsJhiHogh2qwcCzB0OyOp4+3vrd287j5rW
 QXGX2s3BItcIYcgBDgWuXlU9yJ0Snia/X85C4vfDG79K19+jk+ClSm1hdIF3bULHR+9kInfhECl
 v2nYmflsXTKRYzDPRFd6rxRehTOU1eEWfkD2kxvs/Ivv+usnu8SdJQCjxqHFUM+KtPAEZTRTKjR
 FAqDQmAUoEWomGCuxVnSvw0bkcn8/nTCS4k3ZBxiXbUXoFt6d66zaXFfXO6APmlhuqarghSGQJr
 WT+KVLM4O1xarL2FEO6ESctHP0J/Mm/As/2cU/eAzAcm7OIBFoXzXw5IiUCHPeEzQ7YcJQW0iET
 g9wh2fPAKvdPS8g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20701-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A1793AF176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add some extra visibility around the fsnotify handlers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/trace.h     | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 339c3d0bb575..f3bf572b0ada 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9963,6 +9963,8 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 	struct file_lock_core *flc;
 	struct nfsd_notify_event *evt;
 
+	trace_nfsd_file_fsnotify_handle_dir_event(mask, dir, name);
+
 	/* Don't do anything if this is not an expected event */
 	if (!(mask & (FS_CREATE|FS_DELETE|FS_RENAME)))
 		return 0;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 60cacf64181c..3302cb926254 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1377,6 +1377,26 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 
+TRACE_EVENT(nfsd_file_fsnotify_handle_dir_event,
+	TP_PROTO(u32 mask, const struct inode *dir, const struct qstr *name),
+	TP_ARGS(mask, dir, name),
+	TP_STRUCT__entry(
+		__field(u32, mask)
+		__field(dev_t, s_dev)
+		__field(ino_t, i_ino)
+		__string_len(name, name->name, name->len)
+	),
+	TP_fast_assign(
+		__entry->mask = mask;
+		__entry->s_dev = dir->i_sb->s_dev;
+		__entry->i_ino = dir->i_ino;
+		__assign_str(name);
+	),
+	TP_printk("inode=0x%x:0x%x:0x%lx mask=0x%x name=%s",
+			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+			__entry->i_ino, __entry->mask, __get_str(name))
+);
+
 DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	TP_PROTO(
 		const struct nfsd_file *nf

-- 
2.53.0


