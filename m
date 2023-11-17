Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A27EFA4E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 22:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbjKQVV4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 16:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346293AbjKQVV0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 16:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CC268D
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 13:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700255868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njtooIaoqHtxOz+7Ms2cQooTNH6njUKNcTP7iunfXh8=;
        b=jJUp4xZ8u5Zt2GtwF0gvadtL4u+Di7MYsdt7tJvFrS+RZ7vO5GUedSksxf5J9B1e+2gDNr
        48Eq9fzmZAkO5YBu0+Lv/1WjFrxQkISVDd2xAxSbKnsrK139b0XDobt3ZGmwohypdy7N1m
        Qu6PUQ4BpIPLwrowy/dPVA/+OD/YjlA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-1TtKUSzjOcS24bYRIYVe3A-1; Fri,
 17 Nov 2023 16:17:44 -0500
X-MC-Unique: 1TtKUSzjOcS24bYRIYVe3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 457B328040BB;
        Fri, 17 Nov 2023 21:17:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A789DC15881;
        Fri, 17 Nov 2023 21:17:40 +0000 (UTC)
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
Subject: [PATCH v2 28/51] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
Date:   Fri, 17 Nov 2023 21:15:20 +0000
Message-ID: <20231117211544.1740466-29-dhowells@redhat.com>
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

Provide an entry point to delegate a filesystem's ->page_mkwrite() to.
This checks for conflicting writes, then attached any netfs-specific group
marking (e.g. ceph snap) to the page to be considered dirty.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h     |  4 +++
 2 files changed, 63 insertions(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 60e7da53cbd2..3c1f26f32351 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -413,3 +413,62 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 EXPORT_SYMBOL(netfs_file_write_iter);
+
+/*
+ * Notification that a previously read-only page is about to become writable.
+ * Note that the caller indicates a single page of a multipage folio.
+ */
+vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
+{
+	struct folio *folio = page_folio(vmf->page);
+	struct file *file = vmf->vma->vm_file;
+	struct inode *inode = file_inode(file);
+	vm_fault_t ret = VM_FAULT_RETRY;
+	int err;
+
+	_enter("%lx", folio->index);
+
+	sb_start_pagefault(inode->i_sb);
+
+	if (folio_wait_writeback_killable(folio))
+		goto out;
+
+	if (folio_lock_killable(folio) < 0)
+		goto out;
+
+	/* Can we see a streaming write here? */
+	if (WARN_ON(!folio_test_uptodate(folio))) {
+		ret = VM_FAULT_SIGBUS | VM_FAULT_LOCKED;
+		goto out;
+	}
+
+	if (netfs_folio_group(folio) != netfs_group) {
+		folio_unlock(folio);
+		err = filemap_fdatawait_range(inode->i_mapping,
+					      folio_pos(folio),
+					      folio_pos(folio) + folio_size(folio));
+		switch (err) {
+		case 0:
+			ret = VM_FAULT_RETRY;
+			goto out;
+		case -ENOMEM:
+			ret = VM_FAULT_OOM;
+			goto out;
+		default:
+			ret = VM_FAULT_SIGBUS;
+			goto out;
+		}
+	}
+
+	if (folio_test_dirty(folio))
+		trace_netfs_folio(folio, netfs_folio_trace_mkwrite_plus);
+	else
+		trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
+	netfs_set_group(folio, netfs_group);
+	file_update_time(file);
+	ret = VM_FAULT_LOCKED;
+out:
+	sb_end_pagefault(inode->i_sb);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_page_mkwrite);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4cdadd1ce328..80e48af8b72f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -404,6 +404,10 @@ int netfs_write_begin(struct netfs_inode *, struct file *,
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 
+/* VMA operations API. */
+vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
+
+/* (Sub)request management API. */
 void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);

