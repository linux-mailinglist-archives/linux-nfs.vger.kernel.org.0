Return-Path: <linux-nfs+bounces-16175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429EC408B9
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428744EDB6A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AA32AACD;
	Fri,  7 Nov 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItF/ytH3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1B2E54A3;
	Fri,  7 Nov 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528193; cv=none; b=ZlhjY9nmOE6xt1x8x4d2OslyunRsvMQZMi41ktSY0qmbmjdJD1G/8dCapHja8S/TnGC0tsfM7003UvSeOvtVKMmRnxrOOWy/elZHB1tLt/0FUQxNBUIQfbnrAmfvMAn0S3008JhRDo2sGdBccEwxrrQwiG6qQTPH5HDbv7AIUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528193; c=relaxed/simple;
	bh=7sGPPePvvE1dyVYA+mlLSSOV61nBaNIONBpd8bd9QSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Be8Q+kAjjVB0zmAhqDMrKZ8HqWdQOY3EOqxDjv0ZLxbjHjzwmjRKdwPH3leQBv+A8zqa7dlycd16L//rX3FUdeBvFZSKGct5MhvR8t3+wOJDVqqTahSt1SK0aUJsXX0BWHpPLa5eIA+bfAGOLUgkcHK1+YSNzxW45NOFgxOnD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItF/ytH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA03C4CEF5;
	Fri,  7 Nov 2025 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762528192;
	bh=7sGPPePvvE1dyVYA+mlLSSOV61nBaNIONBpd8bd9QSU=;
	h=From:To:Cc:Subject:Date:From;
	b=ItF/ytH3WZmjxt6IHs9iAqQqMo8syEmtZ+LrS8pVjmWvauMFCSH527CTWgvV3KCg7
	 uFAtImeT+EEzZKN/FO1Ru2OK2aTEetMCcgsUm6fgWB+cxhKZB6OjSUAxzqbTY+Vfnw
	 rG+tAHiONl6AAoZWwxLUivlroUn8wcvMPYp96qfB9yootYYu9FWXAwAx72cRTu35a7
	 BCbKfOOjITtKBA/fZDXveq45znAZiM4i5yqfUC9HsZgvdjCgAX/Rm5Vg4yxziqecu8
	 tiFPI/UeSDwae2hdekiUzLYIRZclOEXTldgmN0jG8xKfaJ6Lb5hqJBEYnHVNedSBaw
	 l67SivkIeAS2g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joshua Rogers <linux@joshua.hu>
Subject: [PATCH 1/3] svcrdma: use rc_pageoff for memcpy byte offset
Date: Fri,  7 Nov 2025 10:09:47 -0500
Message-ID: <20251107150949.3808-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

svc_rdma_copy_inline_range added rc_curpage (page index) to the page
base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
land within the current page.

Fixes: 8e122582680c ("svcrdma: Move svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt")
X-Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 661b3fe2779f..945fbb374331 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -848,7 +848,7 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 			head->rc_page_count++;
 
 		dst = page_address(rqstp->rq_pages[head->rc_curpage]);
-		memcpy(dst + head->rc_curpage, src + offset, page_len);
+		memcpy((unsigned char *)dst + head->rc_pageoff, src + offset, page_len);
 
 		head->rc_readbytes += page_len;
 		head->rc_pageoff += page_len;
-- 
2.51.0


