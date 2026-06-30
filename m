Return-Path: <linux-nfs+bounces-22898-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgocE5RURGr3swoAu9opvQ
	(envelope-from <linux-nfs+bounces-22898-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DD6E8B08
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 01:43:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YRI5XNLU;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22898-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22898-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6621B306CFD7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA4330B07;
	Tue, 30 Jun 2026 23:43:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CD33AD9B
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 23:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862983; cv=none; b=uqXRToKE9ZB3bGrHD934L3/NVmUrVkgPOFnOY3WbwE+agafYMnbR1jPRgMZBau+LP/OfYm/FNkYlA/1PpMJ+YIDES9G7jucTuHVI+Rdg3V0BInbxshrZeVHjia9cXR3GaDuQsNiExbGXF/SuF3NqPD5/bKqkp0orhtkp8yp8nS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862983; c=relaxed/simple;
	bh=0/XTuUiMpCyYFXoV3AqtWFZO3wZ6wm1dDqbLqcZ9jNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjwO6ARcAKFkO/BFteLt68pVj47kH2pZT9EQFd5E5p39ZLDFKESloO+vUI7+SmEnI/uIMjSHKrRVbW03l0eCyYLTFscqWgJhIm6DpPS2bL19UYgXo45Stj7JkD7OwDRFoW/jjoQM5ZeoxwQR6u79coklxROYiZomF035nwOFils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRI5XNLU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6131F00A3A;
	Tue, 30 Jun 2026 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862982;
	bh=eI4XoLlsKXYXD1UB4meglpSfDJVc7TEnQCRIrRRYRXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRI5XNLUPdBTw1M52ihnp0MRwVIa3bKbCxlj6d/XdzRJkw8z1irc82SaRv2E/ch0z
	 dzBeU90Ke7r9WTNO66JuVOYPMuZACKKE5EZ3JcpMcqjTg6pcpmeoMAppPJ3yHYJNDJ
	 e9iAlT3kRq9N54UL2O77MXKfR/9e38HaRW+rqVgo/QxZfwA8wT7CUHJdqJIMSzxH7J
	 +oSxI9S81p1KF/ffaMI/BL3gtQOx0cW8mjORWy3nsOKvxiE/VB39SC+TFbdm4RINMR
	 xE5OIqsaW1K8KloED//reXW+wOYXmQL6kiL9UXZ4OurD/Zad7eW8/uCJY8e8lImnMh
	 kVkVepMTJ+zNQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@hammerspace.com>,
	Chuck Lever <cel@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/6] nfs4.2: open UNCACHEABLE_FILE_DATA files with O_DIRECT
Date: Tue, 30 Jun 2026 19:42:54 -0400
Message-ID: <20260630234257.5615-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630234257.5615-1-snitzer@kernel.org>
References: <20260630234257.5615-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22898-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,vger.kernel.org:server fail,ietf.org:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ietf.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA2DD6E8B08

Honor the per-file UNCACHEABLE_FILE_DATA attribute by transparently
opening such regular files with O_DIRECT, so reads and writes bypass the
page cache as the attribute requires, without the application having to
request O_DIRECT itself.

This follows the model the specification describes: the attribute is
"similar in intent to O_DIRECT" and clients "retain flexibility in how
they satisfy the requirements" (draft-ietf-nfsv4-uncacheable-files
Section 4.4, "Relationship to Direct I/O"), and its Implementation
Status (Section 6) describes a prototype Linux client that "treats the
attribute as an indication to use O_DIRECT-like behavior for file
access".

Introduce an NFS_CONTEXT_O_DIRECT open-context flag: nfs4_atomic_open()
sets it when the resolved inode has uncacheable_file_data set (and the
open is not O_APPEND), and the open paths nfs_atomic_open() and
nfs4_file_open() apply O_DIRECT to the file when the flag is set.

The I/O mode is thus selected at open time and is not changed for an
already-open file: a later change to the attribute takes effect on the
next open.  The specification permits this -- a client that has already
opened a file MAY continue with its existing caching behavior and apply
the updated attribute to subsequent operations (Section 5).

The delegation interaction in Section 4.3 was considered: it permits read
caching to remain when another NFSv4.2 mechanism, such as a delegation,
already ensures a consistent view of the file.  That relaxation is
optional ("may remain appropriate") and read-only -- it does not relax
write-behind suppression (Section 4.1) or the WRITE durability invariant
(Section 4.2).  This implementation deliberately does not take it: an
uncacheable file is opened O_DIRECT regardless of any delegation held,
which is compliant (read caching is simply suppressed more aggressively
than the Section 4.3 minimum) and avoids decoupling read vs write caching
behind a single open flag.  Relaxing reads under a delegation is left as
a possible future optimization.

Section 6 observes the benefit holds "for applications that issue
well-formed I/O requests".  That alignment caveat does not constrain the
Linux NFS client's over-the-wire path: the client readily issues
misaligned I/O using O_DIRECT over SunRPC to the remote NFS server.  The
only place a fallback from O_DIRECT to buffered I/O for misaligned I/O
applies is NFS LOCALIO (fs/nfs/localio.c), which detects non-DIO-aligned
I/O and falls back internally; that path is unaffected by this change.

See: https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 fs/nfs/dir.c           |  4 ++++
 fs/nfs/nfs4file.c      |  2 ++
 fs/nfs/nfs4proc.c      | 10 ++++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 17 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c7b723c18620..6b07abf272b1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2208,6 +2208,10 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 	file->f_mode |= FMODE_CAN_ODIRECT;
+	if (test_bit(NFS_CONTEXT_O_DIRECT, &ctx->flags)) {
+		file->f_flags |= O_DIRECT;
+		open_flags |= O_DIRECT;
+	}
 
 	err = nfs_finish_open(ctx, ctx->dentry, file, open_flags);
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index be40e126c539..6401f6363f75 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -91,6 +91,8 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	nfs_fscache_open_file(inode, filp);
 	err = 0;
 	filp->f_mode |= FMODE_CAN_ODIRECT;
+	if (test_bit(NFS_CONTEXT_O_DIRECT, &ctx->flags))
+		filp->f_flags |= O_DIRECT;
 
 out_put_ctx:
 	put_nfs_open_context(ctx);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c8b777465ded..5bec57a2027c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3853,6 +3853,16 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 
 	if (IS_ERR(state))
 		return ERR_CAST(state);
+
+	/*
+	 * Use O_DIRECT if file was marked as Uncacheable, see:
+	 * https://datatracker.ietf.org/doc/draft-ietf-nfsv4-uncacheable-files/
+	 */
+	if (!(open_flags & O_DIRECT) && NFS_I(state->inode)->uncacheable_file_data) {
+		if (!(open_flags & O_APPEND))
+			set_bit(NFS_CONTEXT_O_DIRECT, &ctx->flags);
+	}
+
 	return state->inode;
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8552a0d778d9..48b806aa3a2f 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -110,6 +110,7 @@ struct nfs_open_context {
 #define NFS_CONTEXT_UNLOCK	(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
 #define NFS_CONTEXT_WRITE_SYNC		(5)
+#define NFS_CONTEXT_O_DIRECT		(6)
 
 	struct nfs4_threshold	*mdsthreshold;
 	struct list_head list;
-- 
2.47.3


