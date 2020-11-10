Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB32AE410
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgKJX3Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgKJX3Z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:25 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB4B2080A
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050964;
        bh=Kuo8vxYYtb2g77xXco3cdBkx8fXmlpWOfVyr5XBjErA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qe3v/9mngvpFnZnFbvl8+bJjCgFhOGOBWllab8C0/GAOLnUzoNiCAF+dM/HUJZ7DQ
         EGqQWxBeMHXHWnTlE4MUSr25r1ZOp5IwPvOA2I++fMTlpbA5YTe27kWPQirf6ZtEoL
         hD4TvEszkLoMKxuZU0hyPddxKX977sJsBGK3y8Js=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/11] pNFS/flexfiles: Fix up layoutstats reporting for non-TCP transports
Date:   Tue, 10 Nov 2020 18:19:04 -0500
Message-Id: <20201110231906.863446-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110231906.863446-9-trondmy@kernel.org>
References: <20201110231906.863446-1-trondmy@kernel.org>
 <20201110231906.863446-2-trondmy@kernel.org>
 <20201110231906.863446-3-trondmy@kernel.org>
 <20201110231906.863446-4-trondmy@kernel.org>
 <20201110231906.863446-5-trondmy@kernel.org>
 <20201110231906.863446-6-trondmy@kernel.org>
 <20201110231906.863446-7-trondmy@kernel.org>
 <20201110231906.863446-8-trondmy@kernel.org>
 <20201110231906.863446-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we report the correct netid when using UDP or RDMA
transports to the DSes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a163533446fa..59ae36bf5cc0 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2269,7 +2269,6 @@ ff_layout_encode_netaddr(struct xdr_stream *xdr, struct nfs4_pnfs_ds_addr *da)
 	struct sockaddr *sap = (struct sockaddr *)&da->da_addr;
 	char portbuf[RPCBIND_MAXUADDRPLEN];
 	char addrbuf[RPCBIND_MAXUADDRLEN];
-	char *netid;
 	unsigned short port;
 	int len, netid_len;
 	__be32 *p;
@@ -2279,18 +2278,13 @@ ff_layout_encode_netaddr(struct xdr_stream *xdr, struct nfs4_pnfs_ds_addr *da)
 		if (ff_layout_ntop4(sap, addrbuf, sizeof(addrbuf)) == 0)
 			return;
 		port = ntohs(((struct sockaddr_in *)sap)->sin_port);
-		netid = "tcp";
-		netid_len = 3;
 		break;
 	case AF_INET6:
 		if (ff_layout_ntop6_noscopeid(sap, addrbuf, sizeof(addrbuf)) == 0)
 			return;
 		port = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
-		netid = "tcp6";
-		netid_len = 4;
 		break;
 	default:
-		/* we only support tcp and tcp6 */
 		WARN_ON_ONCE(1);
 		return;
 	}
@@ -2298,8 +2292,9 @@ ff_layout_encode_netaddr(struct xdr_stream *xdr, struct nfs4_pnfs_ds_addr *da)
 	snprintf(portbuf, sizeof(portbuf), ".%u.%u", port >> 8, port & 0xff);
 	len = strlcat(addrbuf, portbuf, sizeof(addrbuf));
 
+	netid_len = strlen(da->da_netid);
 	p = xdr_reserve_space(xdr, 4 + netid_len);
-	xdr_encode_opaque(p, netid, netid_len);
+	xdr_encode_opaque(p, da->da_netid, netid_len);
 
 	p = xdr_reserve_space(xdr, 4 + len);
 	xdr_encode_opaque(p, addrbuf, len);
-- 
2.28.0

