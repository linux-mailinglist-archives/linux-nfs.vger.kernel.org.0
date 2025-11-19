Return-Path: <linux-nfs+bounces-16546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB017C6F203
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 15:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 185912FA00
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8BD3612D4;
	Wed, 19 Nov 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWxFn37s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0D361DCC
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560709; cv=none; b=kX79p05SkeNhngsqH5HdOs1IS5OR3NaFc18eQf+6Og93DSlmDps4bhulQeEgRRMLxwEybZ69F+W0ugzKlxZfKZYk4Xboyh6hrfv47gdWy1y86/+UTkL0Tm0PoE913YF7vRgLqBFWNpGAUoOEAA92GgpF6ipyo08T1OJlmLqr2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560709; c=relaxed/simple;
	bh=WADlRR0SUWGIeL5SG2D5OVRMkRIgZ53RQD4lEEehnvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iImHTicsZyNYMeTexC8r5u2mTAy3oV/W9ZWi42b911uYefc9OFc5zNP6Ksw4HifzVcUmkJoV8S22e7MH4KzEiOtlF24V6Wa/x/9rAMsNM+jpW0/R5kPsho3L6b7AftxsOorlR4D3ReSAhK05LEOYTJFQTjBWtdSnW/kNUf+zazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWxFn37s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACA0C116C6;
	Wed, 19 Nov 2025 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763560709;
	bh=WADlRR0SUWGIeL5SG2D5OVRMkRIgZ53RQD4lEEehnvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWxFn37so0fCjd91A7go6ZqXEHOv1OcnE9m1ymirL+8ri98TGyANge0eroEbbBFVu
	 jdfmwt/5FFM5R6hNmKQluiVkchIIn0joaY4fIeoQUGwRN0SLdLdGQMf9Zhq4o2aIrS
	 qY1JUr2dY4bUx0uyls76Glw8w5CP5SFnQnXSfXC9K6FHQzetlsNp2subVyH/LBF07/
	 J4nMK6icNVTesh8R2j6rled+rz9u1H0qvcDcokPWNSzT4bPuSzO0nxMJo8twi/jtzB
	 /tERTv3boC9oZBSDzLa5sjKnrs6Rn+7Sj3/S9HaZ/LzFNNBlJfgZ4PNgxwKNO6Zayf
	 Q51f4ifakJ94Q==
From: Trond Myklebust <trondmy@kernel.org>
To: Michael Stoler <michael.stoler@vastdata.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Initialise verifiers for visible dentries in readdir and lookup
Date: Wed, 19 Nov 2025 08:58:24 -0500
Message-ID: <9bd545539b233725a3416801f7c374bff0327d6e.1763560328.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763560328.git.trond.myklebust@hammerspace.com>
References: <53bc46637bdc4b267a318c74fb4c97cb382f29d1.camel@kernel.org> <cover.1763560328.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the verifiers are initialised before calling
d_splice_alias() in both nfs_prime_dcache() and nfs_lookup().

Reported-by: Michael Stoler <michael.stoler@vastdata.com>
Fixes: a1147b8281bd ("NFS: Fix up directory verifier races")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d557b0443e8b..2eead7e85be5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -789,16 +789,17 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		goto out;
 	}
 
+	nfs_set_verifier(dentry, dir_verifier);
 	inode = nfs_fhget(dentry->d_sb, entry->fh, entry->fattr);
 	alias = d_splice_alias(inode, dentry);
 	d_lookup_done(dentry);
 	if (alias) {
 		if (IS_ERR(alias))
 			goto out;
+		nfs_set_verifier(alias, dir_verifier);
 		dput(dentry);
 		dentry = alias;
 	}
-	nfs_set_verifier(dentry, dir_verifier);
 	trace_nfs_readdir_lookup(d_inode(parent), dentry, 0);
 out:
 	dput(dentry);
@@ -1994,13 +1995,14 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	nfs_lookup_advise_force_readdirplus(dir, flags);
 
 no_entry:
+	nfs_set_verifier(dentry, dir_verifier);
 	res = d_splice_alias(inode, dentry);
 	if (res != NULL) {
 		if (IS_ERR(res))
 			goto out;
+		nfs_set_verifier(res, dir_verifier);
 		dentry = res;
 	}
-	nfs_set_verifier(dentry, dir_verifier);
 out:
 	trace_nfs_lookup_exit(dir, dentry, flags, PTR_ERR_OR_ZERO(res));
 	nfs_free_fattr(fattr);
-- 
2.51.1


