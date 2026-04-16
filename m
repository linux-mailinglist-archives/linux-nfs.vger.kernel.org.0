Return-Path: <linux-nfs+bounces-20879-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO7VMtge4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20879-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:39:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF7412FB9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2301C314B573
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2939D6FD;
	Thu, 16 Apr 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG0DNSGr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BDE393DC2;
	Thu, 16 Apr 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360943; cv=none; b=MLBqJjxodBmMOgA4WtUxdj0ILI6bCPV5xCoIzGpP8yiWE0YbQTo5c+ZnsI3RFEasAxFCpS1uj0fxJiqMNNaAtzNwj7qNi3BVg8B/l0GMDrfcHjFqK9naFvSBAuCWiVIpxwl73kl2K8Z3j0hHNs8d3tu49Bca2jEo6HU4ll42fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360943; c=relaxed/simple;
	bh=umta9lJOOxbQRnfhihN9L/gicaIZYJJzuXCSGw/CyLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RUa9xODpqL0KJj/1s1p3BsPCm/GUXrboNxkFXssj+WNL3CoPaaQ4Ju/4l3kkIMiyxgmJu6/qOUV0Lf+r6HDWDztEdD5Uv5LZLWuN4f9q5oYwP0kp7RQrj3iwAmZe+pd0SDu/RcRunFjIfSDew/HvQ2BAwYkgxRj1ow2qCUsObjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG0DNSGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C202CC2BCB0;
	Thu, 16 Apr 2026 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360943;
	bh=umta9lJOOxbQRnfhihN9L/gicaIZYJJzuXCSGw/CyLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aG0DNSGr7HLm+ExGN0tmfe08g6yFSjZBmYmG0f+vOYCBUfcjMTNnjM4UeuSuVvG3m
	 cxNxBZSl4VOsY4gHVmYrQIasD8Tohr3o2cXcqboxKTxCxK6MejBNM78gud/rWIkfJy
	 WYR8/s0kbNDTNwgfuti0YHMmEJUC11vuXLRoGx8O7On0lLI5ruDh05/0Vg1byo431b
	 IlIAiFm8CktWOl44MaT1XiuOau40XSKXznjVgM9oiqsOWNLbindn+0FU0dkrKbtd6i
	 2tdXQCWCHQ2w8RNehGOg/fUtEcXlzTuYdp3pv+jb6a/G3isRGNvhYM80Mva9rH/0ul
	 +z8k4/pLEyi/A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:08 -0700
Subject: [PATCH v2 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4476; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=umta9lJOOxbQRnfhihN9L/gicaIZYJJzuXCSGw/CyLI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3jVOcuVAwa6kZYphaIfJyv5Js/gWq3AiJEX
 iD2147H72+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4wAKCRAADmhBGVaC
 FUsgD/4jbEcaQxKHvHlp8LzkDknyOls4SSdIWUHQxWrvGNNIoAdDvIFOkw3P209ZK/e/4sRdEQ/
 p8PjIHyB7e2W9tVrblbC6pBtMKG1KQ9e5W95us3FO/BQTXh6VNJF+r1oK/NY+d2BhtERG+OSxuQ
 ReCbOr0ZaWY7TN3OyxJUWCKh7pxB333HWm7jyD1iLQltBvNPh5rWqf1p2MqRWrSIcvL4l6QT1I/
 nobsSNPMRgD+EQvMkS4TtwzrgLfJpE+JJnxzf+9DplR65vZVy27v+bxD4QPO5W6JTYlzanOSsOh
 StvITUc5i3kn6P3/RPX9d9i7hvAmLjkIEt2mInTPQeNqatt0AmqZOHK3SCPSdPqxJJWZl5TRYwp
 4iiBX/qNqHwrUJ61ETlQvIQwYcFWwBc5KwEEbwdOmGs0gyJRJuw/PfiGtQ89Z3mUC8YTIrFcSDy
 CrAUAe3UHtBdXm/+NpyN+wErNhFaRi2TFmqp+3h0gAmoBEqSf+gsNT+BXHca2+YXe1eFjKAaN7j
 lRlduxn0FflbpijUOenEdl4ln91G8HwIWQhfL2WV71I+psb7a9uSroblCemCGhkXBZNIJ7OAP+D
 A0KHkmxYoDlCD3o7lwgJfKiKyxdq1/MhB9L4N192TEI/7/hhoXqEYpayjX00Vn59FtU/Ad4VX7D
 8p4ztOIBGo/vTeQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20879-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 7FFF7412FB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new fsnotify_rename_data struct and FSNOTIFY_EVENT_RENAME data
type that carries both the moved dentry and the inode that was
overwritten by the rename (if any).

Update fsnotify_data_inode(), fsnotify_data_dentry(), and
fsnotify_data_sb() to handle the new type, and add a new
fsnotify_data_rename_target() helper for extracting the overwritten
target inode.

Update fsnotify_move() to use the new data type for FS_RENAME and
FS_MOVED_TO events, passing the overwritten target inode through the
event data. FS_MOVED_FROM is unchanged since the source directory
doesn't need overwrite information.

This is done so that fsnotify consumers like nfsd can atomically
observe the overwritten file when a rename replaces an existing entry,
without needing a separate FS_DELETE event.

Assisted-by: Claude (Anthropic Claude Code)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fsnotify.h         |  8 ++++++--
 include/linux/fsnotify_backend.h | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 079c18bcdbde..bda798bc67bc 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -257,6 +257,10 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	__u32 new_dir_mask = FS_MOVED_TO;
 	__u32 rename_mask = FS_RENAME;
 	const struct qstr *new_name = &moved->d_name;
+	struct fsnotify_rename_data rd = {
+		.moved = moved,
+		.target = target,
+	};
 
 	if (isdir) {
 		old_dir_mask |= FS_ISDIR;
@@ -265,12 +269,12 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	}
 
 	/* Event with information about both old and new parent+name */
-	fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
+	fsnotify_name(rename_mask, &rd, FSNOTIFY_EVENT_RENAME,
 		      old_dir, old_name, 0);
 
 	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
 		      old_dir, old_name, fs_cookie);
-	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
+	fsnotify_name(new_dir_mask, &rd, FSNOTIFY_EVENT_RENAME,
 		      new_dir, new_name, fs_cookie);
 
 	if (target)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 66e185bd1b1b..f8c8fb7f34ae 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -311,6 +311,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_DENTRY,
 	FSNOTIFY_EVENT_MNT,
 	FSNOTIFY_EVENT_ERROR,
+	FSNOTIFY_EVENT_RENAME,
 };
 
 struct fs_error_report {
@@ -335,6 +336,11 @@ struct fsnotify_mnt {
 	u64 mnt_id;
 };
 
+struct fsnotify_rename_data {
+	struct dentry *moved;	/* the dentry that was renamed */
+	struct inode *target;	/* inode overwritten by rename, or NULL */
+};
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -348,6 +354,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return d_inode(file_range_path(data)->dentry);
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *)data)->inode;
+	case FSNOTIFY_EVENT_RENAME:
+		return d_inode(((const struct fsnotify_rename_data *)data)->moved);
 	default:
 		return NULL;
 	}
@@ -363,6 +371,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
 		return ((const struct path *)data)->dentry;
 	case FSNOTIFY_EVENT_FILE_RANGE:
 		return file_range_path(data)->dentry;
+	case FSNOTIFY_EVENT_RENAME:
+		return ((struct fsnotify_rename_data *)data)->moved;
 	default:
 		return NULL;
 	}
@@ -395,6 +405,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 		return file_range_path(data)->dentry->d_sb;
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *) data)->sb;
+	case FSNOTIFY_EVENT_RENAME:
+		return ((const struct fsnotify_rename_data *)data)->moved->d_sb;
 	default:
 		return NULL;
 	}
@@ -430,6 +442,14 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 	}
 }
 
+static inline struct inode *fsnotify_data_rename_target(const void *data,
+							int data_type)
+{
+	if (data_type == FSNOTIFY_EVENT_RENAME)
+		return ((const struct fsnotify_rename_data *)data)->target;
+	return NULL;
+}
+
 static inline const struct file_range *fsnotify_data_file_range(
 							const void *data,
 							int data_type)

-- 
2.53.0


