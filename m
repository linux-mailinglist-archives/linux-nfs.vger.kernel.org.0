Return-Path: <linux-nfs+bounces-20689-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD1eIL4F1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20689-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:25:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CB3AF03C
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2D7F30A6B6F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F73B7746;
	Tue,  7 Apr 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt5cZ5+s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CE3B774A;
	Tue,  7 Apr 2026 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568149; cv=none; b=RzyqYC5PUCreIR66n6Pj7hgBaaqfS4aMRMCnn20302Wl0SasjAJqUWsUlWQ+xW3bAhltHhYp1RaDt4+pZ+CenaLYp1VsJ6GYsQyQLrCH7a/7zu4dakYmKOVninQtOME0PkhNMIfeKw9tXzea8lv9ZeFAXWiLWUMTYUYPkOc4LT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568149; c=relaxed/simple;
	bh=89SziWwM/FohwNGtd0INddyrZACS7OxAWEtzHYq9JF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSPDHvvuIXjvCXOYRgCBXKZqvM3u0e59k7FxrDUkTvOWlb8R77MOy64VrJSR+nltRu9RwrlK1QWhKYPeFReHpa8R0fCaE88gygXblDLyZjo489aSdhxyXi9NwUQ2ZdM7wNtg16rOK6sT86ag9C/5+BBbPQpQrTjgEP2n5yZxmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt5cZ5+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36A0C116C6;
	Tue,  7 Apr 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568146;
	bh=89SziWwM/FohwNGtd0INddyrZACS7OxAWEtzHYq9JF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mt5cZ5+sZ9gnYK7lz8RSkVdf8a4jNhv1uKTkp+t7rf2qvBxnQQKCnhquX/zrrKC0B
	 s7JaTXk0QQSMNzaxyeRu23gGkMr6JLEyljkCnN+pX+sq5KxohNp3DWJCtFucjQKhfr
	 0oDrzykbur3yAPiJOKuzqt2nwgHiiRVtEVQ4U47QtX29YIg+Lo3YKFU+nWlYY7MV7b
	 1v7eyP9y1we23E+UsdsSKXums5bNhOSzBxlgc7h2TiD7JZBCOB6xFRjWoeO/zze++c
	 AvhrTJrWPTpXU6FPKgXTj3h+KzxmZhlBlTY/8NVz0+L1iDoyVw4ibiCNCuif/lI7dO
	 eX3trR0fscnfQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:15 -0400
Subject: [PATCH 02/24] filelock: add a tracepoint to start of break_lease()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-2-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=89SziWwM/FohwNGtd0INddyrZACS7OxAWEtzHYq9JF0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUD7iyMBq1mP3wPgmGDjbwr9A93+l1AzKJpZ
 4PmXRCv5p6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFAwAKCRAADmhBGVaC
 FcLQD/0Rc3WVDbMV0eDNFk3bz/P9dGF2SalFY46/r2PmSoDpyUIZPjHUXUCQlQBd5o9+pNVmNr4
 EulSQJ+VUGCwqekueiUAoM6wccGc2IgW42bzIOmWPkCM7mBYUZMgMWoShyMXOqZYxYk3L0zm86h
 405Tah93VgsAYAnircLpqIK0S/WxU7qMQ3MiBL+uIu35UBBAHaAYUwTWj/u6U7ZI+pFpQ2yCquD
 o+fnOlmqrmEtSwcfkxKVPsmzGIv4F8elJQ5vu/SlQL1gFIdijIwA46l6PZ798rwtSB/157pwjf+
 x1+tHORBpOc7TkJFIzNFqNJksawEnAurxr9v/maV62oNAfOIIiEQSMa9Uvk3mJV3ks5Qk5oJ2j2
 MKeMdkY9mEYA614r01MIBd57KLwxWkW004S4rCFCinEjOYP+7zLWbkvXVKRIWEU9lNb+VMYpQH7
 1VlZA2NnTSJK/SaFFKZP7lAiaSiF1l2+2teBjFENI4Cp5C+vQVPyMaHm/mIIdZFg0wlg6dSjnWB
 vUG6FunqLtO8wqz9bBbfHqbBIqv7Mw8tm0ejiyej49EvEAVgkgrbOi5NQpkvmNkV8WgQIjAf8NW
 Oi7EvOXhrnaQnKmSL2Iecl47ig05lZU/tpTSLm6BZJ4m4aswNBsMqt3mzL3FHY4t6t8XzJgdL4t
 J/AjY9s46/AHFcg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20689-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 149CB3AF03C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

...mostly to show the LEASE_BREAK_* flags.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      |  2 ++
 include/trace/events/filelock.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index dafa0752fdce..5af6dca2d46c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1654,6 +1654,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
 	int error = 0;
 
+	trace_break_lease(inode, flags);
+
 	if (flags & LEASE_BREAK_LEASE)
 		type = FL_LEASE;
 	else if (flags & LEASE_BREAK_DELEG)
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
2.53.0


