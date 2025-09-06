Return-Path: <linux-nfs+bounces-14108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A4B474F5
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE16A02367
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5925A2A2;
	Sat,  6 Sep 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7CQfGJH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3C2594B9
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757177299; cv=none; b=cRnF0gHgjixilWWOc3pPkJuiXW1hApzpDEg4yvwWGZqHLjU71EOZef52d4H7T9B81t9iAXuGFmEYrgsX0FUobJ/7n0kWXvk7ZMh44sUc4vHo3o43vFG6FPBZCiEITwbty5WzCpMJkMVoxlKSxFKJnxL3oHFf6oOmO1ynxx0hEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757177299; c=relaxed/simple;
	bh=pZauyM11CntK8pSkJ8QNRjawZGUOvqDKEEB4FGp7yt8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVFhvZBcOOsiiXnjyXQ30NGe8tsHBOielySrd5D42MBEeMD7DmTO1DO8Bw0U6iq1keqw+tuBv2MLcSCljGcs/LdpviPLCKM8WIv4wTq2LhEtg6h5NGUaWfVCmQw7+YbzsdheQr7p+Kr/M+YX3Dq8oD1UIQa9r7oP6yD7xbS/Zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7CQfGJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63849C4CEF8
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757177299;
	bh=pZauyM11CntK8pSkJ8QNRjawZGUOvqDKEEB4FGp7yt8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s7CQfGJHAN7/nzt311P1PND3Fo5WxlywZeLd8XdxMXJiGJgPmqKkSCFks5nHIWOlD
	 Q1MKZEDZAQZtq6twhWSQUu3kN8cUJuX2BRzn+KOUp8bPeAXTHEETwHjigoLqbj/VW4
	 QNY+U2HKiKvIK097LY9UZNukDrSmXARqTc/C3YCixsWOGwFWlQ57UfIy8XIh9JN2x0
	 tXzlJQqSskw/6LkaQd/hlkQXYN+Rpmi4Su2Z5KfZqGbB1E2qvqOiDcDPAH/6p4BccR
	 p+DpeuhcTSuP+pFejKgZp6XI0lfMyjDuJJOLl8DX+iN85zX4JA3adIlIiI6CaC5GG1
	 z73NlL7/ouEHw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v5 3/3] NFS: Enable use of the RWF_DONTCACHE flag on the NFS client
Date: Sat,  6 Sep 2025 12:48:16 -0400
Message-ID: <3c81beb1e2ee8e56a86f0de4598507c8465613fa.1757177140.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757177140.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com> <cover.1757177140.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The NFS client needs to defer dropbehind until after any writes to the
folio have been persisted on the server. Since this may be a 2 step
process, use folio_end_writeback_no_dropbehind() to allow release of the
writeback flag, and then call folio_end_dropbehind() once the COMMIT is
done.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c     | 9 +++++----
 fs/nfs/nfs4file.c | 1 +
 fs/nfs/write.c    | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8059ece82468..9025c93bcaf1 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -361,6 +361,8 @@ static bool nfs_want_read_modify_write(struct file *file, struct folio *folio,
 
 	if (pnfs_ld_read_whole_page(file_inode(file)))
 		return true;
+	if (folio_test_dropbehind(folio))
+		return false;
 	/* Open for reading too? */
 	if (file->f_mode & FMODE_READ)
 		return true;
@@ -380,7 +382,6 @@ static int nfs_write_begin(const struct kiocb *iocb,
 			   loff_t pos, unsigned len, struct folio **foliop,
 			   void **fsdata)
 {
-	fgf_t fgp = FGP_WRITEBEGIN;
 	struct folio *folio;
 	struct file *file = iocb->ki_filp;
 	int once_thru = 0;
@@ -390,10 +391,8 @@ static int nfs_write_begin(const struct kiocb *iocb,
 		file, mapping->host->i_ino, len, (long long) pos);
 	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos);
 
-	fgp |= fgf_set_order(len);
 start:
-	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp,
-				    mapping_gfp_mask(mapping));
+	folio = write_begin_get_folio(iocb, mapping, pos >> PAGE_SHIFT, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	*foliop = folio;
@@ -405,6 +404,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, folio, pos, len)) {
 		once_thru = 1;
+		folio_clear_dropbehind(folio);
 		ret = nfs_read_folio(file, folio);
 		folio_put(folio);
 		if (!ret)
@@ -949,5 +949,6 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c9a0d1e420c6..7f43e890d356 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -456,4 +456,5 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+	.fop_flags	= FOP_DONTCACHE,
 };
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 647c53d1418a..a671de3dda07 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -296,7 +296,7 @@ static void nfs_folio_end_writeback(struct folio *folio)
 {
 	struct nfs_server *nfss = NFS_SERVER(folio->mapping->host);
 
-	folio_end_writeback(folio);
+	folio_end_writeback_no_dropbehind(folio);
 	if (atomic_long_dec_return(&nfss->writeback) <
 	    NFS_CONGESTION_OFF_THRESH) {
 		nfss->write_congested = 0;
@@ -745,6 +745,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
 		}
 		spin_unlock(&mapping->i_private_lock);
+
+		folio_end_dropbehind(folio);
 	}
 	nfs_page_group_unlock(req);
 
-- 
2.51.0


