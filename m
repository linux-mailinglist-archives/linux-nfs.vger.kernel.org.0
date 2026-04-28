Return-Path: <linux-nfs+bounces-21217-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDvbAspd8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21217-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:12:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0850047E849
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04BB5301DE75
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75493A963C;
	Tue, 28 Apr 2026 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoZRz2pj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F73A759D;
	Tue, 28 Apr 2026 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360242; cv=none; b=L7cSWbdWank0cWKKrNnSU/Vx1govEyzsGLegJzptE4meAH1ZAVg6jX9KDudGzfiSWeUGAY0HZS7w6DpPkOQYKBzI0aKCC7d9qNmucqK/awPcnJE4nqNLL1AyW0BDiP98GSAtoqA5W6bo+9LUlT4K2SXolZAjv3cterg9KJBqCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360242; c=relaxed/simple;
	bh=De00MlFrQJ0V85UIwGjDHrcc8+0WC3lBEWRCtuTezRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M64KxFKyJFoB7e3MZ9mhOgMPWG5+mPatFWzDMiKYNfiA5ervwgTtQRD4y4lT7rWmR6k16HOUKT3Q/yzcff7w8ZsDVKK6/Jb75SL230ZZw+Tnxffz/pay04cBB3mhxvbMu0E62lrp+9pdxkwzpDH27lhcL1B44GLChbas1xUAk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoZRz2pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F63C2BCAF;
	Tue, 28 Apr 2026 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360242;
	bh=De00MlFrQJ0V85UIwGjDHrcc8+0WC3lBEWRCtuTezRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WoZRz2pj5RUkymf4s3+GI7GYYNQCnHcZLU5rpsiwJZMV8bknzSf3s/vPQ2EE2Y4a+
	 ryQwZOW0B8mxfX3wn2y0yZ3wDbTNJCb/iPrji53YN2WjNg1rhL34sfhMWLpOlcAEZi
	 Ydl+b64phXHPg7tgUGSBhC2hdCGTf22iwV9dnDJ/utSRYq5MHrNV3BkNNsBj5clG9L
	 Tgg4ZOrQXQjekpPyh8Z0zDKJGr/61JrYvTxdgqbDmg5zdCAFmK8hzIWXAI80PmnKM+
	 UTp3JJPloRNe1pN8WVChUkW6Q6fqOetpemsrNxVUslq5qk0uHOMgG6FKrgY7yg/+x0
	 /0WF3sOYt5PZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:49 +0100
Subject: [PATCH v3 05/28] fsnotify: new tracepoint in fsnotify()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-5-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4199; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=De00MlFrQJ0V85UIwGjDHrcc8+0WC3lBEWRCtuTezRI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1O0YduBPP7mTpP6tn5nuPakUzLToKY/viDw
 Jt1WX3IyJeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdTgAKCRAADmhBGVaC
 FauiD/9is1l/3fTtoK7FeP3BP2+/zW7ngsi6zeqMB9851qnAn4L5e9zh6MwtMYBtB9zk8Zdm0zV
 ofxCILANC7aQmy7ONdyETZMLJ0YPYSv+t3d9LS5LJb82HTPfkkKk4FLLIdQSY5zaRYmdYLAVzLb
 8GliVw6tfYt8qy/5N6nEoAddKAitebm7P74JnEL7kLE8vJHLAS8iN0j0+wZXWMpDjvdng2SYqT5
 vn8XNO//7ug+1lp704tU8tfF13US8EJaEbhEThhT3WZ07B4hRt3fgB3mqZr30AAEhgQP6x+6uFp
 kcKZvjLZ/OMdadaq+jqvghT1bTj75AUYzvqx7N7YhVJ33IUTlqYZRUzVNjnbvNOoTjZresy9ZjB
 Wg4Bwu0OkvXcwCPDy8/Cn4Ryj8EvZJ250Mz0KGr9vErwNlRDo9fVKjBUQ0vxK7wkp6m9u4IQC2A
 vR+R/qfGUgnaLurkOwFVo/R0VzXiPqOlpPenePf3aVOx6DdkAkqQLFbo5PEoEIpLmvxhupNr0D4
 DNEOl7t1Tn6QFqxN19CZZBzJMK198WOXx1j/OgPUUrUt7WDBtoq6M9Gf/he8SaV/2lSmeM4hh2i
 QMpnQZToDeP1y8zdk517q2n9qgfFaex83pNmpPdAotuJCJIaXDamzSaPehHzG6hVJYYn+/jDKib
 52zKWsz381WdDqQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 0850047E849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21217-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email]

Add a tracepoint so we can see exactly how this is being called.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/notify/fsnotify.c            |  5 ++++
 include/trace/events/fsnotify.h | 51 +++++++++++++++++++++++++++++++++++++++++
 include/trace/misc/fsnotify.h   | 35 ++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e5..5448738635f6 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -14,6 +14,9 @@
 #include <linux/fsnotify_backend.h>
 #include "fsnotify.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsnotify.h>
+
 /*
  * Clear all of the marks on an inode when it is being evicted from core
  */
@@ -504,6 +507,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	int ret = 0;
 	__u32 test_mask, marks_mask = 0;
 
+	trace_fsnotify(mask, data, data_type, dir, file_name, inode, cookie);
+
 	if (path)
 		mnt = real_mount(path->mnt);
 
diff --git a/include/trace/events/fsnotify.h b/include/trace/events/fsnotify.h
new file mode 100644
index 000000000000..341bbd57a39b
--- /dev/null
+++ b/include/trace/events/fsnotify.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsnotify
+
+#if !defined(_TRACE_FSNOTIFY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSNOTIFY_H
+
+#include <linux/tracepoint.h>
+
+#include <trace/misc/fsnotify.h>
+
+TRACE_EVENT(fsnotify,
+	TP_PROTO(__u32 mask, const void *data, int data_type,
+		 struct inode *dir, const struct qstr *file_name,
+		 struct inode *inode, u32 cookie),
+
+	TP_ARGS(mask, data, data_type, dir, file_name, inode, cookie),
+
+	TP_STRUCT__entry(
+		__field(__u32, mask)
+		__field(unsigned long, dir_ino)
+		__field(unsigned long, ino)
+		__field(dev_t, s_dev)
+		__field(int, data_type)
+		__field(u32, cookie)
+		__string(file_name, file_name ? (const char *)file_name->name : "")
+	),
+
+	TP_fast_assign(
+		__entry->mask = mask;
+		__entry->dir_ino = dir ? dir->i_ino : 0;
+		__entry->ino = inode ? inode->i_ino : 0;
+		__entry->s_dev = dir ? dir->i_sb->s_dev :
+				 inode ? inode->i_sb->s_dev : 0;
+		__entry->data_type = data_type;
+		__entry->cookie = cookie;
+		__assign_str(file_name);
+	),
+
+	TP_printk("dev=%d:%d dir=%lu ino=%lu data_type=%d cookie=0x%x mask=0x%x %s name=%s",
+		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+		  __entry->dir_ino, __entry->ino,
+		  __entry->data_type, __entry->cookie,
+		  __entry->mask, show_fsnotify_mask(__entry->mask),
+		  __get_str(file_name))
+);
+
+#endif /* _TRACE_FSNOTIFY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/trace/misc/fsnotify.h b/include/trace/misc/fsnotify.h
new file mode 100644
index 000000000000..a201e1bd6d8c
--- /dev/null
+++ b/include/trace/misc/fsnotify.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Display helpers for fsnotify events
+ */
+
+#include <linux/fsnotify_backend.h>
+
+#define show_fsnotify_mask(mask) \
+	__print_flags(mask, "|", \
+		{ FS_ACCESS,		"ACCESS" }, \
+		{ FS_MODIFY,		"MODIFY" }, \
+		{ FS_ATTRIB,		"ATTRIB" }, \
+		{ FS_CLOSE_WRITE,	"CLOSE_WRITE" }, \
+		{ FS_CLOSE_NOWRITE,	"CLOSE_NOWRITE" }, \
+		{ FS_OPEN,		"OPEN" }, \
+		{ FS_MOVED_FROM,	"MOVED_FROM" }, \
+		{ FS_MOVED_TO,		"MOVED_TO" }, \
+		{ FS_CREATE,		"CREATE" }, \
+		{ FS_DELETE,		"DELETE" }, \
+		{ FS_DELETE_SELF,	"DELETE_SELF" }, \
+		{ FS_MOVE_SELF,		"MOVE_SELF" }, \
+		{ FS_OPEN_EXEC,		"OPEN_EXEC" }, \
+		{ FS_UNMOUNT,		"UNMOUNT" }, \
+		{ FS_Q_OVERFLOW,	"Q_OVERFLOW" }, \
+		{ FS_ERROR,		"ERROR" }, \
+		{ FS_OPEN_PERM,		"OPEN_PERM" }, \
+		{ FS_ACCESS_PERM,	"ACCESS_PERM" }, \
+		{ FS_OPEN_EXEC_PERM,	"OPEN_EXEC_PERM" }, \
+		{ FS_PRE_ACCESS,	"PRE_ACCESS" }, \
+		{ FS_MNT_ATTACH,	"MNT_ATTACH" }, \
+		{ FS_MNT_DETACH,	"MNT_DETACH" }, \
+		{ FS_EVENT_ON_CHILD,	"EVENT_ON_CHILD" }, \
+		{ FS_RENAME,		"RENAME" }, \
+		{ FS_DN_MULTISHOT,	"DN_MULTISHOT" }, \
+		{ FS_ISDIR,		"ISDIR" })

-- 
2.54.0


