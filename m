Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDD7C8B4D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjJMQVB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjJMQUo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 12:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899D19A
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697213200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uT/Mhdx8sQf5PESeJ8Rr2IswwVlQVrc+dpLVfyRgQ2c=;
        b=I0jAd+U4YLua9w0EAotqtbmR68NAlkD+QbCqjYVF4wq3bTTFjG46nZoo+tO7A/AsKkKstn
        kyOYA21fYq012YGj/T/bmn154CCLv2n+WxYM+9qZ9lWdYYJgNAnVYEJT112744vgLlM46P
        qhfyBtn1rS0hkF2jy6h0lrOFEM6IFzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-oOqr7qHpOt-wp8G5blDJHw-1; Fri, 13 Oct 2023 12:06:23 -0400
X-MC-Unique: oOqr7qHpOt-wp8G5blDJHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 259D588B7B8;
        Fri, 13 Oct 2023 16:06:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61A841C060DF;
        Fri, 13 Oct 2023 16:06:19 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH 33/53] netfs: Provide minimum blocksize parameter
Date:   Fri, 13 Oct 2023 17:04:02 +0100
Message-ID: <20231013160423.2218093-34-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a parameter for minimum blocksize in the netfs_i_context struct.  This
can be used, for instance, to force I/O alignment for content encryption.
It also requires the use of an RMW cycle if a write we want to do doesn't
meet the block alignment requirements.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c  | 26 ++++++++++++++++++++++----
 fs/netfs/buffered_write.c |  3 ++-
 fs/netfs/direct_read.c    |  3 ++-
 include/linux/netfs.h     |  2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index ab9f8e123245..e06461ef0bfa 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -527,14 +527,26 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	struct address_space *mapping = folio_file_mapping(folio);
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	unsigned long long start = folio_pos(folio);
-	size_t flen = folio_size(folio);
+	unsigned long long i_size, rstart, end;
+	size_t rlen;
 	int ret;
 
-	_enter("%zx @%llx", flen, start);
+	DEFINE_READAHEAD(ractl, file, NULL, mapping, folio_index(folio));
+
+	_enter("%zx @%llx", len, start);
 
 	ret = -ENOMEM;
 
-	rreq = netfs_alloc_request(mapping, file, start, flen,
+	i_size = i_size_read(mapping->host);
+	end = round_up(start + len, 1U << ctx->min_bshift);
+	if (end > i_size) {
+		unsigned long long limit = round_up(start + len, PAGE_SIZE);
+		end = max(limit, round_up(i_size, PAGE_SIZE));
+	}
+	rstart = round_down(start, 1U << ctx->min_bshift);
+	rlen   = end - rstart;
+
+	rreq = netfs_alloc_request(mapping, file, rstart, rlen,
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
@@ -548,7 +560,13 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 		goto error_put;
 
 	netfs_stat(&netfs_n_rh_write_begin);
-	trace_netfs_read(rreq, start, flen, netfs_read_trace_prefetch_for_write);
+	trace_netfs_read(rreq, rstart, rlen, netfs_read_trace_prefetch_for_write);
+
+	/* Expand the request to meet caching requirements and download
+	 * preferences.
+	 */
+	ractl._nr_pages = folio_nr_pages(folio);
+	netfs_rreq_expand(rreq, &ractl);
 
 	/* Set up the output buffer */
 	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d5a5a315fbd3..7163fcc05206 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -80,7 +80,8 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 	if (file->f_mode & FMODE_READ)
 		return NETFS_JUST_PREFETCH;
 
-	if (netfs_is_cache_enabled(ctx))
+	if (netfs_is_cache_enabled(ctx) ||
+	    ctx->min_bshift > 0)
 		return NETFS_JUST_PREFETCH;
 
 	if (!finfo)
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 1d26468aafd9..52ad8fa66dd5 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -185,7 +185,8 @@ static ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_
 	 * will then need to pad the request out to the minimum block size.
 	 */
 	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags)) {
-		start = rreq->start;
+		min_bsize = 1ULL << ctx->min_bshift;
+		start = round_down(rreq->start, min_bsize);
 		end = min_t(unsigned long long,
 			    round_up(rreq->start + rreq->len, min_bsize),
 			    ctx->remote_i_size);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index fb4f4f826b93..6244f7a9a44a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -141,6 +141,7 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+	unsigned char		min_bshift;	/* log2 min block size for bounding box or 0 */
 };
 
 /*
@@ -462,6 +463,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 	ctx->remote_i_size = i_size_read(&ctx->inode);
 	ctx->zero_point = ctx->remote_i_size;
 	ctx->flags = 0;
+	ctx->min_bshift = 0;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	ctx->cache = NULL;
 #endif

