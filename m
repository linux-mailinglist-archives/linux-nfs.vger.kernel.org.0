Return-Path: <linux-nfs+bounces-23328-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RCluKTyfV2o6YAAAu9opvQ
	(envelope-from <linux-nfs+bounces-23328-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 16:54:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDD75FA16
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 16:54:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HbaOJl3P;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23328-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23328-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A5F32D16C1
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 14:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F740EBAF;
	Wed, 15 Jul 2026 14:35:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EED3CCFB8
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 14:35:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126155; cv=none; b=n+NWM9cFpmSzrLVEfw8G1vMIqQo4Db2NfSxtCQPXPu6bhxv1D9qNZjHM6Syp9wdJ3hlxFgi9J9xMgwI5d9KtQfVWXuqAW6OMchTcnmpwcaGTNWsj5EuDYnAgODHY5qXu18wFPPx4bb3AeUTV9PedY2Rv5SGtGRuDaoAoUuTANug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126155; c=relaxed/simple;
	bh=aq/dqivTylEYUypjlV4BF+bTiDzXZi2U/ysC7mi1ILE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZ2RuRZlFyBrdNYFOt3h9XMEbVivuUPvAc6b6nk4pgGLm2Ax2hEXdMbdbIgssaQbgGLV0eKzMyhJu1Dg5xnsbsu2s3c1uW3dfguMyLAe5bMWnfJB4Q81wP0X/pPKlAyt39ZaMqD09qH4AZ4VfnFOcDoW9EUEJZQhBzXbUZa1RMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbaOJl3P; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38827cee19eso5774727a91.3
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784126154; x=1784730954; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvDbt+8SzF/ZiDvgKGOK70E+TOXcsILzu2Lzhah2Cr4=;
        b=HbaOJl3Pd742gvMcI1Tmja05FMgBFGVWkf8gG/deBR939O8j3kyyZkaTGPbvP+a4Yv
         epHmBBpNxEOvuhr5sY1RV1TxUvOBKNklQ4bM2WQdket9jiUQMIfiK3HwW+g0OUHNcSLB
         DcKYW2syXAAHEvqNSAb1EOfl6ycL/FHJP3kaElqe47JV+3ZhRrkt5zY+MCQAu7+UC1SN
         U4mu7KJrVULbKn/MHNzRhdEnB8Ft1zi3KXA+9KeuzPgcZSj4sXfbPadVXDJtgOR/DTuQ
         1Ow81dUoytDj98YnW7QxRmdBeccitcUN7aoREXHyvlHGIoRkOgRxjQXyMfmZw5U2lkqb
         TCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126154; x=1784730954;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvDbt+8SzF/ZiDvgKGOK70E+TOXcsILzu2Lzhah2Cr4=;
        b=qzOEAw760OhvWPr9kzLC6b/IDOmuje0NSrUr/+rp0Ox1I5FuTKX7ZCjokBSNb6XIbE
         CdVKUZKRpz03vqCWv0aGGrt5cYyNi4QXA9qAFxP9AcXv5V7ijjH9TeXGo8CpaR2ty3gK
         z5nV3BgNi6aZb7Z/ckyPdaxBCpybT9x1Js6gr0Isdoc4u0RPF0NBVMP9pkZTUob/Lcfo
         vY9cWSzMxED4bTqKM+BUkgP0jLNRlKk9VU/nVCmXEDtu6iv6VTQtcqtpfGtxqwaEhvVS
         VcrfDrl9xQNscvaEc8Qw89nVekvki0quAtIBfa7KNZUl4Pj6TYCopBcashqFMrK2QDzx
         T7FA==
X-Forwarded-Encrypted: i=1; AHgh+RrDZmWxuKSMR2pQNqOkCpGnSL9CWX1cVt2UEMEjRYOj59QY/zNY134cukwM4C3erjTQS6HiC9zlQ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGI9Wuq+qyP3JrceKn7/oNdKEOJi5ggcIewyZ4d7yuPmVMHri
	9Ay52y4QoLwTgrDSMW811LE5PMKl5g9es78f2ochiwAvZ7bX80waWv0K0o4Uzo0q2/+K+zFib0F
	WnA==
X-Received: from pjbpd7.prod.google.com ([2002:a17:90b:1dc7:b0:381:1980:b2c8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec7:b0:37c:774c:77ba
 with SMTP id 98e67ed59e1d1-38e1afbf5abmr6518324a91.21.1784126153426; Wed, 15
 Jul 2026 07:35:53 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:35:40 +0000
In-Reply-To: <20260715143540.3597616-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715143540.3597616-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260715143540.3597616-6-praan@google.com>
Subject: [PATCH v3 5/5] nfs: introduce nfs_direct_extract_pages helper
From: Pranjal Shrivastava <praan@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:logang@deltatee.com,m:jgg@ziepe.ca,m:linux-pci@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23328-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nfs_page_list.next:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDEDD75FA16
X-Rspamd-Action: no action

Introduce nfs_direct_extract_pages() in direct.c to centralize page
extraction and request creation for the Direct I/O path. The helper
manages extraction from the iters and builds a list of nfs_page requests

Refactor nfs_direct_read_schedule_iovec() and
nfs_direct_write_schedule_iovec() to utilize the new helper, unifying
the extraction logic on both paths.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c | 127 ++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 63 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index b9ac0a67693c..d31e4720ffff 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -178,6 +178,50 @@ static void nfs_direct_release_pages(struct page **pages, unsigned int npages,
 	}
 }
 
+static ssize_t nfs_direct_extract_pages(struct nfs_direct_req *dreq,
+					 struct iov_iter *iter,
+					 size_t size, loff_t *pos,
+					 struct list_head *list)
+{
+	bool pinned = iov_iter_extract_will_pin(iter);
+	struct page **pagevec = NULL;
+	ssize_t result, bytes = 0;
+	unsigned int npages, i;
+	size_t pgbase;
+
+	result = iov_iter_extract_pages(iter, &pagevec, size, ~0U, 0, &pgbase);
+	if (result <= 0)
+		return result;
+
+	npages = (result + pgbase + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	for (i = 0; i < npages; i++) {
+		struct nfs_page *req;
+		unsigned int req_len = min_t(size_t, result - bytes, PAGE_SIZE - pgbase);
+
+		req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
+						pinned, pgbase, *pos,
+						req_len);
+		if (IS_ERR(req)) {
+			if (!bytes)
+				bytes = PTR_ERR(req);
+			break;
+		}
+
+		list_add_tail(&req->wb_list, list);
+		pgbase = 0;
+		bytes += req_len;
+		*pos += req_len;
+	}
+
+	if (i < npages) {
+		iov_iter_revert(iter, result - bytes);
+		nfs_direct_release_pages(pagevec + i, npages - i, pinned);
+	}
+
+	kvfree(pagevec);
+	return bytes;
+}
+
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
 			      struct nfs_direct_req *dreq)
 {
@@ -346,6 +390,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	ssize_t result = -EINVAL;
 	size_t requested_bytes = 0;
 	size_t rsize = max_t(size_t, NFS_SERVER(inode)->rsize, PAGE_SIZE);
+	LIST_HEAD(nfs_page_list);
 
 	nfs_pageio_init_read(&desc, dreq->inode, false,
 			     &nfs_direct_read_completion_ops);
@@ -354,43 +399,23 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	inode_dio_begin(inode);
 
 	while (iov_iter_count(iter)) {
-		struct page **pagevec = NULL;
-		size_t bytes;
-		size_t pgbase;
-		unsigned npages, i;
-		bool pinned = iov_iter_extract_will_pin(iter);
-
-		result = iov_iter_extract_pages(iter, &pagevec,
-						rsize, ~0U, 0, &pgbase);
+		result = nfs_direct_extract_pages(dreq, iter, rsize, &pos, &nfs_page_list);
 		if (result < 0)
 			break;
 
-		bytes = result;
-		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
-		for (i = 0; i < npages; i++) {
-			struct nfs_page *req;
-			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
-			/* XXX do we need to do the eof zeroing found in async_filler? */
-			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							pinned, pgbase, pos,
-							req_len);
-			if (IS_ERR(req)) {
-				result = PTR_ERR(req);
-				break;
-			}
+		while (!list_empty(&nfs_page_list)) {
+			struct nfs_page *req = nfs_list_entry(nfs_page_list.next);
+			size_t req_len = req->wb_bytes;
+
+			nfs_list_remove_request(req);
 			if (!nfs_pageio_add_request(&desc, req)) {
 				result = desc.pg_error;
 				nfs_release_request(req);
+				nfs_release_request_list(&nfs_page_list);
 				break;
 			}
-			pgbase = 0;
-			bytes -= req_len;
 			requested_bytes += req_len;
-			pos += req_len;
 		}
-		if (i < npages)
-			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
-		kvfree(pagevec);
 		if (result < 0)
 			break;
 	}
@@ -881,6 +906,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	ssize_t result = 0;
 	size_t requested_bytes = 0;
 	size_t wsize = max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
+	LIST_HEAD(nfs_page_list);
 	bool defer = false;
 
 	trace_nfs_direct_write_schedule_iovec(dreq);
@@ -893,55 +919,32 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 
 	NFS_I(inode)->write_io += iov_iter_count(iter);
 	while (iov_iter_count(iter)) {
-		struct page **pagevec = NULL;
-		size_t bytes;
-		size_t pgbase;
-		unsigned npages, i;
-		bool pinned = iov_iter_extract_will_pin(iter);
-
-		result = iov_iter_extract_pages(iter, &pagevec,
-						wsize, ~0U, 0, &pgbase);
+		result = nfs_direct_extract_pages(dreq, iter, wsize, &pos, &nfs_page_list);
 		if (result < 0)
 			break;
 
-		bytes = result;
-		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
-		for (i = 0; i < npages; i++) {
-			struct nfs_page *req;
-			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
-
-			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							pinned, pgbase, pos,
-							req_len);
-			if (IS_ERR(req)) {
-				result = PTR_ERR(req);
-				break;
-			}
-
-			if (desc.pg_error < 0) {
-				nfs_free_request(req);
-				result = desc.pg_error;
-				break;
-			}
-
-			pgbase = 0;
-			bytes -= req_len;
-			requested_bytes += req_len;
-			pos += req_len;
+		while (!list_empty(&nfs_page_list)) {
+			struct nfs_page *req = nfs_list_entry(nfs_page_list.next);
+			size_t req_len = req->wb_bytes;
 
+			nfs_list_remove_request(req);
 			if (defer) {
 				nfs_mark_request_commit(req, NULL, &cinfo, 0);
+				requested_bytes += req_len;
 				continue;
 			}
 
 			nfs_lock_request(req);
-			if (nfs_pageio_add_request(&desc, req))
+			if (nfs_pageio_add_request(&desc, req)) {
+				requested_bytes += req_len;
 				continue;
+			}
 
 			/* Exit on hard errors */
 			if (desc.pg_error < 0 && desc.pg_error != -EAGAIN) {
 				result = desc.pg_error;
 				nfs_unlock_and_release_request(req);
+				nfs_release_request_list(&nfs_page_list);
 				break;
 			}
 
@@ -952,12 +955,10 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			spin_unlock(&dreq->lock);
 			nfs_unlock_request(req);
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
+			requested_bytes += req_len;
 			desc.pg_error = 0;
 			defer = true;
 		}
-		if (i < npages)
-			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
-		kvfree(pagevec);
 		if (result < 0)
 			break;
 	}
-- 
2.55.0.229.g6434b31f56-goog


