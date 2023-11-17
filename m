Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9207EFA04
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346314AbjKQVTl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 16:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbjKQVTZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 16:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B911170F
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 13:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700255893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qasw+3DRr0CW1YV8TSL9wIAaCWlUGU8d7+6bcjpE3Y=;
        b=dcTCBZdfDP3xInv6XUFCARp1O/Qj6IN9fnCe+XngHXJTPS6CRbjlBr2enxfTjARFiUsqj9
        l0eEiq0aUeCl45esDPH/9uJR/8hy6VjE7t8PFFdMs5w6edlWWnmLBa5ptxuDnVN6W65a6m
        8BhcWUerPk2h9vpKRI3PIqn3HyY8n1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-rAZg2Yx3M1y0duiuqxkUIg-1; Fri,
 17 Nov 2023 16:18:08 -0500
X-MC-Unique: rAZg2Yx3M1y0duiuqxkUIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD1A33C0C48C;
        Fri, 17 Nov 2023 21:18:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E541121306;
        Fri, 17 Nov 2023 21:18:04 +0000 (UTC)
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
Subject: [PATCH v2 35/51] netfs: Support decryption on ubuffered/DIO read
Date:   Fri, 17 Nov 2023 21:15:27 +0000
Message-ID: <20231117211544.1740466-36-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Support unbuffered and direct I/O reads from an encrypted file.  This may
require making a larger read than is required into a bounce buffer and
copying out the required bits.  We don't decrypt in-place in the user
buffer lest userspace interfere and muck up the decryption.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/direct_read.c | 10 ++++++++++
 fs/netfs/internal.h    | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 52ad8fa66dd5..158719b56900 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -181,6 +181,16 @@ static ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_
 		iov_iter_advance(iter, orig_count);
 	}
 
+	/* If we're going to do decryption or decompression, we're going to
+	 * need a bounce buffer - and if the data is misaligned for the crypto
+	 * algorithm, we decrypt in place and then copy.
+	 */
+	if (test_bit(NETFS_RREQ_CONTENT_ENCRYPTION, &rreq->flags)) {
+		if (!netfs_is_crypto_aligned(rreq, iter))
+			__set_bit(NETFS_RREQ_CRYPT_IN_PLACE, &rreq->flags);
+		__set_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags);
+	}
+
 	/* If we're going to use a bounce buffer, we need to set it up.  We
 	 * will then need to pad the request out to the minimum block size.
 	 */
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index fbecfd9b3174..447a67301329 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -193,6 +193,23 @@ static inline void netfs_put_group_many(struct netfs_group *netfs_group, int nr)
 		netfs_group->free(netfs_group);
 }
 
+/*
+ * Check to see if a buffer aligns with the crypto unit block size.  If it
+ * doesn't the crypto layer is going to copy all the data - in which case
+ * relying on the crypto op for a free copy is pointless.
+ */
+static inline bool netfs_is_crypto_aligned(struct netfs_io_request *rreq,
+					   struct iov_iter *iter)
+{
+	struct netfs_inode *ctx = netfs_inode(rreq->inode);
+	unsigned long align, mask = (1UL << ctx->min_bshift) - 1;
+
+	if (!ctx->min_bshift)
+		return true;
+	align = iov_iter_alignment(iter);
+	return (align & mask) == 0;
+}
+
 /*****************************************************************************/
 /*
  * debug tracing

