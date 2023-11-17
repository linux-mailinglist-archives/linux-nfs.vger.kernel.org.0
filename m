Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496827EF989
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 22:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346302AbjKQVQ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 16:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346269AbjKQVQh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 16:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E59C1BCA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700255785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIcfdnuUCbQOOB+XHi4o+OLT8DZkVqX+ywLCC563uKQ=;
        b=fXhODms8SWxk4O3gln5jgVfPVuJRAskbMaWL98q9xxlroAKg+NIajxhcEnVCKVSPcXovD/
        F22bmqIzRJB6CA+XKW6Sabr2ogBd6S8d4AYjvIic11/Xmjgie0tHOTw8XJ/8cLLwfFLqYc
        aPjS3Q+MIaN0QDDDj7g//zubFqAx1ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-BadMrd11P9WE2jcn7M2rhQ-1; Fri, 17 Nov 2023 16:16:20 -0500
X-MC-Unique: BadMrd11P9WE2jcn7M2rhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4B00821938;
        Fri, 17 Nov 2023 21:16:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 220B540C6EB9;
        Fri, 17 Nov 2023 21:16:17 +0000 (UTC)
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
Subject: [PATCH v2 09/51] netfs: Add support for DIO buffering
Date:   Fri, 17 Nov 2023 21:15:01 +0000
Message-ID: <20231117211544.1740466-10-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a bvec array pointer and an iterator to netfs_io_request for either
holding a copy of a DIO iterator or a list of all the bits of buffer
pointed to by a DIO iterator.

There are two problems:  Firstly, if an iovec-class iov_iter is passed to
->read_iter() or ->write_iter(), this cannot be passed directly to
kernel_sendmsg() or kernel_recvmsg() as that may cause locking recursion if
a fault is generated, so we need to keep track of the pages involved
separately.

Secondly, if the I/O is asynchronous, we must copy the iov_iter describing
the buffer before returning to the caller as it may be immediately
deallocated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/objects.c    | 10 ++++++++++
 include/linux/netfs.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 1bd20bdad983..4df5e5eeada6 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -76,6 +76,7 @@ static void netfs_free_request(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
+	unsigned int i;
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
 	netfs_proc_del_rreq(rreq);
@@ -84,6 +85,15 @@ static void netfs_free_request(struct work_struct *work)
 		rreq->netfs_ops->free_request(rreq);
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
+	if (rreq->direct_bv) {
+		for (i = 0; i < rreq->direct_bv_count; i++) {
+			if (rreq->direct_bv[i].bv_page) {
+				if (rreq->direct_bv_unpin)
+					unpin_user_page(rreq->direct_bv[i].bv_page);
+			}
+		}
+		kvfree(rreq->direct_bv);
+	}
 	kfree_rcu(rreq, rcu);
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 48868b3e4d51..6d820a860052 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -192,6 +192,9 @@ struct netfs_io_request {
 	struct iov_iter		iter;		/* Unencrypted-side iterator */
 	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
 	void			*netfs_priv;	/* Private data for the netfs */
+	struct bio_vec		*direct_bv	/* DIO buffer list (when handling iovec-iter) */
+	__counted_by(direct_bv_count);
+	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
@@ -199,6 +202,7 @@ struct netfs_io_request {
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
+	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */

