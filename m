Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4799C4436C0
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Nov 2021 20:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKBTyi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Nov 2021 15:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhKBTyf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Nov 2021 15:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635882719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=s/xW7jVqLLTAUlQrtQVKmvQYV8N/dGkOL2FiPCkTAmY=;
        b=GAPDycsjpkdGwkZ7ancl3Q58B6QtOd1JdD0sxpLYpIkZmqs29+vc4jRpwsG0h9IPj+6Zmh
        KRN8Feo95eW0VeAss3rH5JKOEyonMmcIIr9+LYArYgS0DsBG33WjbxlKs14NYJyww+/VUq
        K9yndP/Tp2PBx1bAS49MXQt9UYwZiWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-1fYZawoWPP2EjkDEv_S96Q-1; Tue, 02 Nov 2021 15:51:58 -0400
X-MC-Unique: 1fYZawoWPP2EjkDEv_S96Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97921BD52B;
        Tue,  2 Nov 2021 19:51:57 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FC136A8E5;
        Tue,  2 Nov 2021 19:51:56 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     chuck.lever@oracle.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Add offset to nfs_aop_readahead tracepoint
Date:   Tue,  2 Nov 2021 15:51:55 -0400
Message-Id: <1635882715-31130-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the byte offset of the readahead request to the tracepoint output
so we know where the read starts.

Before this patch:
cat-8104    [002] .....   813.168775: nfs_aop_readahead: fileid=00:31:141 fhandle=0xe55807f6 version=1756509392533525500 nr_pages=256
cat-8104    [002] .....   813.174973: nfs_aop_readahead_done: fileid=00:31:141 fhandle=0xe55807f6 version=1756509392533525500 nr_pages=256 ret=0
cat-8104    [002] .....   813.175963: nfs_aop_readahead: fileid=00:31:141 fhandle=0xe55807f6 version=1756509392533525500 nr_pages=256
cat-8104    [002] .....   813.183742: nfs_aop_readahead_done: fileid=00:31:141 fhandle=0xe55807f6 version=1756509392533525500 nr_pages=1 ret=0

After this patch:
cat-6392    [001] .....    73.107782: nfs_aop_readahead: fileid=00:31:141 fhandle=0xed22403f version=1756511950029502774 offset=5242880 nr_pages=256
cat-6392    [001] .....    73.112466: nfs_aop_readahead_done: fileid=00:31:141 fhandle=0xed22403f version=1756511950029502774 nr_pages=256 ret=0
cat-6392    [001] .....    73.115692: nfs_aop_readahead: fileid=00:31:141 fhandle=0xed22403f version=1756511950029502774 offset=6291456 nr_pages=256
cat-6392    [001] .....    73.123283: nfs_aop_readahead_done: fileid=00:31:141 fhandle=0xed22403f version=1756511950029502774 nr_pages=256 ret=0

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/nfstrace.h | 10 +++++++---
 fs/nfs/read.c     |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 83e9615c8b8c..6cca1434df32 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -938,16 +938,18 @@
 TRACE_EVENT(nfs_aop_readahead,
 		TP_PROTO(
 			const struct inode *inode,
+			struct page *page,
 			unsigned int nr_pages
 		),
 
-		TP_ARGS(inode, nr_pages),
+		TP_ARGS(inode, page, nr_pages),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(u64, version)
+			__field(loff_t, offset)
 			__field(unsigned int, nr_pages)
 		),
 
@@ -958,15 +960,16 @@
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->offset = page_index(page) << PAGE_SHIFT;
 			__entry->nr_pages = nr_pages;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu nr_pages=%u",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu offset=%lld nr_pages=%u",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle, __entry->version,
-			__entry->nr_pages
+			__entry->offset, __entry->nr_pages
 		)
 );
 
@@ -985,6 +988,7 @@
 			__field(int, ret)
 			__field(u64, fileid)
 			__field(u64, version)
+			__field(loff_t, offset)
 			__field(unsigned int, nr_pages)
 		),
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c8273d4b12ad..d11af2a9299c 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -404,7 +404,7 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int ret;
 
-	trace_nfs_aop_readahead(inode, nr_pages);
+	trace_nfs_aop_readahead(inode, lru_to_page(pages), nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
 	ret = -ESTALE;
-- 
1.8.3.1

