Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDA2D7CDA
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404401AbgLKR1h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394583AbgLKR1A (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:27:00 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfsd: Fixes for nfsd4_encode_read_plus_data()
Date:   Fri, 11 Dec 2020 12:26:14 -0500
Message-Id: <20201211172615.5716-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we encode the data payload + padding, and that we truncate
the preallocated buffer to the actual read size.

Fixes: 528b84934eb9 ("NFSD: Add READ_PLUS data support")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 833a2c64dfe8..26f6e277101d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4632,6 +4632,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
 	if (nfserr)
 		return nfserr;
+	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
 
 	tmp = htonl(NFS4_CONTENT_DATA);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
@@ -4639,6 +4640,10 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
 	tmp = htonl(*maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
+
+	tmp = xdr_zero;
+	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
+			       xdr_pad_size(*maxcount));
 	return nfs_ok;
 }
 
-- 
2.29.2

