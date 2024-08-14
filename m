Return-Path: <linux-nfs+bounces-5375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AAA9523C6
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 22:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F408F1C21931
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 20:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6A1D6196;
	Wed, 14 Aug 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHsPcG8f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D831D6184
	for <linux-nfs@vger.kernel.org>; Wed, 14 Aug 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668028; cv=none; b=RZqphTxqbHkg8I6njXsAO0EjeW8EVde2iZ17o5Ao1ZZQibg0GhjvhEktTh80Ou9I3+ulFTbTgP5MiJAqtmBhyL5O4TQP5tANFKGmoCtxVGm3dPc3cyIDsn/Jm+2TLBGP5B4QBwXBAtAUftLbJtjqTf0tljIe2E1t4w8Td8KJLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668028; c=relaxed/simple;
	bh=Ldx7tssIVah3LxCRKpQKxn6JsRLlHXO/fkq7QzwY3D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcRzu2J5ny2HG5pWCyOm2q9sTlq6oHDFi1D7DmA/bI61xNFO/Q4fzI0zkI5lfSHXskujq7F3+2xhNHDEp7e0jwnVHC/LnaRzvz3Zivj+HsKtsF9tvq+Uj9bpqjcb1T0U9B/e7XwVaREm4WaZ+nSbUjjAX2KP5Sm0WP5cYBJYQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHsPcG8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysayb5RXeXC3/aarWcnK8uuWcOM3GXCwJSpymUE1G5c=;
	b=aHsPcG8ffhudqFRzSIwpt0sqTNTibJ1vJkMhAeSZSSjcHbn5QQOsF61nmC61Zj+RDORm4q
	EbfpQwXcfsG7Y814gili8Jpop56xl291UIkSRNnbbvWhUqRgdi1JavG//z07hNFe0H7WHA
	omJ5hgR+mSN7ZoMMMJdwCoZgd0Oy/fE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-LKaV8qK4MgahAHzEnVal2w-1; Wed,
 14 Aug 2024 16:40:21 -0400
X-MC-Unique: LKaV8qK4MgahAHzEnVal2w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EC7918EB232;
	Wed, 14 Aug 2024 20:40:18 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B01791955E8C;
	Wed, 14 Aug 2024 20:40:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/25] netfs: Set the request work function upon allocation
Date: Wed, 14 Aug 2024 21:38:30 +0100
Message-ID: <20240814203850.2240469-11-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Set the work function in the netfs_io_request work_struct when we allocate
the request rather than doing this later.  This reduces the number of
places we need to set it in future code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h    | 1 +
 fs/netfs/io.c          | 4 +---
 fs/netfs/objects.c     | 9 ++++++++-
 fs/netfs/write_issue.c | 1 -
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 9e6e0e59d7e4..f2920b4ee726 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -29,6 +29,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 /*
  * io.c
  */
+void netfs_rreq_work(struct work_struct *work);
 int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
 
 /*
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index ce3e821b4e4f..8b9aaa99d787 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -422,7 +422,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 	netfs_rreq_completed(rreq, was_async);
 }
 
-static void netfs_rreq_work(struct work_struct *work)
+void netfs_rreq_work(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =
 		container_of(work, struct netfs_io_request, work);
@@ -734,8 +734,6 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	// TODO: Use bounce buffer if requested
 	rreq->io_iter = rreq->iter;
 
-	INIT_WORK(&rreq->work, netfs_rreq_work);
-
 	/* Chop the read into slices according to what the cache and the netfs
 	 * want and submit each one.
 	 */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 0294df70c3ff..d6e9785ce7a3 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -48,9 +48,16 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
 	INIT_LIST_HEAD(&rreq->subrequests);
-	INIT_WORK(&rreq->work, NULL);
 	refcount_set(&rreq->ref, 1);
 
+	if (origin == NETFS_READAHEAD ||
+	    origin == NETFS_READPAGE ||
+	    origin == NETFS_READ_FOR_WRITE ||
+	    origin == NETFS_DIO_READ)
+		INIT_WORK(&rreq->work, netfs_rreq_work);
+	else
+		INIT_WORK(&rreq->work, netfs_write_collection_worker);
+
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (file && file->f_flags & O_NONBLOCK)
 		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 34e541afd79b..41db709ca1d3 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -109,7 +109,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	wreq->contiguity = wreq->start;
 	wreq->cleaned_to = wreq->start;
-	INIT_WORK(&wreq->work, netfs_write_collection_worker);
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;


