Return-Path: <linux-nfs+bounces-21216-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJvoKaFe8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21216-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:15:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B957047E9B6
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A24D3063D7E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE673B0ADD;
	Tue, 28 Apr 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRn6bOKR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834B3AC0CB;
	Tue, 28 Apr 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360238; cv=none; b=jxpy32/TyhFURK43hJvy3g1eQiOtoI1SsWMv9rFfwcIMKtxAukVGg24gK4uRc+S6PVTo5qUyGAKq+yA+Ezk/Q+n5UgN95dJkS27eFVqZo0ENIc3yaM2bdLOsVNIU6VK5Dhy6CaNgvX7aOJYroCMVLxO8kaUNg+5Bqk6mgHuuLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360238; c=relaxed/simple;
	bh=IuBgyfioZ3xNhDmwdST2xiPVoLcfcrwzjswVVDGmPJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1cPVVj0mgSdYL+eqFioo2BSJrlNXc1rtjH+a3wY2MnmIttNetcITUZ/Hisl5LEl9gY7L9GYLThBWP02EJY2daqPancd7tfHf3HSptb5W0CldfaN/ndDPiOHJPTn6B3PdBEHyQn9ZKKUMcco59WJPvoS5HA3edXjgXoIWXGYodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRn6bOKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD4C2BCB6;
	Tue, 28 Apr 2026 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360238;
	bh=IuBgyfioZ3xNhDmwdST2xiPVoLcfcrwzjswVVDGmPJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RRn6bOKROAyFS3XJrswkFC6WT+xnM2NR9asW23E7H3xfwOZ7oi3+5QcL6m2RehX/0
	 o40xvpMyeQhYo+0zF0h7cjT7DT331+sL3i+qheQZsRTLIBqphu662u3/xp+GMy7Sx6
	 KP3Qs3HdHkc7LEJgzCjnwyBsR8B26EHipsT9q5RHZEl8Wsnu3li1bk8tXq8oIr3ARY
	 gUFf1DUM1IboG2dD4UJPhQt85PY8hO/3GaIy4/3/Z2dvjPC0zkeTbKU3pPDjBSS1Ne
	 WA88jr7b8Uz4Ag/0VyohbYSAYcfEjlulEwAx7zCmENhfnf1VAGmPoN8nAYhPz/VCsi
	 qG16eNaKfSNZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:48 +0100
Subject: [PATCH v3 04/28] filelock: add an inode_lease_ignore_mask helper
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-4-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IuBgyfioZ3xNhDmwdST2xiPVoLcfcrwzjswVVDGmPJA=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGnwXU2hh0ZZO/L8wq2UGnaq4tqa5dMqjCV3yarG8+4DGecGW
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJp8F1NAAoJEAAOaEEZVoIVOWMQAJoQ
 vKpMcnY9DVgRhALHuwyFFoJS5Iy0uPEs52rbkCnJAcwsDnQyXZdmN+8H60CCbtt6s4IT/INW+IO
 UR9jhD9rNqp0LbdMqINJsQLbqi3njvjNA89/nhW8MYb3/uijynDL0J/BFyJMvr/miAjdTSKhDAU
 xTZ4ShQDvrJkARzrjoCNE704N9H7o/bX6twyUr9lk8pERftGEO05UoNcMHHUVkMqdSvREP6ICVQ
 Wgqonroe7GQsc5uhv3RsJBHHjIE7Qh3rAycnHKVMMdMWnWlCXkY6bEfBWs+EQjMypKL+eZ/Wvs/
 fqb3WKiRRidL6XOtn/DOzJpvls0z1twEnNFP4mwOL9e6f2elBGUR18BQM4HqV/FCw5Gb0ffZrMw
 75d6dBFHNxzypluzuxl1c+Znbt1b9+ViWaJABRBdQwmTgTMjjuFV3ypF5wPJqbwvjLBWfNtGl75
 h0NG3K+d6Zot6UPvENl2bDTeyhSyrcG0aW52cBXZFv2dgNYK0B1ki4jLYIXJvm+jDVI/Iz738fl
 L4r8xA0BCVTdC68lGyyVhNIZZsdWH6TxUyvxEM5gIb1wr7jjo667m3L64TVzTczNotWA/8mZu5H
 66bhYNKs5jpf8kGsFeBDpXB3tOZO+71DuSNXyixuWug+jmVEn2BBuzQ/ixhMPoHKCBq/ew9EGDB
 X7lQH
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B957047E9B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21216-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add a new routine that returns a mask of all dir change events that are
currently ignored by any leases. nfsd will use this to determine how to
configure the fsnotify_mark mask.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 32 ++++++++++++++++++++++++++++++++
 include/linux/filelock.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 792c3920b33a..61f64b261282 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1582,6 +1582,38 @@ static bool leases_conflict(struct file_lock_core *lc, struct file_lock_core *bc
 	return rc;
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
index 9dd4e67a6f30..6e125902c58a 100644
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
2.54.0


