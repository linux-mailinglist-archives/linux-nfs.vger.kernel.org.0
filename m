Return-Path: <linux-nfs+bounces-11811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793CABBFD1
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EF61B62CA6
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C164F2857C9;
	Mon, 19 May 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCUsXDF3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A62853F7
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662553; cv=none; b=Lm3EBz76C9hpqdJJfuLsFsvw8htUD/iQZJhvivgZuVa4AtqzgZGmbzIxv4P58I3c7/s7RbHwJ/nrg2w1MvK07+zMs2yXAwCoVK6wyXMmcvJGwUETX7i0mLfmWhntJl95E+++pLLVxkiefaWge6xaY/oEF/70CbBBkM+jEMHF58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662553; c=relaxed/simple;
	bh=mPmvLyfGBuynV0FovR0WJT+p+w87wfi+V4QQOjQPuqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozkw8lxzzgyBOobJTj+iLY9yKfdXNJL33QiH4wlnw7lWPKUjhjJzyvU3GeZ+lxZESy1fVwjVtIojne31RIVSxbuY8QjVAfcOipfEs/eWE+l5KF8fyW7sJjhv0vVRGxrOCAEnNRjW/f2h7c6xzsbqW0ZAnCZ8Qo+n9UJDjNsm03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCUsXDF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3W33PM6TQ9OEUN7r8/bHM/UYjJbT78cxjm2wZfj69I=;
	b=cCUsXDF3BVnfxdPIWs9QjotUZy8YtJ5+uNr5YRYGLNms8nk91mF7uY9g7CoqNfcISa91mw
	7f5BpxnIlmJzSzYTCHPMa0NNaQf4ozHTMSaB5kDtUS1dkimlnsZZjk5NDF20NWBZWYKbxt
	5F2kxdcLSN6UN/Rj15+nn0HZR2dCXZg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-xLqE-0MJP8SyAXbCrq6Slg-1; Mon,
 19 May 2025 09:49:05 -0400
X-MC-Unique: xLqE-0MJP8SyAXbCrq6Slg-1
X-Mimecast-MFC-AGG-ID: xLqE-0MJP8SyAXbCrq6Slg_1747662542
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 640141800446;
	Mon, 19 May 2025 13:49:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3772A180049D;
	Mon, 19 May 2025 13:48:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] fs/netfs: remove `netfs_io_request.ractl`
Date: Mon, 19 May 2025 14:48:03 +0100
Message-ID: <20250519134813.2975312-8-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Max Kellermann <max.kellermann@ionos.com>

Since this field is only used by netfs_prepare_read_iterator() when
called by netfs_readahead(), we can simply pass it as parameter.  This
shrinks the struct from 576 to 568 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 24 ++++++++++++------------
 include/linux/netfs.h    |  1 -
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 0d1b6d35ff3b..5f53634a3862 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -78,7 +78,8 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
  * [!] NOTE: This must be run in the same thread as ->issue_read() was called
  * in as we access the readahead_control struct.
  */
-static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
+static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
+					   struct readahead_control *ractl)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	size_t rsize = subreq->len;
@@ -86,7 +87,7 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 	if (subreq->source == NETFS_DOWNLOAD_FROM_SERVER)
 		rsize = umin(rsize, rreq->io_streams[0].sreq_max_len);
 
-	if (rreq->ractl) {
+	if (ractl) {
 		/* If we don't have sufficient folios in the rolling buffer,
 		 * extract a folioq's worth from the readahead region at a time
 		 * into the buffer.  Note that this acquires a ref on each page
@@ -99,7 +100,7 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 		while (rreq->submitted < subreq->start + rsize) {
 			ssize_t added;
 
-			added = rolling_buffer_load_from_ra(&rreq->buffer, rreq->ractl,
+			added = rolling_buffer_load_from_ra(&rreq->buffer, ractl,
 							    &put_batch);
 			if (added < 0)
 				return added;
@@ -211,7 +212,8 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
  * slicing up the region to be read according to available cache blocks and
  * network rsize.
  */
-static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
+static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
+				    struct readahead_control *ractl)
 {
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
 	unsigned long long start = rreq->start;
@@ -291,7 +293,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		break;
 
 	issue:
-		slice = netfs_prepare_read_iterator(subreq);
+		slice = netfs_prepare_read_iterator(subreq, ractl);
 		if (slice < 0) {
 			ret = slice;
 			subreq->error = ret;
@@ -359,11 +361,10 @@ void netfs_readahead(struct readahead_control *ractl)
 
 	netfs_rreq_expand(rreq, ractl);
 
-	rreq->ractl = ractl;
 	rreq->submitted = rreq->start;
 	if (rolling_buffer_init(&rreq->buffer, rreq->debug_id, ITER_DEST) < 0)
 		goto cleanup_free;
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, ractl);
 
 	netfs_put_request(rreq, true, netfs_rreq_trace_put_return);
 	return;
@@ -389,7 +390,6 @@ static int netfs_create_singular_buffer(struct netfs_io_request *rreq, struct fo
 	if (added < 0)
 		return added;
 	rreq->submitted = rreq->start + added;
-	rreq->ractl = (struct readahead_control *)1UL;
 	return 0;
 }
 
@@ -459,7 +459,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	iov_iter_bvec(&rreq->buffer.iter, ITER_DEST, bvec, i, rreq->len);
 	rreq->submitted = rreq->start + flen;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 
 	if (sink)
 		folio_put(sink);
@@ -528,7 +528,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	if (ret < 0)
 		goto discard;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
@@ -685,7 +685,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (ret < 0)
 		goto error_put;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	if (ret < 0)
 		goto error;
@@ -750,7 +750,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	if (ret < 0)
 		goto error_put;
 
-	netfs_read_to_pagecache(rreq);
+	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
 	return ret < 0 ? ret : 0;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 33f145f7f2c2..2b127527544e 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -228,7 +228,6 @@ struct netfs_io_request {
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
 	struct netfs_io_request	*copy_to_cache;	/* Request to write just-read data to the cache */
-	struct readahead_control *ractl;	/* Readahead descriptor */
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams


