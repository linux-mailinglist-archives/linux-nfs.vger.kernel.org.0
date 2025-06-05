Return-Path: <linux-nfs+bounces-12132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE915ACF173
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 16:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D7189392A
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465022D780;
	Thu,  5 Jun 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQl/hj8d"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD81DB34B
	for <linux-nfs@vger.kernel.org>; Thu,  5 Jun 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132123; cv=none; b=fqQ1GuxRYVgrxGfyw7qVTj17R/tpuWQrh3vGMWEB1jPmAQ2idPeYMVaNeK5dc7N087BI/d9HQBoj0cdKMvGvgn5QWr8x7AjXZGGxRqD88jWv2HMVSjV/6Pwck8drlJa/ON+U7VZMLcNaJLpDcXmpYbHdjZ0UX74s59Tk32pHVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132123; c=relaxed/simple;
	bh=jeE8MrMC+vYnKJlIJrQGIVlZ8jfBkPjbK51oHvsx3zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrVpljUvrFb6m+oSk8SznI46g94VWW2rhUZszHIMr4gmZGgI/HqxuEMdXTuZPDo7Ri99sXNdup28uTemcLtr/lwaEqlKFkxf+Veg2LAzsycYOLr7BPwscKTnR/834xmXdw0MOCYTuvqVhCIvTBcHDv8oOqnbKScUUr6Gl4g0yBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQl/hj8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749132120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x3uMkiro3skSlScmApRNSd+Svezof17oOw4n/xGpV74=;
	b=NQl/hj8dbLmX2SHYvCMIm2iXRTGtIE7WEFc3frYk2wBHgCj+9u98cQcluZ9ysv2F4GGxxc
	/Vx+43rNEfRjY411ZWoHw3PSGn0SwiYoR70/WeID78iQNRn2DiVEVzUoYgZFVAq6eBMKb7
	8/jk70HlP4Nt+nlPZ/poHQRjak5Bf1A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-ypY9QZYVNzuqG2dhFKu2Dw-1; Thu,
 05 Jun 2025 10:01:57 -0400
X-MC-Unique: ypY9QZYVNzuqG2dhFKu2Dw-1
X-Mimecast-MFC-AGG-ID: ypY9QZYVNzuqG2dhFKu2Dw_1749132115
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0E9D195609E;
	Thu,  5 Jun 2025 14:01:55 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 349FC18002A5;
	Thu,  5 Jun 2025 14:01:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Cleanup/fix initial rq_pages allocation
Date: Thu,  5 Jun 2025 10:01:52 -0400
Message-ID: <458f45b2b7259c17555dd65aa7cdbbf1a459d5e6.1749131924.git.bcodding@redhat.com>
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

Additionally, it seems that svc_init_buffer() is redundant because
svc_alloc_arg() will perform the required allocation and does the correct
thing to retry the allocations.

The call to allocate memory in svc_alloc_arg() drops the preferred node
argument, but I expect we'll still allocate on the preferred node because
the allocation call happens within the svc thread context, which chooses
the node with memory closest to the current thread's execution.

This patch cleans out svc_init_buffer() to allow svc_alloc_arg() to handle
the allocation of rq_pages.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/svc.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c..e14f2d5c15bf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -635,27 +635,6 @@ svc_destroy(struct svc_serv **servp)
 }
 EXPORT_SYMBOL_GPL(svc_destroy);
 
-static bool
-svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
-{
-	unsigned long pages, ret;
-
-	/* bc_xprt uses fore channel allocated buffers */
-	if (svc_is_backchannel(rqstp))
-		return true;
-
-	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
-				       * We assume one is at most one page
-				       */
-	WARN_ON_ONCE(pages > RPCSVC_MAXPAGES);
-	if (pages > RPCSVC_MAXPAGES)
-		pages = RPCSVC_MAXPAGES;
-
-	ret = alloc_pages_bulk_node(GFP_KERNEL, node, pages,
-				    rqstp->rq_pages);
-	return ret == pages;
-}
-
 /*
  * Release an RPC server buffer
  */
@@ -708,9 +687,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp->rq_resp)
 		goto out_enomem;
 
-	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
-		goto out_enomem;
-
 	rqstp->rq_err = -EAGAIN; /* No error yet */
 
 	serv->sv_nrthreads += 1;
-- 
2.47.0


