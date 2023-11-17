Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD077EFA08
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 22:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbjKQVTu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 16:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjKQVTa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 16:19:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C913435AD
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700255883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJ0EH3j50U389igBFANhTwAFPV4cR9SbiJMpaWBP0sQ=;
        b=bu4Zirihs7GfRFfk2vBXQkErWL7u7xNx+HlTLJU6vusxb7vWR7u9brB4J7sKdHshhRnyn7
        A8zVO07bmWSI48u5IJUtUZuSuK0frfPVZAQorucFrwnO+VaibxbSb+5yNvGLODI3RY/UK1
        5xaVO0AT39lnnpmJ93320DYVgVF3sKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-2tVkcOLeNIK64W8EMhC0KA-1; Fri, 17 Nov 2023 16:17:57 -0500
X-MC-Unique: 2tVkcOLeNIK64W8EMhC0KA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC7B8101B045;
        Fri, 17 Nov 2023 21:17:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B871C15882;
        Fri, 17 Nov 2023 21:17:54 +0000 (UTC)
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
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/51] netfs: Make netfs_skip_folio_read() take account of blocksize
Date:   Fri, 17 Nov 2023 21:15:24 +0000
Message-ID: <20231117211544.1740466-33-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make netfs_skip_folio_read() take account of blocksize such as crypto
blocksize.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index e06461ef0bfa..de696aaaefbd 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -337,6 +337,7 @@ EXPORT_SYMBOL(netfs_read_folio);
 
 /*
  * Prepare a folio for writing without reading first
+ * @ctx: File context
  * @folio: The folio being prepared
  * @pos: starting position for the write
  * @len: length of write
@@ -350,32 +351,41 @@ EXPORT_SYMBOL(netfs_read_folio);
  * If any of these criteria are met, then zero out the unwritten parts
  * of the folio and return true. Otherwise, return false.
  */
-static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
-				 bool always_fill)
+static bool netfs_skip_folio_read(struct netfs_inode *ctx, struct folio *folio,
+				  loff_t pos, size_t len, bool always_fill)
 {
 	struct inode *inode = folio_inode(folio);
-	loff_t i_size = i_size_read(inode);
+	loff_t i_size = i_size_read(inode), low, high;
 	size_t offset = offset_in_folio(folio, pos);
 	size_t plen = folio_size(folio);
+	size_t min_bsize = 1UL << ctx->min_bshift;
+
+	if (likely(min_bsize == 1)) {
+		low = folio_file_pos(folio);
+		high = low + plen;
+	} else {
+		low = round_down(pos, min_bsize);
+		high = round_up(pos + len, min_bsize);
+	}
 
 	if (unlikely(always_fill)) {
-		if (pos - offset + len <= i_size)
-			return false; /* Page entirely before EOF */
+		if (low < i_size)
+			return false; /* Some part of the block before EOF */
 		zero_user_segment(&folio->page, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
 
-	/* Full folio write */
-	if (offset == 0 && len >= plen)
+	/* Full page write */
+	if (pos == low && high == pos + len)
 		return true;
 
-	/* Page entirely beyond the end of the file */
-	if (pos - offset >= i_size)
+	/* pos beyond last page in the file */
+	if (low >= i_size)
 		goto zero_out;
 
 	/* Write that covers from the start of the folio to EOF or beyond */
-	if (offset == 0 && (pos + len) >= i_size)
+	if (pos == low && (pos + len) >= i_size)
 		goto zero_out;
 
 	return false;
@@ -454,7 +464,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	 * to preload the granule.
 	 */
 	if (!netfs_is_cache_enabled(ctx) &&
-	    netfs_skip_folio_read(folio, pos, len, false)) {
+	    netfs_skip_folio_read(ctx, folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_folio_no_wait;
 	}

