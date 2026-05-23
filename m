Return-Path: <linux-nfs+bounces-21883-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFYeLZfqEWqbrwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21883-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:57:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E75C0349
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8B93303EBA1
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FB34DB56;
	Sat, 23 May 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjm6d2SI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FD330B14;
	Sat, 23 May 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558941; cv=none; b=gA6B36sCRA877BqJwAJJIHf93is+NdGDEznwHmK5Xi707h3Y3QWsp2ouCOwxoKNaDJlyhJTd556qTtzTiYEWHbUR8aRkTfX1FuASEafTgcJZXvvfr2EOz39vdEP6Rk4oeD2R4/QfulIXJh5O9+2iU8E9cu3+VcW8oyVFt9OOm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558941; c=relaxed/simple;
	bh=IIc4FBJOhEeQzkBhvQ9lbobSkiYgyXqkSFDj9nvtGQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duT6QrTVRomLuJ578Ph4MDid+M4bEOaoDZ6dDhC7u/dktKB/Jv2kWX5hVKFsT/7fKrapDc1DQIjwZu045OeomCxUQrXUp5Tf9XccCnz9h1BgQ9W4/FqeUHVe8PxCKPdzpR7P0K6ub2BzpqCArumqwBSmAWMjgzdyxCvE5CLfDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjm6d2SI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D2C1F000E9;
	Sat, 23 May 2026 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558939;
	bh=Ciy3fc6rPG867pO7XlQiiPhPSYMnUaJVLh8uNzpmzP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jjm6d2SI9Nu7Hx3j1OC2PLh3FqVe4KFNVo+MSAgv41PgIQXEqGyPVMvwpSfYgKnXH
	 uzkfQ6qPea9ETsNeZobk+IVCuwvfr8LMKc2Q6kcmtsEoSQH4hnwmUngCTvzOg1hFFK
	 CIRM38hr6bBmHU+IMHxo8otBgSjrHUnlcK7YmSCGa4B+ktawZtU2XLQk7TOtPkNKfm
	 FO6jSlM6EBnZMmmQ/MVg/PXMYVhGaUjesm/iVxPHj2YthtQiCBY1qwXPlDnxfGkM5L
	 egE3jan3i9N+780/faPy3D4BiqHbima0B01JeASewk99glkhCmxR3CIG5rCUqLCQBw
	 DXOcG91KaO07g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 23 May 2026 20:54:20 +0300
Subject: [PATCH 08/17] libfs: simple_transaction_get(): replace
 get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-b4-fs-v1-8-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
To: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Kees Cook <kees@kernel.org>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21883-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 454E75C0349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

simple_transaction_get() allocates memory with get_zeroed_page(). That
memory is used as a file local buffer that is accessed using
copy_from_user() and simple_read_from_buffer().

kmalloc() is a better API for such use and it also provides better
scalability and more debugging possibilities.

Replace use of get_zeroed_page() with kzalloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 fs/libfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 1bbea5e7bae3..80a330c8296f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1258,7 +1258,7 @@ char *simple_transaction_get(struct file *file, const char __user *buf, size_t s
 	if (size > SIMPLE_TRANSACTION_LIMIT - 1)
 		return ERR_PTR(-EFBIG);
 
-	ar = (struct simple_transaction_argresp *)get_zeroed_page(GFP_KERNEL);
+	ar = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!ar)
 		return ERR_PTR(-ENOMEM);
 
@@ -1267,7 +1267,7 @@ char *simple_transaction_get(struct file *file, const char __user *buf, size_t s
 	/* only one write allowed per open */
 	if (file->private_data) {
 		spin_unlock(&simple_transaction_lock);
-		free_page((unsigned long)ar);
+		kfree(ar);
 		return ERR_PTR(-EBUSY);
 	}
 
@@ -1294,7 +1294,7 @@ EXPORT_SYMBOL(simple_transaction_read);
 
 int simple_transaction_release(struct inode *inode, struct file *file)
 {
-	free_page((unsigned long)file->private_data);
+	kfree(file->private_data);
 	return 0;
 }
 EXPORT_SYMBOL(simple_transaction_release);

-- 
2.53.0


