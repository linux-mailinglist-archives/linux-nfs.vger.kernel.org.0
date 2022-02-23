Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1554C1DB6
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiBWVWc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242466AbiBWVUG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE24EA0A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7882D61650
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE9EC340F0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651178;
        bh=DO85EH76fBLzq2Lx6U0jdtZbfqiWZXFuQjyk/xJBHI8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FVYu5IOIfRuOdFUgPK4okMFd/2gKjMXMkL0daW0e3/Mi2chdyBt7L+YwsggMMwjZ0
         fVMJSPck3+xde1Wjjsk95jlSqRc47ewJvXjI9YY3scy7DVJ+SKetCs+xKUGoVp60Kd
         dcaono2PvHwYSPOoxOCKrYkvKmDrTJ9Dw/YSs8XsfLxHSNepo7a9Fwy6aIPQWENtFQ
         JoyBz2h7tVmDINt1RLNTy8rQTZJziGA74XkJzR3+CsR4qh8j5FSmJCaFjOqSSuULzV
         Ik9G572WjJikDEVy70kVrvhV8p90HjHtcptvnH/bxcUCS/0+yUkW23epYgFmtZaEeh
         rC8lfgSoS78ew==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 16/21] NFS: Add basic readdir tracing
Date:   Wed, 23 Feb 2022 16:13:00 -0500
Message-Id: <20220223211305.296816-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-16-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
 <20220223211305.296816-12-trondmy@kernel.org>
 <20220223211305.296816-13-trondmy@kernel.org>
 <20220223211305.296816-14-trondmy@kernel.org>
 <20220223211305.296816-15-trondmy@kernel.org>
 <20220223211305.296816-16-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add tracing to track how often the client goes to the server for updated
readdir information.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 13 ++++++++-
 fs/nfs/nfstrace.h | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 54f0d37485d5..41e2d02d8611 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -969,10 +969,14 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
 		desc->page_index_max = desc->page_index;
+		trace_nfs_readdir_cache_fill(desc->file, nfsi->cookieverf,
+					     desc->last_cookie,
+					     desc->page_index, desc->dtsize);
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
 			nfs_readdir_page_unlock_and_put_cached(desc);
+			trace_nfs_readdir_cache_fill_done(inode, res);
 			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
 				invalidate_inode_pages2(desc->file->f_mapping);
 				desc->page_index = 0;
@@ -1090,7 +1094,14 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->duped = 0;
 	desc->page_index_max = 0;
 
+	trace_nfs_readdir_uncached(desc->file, desc->verf, desc->last_cookie,
+				   -1, desc->dtsize);
+
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
+	if (status < 0) {
+		trace_nfs_readdir_uncached_done(file_inode(desc->file), status);
+		goto out_free;
+	}
 
 	for (i = 0; !desc->eob && i < sz && arrays[i]; i++) {
 		desc->page = arrays[i];
@@ -1109,7 +1120,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 			 i < (desc->page_index_max >> 1))
 			nfs_shrink_dtsize(desc);
 	}
-
+out_free:
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 3672f6703ee7..c2d0543ecb2d 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -160,6 +160,8 @@ DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
+DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_cache_fill_done);
+DEFINE_NFS_INODE_EVENT_DONE(nfs_readdir_uncached_done);
 
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
@@ -271,6 +273,72 @@ DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
 DEFINE_NFS_UPDATE_SIZE_EVENT(update);
 DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
 
+DECLARE_EVENT_CLASS(nfs_readdir_event,
+		TP_PROTO(
+			const struct file *file,
+			const __be32 *verifier,
+			u64 cookie,
+			pgoff_t page_index,
+			unsigned int dtsize
+		),
+
+		TP_ARGS(file, verifier, cookie, page_index, dtsize),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, version)
+			__array(char, verifier, NFS4_VERIFIER_SIZE)
+			__field(u64, cookie)
+			__field(pgoff_t, index)
+			__field(unsigned int, dtsize)
+		),
+
+		TP_fast_assign(
+			const struct inode *dir = file_inode(file);
+			const struct nfs_inode *nfsi = NFS_I(dir);
+
+			__entry->dev = dir->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->version = inode_peek_iversion_raw(dir);
+			if (cookie != 0)
+				memcpy(__entry->verifier, verifier,
+				       NFS4_VERIFIER_SIZE);
+			else
+				memset(__entry->verifier, 0,
+				       NFS4_VERIFIER_SIZE);
+			__entry->cookie = cookie;
+			__entry->index = page_index;
+			__entry->dtsize = dtsize;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu "
+			"cookie=%s:0x%llx cache_index=%lu dtsize=%u",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid, __entry->fhandle,
+			__entry->version, show_nfs4_verifier(__entry->verifier),
+			(unsigned long long)__entry->cookie, __entry->index,
+			__entry->dtsize
+		)
+);
+
+#define DEFINE_NFS_READDIR_EVENT(name) \
+	DEFINE_EVENT(nfs_readdir_event, name, \
+			TP_PROTO( \
+				const struct file *file, \
+				const __be32 *verifier, \
+				u64 cookie, \
+				pgoff_t page_index, \
+				unsigned int dtsize \
+				), \
+			TP_ARGS(file, verifier, cookie, page_index, dtsize))
+
+DEFINE_NFS_READDIR_EVENT(nfs_readdir_cache_fill);
+DEFINE_NFS_READDIR_EVENT(nfs_readdir_uncached);
+
 DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_PROTO(
 			const struct inode *dir,
-- 
2.35.1

