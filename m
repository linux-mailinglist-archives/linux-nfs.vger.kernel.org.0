Return-Path: <linux-nfs+bounces-20877-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HuiEFgf4Wl0pQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20877-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:41:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE341311D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15FB331F28FC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A704339844;
	Thu, 16 Apr 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/f/dG8f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434233688D;
	Thu, 16 Apr 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360942; cv=none; b=f6g8tkXbCM+zCQJYGftuQz7bOHwfYvD1QITDYuJzuTicdZh1K6QRRh/DCCYOXekV9cfbLhl9A5XRHfnn4ktpPfx5eJTDV6e/An+M9rczi05sdqMWCcUP/nUDqlvvT5xi06pjWYYQmFyby5PTv2pFID9sVKon4IOxNJqcu8xJqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360942; c=relaxed/simple;
	bh=R9/KzrvxYF+4HefdcqVALy0RSfXF1sXeb+jfYdn8ZC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeaYX6bQE+02ZajB4BCQ+zocy6hecdjd2AJEY+xg+TA2VwOHyUq4o8fyVIopzcsLhVxaaH0rTYOLaIoQPf1od20n0w0PAF3V2TtNjPWsJ3LLdkMIlZU4ZG8mwBc53/PmgrZ0GQl/tVIW9zrh4g+JOpGWbeCisg3Xkq2rD2xyP/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/f/dG8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F25C2BCB5;
	Thu, 16 Apr 2026 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360941;
	bh=R9/KzrvxYF+4HefdcqVALy0RSfXF1sXeb+jfYdn8ZC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y/f/dG8fjaPkXewYTR48yfAteWcMqzLSv6AYSAv2b27HUvDq3gJIBfIzhCkFpVLl4
	 +x4FrK+YxLaUuWm5mwlUIyA6QytvvKgG65cWEzlgS2jWI7msKe/kyo5TvN0//96ulC
	 la/sl7nw6r0PxuWYXZFtUGkSe7XCCfgTgC5Etw+sMMk7WsiLl+0lQ9oasUl/WBLcMU
	 BG+47EqnPQOeewJQBzCsQI5VLXwesXMVBRZjkMgN/tYSPOpqiSYJVFgBHq4riH6LZ1
	 9NMZ1vLaEpY0fBEFzpH7hHEtMJ6G1+dZX/5rSNNr+INF9xwY5xKGHO8sIwHRmR+VP2
	 sMj74S8/EF2EA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:06 -0700
Subject: [PATCH v2 05/28] fsnotify: new tracepoint in fsnotify()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-5-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4161; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=R9/KzrvxYF+4HefdcqVALy0RSfXF1sXeb+jfYdn8ZC4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3isBcKAZx/y9q3gnPFeIoBe4jcPQE6b3R2T
 kJWIdp+us6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4gAKCRAADmhBGVaC
 FRfkEACgId4LV7zIg+FpqVPrtl2adQ3hZRcbA0FVnYLtLmqVgihoqZZKtcCBWeyzzCxbNSVH91C
 ABi/9cYoOeo67BggHD5GcGhGBMg466OQltsAklVHbDgvaXwKrDj5uW/g1ViRkI+HLjZ8Brfi2e+
 8rux9Hj28SRSuRHiKM8TVTqsdDD8yj3K+lHoLjQ8N7cn/qjT0rkezP13Y9U8W/ptVIONKKYT9Ic
 MDQjeWYoC0gZk5TnHMOmyS2bPkuo9s4Q7hjXktOfOD4Q60bo6weifOBj56ZLyuirQe+H6AHoA4u
 4VIfrmH/09J4CjRglDFqVeXMUdny8gImesJYntjmOM6rcDgWCUK5++9lrPMbKyJrdUP0Bfzp6Mo
 8BdubwNJI2FrWDpzmvbj7tVtWctrnGsMu3DEfrFnYoADuwbn0hD2OFQP48LKYGdEdTd5p75bF6m
 5cdpt/7ZuH9yUlRqkEwBEHdVuT54u4YBA021cUpNs7O7Ewv+SoLsjxDdLdcJXNUSnXyIBrEiIzi
 +IN6Ab5JqoJ0WYf1dli78Dqmzq3RJosP5hu9n6v+V/y3Ipqj2MbEO8/TwoBZa1wpAd5gocLTBx5
 eejGaY85O6Jw/n2Y8wf8atQCaRmb+afKe5RBkkVfnZ4+SZQAWTAlgK6bbCYymY3wmdc5cjmX43r
 m14mfYPl+fxBcjQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20877-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: D8AE341311D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a tracepoint so we can see exactly how this is being called.

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
2.53.0


