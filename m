Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939D92BC963
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Nov 2020 21:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKVUwi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 15:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbgKVUwi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 15:52:38 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B5020789
        for <linux-nfs@vger.kernel.org>; Sun, 22 Nov 2020 20:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606078357;
        bh=t7GJpaRh+lfiM3ldrzF95kY8lX4NRHi/lyj6Qbl2E3o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1MGEYNDsumotVF/KfLFNMgIhV71MpcSvcV92IKcRdoSgqRI2Ta3Kdjrv/ftdXlU/p
         H9jgvaRMEnY1ewjPo90JL4GD6jFROF4ySx0gwOyPcbuHtLrWtLhk2aMzul2urIPK2U
         rR0aNpRNs3KthqRT5mKzTpPlcvNxiFh4331//kP8=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 8/8] NFSv4: Fix open coded xdr_stream_remaining()
Date:   Sun, 22 Nov 2020 15:52:29 -0500
Message-Id: <20201122205229.3826-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201122205229.3826-8-trondmy@kernel.org>
References: <20201122205229.3826-1-trondmy@kernel.org>
 <20201122205229.3826-2-trondmy@kernel.org>
 <20201122205229.3826-3-trondmy@kernel.org>
 <20201122205229.3826-4-trondmy@kernel.org>
 <20201122205229.3826-5-trondmy@kernel.org>
 <20201122205229.3826-6-trondmy@kernel.org>
 <20201122205229.3826-7-trondmy@kernel.org>
 <20201122205229.3826-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 9913aec3ee32..910468c77c58 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5335,11 +5335,11 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
 		res->acl_len = attrlen;
 
 		/* Check for receive buffer overflow */
-		if (res->acl_len > (xdr->nwords << 2) ||
+		if (res->acl_len > xdr_stream_remaining(xdr) ||
 		    res->acl_len + res->acl_data_offset > xdr->buf->page_len) {
 			res->acl_flags |= NFS4_ACL_TRUNC;
-			dprintk("NFS: acl reply: attrlen %u > page_len %u\n",
-					attrlen, xdr->nwords << 2);
+			dprintk("NFS: acl reply: attrlen %u > page_len %zu\n",
+				attrlen, xdr_stream_remaining(xdr));
 		}
 	} else
 		status = -EOPNOTSUPP;
-- 
2.28.0

