Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8924D421108
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhJDOMG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhJDOMG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEA7361216;
        Mon,  4 Oct 2021 14:10:16 +0000 (UTC)
Subject: [PATCH 4/4] NFS: Instrument i_size_write()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:10:16 -0400
Message-ID: <163335661619.1225.5861633622925043275.stgit@morisot.1015granger.net>
In-Reply-To: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Generate a trace event whenever the NFS client modifies the size of
a file. These new events aid troubleshooting workloads that trigger
races around size updates.

There are four new trace points, all named nfs_size_something so
they are easy to grep for or enable as a group with a single glob.

Size updated on the server:

  kworker/u24:10-194   [010]   369.939174: nfs_size_update:      fileid=00:28:2 fhandle=0x36fbbe51 version=1752899344277980615 cursize=250471 newsize=172083

Server-side size update reported via NFSv3 WCC attributes:

             fsx-1387  [006]   380.760686: nfs_size_wcc:         fileid=00:28:2 fhandle=0x36fbbe51 version=1752899355909932456 cursize=146792 newsize=171216

File has been truncated locally:

             fsx-1387  [007]   369.437421: nfs_size_truncate:    fileid=00:28:2 fhandle=0x36fbbe51 version=1752899231200117272 cursize=215244 newsize=0

File has been extended locally:

             fsx-1387  [007]   369.439213: nfs_size_grow:        fileid=00:28:2 fhandle=0x36fbbe51 version=1752899343704248410 cursize=258048 newsize=262144

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/inode.c    |    9 +++------
 fs/nfs/nfstrace.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/write.c    |    1 +
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 853213b3a209..7994a3629ccb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -666,6 +666,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_t offset)
 	if (err)
 		goto out;
 
+	trace_nfs_size_truncate(inode, offset);
 	i_size_write(inode, offset);
 	/* Optimisation */
 	if (offset == 0)
@@ -1453,6 +1454,7 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			&& (fattr->valid & NFS_ATTR_FATTR_SIZE)
 			&& i_size_read(inode) == nfs_size_to_loff_t(fattr->pre_size)
 			&& !nfs_have_writebacks(inode)) {
+		trace_nfs_size_wcc(inode, fattr->size);
 		i_size_write(inode, nfs_size_to_loff_t(fattr->size));
 	}
 }
@@ -2095,16 +2097,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			/* Do we perhaps have any outstanding writes, or has
 			 * the file grown beyond our last write? */
 			if (!nfs_have_writebacks(inode) || new_isize > cur_isize) {
+				trace_nfs_size_update(inode, new_isize);
 				i_size_write(inode, new_isize);
 				if (!have_writers)
 					invalid |= NFS_INO_INVALID_DATA;
 			}
-			dprintk("NFS: isize change on server for file %s/%ld "
-					"(%Ld to %Ld)\n",
-					inode->i_sb->s_id,
-					inode->i_ino,
-					(long long)cur_isize,
-					(long long)new_isize);
 		}
 		if (new_isize == 0 &&
 		    !(fattr->valid & (NFS_ATTR_FATTR_SPACE_USED |
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4094e2856cf9..228bdf010eb6 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -231,6 +231,56 @@ TRACE_EVENT(nfs_access_exit,
 		)
 );
 
+DECLARE_EVENT_CLASS(nfs_update_size_class,
+		TP_PROTO(
+			const struct inode *inode,
+			loff_t new_size
+		),
+
+		TP_ARGS(inode, new_size),
+
+		TP_STRUCT__entry(
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(loff_t, cur_size)
+			__field(loff_t, new_size)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->fileid = nfsi->fileid;
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->cur_size = i_size_read(inode);
+			__entry->new_size = new_size;
+		),
+
+		TP_printk(
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu cursize=%lld newsize=%lld",
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->version,
+			__entry->cur_size, __entry->new_size
+		)
+);
+
+#define DEFINE_NFS_UPDATE_SIZE_EVENT(name) \
+	DEFINE_EVENT(nfs_update_size_class, nfs_size_##name, \
+			TP_PROTO( \
+				const struct inode *inode, \
+				loff_t new_size \
+			), \
+			TP_ARGS(inode, new_size))
+
+DEFINE_NFS_UPDATE_SIZE_EVENT(truncate);
+DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
+DEFINE_NFS_UPDATE_SIZE_EVENT(update);
+DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
+
 #define show_lookup_flags(flags) \
 	__print_flags(flags, "|", \
 			{ LOOKUP_FOLLOW, "FOLLOW" }, \
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index eae9bf114041..1ded0d232ece 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -288,6 +288,7 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 	end = page_file_offset(page) + ((loff_t)offset+count);
 	if (i_size >= end)
 		goto out;
+	trace_nfs_size_grow(inode, end);
 	i_size_write(inode, end);
 	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);


