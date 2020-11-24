Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6271E2C28B1
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbgKXNub (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388591AbgKXNub (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:31 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A64D6208C3
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225830;
        bh=BYDboR5Cc+oCNShOsvGz1Dy+YDR9rdlwJoTlpNiF9uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kVqk9EXbchekyJ7r2PqWDRQA5gSf1Zl9l4FCdEMVm5PveQEp+/8VypwcpyKLjn5mc
         22PB4qzGVKtiO9qSDNHxkflF5ZR9/UJ8442sWShdslKTd0YGhISigmuz313uu7ZqD9
         n8RV6T5QL73dJkagtcoA5MMZHrLcve5/gxavOnos=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/9] SUNRPC: Fix open coded xdr_stream_remaining()
Date:   Tue, 24 Nov 2020 08:50:23 -0500
Message-Id: <20201124135025.1097571-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124135025.1097571-7-trondmy@kernel.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
 <20201124135025.1097571-2-trondmy@kernel.org>
 <20201124135025.1097571-3-trondmy@kernel.org>
 <20201124135025.1097571-4-trondmy@kernel.org>
 <20201124135025.1097571-5-trondmy@kernel.org>
 <20201124135025.1097571-6-trondmy@kernel.org>
 <20201124135025.1097571-7-trondmy@kernel.org>
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

