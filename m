Return-Path: <linux-nfs+bounces-22637-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hqfiJt5SMWo4gwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22637-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:42:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8A69007B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ceuacCKs;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22637-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22637-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13A24309C905
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676223375C5;
	Tue, 16 Jun 2026 13:40:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299330C345
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 13:40:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617218; cv=none; b=DUdCLMqYXfs+JPvsWXqfPGxM7R6J/S52bfUT/7Ak9HAfWAeq1lrBPzxeBGmnY9a1ZLzZCL2aIQdF7BsmG0frImTf/vlpBiBakEZECY6XRvZUZWoCRHpKvvKKHXZfQkV+kQiRzdNKPWny8mbrG4bDhB+OgKGDf+1UubUfQzw/rzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617218; c=relaxed/simple;
	bh=IjrWZLt+6c2GUao89RH/uES/lGNQShLO7756+ao9/DQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QfE53L0ibocsq/d+6BBmYZzDZPxPSeY0SDcJuKqwbJ7DyA2+VprmKrZVxCjWwab8Jbg9Sf6g3xQhwAm5+lgMqPWcMaHEXEhaHiP3jvZcKldKHdnLtsH3LEU9By7+ml/WSPUEaM9Yv0CnqxJG3xVKnBaSpt8d/WVdNQIk3/tu2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceuacCKs; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bd4146cb2so5051759a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781617216; x=1782222016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MG2zhbOg35+KcFmkxQ6aYGhkiBRRwQXPY2Of4EsggbA=;
        b=ceuacCKsPxAjBnOFv6tFkpdeulUyegsgjNTlyBulqOd1U6mVNAk6j5KL8rmUwZawU9
         PHGYiUAI/uifTmefLOTrZeSoZkstDH+CtKzx8t9zU5TLm91IJqzbkt2RMsibnQ+sYNxL
         Bj7tIq0i1s20fAlAEwRTt2prM82euFLpkuXm7HIdJxdYYKFANsYqsolrlrASzOuzdPC8
         wYsCRL2BY9FZUnKAG0swvNh4QP+ibbgVO0Zk8ZeeLH1QI1j1OBJia7irnQKGsISkK1x/
         Khq/P9WGcmYah7mOv+jjiPKIrnkri32/Ju/DXKosqWWpEok57fV5cQoOXlGAMnLsFM/0
         i5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617216; x=1782222016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG2zhbOg35+KcFmkxQ6aYGhkiBRRwQXPY2Of4EsggbA=;
        b=LwsrOlglUU1TE8OjESTTJ1UKH+4RKtFo0DanbCGPimv7T5UkQNrgMdSGG1uTT2EANX
         E8Ja3dkIyRu962pr8Lgy11AXz0oQ4ykvDIk7bKalUTU+gbCUrgDU4wdmAs4NT35SFIIh
         470x9UgHwuUxxHKyUmPXOat47tUIM9tMCn8Ix3ufKjwhoYWsUIDt9xIpiLUXXay+GHNc
         u8CU2F4RhAecySGzpCtYohaHahqkvYtdZl6H37eJQJc10pE5CixRET4ztXgYhteAXnYN
         IGdlSSgThQZS1OVP5vfqLg1pTTwp3xKFRffudqRiT+CAWPMhlOLfUI2zRvLC3b7e0sGL
         CC9A==
X-Gm-Message-State: AOJu0Yw+21z507KM0WdgbchbgtkLav5er/44ddl/byKqrChFFPb8BdHW
	uEa3eXkSwM3d3QljLru+hJgencPciglfwPPpK2vGfzaOr1fof+DEAZlJokduxcdPVlhUa/iDoyD
	5ukLtpjYreXQGfF8Kd5whUw34ZBxUSU2UddOPLw6McMpefcQejFSNxKmR+pJBBioHs11G0gxerO
	nb7JUHbB3T69iNCZw8sEWMGL3YruCQvRo6lNs=
X-Received: from pgbcz8.prod.google.com ([2002:a05:6a02:2308:b0:c85:b213:8d9d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0e:b0:368:864:62ad
 with SMTP id 98e67ed59e1d1-37c52336492mr3374252a91.3.1781617215938; Tue, 16
 Jun 2026 06:40:15 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:39:59 +0000
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616134000.2733403-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616134000.2733403-7-praan@google.com>
Subject: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for requests
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Christoph Hellwig <hch@infradead.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22637-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nfs_page_list.next:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15D8A69007B

Optimize nfs_direct_extract_pages() to group contiguous pages from the
same folio into single nfs_page structures. This effectively migrates
NFS Direct I/O from being page-based to being folio-based.

Reduce the number of nfs_page allocations and subsequent iterations
by utilizing nfs_page_create_from_folio() to create aggregated
requests.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index e2a93cfb6c72..ddc6b27f5315 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -194,23 +194,45 @@ static ssize_t nfs_direct_extract_pages(struct nfs_direct_req *dreq,
 		return result;
 
 	npages = (result + pgbase + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	for (i = 0; i < npages; i++) {
+	for (i = 0; i < npages; ) {
+		unsigned int chunk_len, folio_offset;
+		unsigned int nr_to_add = 1;
 		struct nfs_page *req;
-		unsigned int req_len = min_t(size_t, result - bytes, PAGE_SIZE - pgbase);
+		struct folio *folio;
 
-		req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-						pinned, pgbase, *pos,
-						req_len);
+		folio = page_folio(pagevec[i]);
+		folio_offset = (folio_page_idx(folio, pagevec[i]) << PAGE_SHIFT) + pgbase;
+		chunk_len = min_t(size_t, result - bytes, PAGE_SIZE - pgbase);
+
+		while (i + nr_to_add < npages) {
+			struct page *next_page = pagevec[i + nr_to_add];
+			struct page *prev_page = pagevec[i + nr_to_add - 1];
+
+			if (page_folio(next_page) != folio ||
+			    next_page != prev_page + 1)
+				break;
+
+			chunk_len += min_t(size_t, result - bytes - chunk_len, PAGE_SIZE);
+			nr_to_add++;
+		}
+
+		req = nfs_page_create_from_folio(dreq->ctx, folio,
+						  pinned, folio_offset,
+						  chunk_len);
 		if (IS_ERR(req)) {
 			if (!bytes)
 				bytes = PTR_ERR(req);
 			break;
 		}
 
+		req->wb_index = *pos >> PAGE_SHIFT;
+		req->wb_offset = offset_in_page(*pos);
+
 		list_add_tail(&req->wb_list, list);
 		pgbase = 0;
-		bytes += req_len;
-		*pos += req_len;
+		bytes += chunk_len;
+		*pos += chunk_len;
+		i += nr_to_add;
 	}
 
 	if (i < npages) {
@@ -403,9 +425,9 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 		if (result < 0)
 			break;
 
-		requested_bytes += result;
 		while (!list_empty(&nfs_page_list)) {
 			struct nfs_page *req = nfs_list_entry(nfs_page_list.next);
+			size_t req_len = req->wb_bytes;
 
 			nfs_list_remove_request(req);
 			if (!nfs_pageio_add_request(&desc, req)) {
@@ -414,6 +436,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 				nfs_release_request_list(&nfs_page_list);
 				break;
 			}
+			requested_bytes += req_len;
 		}
 		if (result < 0)
 			break;
@@ -922,19 +945,22 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 		if (result < 0)
 			break;
 
-		requested_bytes += result;
 		while (!list_empty(&nfs_page_list)) {
 			struct nfs_page *req = nfs_list_entry(nfs_page_list.next);
+			size_t req_len = req->wb_bytes;
 
 			nfs_list_remove_request(req);
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
@@ -951,6 +977,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			spin_unlock(&dreq->lock);
 			nfs_unlock_request(req);
 			nfs_mark_request_commit(req, NULL, &cinfo, 0);
+			requested_bytes += req_len;
 			desc.pg_error = 0;
 			defer = true;
 		}
-- 
2.54.0.1136.gdb2ca164c4-goog


