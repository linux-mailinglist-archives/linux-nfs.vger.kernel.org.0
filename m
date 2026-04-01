Return-Path: <linux-nfs+bounces-20604-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFAFLdd1zWnYdgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20604-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:45:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A737FEE2
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 212663053D9D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E3258CCC;
	Wed,  1 Apr 2026 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gx8GQyFv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A4319852
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072721; cv=none; b=tlnRrIjprdsJXBd2l+6GSimRH9VD/IeruteUO2suANv0IzNuFM0fM4q0WcorBEw7aeoGklqwlambXIKba07DeYzarqXHOjH5eYEu0xdA64PeVURG+2nWCRnEb8h1NG8JfZzKOHapX0V5a2JuOvGmjzk2ny6yR5viMLXWBxD9/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072721; c=relaxed/simple;
	bh=m0dbA71P9BENKIFeOT3+NZ2Rt78VrDjg+GV+s0ZEm2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jv1rwvjB28OPYV61eR7QD2clUdiuIG0vQCeO4gruNiU9cRzTMNMtClfTCPZzOahte/5yGwfO75At/4I1OpMtGy7R6yIUISwTq93YzxkF9kzvyKRDAXOwgw/Wu8iqZFWM5Td7aEMP/goLOb+TZqYTpD7u7vhqB8p5JzTTCNWsgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gx8GQyFv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3594620fe97so157188a91.1
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2026 12:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775072718; x=1775677518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifkqGBJrPOFSmkn2S6G7z6he9fQIFEFSeXmggiToCT8=;
        b=gx8GQyFvvp9svn7q8DDmhkiAxXYElZjt2uyVl+M8lI2ctttecql1NV7Uvc5I1aGEIa
         ABl3g191I0zbOKwzHYHBFI5yG3vLr88AoSDJfCSue8RAeXtUTcRjhO5Ab+k07pdkDFmp
         43xh0o+w+8DU6scS0YEaRQF/QDX6SAJgS1jetvE9vEq6Ha8Lsl4k+y1tAziX93gueiQG
         atZv14ykQ7BbohCro/EZoULyar7zs0LvbWcjTW7Oumxdb+2LyS4z8VFEch0ygzBaapYP
         gLIy1t+VNghAV+9kRQya4BWg/o4s75NBkYc0cuny4fBAH1prRXWjc92KcMRe3T0ObXa9
         yn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072718; x=1775677518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifkqGBJrPOFSmkn2S6G7z6he9fQIFEFSeXmggiToCT8=;
        b=bstwNERL6sGMD8aaQAFuk6MgZ2Y6HeHeqj8nFEE67Uo6ZFIiMFQmyOZ6U98I2yL+vR
         MBYeN2VtCiFZxC1Wfco82G4+Liet2i2P/KxSmrNFBCykW1BChlp2TUAh60Ma7m46+ogI
         9PbR1DVW9a0pHE4nHLsi4pq0urrRIPNm+52xZlt0rfN1Rp4nUNo+tqpBDR9Vx8j2IGK3
         T1S1e+OwSPRG0DwlDbJRbeseIbz6OgWEGUToNeM1auizqbFbnNWPlFvM4HTwi3+Xw+O4
         XJ/8ddMVvi6+IebQNuUtczD2RgczciJpIQj++dMnRgcxsiaWpVXd4h6MwETdbaMOuD5O
         Jl1A==
X-Forwarded-Encrypted: i=1; AJvYcCUUo9n2SSl5CC35e6eMwZEi1pnykuU1v3BEf0xvMYPQmpS6TTzIDUv+HZKrPy6bduK1QgF+j169puw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+PxyuMwQXWmM9RLmYc73z55XdNcPeRjErD44C17mLuC4SIblj
	mOfLy3g/F5ZRvKcpYEE7uS5IyvjmlKs49nYb7E6Nbp/5xTw3okqT401xi8SgyF620FvhdFH5JwF
	+bQ==
X-Received: from pjyl23.prod.google.com ([2002:a17:90a:ec17:b0:35c:204e:72ce])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc2:b0:35d:8fd8:d893
 with SMTP id 98e67ed59e1d1-35dd404287amr580025a91.7.1775072717869; Wed, 01
 Apr 2026 12:45:17 -0700 (PDT)
Date: Wed,  1 Apr 2026 19:45:00 +0000
In-Reply-To: <20260401194501.2269200-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401194501.2269200-1-praan@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260401194501.2269200-5-praan@google.com>
Subject: [RFC PATCH 4/4] nfs: allow P2PDMA in direct I/O path
From: Pranjal Shrivastava <praan@google.com>
To: trond.myklebust@hammerspace.com, anna@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com, 
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20604-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 978A737FEE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Migrate the NFS Direct I/O path from the legacy iov_iter_get_pages_alloc2()
API to the modern iov_iter_extract_pages() API. This migration enables
support for PCI Peer-to-Peer DMA (P2PDMA) by allowing the setting the
ITER_ALLOW_P2PDMA flag.

Pass ITER_ALLOW_P2PDMA to iov_iter_extract_pages() only if the local
mount indicates support via the NFS_CAP_P2PDMA capability bit (detected
at mount time for RDMA transports).

Fix the memory safety bug in the Direct I/O loop where pages were being
unpinned immediately after request creation. Instead, we now leverage
pin-aware nfs_page structures to hold the pins until the I/O is complete
The manual release in the loop is updated to only clean up pages that
failed to be handed over to an nfs_page request.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c | 51 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index c8429b430181..6916541af9db 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -165,11 +165,17 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 	return 0;
 }
 
-static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
+static void nfs_direct_release_pages(struct page **pages, unsigned int npages,
+				     bool pinned)
 {
 	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
+
+	if (pinned) {
+		unpin_user_pages(pages, npages);
+	} else {
+		for (i = 0; i < npages; i++)
+			put_page(pages[i]);
+	}
 }
 
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
@@ -354,23 +360,30 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	inode_dio_begin(inode);
 
 	while (iov_iter_count(iter)) {
-		struct page **pagevec;
+		/* Tell extract pages to allocate the page array */
+		struct page **pagevec = NULL;
 		size_t bytes;
 		size_t pgbase;
 		unsigned npages, i;
+		bool pinned = iov_iter_extract_will_pin(iter);
+		iov_iter_extraction_t extraction_flags = 0;
+
+		if (NFS_SERVER(inode)->caps & NFS_CAP_P2PDMA)
+			extraction_flags |= ITER_ALLOW_P2PDMA;
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  rsize, &pgbase);
+		result = iov_iter_extract_pages(iter, &pagevec,
+						rsize, ~0U,
+						extraction_flags, &pgbase);
 		if (result < 0)
 			break;
-	
+
 		bytes = result;
 		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
 		for (i = 0; i < npages; i++) {
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 			/* XXX do we need to do the eof zeroing found in async_filler? */
-			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], false,
+			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], pinned,
 							pgbase, pos, req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -386,7 +399,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			requested_bytes += req_len;
 			pos += req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		if (i < npages)
+			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -882,13 +896,21 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 
 	NFS_I(inode)->write_io += iov_iter_count(iter);
 	while (iov_iter_count(iter)) {
-		struct page **pagevec;
+
+		/* Tell extract pages to allocate the page array */
+		struct page **pagevec = NULL;
 		size_t bytes;
 		size_t pgbase;
 		unsigned npages, i;
+		bool pinned = iov_iter_extract_will_pin(iter);
+		iov_iter_extraction_t extraction_flags = 0;
+
+		if (NFS_SERVER(inode)->caps & NFS_CAP_P2PDMA)
+			extraction_flags |= ITER_ALLOW_P2PDMA;
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  wsize, &pgbase);
+		result = iov_iter_extract_pages(iter, &pagevec,
+						wsize, ~0U,
+						extraction_flags, &pgbase);
 		if (result < 0)
 			break;
 
@@ -898,7 +920,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 
-			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], false,
+			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], pinned,
 							pgbase, pos, req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -942,7 +964,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			desc.pg_error = 0;
 			defer = true;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		if (i < npages)
+			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
-- 
2.53.0.1185.g05d4b7b318-goog


