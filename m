Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB91E2AE412
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgKJX30 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKJX30 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:26 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3617620781
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050965;
        bh=1+6bk7j9y7Q8iGihembwdMHIt1iNAhj0G9cagnoabus=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CWxcKoXtcLCjssu0I6Ea9YJgTp64c1lvfTRTGkN/tRHVGnc5DIHtIzwP1YcFmAUt5
         PsRQ/mFqwoyo+H3Gq4iPqYfC8yJ8Srdqza56g04xmU8CsEx+hxRqSc9d5LmidusuBs
         M8FqpceOEC/E99WTctyWJnyl/3J7zQkx6+FpdRSU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 11/11] pNFS: Clean up open coded xdr string decoding
Date:   Tue, 10 Nov 2020 18:19:06 -0500
Message-Id: <20201110231906.863446-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110231906.863446-11-trondmy@kernel.org>
References: <20201110231906.863446-1-trondmy@kernel.org>
 <20201110231906.863446-2-trondmy@kernel.org>
 <20201110231906.863446-3-trondmy@kernel.org>
 <20201110231906.863446-4-trondmy@kernel.org>
 <20201110231906.863446-5-trondmy@kernel.org>
 <20201110231906.863446-6-trondmy@kernel.org>
 <20201110231906.863446-7-trondmy@kernel.org>
 <20201110231906.863446-8-trondmy@kernel.org>
 <20201110231906.863446-9-trondmy@kernel.org>
 <20201110231906.863446-10-trondmy@kernel.org>
 <20201110231906.863446-11-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Use the existing xdr_stream_decode_string_dup() to safely decode into
kmalloced strings.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 43 +++++++------------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index b96ecb395310..1babf56faf66 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1045,9 +1045,8 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 	struct nfs4_pnfs_ds_addr *da = NULL;
 	char *buf, *portstr;
 	__be16 port;
-	int nlen, rlen;
+	ssize_t nlen, rlen;
 	int tmp[2];
-	__be32 *p;
 	char *netid;
 	size_t len;
 	char *startsep = "";
@@ -1055,45 +1054,17 @@ nfs4_decode_mp_ds_addr(struct net *net, struct xdr_stream *xdr, gfp_t gfp_flags)
 
 
 	/* r_netid */
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
+	nlen = xdr_stream_decode_string_dup(xdr, &netid, XDR_MAX_NETOBJ,
+					    gfp_flags);
+	if (unlikely(nlen < 0))
 		goto out_err;
-	nlen = be32_to_cpup(p++);
-
-	p = xdr_inline_decode(xdr, nlen);
-	if (unlikely(!p))
-		goto out_err;
-
-	netid = kmalloc(nlen+1, gfp_flags);
-	if (unlikely(!netid))
-		goto out_err;
-
-	netid[nlen] = '\0';
-	memcpy(netid, p, nlen);
 
 	/* r_addr: ip/ip6addr with port in dec octets - see RFC 5665 */
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		goto out_free_netid;
-	rlen = be32_to_cpup(p);
-
-	p = xdr_inline_decode(xdr, rlen);
-	if (unlikely(!p))
-		goto out_free_netid;
-
 	/* port is ".ABC.DEF", 8 chars max */
-	if (rlen > INET6_ADDRSTRLEN + IPV6_SCOPE_ID_LEN + 8) {
-		dprintk("%s: Invalid address, length %d\n", __func__,
-			rlen);
+	rlen = xdr_stream_decode_string_dup(xdr, &buf, INET6_ADDRSTRLEN +
+					    IPV6_SCOPE_ID_LEN + 8, gfp_flags);
+	if (unlikely(rlen < 0))
 		goto out_free_netid;
-	}
-	buf = kmalloc(rlen + 1, gfp_flags);
-	if (!buf) {
-		dprintk("%s: Not enough memory\n", __func__);
-		goto out_free_netid;
-	}
-	buf[rlen] = '\0';
-	memcpy(buf, p, rlen);
 
 	/* replace port '.' with '-' */
 	portstr = strrchr(buf, '.');
-- 
2.28.0

