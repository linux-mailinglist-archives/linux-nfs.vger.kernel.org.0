Return-Path: <linux-nfs+bounces-12219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F59AD24EE
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 19:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFD73A510D
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jun 2025 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170081DC9A3;
	Mon,  9 Jun 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh4JEOa7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019A74C14
	for <linux-nfs@vger.kernel.org>; Mon,  9 Jun 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489727; cv=none; b=bsQnoayQHa7DvPxwVL6fbf2FELgrWupP1vfF4un7IdD10+XfH2VbT1tBaLZb/wf3j4gXQ1CUHY2QtXdfERCPOBy71ZbTtyB0xf1wUs1FzgIvxuEbGH4ozNAQITEMLjJ4cFgvpEEKUXMOYyxFHbUwVXe0VBaeupEuDhFUOs/CzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489727; c=relaxed/simple;
	bh=UoMwJeCvOt9YRBR4suPMD+/Q7pqJd5xK3eI7ld3Rduk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBYJLHED0gFdrmYnRSFcdoPniJsyQq/LkLvn30hqS832TRYwgOTtdhyK2vpuIRDrbDk8OPTGXjE6sLFrDBpKhCoVXnMaZVjfBJZQDUZkP/ngZPFuNWzDDDLouI/up3HYJ/w3Z3Te/kX6yv/k/yKZWZFULe6IjqY2OFd3/KZ01eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uh4JEOa7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749489724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=55QAl5PIxNSxhuHjppzV/dd0svLL28BmG3+ZQja/gyY=;
	b=Uh4JEOa74vR7k/ZTgyfi8AwDQATAL5D9HViL4KhYiqObE+LDIZBshaHSc/Pxk85ClIypnw
	Nuw6i/aKzGXOyIOaLmsAxVqdIVQQCPzUna9l+x6JEXn+qvWmNsgOniQ9Q3y/g5czibLXeh
	GXEIzPdOjbxEWwfFiDe6V7pR1boPMP0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-Uya1LG33O3Oon4dHqi8pdg-1; Mon,
 09 Jun 2025 13:22:00 -0400
X-MC-Unique: Uya1LG33O3Oon4dHqi8pdg-1
X-Mimecast-MFC-AGG-ID: Uya1LG33O3Oon4dHqi8pdg_1749489719
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BFAF1800287;
	Mon,  9 Jun 2025 17:21:59 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.9])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 217EE1800285;
	Mon,  9 Jun 2025 17:21:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Mon,  9 Jun 2025 13:21:56 -0400
Message-ID: <151437c300ca8eb4d8d9a842c9caf167cb32b6ea.1749489592.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

While investigating some reports of memory-constrained NUMA machines
failing to mount v3 and v4.0 nfs mounts, we found that svc_init_buffer()
was not attempting to retry allocations from the bulk page allocator.
Typically, this results in a single page allocation being returned and
the mount attempt fails with -ENOMEM.  A retry would have allowed the mount
to succeed.

Additionally, it seems that the bulk allocation in svc_init_buffer() is
redundant because svc_alloc_arg() will perform the required allocation and
does the correct thing to retry the allocations.

The call to allocate memory in svc_alloc_arg() drops the preferred node
argument, but I expect we'll still allocate on the preferred node because
the allocation call happens within the svc thread context, which chooses
the node with memory closest to the current thread's execution.

This patch cleans out the bulk allocation in svc_init_buffer() to allow
svc_alloc_arg() to handle the allocation/retry logic for rq_pages.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

--
On v2:
	- rebased on nfsd-next
	- keep the rq_pages array allocation in svc_init_buffer(), defer
	  the page allocation to svc_alloc_arg()
---
 net/sunrpc/svc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 939b6239df8a..ef8a05aac87f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -638,8 +638,6 @@ EXPORT_SYMBOL_GPL(svc_destroy);
 static bool
 svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 {
-	unsigned long ret;
-
 	rqstp->rq_maxpages = svc_serv_maxpages(serv);
 
 	/* rq_pages' last entry is NULL for historical reasons. */
@@ -649,9 +647,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int node)
 	if (!rqstp->rq_pages)
 		return false;
 
-	ret = alloc_pages_bulk_node(GFP_KERNEL, node, rqstp->rq_maxpages,
-				    rqstp->rq_pages);
-	return ret == rqstp->rq_maxpages;
+	return true;
 }
 
 /*
-- 
2.47.0


