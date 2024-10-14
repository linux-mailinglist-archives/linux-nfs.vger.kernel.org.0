Return-Path: <linux-nfs+bounces-7136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DE99C802
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 13:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8481C2476A
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Oct 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F331A01CD;
	Mon, 14 Oct 2024 11:00:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1501AC42C;
	Mon, 14 Oct 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903634; cv=none; b=qwfm4Inv76YTgaEK0Kp2bx5bbs9bsPYs4lrkn9AJYCJsD5jZM+iPos4YyU1yzs1F1HmILYIWxikjxOv8fRVVx+cquOqvNbNPXZDVvANqJNLu9Y03Btqeg0BvuhAW2waPXnVxMw6j+WavPlqVkpww35HcfH4n94bgJloa20u8Adw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903634; c=relaxed/simple;
	bh=e+YQDR10H2AzwPGwlgfVFvSnmoMZbbXPbr3mIsLC0sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6+YQzMc7Wfm76GaiP7hzYHtFqUkYCDU5hvlFa+GVRdttumZEiQAXwLm1PeGUcjlMARdNbIBkw/ZloamsaQLD3bOHEz+OiaBumZ/5stzGw/rWJt0Z03UHdoRwz/ZYkVxOILRvlurVnvnPw11/MQHZVUWGwHDfKIAIs6X+kcJ7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB86168F;
	Mon, 14 Oct 2024 04:01:01 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1323A3F51B;
	Mon, 14 Oct 2024 04:00:28 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 21/57] sunrpc: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:28 +0100
Message-ID: <20241014105912.3207374-21-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Updated array sizes in various structs to contain enough entries for the
smallest supported page size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/linux/sunrpc/svc.h      | 8 +++++---
 include/linux/sunrpc/svc_rdma.h | 4 ++--
 include/linux/sunrpc/svcsock.h  | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index a7d0406b9ef59..dda44018b8f36 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -160,6 +160,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  */
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
+#define RPCSVC_MAXPAGES_MAX	((RPCSVC_MAXPAYLOAD+PAGE_SIZE_MIN-1)/PAGE_SIZE_MIN \
+				+ 2 + 1)
 
 /*
  * The context of a single thread, including the request currently being
@@ -190,14 +192,14 @@ struct svc_rqst {
 	struct xdr_stream	rq_res_stream;
 	struct page		*rq_scratch_page;
 	struct xdr_buf		rq_res;
-	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
+	struct page		*rq_pages[RPCSVC_MAXPAGES_MAX + 1];
 	struct page *		*rq_respages;	/* points into rq_pages */
 	struct page *		*rq_next_page; /* next reply page to use */
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
-	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
+	struct kvec		rq_vec[RPCSVC_MAXPAGES_MAX]; /* generally useful.. */
+	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES_MAX];
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d33bab33099ab..7c6441e8d6f7a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -200,7 +200,7 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	unsigned int		rc_page_count;
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
+	struct page		*rc_pages[RPCSVC_MAXPAGES_MAX];
 };
 
 /*
@@ -242,7 +242,7 @@ struct svc_rdma_send_ctxt {
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
-	struct page		*sc_pages[RPCSVC_MAXPAGES];
+	struct page		*sc_pages[RPCSVC_MAXPAGES_MAX];
 	struct ib_sge		sc_sges[];
 };
 
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index 7c78ec6356b92..6c6bcc82685a3 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -40,7 +40,7 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
-	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
+	struct page *		sk_pages[RPCSVC_MAXPAGES_MAX];	/* received data */
 };
 
 static inline u32 svc_sock_reclen(struct svc_sock *svsk)
-- 
2.43.0


