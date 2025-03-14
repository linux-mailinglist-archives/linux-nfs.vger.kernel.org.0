Return-Path: <linux-nfs+bounces-10624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E34A61698
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 17:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E746819C4861
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Mar 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C0204C3A;
	Fri, 14 Mar 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQFvnHEK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4741204592
	for <linux-nfs@vger.kernel.org>; Fri, 14 Mar 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970558; cv=none; b=lTeEnXUU3hmZE56Uip6ZbAS9t/XNlMDZcvEmoeKAzPtOuGthqTfdDaLLQEOr06RZNUb6UTI5P1IUTK+PMKe5GLPy6HUjuGR3yLKIoSMfCgpag5BnMlfOI2AAuPCDkvBM4ykR9o7mvTmGwMQCJEHDgc7t+PPS72vyZjSg33N6xNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970558; c=relaxed/simple;
	bh=7RfnCZTxnffbMtVXJbp1eKsFHKdpEKrmz3WERO38Qz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo0mEuOrUE3s1zlkqHwWJOF6KFeBreq9cBT6Gi11D71Y7BUhA1wqkvIAK+TQw1PRiB5smQfWo+aztgNvJxZzCR2WG4wPlOnXa0CsV8FDQO+91PqPMvmJWLEYpCyFnXuaviAjKuIfEVC1sRTiiGTfW3xvVjeh/VTT1Xjn1MFn6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQFvnHEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741970556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KsqgtlbawqA1+pPoXDWlta38taI8Ws6UsIFBymdNjzI=;
	b=ZQFvnHEKYuZkikAOXpkelGtYdB2hGXKeMvkTzIe1zHwG/0L2jnihik6k8Y2nfqAv1KyG95
	4bZ4TCqPYuNNsptQbqf203Oz8xnDABKxsS03QaG43G/QpeWfUQKbkkIas/Nl36vGCojRyC
	eIlMlk3+J3tLTXWolM/55r8e+4jITb8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-ABSHVzyUNcyxoKCf-bpvQg-1; Fri,
 14 Mar 2025 12:42:31 -0400
X-MC-Unique: ABSHVzyUNcyxoKCf-bpvQg-1
X-Mimecast-MFC-AGG-ID: ABSHVzyUNcyxoKCf-bpvQg_1741970550
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E75A180AF50;
	Fri, 14 Mar 2025 16:42:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEF571944CE5;
	Fri, 14 Mar 2025 16:42:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/4] netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
Date: Fri, 14 Mar 2025 16:41:59 +0000
Message-ID: <20250314164201.1993231-5-dhowells@redhat.com>
In-Reply-To: <20250314164201.1993231-1-dhowells@redhat.com>
References: <20250314164201.1993231-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Fix netfs_unbuffered_read() to return an ssize_t rather than an int as
netfs_wait_for_read() returns ssize_t and this gets implicitly truncated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_read.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 0bf3c2f5a710..5e3f0aeb51f3 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -125,9 +125,9 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
  * Perform a read to an application buffer, bypassing the pagecache and the
  * local disk cache.
  */
-static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
+static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 {
-	int ret;
+	ssize_t ret;
 
 	_enter("R=%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
@@ -155,7 +155,7 @@ static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 	else
 		ret = -EIOCBQUEUED;
 out:
-	_leave(" = %d", ret);
+	_leave(" = %zd", ret);
 	return ret;
 }
 


