Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4B2CB19A
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Dec 2020 01:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgLBAfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 19:35:18 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:54902 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgLBAfR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 19:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606869317; x=1638405317;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NM9uzIA6eqTdAxM6MN04gnMaktbZtOmkPWI+E9wYDLM=;
  b=LIeM/eykvaSRYvuWiZiBlp2H62TsdARrZhqQPXdSwAaDbsFET2KFvFXl
   AL94DhwtJtlVV6/bLgsUgZpyP0BnLxfpjfcy+WrWh8L2zPWQv90IpNIb0
   r/yt7QnqZSgVQz3ttePh9aHK6AVaiUXJwk8D4RGzbWJQaCafaXFd7I7o9
   Y=;
X-IronPort-AV: E=Sophos;i="5.78,385,1599523200"; 
   d="scan'208";a="68473683"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Dec 2020 00:34:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id C32F4A1F65;
        Wed,  2 Dec 2020 00:34:12 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 00:34:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 00:34:11 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 2 Dec 2020 00:34:11 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id D17B4C1321; Wed,  2 Dec 2020 00:34:11 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     <chuck.lever@oracle.com>, <aglo@umich.edu>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2] NFSv4.2: improve page handling for GETXATTR
Date:   Wed, 2 Dec 2020 00:34:11 +0000
Message-ID: <20201202003411.659-1-fllinden@amazon.com>
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
 fs/nfs/nfs42proc.c | 47 +++++++++++++++++++++++++++++++++++-----------
 fs/nfs/nfs42xdr.c  | 14 ++++++++------
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index faa673667fce..378a9edf9de9 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1173,14 +1173,12 @@ static int _nfs42_proc_setxattr(struct inode *inode, const char *name,
 }
 
 static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
-				void *buf, size_t buflen)
+				void *buf, size_t buflen, struct page **pages,
+				size_t plen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct page *pages[NFS4XATTR_MAXPAGES] = {};
 	struct nfs42_getxattrargs arg = {
 		.fh		= NFS_FH(inode),
-		.xattr_pages	= pages,
-		.xattr_len	= buflen,
 		.xattr_name	= name,
 	};
 	struct nfs42_getxattrres res;
@@ -1189,7 +1187,10 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 		.rpc_argp	= &arg,
 		.rpc_resp	= &res,
 	};
-	int ret, np;
+	ssize_t ret;
+
+	arg.xattr_len = plen;
+	arg.xattr_pages = pages;
 
 	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
 	    &res.seq_res, 0);
@@ -1214,10 +1215,6 @@ static ssize_t _nfs42_proc_getxattr(struct inode *inode, const char *name,
 		_copy_from_pages(buf, pages, 0, res.xattr_len);
 	}
 
-	np = DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
-	while (--np >= 0)
-		__free_page(pages[np]);
-
 	return res.xattr_len;
 }
 
@@ -1294,16 +1291,44 @@ ssize_t nfs42_proc_getxattr(struct inode *inode, const char *name,
 			      void *buf, size_t buflen)
 {
 	struct nfs4_exception exception = { };
-	ssize_t err;
+	ssize_t err, np, i;
+	struct page **pages;
 
+	np = nfs_page_array_len(0, buflen ?: XATTR_SIZE_MAX);
+	pages = kmalloc_array(np, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	for (i = 0; i < np; i++) {
+		pages[i] = alloc_page(GFP_KERNEL);
+		if (!pages[i]) {
+			np = i + 1;
+			goto out;
+		}
+	}
+
+	/*
+	 * The GETXATTR op has no length field in the call, and the
+	 * xattr data is at the end of the reply.
+	 *
+	 * There is no downside in using the page-aligned length. It will
+	 * allow receiving and caching xattrs that are too large for the
+	 * caller but still fit in the page-rounded value.
+	 */
 	do {
-		err = _nfs42_proc_getxattr(inode, name, buf, buflen);
+		err = _nfs42_proc_getxattr(inode, name, buf, buflen,
+			pages, np * PAGE_SIZE);
 		if (err >= 0)
 			break;
 		err = nfs4_handle_exception(NFS_SERVER(inode), err,
 				&exception);
 	} while (exception.retry);
 
+out:
+	while (--np >= 0)
+		__free_page(pages[np]);
+	kfree(pages);
+
 	return err;
 }
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a88f98c..f4eef4c49868 100644
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
 
@@ -1476,18 +1482,14 @@ static void nfs4_xdr_enc_getxattr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	struct compound_hdr hdr = {
 		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
 	};
-	size_t plen;
 
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_getxattr(xdr, args->xattr_name, &hdr);
 
-	plen = args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
-
-	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
-	    hdr.replen);
-	req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
+	rpc_prepare_reply_pages(req, args->xattr_pages, 0,
+	    args->xattr_len, hdr.replen);
 
 	encode_nops(&hdr);
 }
-- 
2.23.3

