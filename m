Return-Path: <linux-nfs+bounces-3872-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B790A1BF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583BE1F21175
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E2175BE;
	Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9rwefPb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D314AB8
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587515; cv=none; b=DppY+tPAbmZDJCgT7nAKopeCgsewt6VUGE7DVeSwEV9I5LCz+qPZX2KZCPV7IlKkRH+ywMJncI5sAH/G9g0dszgH+/qa22AjhpcXs1py3fsV2iabKzEJ42PVIbdEyMahM08nmwZhX5h0VTry37AxMPozYBXj4zQfdKAYzQmG+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587515; c=relaxed/simple;
	bh=X7UbP5XUAQHqhB+kaWsTLdqYVttx/NB91m5T/BoyC6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uurZ5wCai7VfaVdwEwI/yWoI+tVQp51I7xlNxg2ye0VofwMylpqFo5OyLNqx7eNMH99OrQIbauTiulWxxFSoMY/4hMf1A5TES8YG2wxiekVt8zM285v+Toww/qdc75fV/BPFnX9AFS6/9x5/RuBNXovJ5Zf8cRFtfjX08s/Wg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9rwefPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA94AC32786
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587515;
	bh=X7UbP5XUAQHqhB+kaWsTLdqYVttx/NB91m5T/BoyC6s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g9rwefPbCRUuG3hXR4M4ZRgZ+eVzwpGclubxmjNYarWqNTlWQwlBGWsMkh8WPij9E
	 DvkaNYEi5bhcY5tVZQepZYUwJ1bYKdDrcNQac+GY8YrebbJIcVHz6pA/RKvgu0DnQD
	 GZVyWV6Tg72gBKgvXSPdYYXrdQOArq0EUEgTF71t7yicK6RG0YXEP0h6CCjn6ihB6O
	 w8FSHO+aDjYxRsLN4mziru5ddwcEVjQw+Uwnga5+OovX9ISwm6YTEqksNhGsSetnmf
	 2agkT490Rscn2JIcwDnqXGtxsuH2s4SnCtRY08Wv5VPR+nim0GZsIE/n7cHWdzakFv
	 d5Y5+1Onp07Kw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/19] NFSv4: Don't request atime/mtime/size if they are delegated to us
Date: Sun, 16 Jun 2024 21:21:31 -0400
Message-ID: <20240617012137.674046-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-13-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

If the timestamps and size are delegated to the client, then it is
authoritative w.r.t. their values, so we should not be requesting those
values from the server.
Note that this allows us to optimise away most GETATTR calls if the only
changes to the attributes are the result of read() or write().

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 88edeaf5b5d5..cbd340cd825e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -310,6 +310,18 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 		dst[1] &= ~FATTR4_WORD1_MODE;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
 		dst[1] &= ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
+
+	if (nfs_have_delegated_mtime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+		if (!(cache_validity & NFS_INO_INVALID_MTIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
+		if (!(cache_validity & NFS_INO_INVALID_CTIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
+	} else if (nfs_have_delegated_atime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+	}
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -3414,7 +3426,8 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		.inode = inode,
 		.stateid = &arg.stateid,
 	};
-	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE;
+	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE |
+				     NFS_INO_INVALID_CTIME;
 	int err;
 
 	if (sattr->ia_valid & (ATTR_MODE | ATTR_KILL_SUID | ATTR_KILL_SGID))
@@ -4978,8 +4991,9 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 		goto out;
 
 	nfs4_inode_make_writeable(inode);
-	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.fattr->label), inode,
-				NFS_INO_INVALID_CHANGE);
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.fattr->label),
+				inode,
+				NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME);
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
 		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
-- 
2.45.2


