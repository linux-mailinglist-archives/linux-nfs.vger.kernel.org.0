Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A36183FE
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiKCQRs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKCQRr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 12:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6258186DC
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667492207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6BR26WY45da2HKwNJhtAF7JVmHpbn/c+XtR1jiBgmA=;
        b=VSQ9JtkG4GHtwmF40yo3Kwnl3wKfEKkzpqmg915+utX0xL1Y9Oxi2dbtnYJEgcM6MGYnAX
        FRdgk417tZnhS4GQXhVBMe7OFleYKJRwQ++AtZeMuSwqsFH9VSNBLS1jHiQkPkGz4XvWvo
        VSEfPNA6owtcr62TtDz5q8YgS7bC+kY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-SjEvcLOxO_aCh_5fx9Tv9w-1; Thu, 03 Nov 2022 12:16:42 -0400
X-MC-Unique: SjEvcLOxO_aCh_5fx9Tv9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7D67101A528;
        Thu,  3 Nov 2022 16:16:41 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.10.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C561402BDA;
        Thu,  3 Nov 2022 16:16:41 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: [PATCH v10 5/6] NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
Date:   Thu,  3 Nov 2022 12:16:36 -0400
Message-Id: <20221103161637.1725471-6-dwysocha@redhat.com>
In-Reply-To: <20221103161637.1725471-1-dwysocha@redhat.com>
References: <20221103161637.1725471-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFS specific trace points are no longer needed as tracing is well
covered by netfs and fscache.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h      | 91 ------------------------------------------
 include/linux/nfs_fs.h |  1 -
 2 files changed, 92 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8c6cc58679ff..6b56abe49ec2 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -39,7 +39,6 @@
 			{ BIT(NFS_INO_STALE), "STALE" }, \
 			{ BIT(NFS_INO_ACL_LRU_SET), "ACL_LRU_SET" }, \
 			{ BIT(NFS_INO_INVALIDATING), "INVALIDATING" }, \
-			{ BIT(NFS_INO_FSCACHE), "FSCACHE" }, \
 			{ BIT(NFS_INO_LAYOUTCOMMIT), "NEED_LAYOUTCOMMIT" }, \
 			{ BIT(NFS_INO_LAYOUTCOMMITTING), "LAYOUTCOMMIT" }, \
 			{ BIT(NFS_INO_LAYOUTSTATS), "LAYOUTSTATS" }, \
@@ -1213,96 +1212,6 @@ TRACE_EVENT(nfs_readpage_short,
 		)
 );
 
-DECLARE_EVENT_CLASS(nfs_fscache_page_event,
-		TP_PROTO(
-			const struct inode *inode,
-			struct page *page
-		),
-
-		TP_ARGS(inode, page),
-
-		TP_STRUCT__entry(
-			__field(dev_t, dev)
-			__field(u32, fhandle)
-			__field(u64, fileid)
-			__field(loff_t, offset)
-		),
-
-		TP_fast_assign(
-			const struct nfs_inode *nfsi = NFS_I(inode);
-			const struct nfs_fh *fh = &nfsi->fh;
-
-			__entry->offset = page_index(page) << PAGE_SHIFT;
-			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
-			__entry->fhandle = nfs_fhandle_hash(fh);
-		),
-
-		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld",
-			MAJOR(__entry->dev), MINOR(__entry->dev),
-			(unsigned long long)__entry->fileid,
-			__entry->fhandle,
-			(long long)__entry->offset
-		)
-);
-DECLARE_EVENT_CLASS(nfs_fscache_page_event_done,
-		TP_PROTO(
-			const struct inode *inode,
-			struct page *page,
-			int error
-		),
-
-		TP_ARGS(inode, page, error),
-
-		TP_STRUCT__entry(
-			__field(int, error)
-			__field(dev_t, dev)
-			__field(u32, fhandle)
-			__field(u64, fileid)
-			__field(loff_t, offset)
-		),
-
-		TP_fast_assign(
-			const struct nfs_inode *nfsi = NFS_I(inode);
-			const struct nfs_fh *fh = &nfsi->fh;
-
-			__entry->offset = page_index(page) << PAGE_SHIFT;
-			__entry->dev = inode->i_sb->s_dev;
-			__entry->fileid = nfsi->fileid;
-			__entry->fhandle = nfs_fhandle_hash(fh);
-			__entry->error = error;
-		),
-
-		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x "
-			"offset=%lld error=%d",
-			MAJOR(__entry->dev), MINOR(__entry->dev),
-			(unsigned long long)__entry->fileid,
-			__entry->fhandle,
-			(long long)__entry->offset, __entry->error
-		)
-);
-#define DEFINE_NFS_FSCACHE_PAGE_EVENT(name) \
-	DEFINE_EVENT(nfs_fscache_page_event, name, \
-			TP_PROTO( \
-				const struct inode *inode, \
-				struct page *page \
-			), \
-			TP_ARGS(inode, page))
-#define DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(name) \
-	DEFINE_EVENT(nfs_fscache_page_event_done, name, \
-			TP_PROTO( \
-				const struct inode *inode, \
-				struct page *page, \
-				int error \
-			), \
-			TP_ARGS(inode, page, error))
-DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_read_page);
-DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_read_page_exit);
-DEFINE_NFS_FSCACHE_PAGE_EVENT(nfs_fscache_write_page);
-DEFINE_NFS_FSCACHE_PAGE_EVENT_DONE(nfs_fscache_write_page_exit);
 
 TRACE_EVENT(nfs_pgio_error,
 	TP_PROTO(
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a1c402e26abf..0150a5673419 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -281,7 +281,6 @@ struct nfs4_copy_state {
 #define NFS_INO_ACL_LRU_SET	(2)		/* Inode is on the LRU list */
 #define NFS_INO_INVALIDATING	(3)		/* inode is being invalidated */
 #define NFS_INO_PRESERVE_UNLINKED (4)		/* preserve file if removed while open */
-#define NFS_INO_FSCACHE		(5)		/* inode can be cached by FS-Cache */
 #define NFS_INO_LAYOUTCOMMIT	(9)		/* layoutcommit required */
 #define NFS_INO_LAYOUTCOMMITTING (10)		/* layoutcommit inflight */
 #define NFS_INO_LAYOUTSTATS	(11)		/* layoutstats inflight */
-- 
2.31.1

