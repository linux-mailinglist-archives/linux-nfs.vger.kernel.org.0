Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC542BC95C
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKVUwf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 15:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbgKVUwf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 15:52:35 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7251420782
        for <linux-nfs@vger.kernel.org>; Sun, 22 Nov 2020 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606078354;
        bh=A2MtDuZ1NZ5rfhyFyzg3U6eJcSxZ9+2Hp5BMK2OFL8U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pq7FCzGrf3g+GTuT9SpNsGsbP4JR1IrM7IcSoFn3WM3d7ApYsOYnxzYGWU2yjXD8u
         XlUR0zGAq+if+w7aUaORKgpmol0MPXvS2Ixrh8ZOwpHWtW7jl8zl4gudBHFHS+6WIu
         5tlAizicLWzlY1RGz/X9B/IHiRkFvbNWm0nbF7+I=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/8] SUNRPC: Fix up typo in xdr_init_decode()
Date:   Sun, 22 Nov 2020 15:52:23 -0500
Message-Id: <20201122205229.3826-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122205229.3826-2-trondmy@kernel.org>
References: <20201122205229.3826-1-trondmy@kernel.org>
 <20201122205229.3826-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We already know that the head buffer and page are empty, so if there is
any data, it is in the tail.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index b1cda6d85ded..bc7a622016ee 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1060,7 +1060,7 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 	else if (buf->page_len != 0)
 		xdr_set_page_base(xdr, 0, buf->len);
 	else
-		xdr_set_iov(xdr, buf->head, buf->len);
+		xdr_set_iov(xdr, buf->tail, buf->len);
 	if (p != NULL && p > xdr->p && xdr->end >= p) {
 		xdr->nwords -= p - xdr->p;
 		xdr->p = p;
-- 
2.28.0

