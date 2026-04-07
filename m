Return-Path: <linux-nfs+bounces-20690-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMJDGc8F1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20690-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:25:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF43AF058
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E649330B062D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19773B7778;
	Tue,  7 Apr 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnCqLrjt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5383B7769;
	Tue,  7 Apr 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568149; cv=none; b=B1ZU68T3CNW9zUOJ4w8jqcbM8LIzTiu6PA/wLgX4aZthbZGFAJuBuSzGG+ZK/NEpdVs46Ogl1wAcwCeJ0HWKGJa7p20wj463NiD4kC1KumO7hAmi0MrMV0dZ8Jh8gYq12lPrWTIdELoqmazKAJc9CIc6C1qvYKtnp8bS5tOrd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568149; c=relaxed/simple;
	bh=nkFmX2Mfye18XQtESCi4FsaKjk012eRExu5WCQ+gHRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eRXYYJ9iXOilQZKb9ZO6CWjrbQ0TTfY43EDfppppGoYypQVsxq2d1ZTJMsqjxiSz1TF/61ci0luzoGV6+teDvnocEIwYbS+bfyIrGg5MKvsDSHsT908/hcWILxA/gH/80TcyW2xe+h9Sto0+md8E+Q0t4yQq2Ie+fcRuWaPnc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnCqLrjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A986C19424;
	Tue,  7 Apr 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568149;
	bh=nkFmX2Mfye18XQtESCi4FsaKjk012eRExu5WCQ+gHRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SnCqLrjtqLfN8EF1DqSGWjgSK9lo1fF9paPunJa97pz+zY/VfBAwooK/wSZK/ITTA
	 XPfZP6a2Ekh7lePlVXB8AK6zn0+qykQXsX8zJ5Guq31TddluO3dlSdhR+nXUtoIvNS
	 DmqdkfFRQzGnAROY22HBvN7eC9weVKdoy9ZHYurUT7nchAV5Ng3IPKnAQUMbaE3JBE
	 nbTvPEiCDmg/ToYGYPwFBJQ7vTfB8NvIcIuDQ2s8geYq6E5TzlzAOxQoFB9UC9id5W
	 My7c58SsGJEnBXWErudMc4FTfxGn42TH0hKBOfVkkGgznDJa5hw9r4ePLKtoKIKLgh
	 BmqO17+flNJqw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:16 -0400
Subject: [PATCH 03/24] filelock: add an inode_lease_ignore_mask helper
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-3-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nkFmX2Mfye18XQtESCi4FsaKjk012eRExu5WCQ+gHRU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUDcEeGmoDoT17X1wAV27PrpJ2DbRi1NKDkZ
 ejuNiNVCimJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFAwAKCRAADmhBGVaC
 FQ1SEACNKYjjMZ+e0reHSlZVaYMPM7jlMUjKTfnAKnR+SxwbZKILPqaxAw562KwFBqaCECYOcDX
 AvW8tmTXKXy3fhe+y6KBQIeLvYMqCTH43NgQK5asE/jyT/GLlc07ugnSfY80iFHT+32hggoQyRO
 KpG0qdbec76VZp8wOTZJ8q8uRftzwbH/YQj+n9KShCNt0HJfNTNzAk6k9/I1X0gExGS+WQSYdWl
 A63QUizH4DRbs6iaUM4OF/91nGhhA+bDVwF/aI0WblwbHs0JKh/7FgANZ0B0nITz/EMKhO04B8K
 JWjr9C/WIDiAHXkasx35+tDVpp2eXA72UGOJIYC/TetN+7TpjN2tgHDCupcPbyl7fEomjmM04MN
 sFYEDSUpBi9x9tYXgNNV+XOC7AMo8si9/LLvY64lGOcOvQZFwtzvdcl14/NIwX7OSM4WTK6gCDs
 5KDKTC0jOJxtELKoxZw+TlyaEEgvNU3LDSyworjBqVgFSMF48OID7CwY9ra5GUtd5KOO4gyHYkY
 yulrSFo7ijZEuhAXHKodB+eXF2Dh8zd70Aezs195FGiKCI3gdZvLQPSWphAkqJJJidop9eweJQt
 phw0XarLTwrxWY1QmOCjDzwUtKHvlPm6PGhZRA9thmo8s1J4Me6itdDTovYMaHyPvQzRq3V7ZJ3
 blC+nOeqQS9SHGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20690-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11BF43AF058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new routine that returns a mask of all dir change events that are
currently ignored by any leases. nfsd will use this to determine how to
configure the fsnotify_mark mask.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 32 ++++++++++++++++++++++++++++++++
 include/linux/filelock.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 5af6dca2d46c..04980b065734 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1597,6 +1597,38 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 	return false;
 }
 
+#define IGNORE_MASK	(FL_IGN_DIR_CREATE | FL_IGN_DIR_DELETE | FL_IGN_DIR_RENAME)
+
+/**
+ * inode_lease_ignore_mask - return union of all ignored inode events for this inode
+ * @inode: inode of which to get ignore mask
+ *
+ * Walk the list of leases, and return the result of all of
+ * their FL_IGN_DIR_* bits or'ed together.
+ */
+u32
+inode_lease_ignore_mask(struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	struct file_lock_core *flc;
+	u32 mask = 0;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return 0;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		mask |= flc->flc_flags & IGNORE_MASK;
+		/* If we already have everything, we can stop */
+		if (mask == IGNORE_MASK)
+			break;
+	}
+	spin_unlock(&ctx->flc_lock);
+	return mask;
+}
+EXPORT_SYMBOL_GPL(inode_lease_ignore_mask);
+
 static bool
 ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
 {
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 5a19cdb047da..416483b136f1 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -236,6 +236,7 @@ int generic_setlease(struct file *, int, struct file_lease **, void **priv);
 int kernel_setlease(struct file *, int, struct file_lease **, void **);
 int vfs_setlease(struct file *, int, struct file_lease **, void **);
 int lease_modify(struct file_lease *, int, struct list_head *);
+u32 inode_lease_ignore_mask(struct inode *inode);
 
 struct notifier_block;
 int lease_register_notifier(struct notifier_block *);

-- 
2.53.0


