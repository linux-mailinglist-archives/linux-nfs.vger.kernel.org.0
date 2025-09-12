Return-Path: <linux-nfs+bounces-14392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B7B5583C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8717BA082
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30D32F770;
	Fri, 12 Sep 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK9JeD69"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D432A83C
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711653; cv=none; b=aZBckeJKVt1wtzI+kinM0BgmsbyRKc9X219+jkUwf3b4YFCmwJlFw265aWb6JH7jHREt503xE96uWZoaP0n/fgTAfWNMVqfGODNwmMWJSf9//Geh4YJi8F/YBs97Spkj/rIwEARdTbevru06o55S843/3zVNH7MGg2aI4REpla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711653; c=relaxed/simple;
	bh=9j1xF3KG0DbvtxGm8bKVzmDWJHOyo8ijF90M0l7Ek9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxKGdHEbRW2BOsqCITVTEVh9of5VfSdGC/AqKmvO7dwbEYNVBCBrrdbir2LjQDorMEU/k5q4yicTCwNRj4FQSEu0/JzZAPTT2WkNwC4NjFfligGYYXUzTgTxg7cW0lchHCGp1Q3AYgmUrNjKq2iwIpwI6qbOk7iETyPU9D0vo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK9JeD69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0EDC4CEF5;
	Fri, 12 Sep 2025 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711652;
	bh=9j1xF3KG0DbvtxGm8bKVzmDWJHOyo8ijF90M0l7Ek9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sK9JeD69vHQctgTF1lkyc2gLff/4QbhdwLbgr2Qp0lGqJQoxvR4+B6W5TkV+DlIfs
	 0pVoFsOeEMRkP/4P9nbdzNF0vsAGmIMIiWdA58eadea7FiRtdGqx8GDq7Mmbz74paj
	 KOQBXIdp+uxtBXc3S45jhljvqdN3HkbSLeCeCy0+gFmUYCccABPzNJBLBkNHq4o+k2
	 yP6Zg0r1kSX4gm56ViAlTV98yoiQUgQe2Dqll96Zx2U9mQECyaqnUNV/2toywYfmNy
	 LxvPBjBYe/TrWNFD18wOEun5YrsQ0dQ5WK54hbFRqWe3SsIo7t2hZOlyvyu2qPmQg8
	 7TTcjeYFgogag==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 1/9] sunrpc: Introduce xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:01 -0400
Message-ID: <20250912211410.837006-2-anna@kernel.org>
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

This will replace xdr_set_scratch_page() when we switch pages to folios.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 include/linux/sunrpc/xdr.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 8a9ec617cf66..3ce17321689a 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -300,6 +300,19 @@ xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
 	xdr_set_scratch_buffer(xdr, page_address(page), PAGE_SIZE);
 }
 
+/**
+ * xdr_set_scratch_folio - Attach a scratch buffer for decoding data
+ * @xdr: pointer to xdr_stream struct
+ * @page: an anonymous folio
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_set_scratch_folio(struct xdr_stream *xdr, struct folio *folio)
+{
+	xdr_set_scratch_buffer(xdr, folio_address(folio), folio_size(folio));
+}
+
 /**
  * xdr_reset_scratch_buffer - Clear scratch buffer information
  * @xdr: pointer to xdr_stream struct
-- 
2.51.0


