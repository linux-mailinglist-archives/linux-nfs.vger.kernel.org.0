Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E5445BE3
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Nov 2021 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhKDWBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Nov 2021 18:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232119AbhKDWBl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F461604DC;
        Thu,  4 Nov 2021 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636063143;
        bh=qIXxBsrXBM22xAHtbTBz11f3Zf4MYjtwpxk8KAPRU3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJTb3owkUncayZTBYKpO3zR22K3zgyyXN8w3ODPBCYAM7wCCwOy7M9WcsFW+Xp3AN
         v11yNwJMV0gVU1mULe9B9MW9ASQTzTwWmTBvfJNLm2D/14P1vF/vZ52FhWfgW+9baW
         NbLEW75aR1mq3BChpz/pMq42m/nOy/nr8CGleW09QgL3xZjH9OEQU7hqG3Sl8mpsxX
         7upyzts+pYjrnPTcVrXIwdY4ptxPhbz8AEXOPhlpafKf0Tn8ohy7ifn07/cGHnf3Cm
         px4kululBOgib4vVMcluvyt912KnOWrWy6TbN8zTDAte89tgYFGfsz8MNQSw4ElUuF
         JVtgMBOlgWRZw==
From:   trondmy@kernel.org
To:     rtm@csail.mit.edu
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Fix potential Oops in decode_op_map()
Date:   Thu,  4 Nov 2021 17:52:56 -0400
Message-Id: <20211104215256.408315-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211104215256.408315-1-trondmy@kernel.org>
References: <20211104215256.408315-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The return value of xdr_inline_decode() is not being checked, leading to
a potential Oops. Just replace the open coded array decode with the
generic XDR version.

Reported-by: <rtm@csail.mit.edu>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index fa01edf19015..69862bf6db00 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5567,20 +5567,9 @@ static int decode_secinfo_no_name(struct xdr_stream *xdr, struct nfs4_secinfo_re
 
 static int decode_op_map(struct xdr_stream *xdr, struct nfs4_op_map *op_map)
 {
-	__be32 *p;
-	uint32_t bitmap_words;
-	unsigned int i;
-
-	p = xdr_inline_decode(xdr, 4);
-	if (!p)
-		return -EIO;
-	bitmap_words = be32_to_cpup(p++);
-	if (bitmap_words > NFS4_OP_MAP_NUM_WORDS)
+	if (xdr_stream_decode_uint32_array(xdr, op_map->u.words,
+					   ARRAY_SIZE(op_map->u.words)) < 0)
 		return -EIO;
-	p = xdr_inline_decode(xdr, 4 * bitmap_words);
-	for (i = 0; i < bitmap_words; i++)
-		op_map->u.words[i] = be32_to_cpup(p++);
-
 	return 0;
 }
 
-- 
2.33.1

