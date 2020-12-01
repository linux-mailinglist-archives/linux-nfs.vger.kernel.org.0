Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531B42CAF0E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgLAVpV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 16:45:21 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:63626 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbgLAVpV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 16:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606859120; x=1638395120;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AXTwL0lJKMrT00SN16kiyCL8fhb0iCZEhg7+iIVh+pU=;
  b=EmJ94ytRXI8kjPbOuZVzUsB9FJW5JGTRFs57ej1K+jb7tAhapF51kEDK
   vUtCXiS5SFujkbId8qM/83lx+y+CJMTBkUJyRhGkE91ig6QKGSx81wle8
   9+/zuHKDKkgtlmF68b49Hs5JEOgvlAlCC5wObpO6jMiZZYpgqSdpfemvO
   Q=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="68419752"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 01 Dec 2020 21:31:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 565DDA2226;
        Tue,  1 Dec 2020 21:31:30 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 21:31:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 1 Dec 2020 21:31:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 1 Dec 2020 21:31:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id A4F38C133E; Tue,  1 Dec 2020 21:31:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     <chuck.lever@oracle.com>, <aglo@umich.edu>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH] NFSv4.2: improve page handling for GETXATTR
Date:   Tue, 1 Dec 2020 21:31:28 +0000
Message-ID: <20201201213128.13624-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

XDRBUF_SPARSE_PAGES can cause problems for the RDMA transport,
and it's easy enough to allocate enough pages for the request
up front, so do that.

Also, since we've allocated the pages anyway, use the full
page aligned length for the receive buffer. This will allow
caching of valid replies that are too large for the caller,
but that still fit in the allocated pages.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs42proc.c | 39 ++++++++++++++++++++++++++++++---------
 fs/nfs/nfs42xdr.c  | 22 +++++++++++++++++-----
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 2b2211d1234e..bfe15ac77bd9 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 				void *buf, size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct page *pages[NFS4XATTR_MAXPAGES] = {};
+	struct page **pages;
 	struct nfs42_getxattrargs arg = {
 		.fh		= NFS_FH(inode),
-		.xattr_pages	= pages,
-		.xattr_len	= buflen,
 		.xattr_name	= name,
 	};
 	struct nfs42_getxattrres res;
@@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 		.rpc_argp	= &arg,
 		.rpc_resp	= &res,
 	};
-	int ret, np;
+	ssize_t ret, np, i;
+
+	arg.xattr_len = buflen ?: XATTR_SIZE_MAX;
+
+	ret = -ENOMEM;
+	np = DIV_ROUND_UP(arg.xattr_len, PAGE_SIZE);
+
+	pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
+	if (pages == NULL)
+		return ret;
+
+	for (i = 0; i < np; i++) {
+		pages[i] = alloc_page(GFP_KERNEL);
+		if (!pages[i])
+			goto out_free;
+	}
+
+	arg.xattr_pages = pages;
 
 	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
 	    &res.seq_res, 0);
 	if (ret < 0)
-		return ret;
+		goto out_free;
+
+	ret = res.xattr_len;
 
 	/*
 	 * Normally, the caching is done one layer up, but for successful
@@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 	nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);
 
 	if (buflen) {
-		if (res.xattr_len > buflen)
-			return -ERANGE;
+		if (res.xattr_len > buflen) {
+			ret = -ERANGE;
+			goto out_free;
+		}
 		_copy_from_pages(buf, pages, 0, res.xattr_len);
 	}
 
-	np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
+out_free:
 	while (--np >= 0)
 		__free_page(pages[np]);
 
-	return res.xattr_len;
+	kfree(pages);
+
+	return ret;
 }
 
 static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a88f98c..8dfe674d1301 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -489,6 +489,12 @@ static int decode_getxattr(struct xdr_stream *xdr,
 		return -EIO;
 
 	len = be32_to_cpup(p);
+
+	/*
+	 * Only check against the page length here. The actual
+	 * requested length may be smaller, but that is only
+	 * checked against after possibly caching a valid reply.
+	 */
 	if (len > req->rq_rcv_buf.page_len)
 		return -ERANGE;
 
@@ -1483,11 +1489,17 @@ static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_getxattr(xdr, args->xattr_name, &hdr);
 
-	plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
-
-	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
-	    hdr.replen);
-	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+	/*
+	 * The GETXATTR op has no length field in the call, and the
+	 * xattr data is at the end of the reply.
+	 *
+	 * Since the pages have already been allocated, there is no
+	 * downside in using the page-aligned length. It will allow
+	 * receiving and caching xattrs that are too large for the
+	 * caller but still fit in the page-rounded value.
+	 */
+	plen = round_up(args->xattr_len, PAGE_SIZE);
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen, hdr.replen);
 
 	encode_nops(&hdr);
 }
-- 
2.23.3

