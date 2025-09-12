Return-Path: <linux-nfs+bounces-14400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC0B5583D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3675C0988
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DBE3376A9;
	Fri, 12 Sep 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqFtK6Pj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036D337688
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711656; cv=none; b=NnnbdNQ1+rw4xHrWjn4tSALL68ix7rZ6Mlsi/X5MJKG69REoYcf0GAsompDCZ0wxihkmVgS21r92GOg/RhpHuW1yRXFAMM6nO8KtOlK1iCKT670ehLL1xSl4Z2WBk5mxZMIpjEHfPYPDdEQwjjFVNy1z555sIoAov4N55uadojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711656; c=relaxed/simple;
	bh=nuguKdehxnZOZZT0e/o+mCRAE84CwqrPUUAYfyhzlL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXv/cxyUqW+EneEQvl3/eG1pfam6CN/J42finWTm0rW4uMeFJkWWKTQ2zATaxj20dmj5+4/Fyn5yuSGEy0ZOBQ+1asKG9Z4CR1Lef9rtKEo5tefuS5T/jDSqBw0ziaxpTOMVU/ZUYGVxgHRBtthiDmPdfPUvN5y298XcDAA+ZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqFtK6Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CBCC4CEF8;
	Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711656;
	bh=nuguKdehxnZOZZT0e/o+mCRAE84CwqrPUUAYfyhzlL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqFtK6Pjqbw1vE94l0gpSaN2/kwB27AGfFRmeGEZwBuiQg1dzDvWgwXszEeGks9rn
	 7U6Dm9tHgv4Xt50qBNVJCrqs20cfmVXgiFQzC3BG++RdPyjm+ughzRAVwOfMqQwyN7
	 UyqosDtkexhv4gVetaZSbOKuFZ3gS7RbYK38VmGnqA1zOiTBv3v2B6k44Xu9eeZMlj
	 vAKzxHed1t+3PU0fAB7YQEWnL4TvPV7XPduKgILIZpCC8niozL6ZMK7kLxnfhsiRGX
	 YyHn+/8eaIoesHONifLNx6R4nZ9lOKBHvRw/IUoRboRysUVxvDRXAEIxAu/poab4Xb
	 yjF1f7qwBpUdg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 8/9] SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:09 -0400
Message-ID: <20250912211410.837006-10-anna@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912211410.837006-1-anna@kernel.org>
References: <20250912211410.837006-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

The only snag here is that __folio_alloc_node() doesn't handle
NUMA_NO_NODE, so I also need to update svc_pool_map_get_node() to return
numa_mem_id() instead. I arrived at this approach by  looking at what
other users of __folio_alloc_node() do for this case.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 include/linux/sunrpc/svc.h |  4 ++--
 net/sunrpc/svc.c           | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 40cbe81360ed..5506d20857c3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -196,7 +196,7 @@ struct svc_rqst {
 	struct xdr_buf		rq_arg;
 	struct xdr_stream	rq_arg_stream;
 	struct xdr_stream	rq_res_stream;
-	struct page		*rq_scratch_page;
+	struct folio		*rq_scratch_folio;
 	struct xdr_buf		rq_res;
 	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
 	struct page *		*rq_pages;
@@ -503,7 +503,7 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
 
 	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
-	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
+	xdr_set_scratch_folio(xdr, rqstp->rq_scratch_folio);
 }
 
 /**
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9c7245d811eb..de05ef637bdc 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -352,7 +352,7 @@ static int svc_pool_map_get_node(unsigned int pidx)
 		if (m->mode == SVC_POOL_PERNODE)
 			return m->pool_to[pidx];
 	}
-	return NUMA_NO_NODE;
+	return numa_mem_id();
 }
 /*
  * Set the given thread's cpus_allowed mask so that it
@@ -669,8 +669,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
 	folio_batch_release(&rqstp->rq_fbatch);
 	kfree(rqstp->rq_bvec);
 	svc_release_buffer(rqstp);
-	if (rqstp->rq_scratch_page)
-		put_page(rqstp->rq_scratch_page);
+	if (rqstp->rq_scratch_folio)
+		folio_put(rqstp->rq_scratch_folio);
 	kfree(rqstp->rq_resp);
 	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
@@ -691,8 +691,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 
-	rqstp->rq_scratch_page = alloc_pages_node(node, GFP_KERNEL, 0);
-	if (!rqstp->rq_scratch_page)
+	rqstp->rq_scratch_folio = __folio_alloc_node(GFP_KERNEL, 0, node);
+	if (!rqstp->rq_scratch_folio)
 		goto out_enomem;
 
 	rqstp->rq_argp = kmalloc_node(serv->sv_xdrsize, GFP_KERNEL, node);
-- 
2.51.0


