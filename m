Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFAA23CC7B
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHEQsJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 12:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgHEQpU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 12:45:20 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61118235FC
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596644215;
        bh=4IXuXNxvGfeK4Lm/RyUj3pAht3o7OOXUoJtD6gkHrkc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HpdiqxKXSklZxbJVINZe07HxsqUTBjokau1AkEO3otFqqRFe0+A7F/lCFj4T6T36o
         3KhCWse+CXLU1hCiB0Tq5ykwX3CvoNBt4QgOAik411Zib6TlRKGvM8+edIx2jmOP5s
         XklDjChFG+occ5UxwCzNYhEfWdAEinW+FcW9LHu0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Add layout segment info to pnfs read/write/commit tracepoints
Date:   Wed,  5 Aug 2020 12:14:46 -0400
Message-Id: <20200805161446.383482-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805161446.383482-2-trondmy@kernel.org>
References: <20200805161446.383482-1-trondmy@kernel.org>
 <20200805161446.383482-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Allow the pnfs I/O tracepoints to trace which layout segment is being
used.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4trace.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 61c33536dcf3..072a35adb0e3 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1745,6 +1745,8 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
+			__field(int, layoutstateid_seq)
+			__field(u32, layoutstateid_hash)
 		),
 
 		TP_fast_assign(
@@ -1754,6 +1756,8 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 						  hdr->args.fh : &nfsi->fh;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
+			const struct pnfs_layout_segment *lseg = hdr->lseg;
+			const struct pnfs_layout_hdr *lo = lseg->pls_layout;
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
@@ -1766,11 +1770,15 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 				be32_to_cpu(state->stateid.seqid);
 			__entry->stateid_hash =
 				nfs_stateid_hash(&state->stateid);
+			__entry->layoutstateid_seq = lseg->pls_seq;
+			__entry->layoutstateid_hash =
+				nfs_stateid_hash(&lo->plh_stateid);
 		),
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%u res=%u stateid=%d:0x%08x",
+			"offset=%lld count=%u res=%u stateid=%d:0x%08x "
+			"layoutstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1778,7 +1786,8 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			__entry->fhandle,
 			(long long)__entry->offset,
 			__entry->arg_count, __entry->res_count,
-			__entry->stateid_seq, __entry->stateid_hash
+			__entry->stateid_seq, __entry->stateid_hash,
+			__entry->layoutstateid_seq, __entry->layoutstateid_hash
 		)
 );
 #define DEFINE_NFS4_READ_EVENT(name) \
@@ -1811,6 +1820,8 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
+			__field(int, layoutstateid_seq)
+			__field(u32, layoutstateid_hash)
 		),
 
 		TP_fast_assign(
@@ -1820,6 +1831,8 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 						  hdr->args.fh : &nfsi->fh;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
+			const struct pnfs_layout_segment *lseg = hdr->lseg;
+			const struct pnfs_layout_hdr *lo = lseg->pls_layout;
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
@@ -1832,11 +1845,15 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 				be32_to_cpu(state->stateid.seqid);
 			__entry->stateid_hash =
 				nfs_stateid_hash(&state->stateid);
+			__entry->layoutstateid_seq = lseg->pls_seq;
+			__entry->layoutstateid_hash =
+				nfs_stateid_hash(&lo->plh_stateid);
 		),
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%u res=%u stateid=%d:0x%08x",
+			"offset=%lld count=%u res=%u stateid=%d:0x%08x "
+			"layoutstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1844,7 +1861,8 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			__entry->fhandle,
 			(long long)__entry->offset,
 			__entry->arg_count, __entry->res_count,
-			__entry->stateid_seq, __entry->stateid_hash
+			__entry->stateid_seq, __entry->stateid_hash,
+			__entry->layoutstateid_seq, __entry->layoutstateid_hash
 		)
 );
 
@@ -1875,6 +1893,8 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			__field(unsigned long, error)
 			__field(loff_t, offset)
 			__field(u32, count)
+			__field(int, layoutstateid_seq)
+			__field(u32, layoutstateid_hash)
 		),
 
 		TP_fast_assign(
@@ -1882,6 +1902,9 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			const struct nfs_fh *fh = data->args.fh ?
 						  data->args.fh : &nfsi->fh;
+			const struct pnfs_layout_segment *lseg = data->lseg;
+			const struct pnfs_layout_hdr *lo = lseg ?
+						  lseg->pls_layout : NULL;
 
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
@@ -1889,18 +1912,22 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
 			__entry->error = error < 0 ? -error : 0;
+			__entry->layoutstateid_seq = lseg ? lseg->pls_seq : 0;
+			__entry->layoutstateid_hash = lo ?
+					nfs_stateid_hash(&lo->plh_stateid) : 0;
 		),
 
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld count=%u",
+			"offset=%lld count=%u layoutstateid=%d:0x%08x",
 			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
 			(long long)__entry->offset,
-			__entry->count
+			__entry->count,
+			__entry->layoutstateid_seq, __entry->layoutstateid_hash
 		)
 );
 #define DEFINE_NFS4_COMMIT_EVENT(name) \
-- 
2.26.2

