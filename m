Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9642C28B2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgKXNuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388603AbgKXNuc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:32 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2128E208CA
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225831;
        bh=6ElKWEj1svJHZwUEVi60TAjY59KVXZ4W+el3vIKhEYs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZBxur327ZZ+GOdFCZltwDYG5j4iEgw56Y8VXdIcX13Zw8L7Hr1iHCqo7jMdh7Ju6J
         qmQvigyJcS2RfLGVjkUsAIT7HkPQB82xv5aYX7RSHtoeELUQr0nonEEEUik5lhQuoQ
         cIMwMsIYos24UmYaaPALyiLUtuTdE8Sgm2K0EZY4=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 8/9] NFSv4: Fix open coded xdr_stream_remaining()
Date:   Tue, 24 Nov 2020 08:50:24 -0500
Message-Id: <20201124135025.1097571-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124135025.1097571-8-trondmy@kernel.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
 <20201124135025.1097571-2-trondmy@kernel.org>
 <20201124135025.1097571-3-trondmy@kernel.org>
 <20201124135025.1097571-4-trondmy@kernel.org>
 <20201124135025.1097571-5-trondmy@kernel.org>
 <20201124135025.1097571-6-trondmy@kernel.org>
 <20201124135025.1097571-7-trondmy@kernel.org>
 <20201124135025.1097571-8-trondmy@kernel.org>
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
index 3899ef3047f4..de69276cfd22 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5337,11 +5337,11 @@ static int decode_getacl(struct xdr_stream *xdr, struct rpc_rqst *req,
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

