Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4BC7EF99A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjKQVRW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 16:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjKQVRA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 16:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680B1FEF
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700255798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aymUqh8tNqy/9mbxQPB2e2M5NzhlTlDvAtO1iWjEkMc=;
        b=az4q1HAE7wQifSgnjUWkVAGiv5GWoocQzH+9iKMz4A9JEiknHIdOT7wtgG834RccUo8dI5
        o3DNOnkOOBxD7d6UzYKrGf1JpnJqv9CBPQN+xXbaKETRloZGO7TJyCqIcSkNyFCYr8QKC3
        0uChYSMbOc0DAZvsEYFJ1yARN5O8/nQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-QQ2MUg3zMpa_F036AItkIg-1; Fri,
 17 Nov 2023 16:16:34 -0500
X-MC-Unique: QQ2MUg3zMpa_F036AItkIg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20F093821359;
        Fri, 17 Nov 2023 21:16:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 863BC492BE0;
        Fri, 17 Nov 2023 21:16:30 +0000 (UTC)
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
Subject: [PATCH v2 13/51] netfs: Limit subrequest by size or number of segments
Date:   Fri, 17 Nov 2023 21:15:05 +0000
Message-ID: <20231117211544.1740466-14-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

Limit a subrequest to a maximum size and/or a maximum number of contiguous
physical regions.  This permits, for instance, an subreq's iterator to be
limited to the number of DMA'able segments that a large RDMA request can
handle.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/io.c                | 18 ++++++++++++++++++
 include/linux/netfs.h        |  1 +
 include/trace/events/netfs.h |  1 +
 3 files changed, 20 insertions(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index d8e9cd6ce338..c80b8eed1209 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -525,6 +525,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 			struct iov_iter *io_iter)
 {
 	enum netfs_io_source source;
+	size_t lsize;
 
 	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
 
@@ -547,13 +548,30 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 			source = NETFS_INVALID_READ;
 			goto out;
 		}
+
+		if (subreq->max_nr_segs) {
+			lsize = netfs_limit_iter(io_iter, 0, subreq->len,
+						 subreq->max_nr_segs);
+			if (subreq->len > lsize) {
+				subreq->len = lsize;
+				trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+			}
+		}
 	}
 
+	if (subreq->len > rreq->len)
+		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %zx\n",
+			rreq->debug_id, subreq->debug_index,
+			subreq->len, rreq->len);
+
 	if (WARN_ON(subreq->len == 0)) {
 		source = NETFS_INVALID_READ;
 		goto out;
 	}
 
+	subreq->source = source;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+
 	subreq->io_iter = *io_iter;
 	iov_iter_truncate(&subreq->io_iter, subreq->len);
 	iov_iter_advance(io_iter, subreq->len);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index cd673596b411..20ddd46fa0bc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -163,6 +163,7 @@ struct netfs_io_subrequest {
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
+	unsigned int		max_nr_segs;	/* 0 or max number of segments in an iterator */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned long		flags;
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index beec534cbaab..fce6d0bc78e5 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -44,6 +44,7 @@
 #define netfs_sreq_traces					\
 	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\
 	EM(netfs_sreq_trace_free,		"FREE ")	\
+	EM(netfs_sreq_trace_limited,		"LIMIT")	\
 	EM(netfs_sreq_trace_prepare,		"PREP ")	\
 	EM(netfs_sreq_trace_resubmit_short,	"SHORT")	\
 	EM(netfs_sreq_trace_submit,		"SUBMT")	\

