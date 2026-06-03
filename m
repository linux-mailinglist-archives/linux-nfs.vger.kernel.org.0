Return-Path: <linux-nfs+bounces-22225-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cc6fM2u8H2rbpAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22225-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:32:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 509146344AF
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:32:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cleFaQCO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22225-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22225-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A623030E14DB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D337C0EC;
	Wed,  3 Jun 2026 05:30:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275737B3E1
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 05:30:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464647; cv=none; b=Rj3GxXMSwf6xDQildfMt1p0CddAIGfl0hNJvDmneXSopK1193UjbH7V1hq1EM2Ohlgy40Dh91T01NjyEO7hGFKDY0J1bdBTH5rPz3Iby2bjVVyuTXqmzCJM/SJFVy+txZftkyhwFHrosiTSoKrxcTaKfEvP5WStwEw4g9B6mX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464647; c=relaxed/simple;
	bh=JUzn0Tl54v/LajHr6WA3u6ilMr7KtTSGf8HuMCerDVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3vN8JkTSOtub38pluCIgfRgmy6xnxkwGVsyf1UEcC4/TGJ35PWcA7Efwg8J4z3stGb3xU94+Tf4AStsfoXzKIUZi1LeSwXX0WhshOawuce2E32PrD9x3uHfsuF939N+ws57T4Cn6WsdnE8QnBFG0qe4vMswPbMDov5EkE/UIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cleFaQCO; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b982ec338so5970101a91.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 22:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780464645; x=1781069445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aceiKrGtkOAldA+lS+bg3KAJPMkEMywV7kdTVFchn4Q=;
        b=cleFaQCOtbo0g4Il5kiIdUW1HScihfeObuQIne+xm1QU5A28KJU+kFAi7PXQ1uL4hj
         AI5kzl2ufvmBQI0255LYavFE5ezJcJ31RtKBcwLQtAwfodJKW0tA2hoMdb3Vdu0xSfXK
         WfC/jvE05SyQfvo+aESka65inIrRTnBBSCkbciVnetMRd9I4uPF+2VyHO6osUCNhCh/f
         BLjZRKYdL69Omhj80Qhwh9LQTr2yFxg52lbqs3MLTSwpGJixtmuJ2y4BERkg29Z331ZO
         CLNmTRcdeLkbQeEXtlMtTpwyiJ6GkPYQ6MvEu5cHhm25Mi6haw9MhvQe5ezll6xMtwkd
         J1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464645; x=1781069445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aceiKrGtkOAldA+lS+bg3KAJPMkEMywV7kdTVFchn4Q=;
        b=s8JJAg5SR2jWhRLzgJaxCKoovpXtXmeA5uNEA1f7LxK32yhU8DYyX0P++ZY/A9oDRM
         8OS+HHLS3SRFQtnYI2oM+4JtxYztlZVEkiM3LDywogJ4sY5QG0HMGq2UQj4kYJKMLyKw
         R3NGJRBo0ZOVGwVh90Dvxx3M6mNcd62rFSuGn1pctcBtuY/FmURbZAFA3xBes8w/28oi
         SXvHHj5zY2D58LE0unrF1WiPlanEKfou1MPk//XelSSY7yh5kfEtGvLip2KPLpzCSyf4
         tXnM3nNdu2yH3MqVtYyl7N1kiqyIdVj0biqi1TvvmGS5Ob3d3D3GPXYEwyed21CvweZL
         LMjg==
X-Gm-Message-State: AOJu0Ywvyqn8L5stXtcFIr+CqjGAON1516AvHKvROD+sEw1/upqWvHU+
	MfhxcPMU0DJSyVMs+CWcq5iBBvyFvpGJEKGQMG0Kz2kyyjjz4iRwHWf7U2akUV71yEl3iR6ylnj
	c3EhKY/jAQca9/89v79w3prjK6BdH4T5pSU53Gue7udwXkgAehYl9t8UvucoQDQhNMMhfJyXXnB
	olcNGHVhZCb2r5V2+f19VPzpDGTrv5tKP5F9k=
X-Received: from pjff14.prod.google.com ([2002:a17:90b:562e:b0:365:eb99:afdb])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1642:b0:36b:bb66:fbd0
 with SMTP id 98e67ed59e1d1-36e30742d00mr1848636a91.4.1780464644804; Tue, 02
 Jun 2026 22:30:44 -0700 (PDT)
Date: Wed,  3 Jun 2026 05:30:30 +0000
In-Reply-To: <20260603053033.3300318-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603053033.3300318-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603053033.3300318-5-praan@google.com>
Subject: [PATCH v1 4/7] nfs: migrate direct I/O to iov_iter_extract_pages
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22225-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 509146344AF

Migrate the NFS Direct I/O path away from the legacy
iov_iter_get_pages_alloc2() API to the modern iov_iter_extract_pages API.
The transition aligns NFS with the modern VFS extraction model and serves
as a preparatory step for supporting requirements such as page pinning
via GUP for DMA.

The migration fixes a bug in the Direct I/O loop where pages were being
unpinned immediately after request creation. With the new extraction
model, pins are held until the I/O is complete. Manual release in the
loop is correspondingly updated to only clean up failed pages.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2691eeaaeb8c..b6aaa5f80241 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -354,16 +354,17 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	inode_dio_begin(inode);
 
 	while (iov_iter_count(iter)) {
-		struct page **pagevec;
+		struct page **pagevec = NULL;
 		size_t bytes;
 		size_t pgbase;
 		unsigned npages, i;
+		bool pinned = iov_iter_extract_will_pin(iter);
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  rsize, &pgbase);
+		result = iov_iter_extract_pages(iter, &pagevec,
+						rsize, ~0U, 0, &pgbase);
 		if (result < 0)
 			break;
-	
+
 		bytes = result;
 		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
 		for (i = 0; i < npages; i++) {
@@ -371,7 +372,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 			/* XXX do we need to do the eof zeroing found in async_filler? */
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							false, pgbase, pos,
+							pinned, pgbase, pos,
 							req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -387,7 +388,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			requested_bytes += req_len;
 			pos += req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages, false);
+		if (i < npages)
+			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -883,13 +885,14 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 
 	NFS_I(inode)->write_io += iov_iter_count(iter);
 	while (iov_iter_count(iter)) {
-		struct page **pagevec;
+		struct page **pagevec = NULL;
 		size_t bytes;
 		size_t pgbase;
 		unsigned npages, i;
+		bool pinned = iov_iter_extract_will_pin(iter);
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  wsize, &pgbase);
+		result = iov_iter_extract_pages(iter, &pagevec,
+						wsize, ~0U, 0, &pgbase);
 		if (result < 0)
 			break;
 
@@ -900,7 +903,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							false, pgbase, pos,
+							pinned, pgbase, pos,
 							req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -944,7 +947,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			desc.pg_error = 0;
 			defer = true;
 		}
-		nfs_direct_release_pages(pagevec, npages, false);
+		if (i < npages)
+			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
-- 
2.54.0.1013.g208068f2d8-goog


