Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD4445BE2
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhKDWBl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 18:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231643AbhKDWBl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A885361244;
        Thu,  4 Nov 2021 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636063142;
        bh=Pd/1bFjP2FDx/XaL++gU3HIItLHVOI/Pj5Sji1vON/c=;
        h=From:To:Cc:Subject:Date:From;
        b=pALSZ8+t/4YP+NTu0KGutFQYZuTAmUgYYcofpKbYRnRbUqB48HWApRp6oLVpiUuML
         +3KivH/hSvs3Jgx0WysERlxO8ZRvplSiVUC2eEFE5L3v9iaR1VJThoXZbOWP17o8FV
         ADY53eC2KNSt1iWEKxslXIaBnW0NPACFlFbJwg+ZZo30Wc3wME+/K3d04AvITCOq+o
         sDU0F6aAb19a9v4fsaBGc4HfEtDPxLDABZXxTSi7w9+0RoCGte9yuh8uhYe+vTREVh
         VhVR3MsghSHKBUV2Dp3vkxFQhd76QQJafs52oYLgM89g509fEKq0b6kcPsASUI9HI4
         r/owj8F3Uwj2w==
From:   trondmy@kernel.org
To:     rtm@csail.mit.edu
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Ensure decode_compound_hdr() sanity checks the tag
Date:   Thu,  4 Nov 2021 17:52:55 -0400
Message-Id: <20211104215256.408315-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The server is supposed to return the same tag that the client sends in
the outgoing RPC call, but we should still sanity check the length just
in case.

Reported-by: <rtm@csail.mit.edu>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1e3b1db7afa9..fa01edf19015 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3168,20 +3168,23 @@ static int decode_opaque_inline(struct xdr_stream *xdr, unsigned int *len, char
 
 static int decode_compound_hdr(struct xdr_stream *xdr, struct compound_hdr *hdr)
 {
-	__be32 *p;
+	ssize_t ret;
+	void *ptr;
+	u32 tmp;
 
-	p = xdr_inline_decode(xdr, 8);
-	if (unlikely(!p))
+	if (xdr_stream_decode_u32(xdr, &tmp) < 0)
 		return -EIO;
-	hdr->status = be32_to_cpup(p++);
-	hdr->taglen = be32_to_cpup(p);
+	hdr->status = tmp;
 
-	p = xdr_inline_decode(xdr, hdr->taglen + 4);
-	if (unlikely(!p))
+	ret = xdr_stream_decode_opaque_inline(xdr, &ptr, NFS4_OPAQUE_LIMIT);
+	if (ret < 0)
+		return -EIO;
+	hdr->taglen = ret;
+	hdr->tag = ptr;
+
+	if (xdr_stream_decode_u32(xdr, &tmp) < 0)
 		return -EIO;
-	hdr->tag = (char *)p;
-	p += XDR_QUADLEN(hdr->taglen);
-	hdr->nops = be32_to_cpup(p);
+	hdr->nops = tmp;
 	if (unlikely(hdr->nops < 1))
 		return nfs4_stat_to_errno(hdr->status);
 	return 0;
-- 
2.33.1

