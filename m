Return-Path: <linux-nfs+bounces-2540-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3455A890609
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584011C2B9A6
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390613D53E;
	Thu, 28 Mar 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCtiQPm9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE013D60C
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643929; cv=none; b=uMuyRnqVBtopABQ9/fX2WjymtsEOJkc1ZQO+VWyrTmRJ3NRSbaDFtn6SEkVdlZP50Vm6iva0wcQiL0SejWJKqOtzyl1iYnoxM2/lI2Jw3qCoT3JzzH6wOc1r0lKte45AuIo19AVUd4KkPoUddQ0r3t0etokJUP9WgGMebZZI/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643929; c=relaxed/simple;
	bh=R+6i2uLSpS5twycFe/I/v/M92DEZ9H/1llIknkjIcgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9ov11Cun5luhkRmovMDyGMvJ0XPiQe+DsRIJUy/cQP3i7DFrvSvGqvAATEUY3zyTpGpVpUkmyEHvA8XkiBLAnyc+/3c4ChLkCw3DLkBGj91wuSrYbJcQgaSgKKC1Dn4iP9+yTb9xB571V2ME6I1ITCrQx8MABl2CfCGpobh9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCtiQPm9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fwXy5U2z+oy82+iSz42Pbn48a/yMNGGfWVYA/FiX5g=;
	b=HCtiQPm9Qver+Z3fd+CisAMpktWaGiwNQM5LurXcIjqRBFCn4NOsIFmdL/Ch/F9asFSpOw
	kmnegNsQHiXQgoGIuGR/vUi0DxkexotylhsuLPdkMhcoCsQmReSZRRrsyCDp39MaobVaiF
	XCoiO5XdniNcrH5Jqu+0XHbqmPAwRB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-QGlJapH-OIS5gE1sBxbDog-1; Thu, 28 Mar 2024 12:38:42 -0400
X-MC-Unique: QGlJapH-OIS5gE1sBxbDog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF59780C799;
	Thu, 28 Mar 2024 16:38:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 900352166AF5;
	Thu, 28 Mar 2024 16:38:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
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
Subject: [PATCH 22/26] netfs, cachefiles: Implement helpers for new write code
Date: Thu, 28 Mar 2024 16:34:14 +0000
Message-ID: <20240328163424.2781320-23-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Implement the helpers for the new write code in cachefiles.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5ba5c7814fe4..437b24b0fd1c 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -622,6 +622,77 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	return ret;
 }
 
+static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+
+	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
+
+	subreq->max_len = ULONG_MAX;
+	subreq->max_nr_segs = BIO_MAX_VECS;
+
+	if (!cachefiles_cres_file(cres)) {
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+			return netfs_prepare_write_failed(subreq);
+		if (!cachefiles_cres_file(cres))
+			return netfs_prepare_write_failed(subreq);
+	}
+}
+
+static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	const struct cred *saved_cred;
+	size_t off, pre, post, len = subreq->len;
+	loff_t start = subreq->start;
+	int ret;
+
+	_enter("W=%x[%x] %llx-%llx",
+	       wreq->debug_id, subreq->debug_index, start, start + len - 1);
+
+	/* We need to start on the cache granularity boundary */
+	off = start & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	if (off) {
+		pre = CACHEFILES_DIO_BLOCK_SIZE - off;
+		if (pre >= len) {
+			netfs_write_subrequest_terminated(subreq, len, false);
+			return;
+		}
+		subreq->transferred += pre;
+		start += pre;
+		len -= pre;
+		iov_iter_advance(&subreq->io_iter, pre);
+	}
+
+	/* We also need to end on the cache granularity boundary */
+	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
+	if (post) {
+		len -= post;
+		if (len == 0) {
+			netfs_write_subrequest_terminated(subreq, post, false);
+			return;
+		}
+		iov_iter_truncate(&subreq->io_iter, len);
+	}
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
+					 &start, &len, len, true);
+	cachefiles_end_secure(cache, saved_cred);
+	if (ret < 0) {
+		netfs_write_subrequest_terminated(subreq, ret, false);
+		return;
+	}
+
+	cachefiles_write(&subreq->rreq->cache_resources,
+			 subreq->start, &subreq->io_iter,
+			 netfs_write_subrequest_terminated, subreq);
+}
+
 /*
  * Clean up an operation.
  */
@@ -638,8 +709,10 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.issue_write		= cachefiles_issue_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.prepare_write_subreq	= cachefiles_prepare_write_subreq,
 	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 };


