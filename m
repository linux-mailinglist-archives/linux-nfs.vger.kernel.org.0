Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F42BC962
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 21:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKVUwh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 15:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbgKVUwh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 15:52:37 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E839920782
        for <linux-nfs@vger.kernel.org>; Sun, 22 Nov 2020 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606078357;
        bh=BYDboR5Cc+oCNShOsvGz1Dy+YDR9rdlwJoTlpNiF9uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zBnm2QnrOmm6HUeXL5C4tVMgJ5KCu7+OgboLNiuYURK1lvjPyb5oSYWxKAyeqbZhE
         v4zsT5rGWnhlJjU0IjH8k97jVLwnwLWjhnFr+D5ekroC6e/a8jlHmPhfeLKWig1MmB
         7IzlQPwj9Ca8hyP02XOyKHwTQ3X1jic7YY80UjDE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/8] SUNRPC: Fix open coded xdr_stream_remaining()
Date:   Sun, 22 Nov 2020 15:52:28 -0500
Message-Id: <20201122205229.3826-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122205229.3826-7-trondmy@kernel.org>
References: <20201122205229.3826-1-trondmy@kernel.org>
 <20201122205229.3826-2-trondmy@kernel.org>
 <20201122205229.3826-3-trondmy@kernel.org>
 <20201122205229.3826-4-trondmy@kernel.org>
 <20201122205229.3826-5-trondmy@kernel.org>
 <20201122205229.3826-6-trondmy@kernel.org>
 <20201122205229.3826-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index ddd5cc2281ab..c852d199c789 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1261,7 +1261,7 @@ uint64_t xdr_align_data(struct xdr_stream *xdr, uint64_t offset, uint32_t length
 
 	xdr_realign_pages(xdr);
 	from = xdr_page_pos(xdr);
-	bytes = xdr->nwords << 2;
+	bytes = xdr_stream_remaining(xdr);
 	if (length < bytes)
 		bytes = length;
 
@@ -1298,7 +1298,7 @@ uint64_t xdr_expand_hole(struct xdr_stream *xdr, uint64_t offset, uint64_t lengt
 
 	xdr_realign_pages(xdr);
 	from = xdr_page_pos(xdr);
-	bytes = xdr->nwords << 2;
+	bytes = xdr_stream_remaining(xdr);
 
 	if (offset + length + bytes > buf->page_len) {
 		unsigned int shift = (offset + length + bytes) - buf->page_len;
-- 
2.28.0

