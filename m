Return-Path: <linux-nfs+bounces-21219-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD7jCwVe8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21219-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:13:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB147E8A9
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFC7330005BA
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D13AE183;
	Tue, 28 Apr 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGjq+Veg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7E3ACA71;
	Tue, 28 Apr 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360251; cv=none; b=luR/N0nm6LxW54wfMHKoWlLjBNtLlxJ5pqCqx+hpJLU1+jMBGfzyzWarKbzv3XarylGTXkbTT97aHcFhnkxcMbyvcqzPULPqRzSv7l2kzI/nYxo1VUVRyieKWW5CzXuSLfd+nOpcl5pvUkZym1Vzvf+OkrtZuouu2O8/NcoWhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360251; c=relaxed/simple;
	bh=3PzI7mTd8rj75uxGR+x9voTdog5T+1azejMVS7FwP6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gfca65q8YzyyW13o7jq3quBEOjZoDJh4RD28yQ+hlGmzsoHg3e8ypdWh770ly/9BFMZYn7TwNGn3tU0FixI6iJQwYC/WXnNy0XjGGEgSEhJ6LSSIKQPwrbyoiZVij/3VbaT6xdL7a1GupwAAxbq+t8Oop03i0+RKKeLmvylQrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGjq+Veg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E0BC2BCAF;
	Tue, 28 Apr 2026 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360251;
	bh=3PzI7mTd8rj75uxGR+x9voTdog5T+1azejMVS7FwP6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oGjq+VegBGknQHPDGMTvGijlWI66uV81is7LKaiCs8GB1HrxcYmOdImlhcG18Zjci
	 vJBkKoRZ3uSyMz+MQx4jxoyTm05rUPFJtEply3hYxketj3iTSYs7mOsGk9VmME8+BD
	 eSjZQIMW9x6UlT8wRgV1S0gl0ibZ5yXpOy/tL8vJbKSnUhdAgNbH5GJcd6UFk0ET/i
	 pmAi78gyZaeVNpoPXfTGLXpm2R3tUWFCKF7fnoG3Tc040JFhfzufTNHYTaewMs3aCv
	 ABDwAsIJG2W0f6MR2c0JCC5ftRbDklO4p/7nha3qnGxg9E/Rn4NxXNf407Q9T3cDQi
	 ehuQmyBZ/TJmQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:51 +0100
Subject: [PATCH v3 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-7-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4564; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3PzI7mTd8rj75uxGR+x9voTdog5T+1azejMVS7FwP6A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1OBjICLvj4mnsu3wxqDkEDO+OK7jsyf7Xo4
 Nzz3OTH/T+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdTgAKCRAADmhBGVaC
 FQBCD/4nYfZdHSyP1sFd2tHosxjWHaeD53sxPCCqXStaOKXctNj5XuzjUI2ZKfzRjIcgOyyHrfz
 UgJNICuTiXYMWHvrMZsbgIK46ZJFyBk61psdpuwdRoxm1TDBfxAtUmdM6K7MqFtb2Zx2Z3WSthI
 uEhweGjN3ZHQ4BQVRpph4uGEi/7KJgKtVn7k8EN51VtUUY3nfv35s+kkGHuP07PZXxmIN8P0x1H
 OsTQ+kUnu9EmaSUI+w1IeJ9ZiWysofuFWTkJQyEOwU14MqbYFY/A+2IN8vXrH63dxUmlNqTAVD/
 gQ7+2Zmitb4/CefxEl5Oo+sD77ytSF041NaWHN24QPjuUZdeXdK8KOMoydt3+/8i3QcdVw/3nsC
 BzmOHYRL/fgdLmj6uYHs05ARUEejhmSHRl59G3kk0ZorMUEEFqaVvGZ9Jk8ONXpfQaedpn7I7nf
 5yxleNZ7dQYB7t1dPXPXUA6LlKPoDU+qHyX/DIdFfDRq+07k39E5UdSIDrPNejcQQ/JX+qkVTOj
 HPYe7ZfNHI+W/0D70q44FGf8D3/gnuD6PKecKrjAYSjDR0j95Nx5QcmtX0t6T6t7QRqF9k2Lhjq
 eTFn/8m3UP250DdVruS0VZpqFMopqtB/vSMVFGus8KQxLbvb4f8WeOmVdhVn095tzLNnwfUaQN5
 xOjBQ/AESnSTTeg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 33EB147E8A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21219-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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
2.54.0


