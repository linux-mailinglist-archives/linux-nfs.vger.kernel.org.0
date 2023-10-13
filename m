Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C559F7C8A90
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 18:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjJMQGn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 12:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjJMQGQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 12:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B671A4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Oct 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697213114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obp1C/bTKivreVyZbMeOEbpW8BryZ03pHgo31ZL3OJs=;
        b=TjmQydxIKFavpD3rvX+/zbmEFPYA7M/VNHXHQjPtssJ80npJoJmktUmlO0C7k6Lm6/XKtv
        mIc+M7nshaot3k34lQQgEtcRsMUxyPVTDWvfcNLUQK4hLFZhssO2UvHQXj1gNhxn8Z+JZy
        zx4/rwig2YNOY23ghsDk/EBXFbNg4Bg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-MyygaxCRPVa_0k68CjzVSg-1; Fri, 13 Oct 2023 12:05:08 -0400
X-MC-Unique: MyygaxCRPVa_0k68CjzVSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B13E9889067;
        Fri, 13 Oct 2023 16:05:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33CF025C2;
        Fri, 13 Oct 2023 16:05:05 +0000 (UTC)
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
Subject: [RFC PATCH 12/53] netfs: Provide tools to create a buffer in an xarray
Date:   Fri, 13 Oct 2023 17:03:41 +0100
Message-ID: <20231013160423.2218093-13-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Provide tools to create a buffer in an xarray, with a function to add
new folios with a mark.  This will be used to create bounce buffer and can be
used more easily to create a list of folios the span of which would require
more than a page's worth of bio_vec structs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h   |  16 +++++
 fs/netfs/misc.c       | 140 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   4 ++
 3 files changed, 160 insertions(+)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 1f067aa96c50..00e01278316f 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -52,6 +52,22 @@ static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq) {}
 static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
 #endif
 
+/*
+ * misc.c
+ */
+int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
+			    struct folio *folio, bool put_mark,
+			    bool pagecache_mark, gfp_t gfp_mask);
+int netfs_add_folios_to_buffer(struct xarray *buffer,
+			       struct address_space *mapping,
+			       pgoff_t index, pgoff_t to, gfp_t gfp_mask);
+int netfs_set_up_buffer(struct xarray *buffer,
+			struct address_space *mapping,
+			struct readahead_control *ractl,
+			struct folio *keep,
+			pgoff_t have_index, unsigned int have_folios);
+void netfs_clear_buffer(struct xarray *buffer);
+
 /*
  * objects.c
  */
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index c3baf2b247d9..c70f856f3129 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,146 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/*
+ * Attach a folio to the buffer and maybe set marks on it to say that we need
+ * to put the folio later and twiddle the pagecache flags.
+ */
+int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
+			    struct folio *folio, bool put_mark,
+			    bool pagecache_mark, gfp_t gfp_mask)
+{
+	XA_STATE_ORDER(xas, xa, index, folio_order(folio));
+
+retry:
+	xas_lock(&xas);
+	for (;;) {
+		xas_store(&xas, folio);
+		if (!xas_error(&xas))
+			break;
+		xas_unlock(&xas);
+		if (!xas_nomem(&xas, gfp_mask))
+			return xas_error(&xas);
+		goto retry;
+	}
+
+	if (put_mark)
+		xas_set_mark(&xas, NETFS_BUF_PUT_MARK);
+	if (pagecache_mark)
+		xas_set_mark(&xas, NETFS_BUF_PAGECACHE_MARK);
+	xas_unlock(&xas);
+	return xas_error(&xas);
+}
+
+/*
+ * Create the specified range of folios in the buffer attached to the read
+ * request.  The folios are marked with NETFS_BUF_PUT_MARK so that we know that
+ * these need freeing later.
+ */
+int netfs_add_folios_to_buffer(struct xarray *buffer,
+			       struct address_space *mapping,
+			       pgoff_t index, pgoff_t to, gfp_t gfp_mask)
+{
+	struct folio *folio;
+	int ret;
+
+	if (to + 1 == index) /* Page range is inclusive */
+		return 0;
+
+	do {
+		/* TODO: Figure out what order folio can be allocated here */
+		folio = filemap_alloc_folio(readahead_gfp_mask(mapping), 0);
+		if (!folio)
+			return -ENOMEM;
+		folio->index = index;
+		ret = netfs_xa_store_and_mark(buffer, index, folio,
+					      true, false, gfp_mask);
+		if (ret < 0) {
+			folio_put(folio);
+			return ret;
+		}
+
+		index += folio_nr_pages(folio);
+	} while (index <= to && index != 0);
+
+	return 0;
+}
+
+/*
+ * Set up a buffer into which to data will be read or decrypted/decompressed.
+ * The folios to be read into are attached to this buffer and the gaps filled
+ * in to form a continuous region.
+ */
+int netfs_set_up_buffer(struct xarray *buffer,
+			struct address_space *mapping,
+			struct readahead_control *ractl,
+			struct folio *keep,
+			pgoff_t have_index, unsigned int have_folios)
+{
+	struct folio *folio;
+	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	unsigned int want_folios = have_folios;
+	pgoff_t want_index = have_index;
+	int ret;
+
+	ret = netfs_add_folios_to_buffer(buffer, mapping, want_index,
+					 have_index - 1, gfp_mask);
+	if (ret < 0)
+		return ret;
+	have_folios += have_index - want_index;
+
+	ret = netfs_add_folios_to_buffer(buffer, mapping,
+					 have_index + have_folios,
+					 want_index + want_folios - 1,
+					 gfp_mask);
+	if (ret < 0)
+		return ret;
+
+	/* Transfer the folios proposed by the VM into the buffer and take refs
+	 * on them.  The locks will be dropped in netfs_rreq_unlock().
+	 */
+	if (ractl) {
+		while ((folio = readahead_folio(ractl))) {
+			folio_get(folio);
+			if (folio == keep)
+				folio_get(folio);
+			ret = netfs_xa_store_and_mark(buffer, folio->index, folio,
+						      true, true, gfp_mask);
+			if (ret < 0) {
+				if (folio != keep)
+					folio_unlock(folio);
+				folio_put(folio);
+				return ret;
+			}
+		}
+	} else {
+		folio_get(keep);
+		ret = netfs_xa_store_and_mark(buffer, keep->index, keep,
+					      true, true, gfp_mask);
+		if (ret < 0) {
+			folio_put(keep);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Clear an xarray buffer, putting a ref on the folios that have
+ * NETFS_BUF_PUT_MARK set.
+ */
+void netfs_clear_buffer(struct xarray *buffer)
+{
+	struct folio *folio;
+	XA_STATE(xas, buffer, 0);
+
+	rcu_read_lock();
+	xas_for_each_marked(&xas, folio, ULONG_MAX, NETFS_BUF_PUT_MARK) {
+		folio_put(folio);
+	}
+	rcu_read_unlock();
+	xa_destroy(buffer);
+}
+
 /**
  * netfs_invalidate_folio - Invalidate or partially invalidate a folio
  * @folio: Folio proposed for release
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 66479a61ad00..e8d702ac6968 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -109,6 +109,10 @@ static inline int wait_on_page_fscache_killable(struct page *page)
 	return folio_wait_private_2_killable(page_folio(page));
 }
 
+/* Marks used on xarray-based buffers */
+#define NETFS_BUF_PUT_MARK	XA_MARK_0	/* - Page needs putting  */
+#define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
+
 enum netfs_io_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,

