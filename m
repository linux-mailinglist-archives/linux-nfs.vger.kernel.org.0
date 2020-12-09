Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48202D44C1
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbgLIOto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 09:49:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733105AbgLIOto (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 09:49:44 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
Date:   Wed,  9 Dec 2020 09:48:00 -0500
Message-Id: <20201209144801.700778-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209144801.700778-15-trondmy@kernel.org>
References: <20201209144801.700778-1-trondmy@kernel.org>
 <20201209144801.700778-2-trondmy@kernel.org>
 <20201209144801.700778-3-trondmy@kernel.org>
 <20201209144801.700778-4-trondmy@kernel.org>
 <20201209144801.700778-5-trondmy@kernel.org>
 <20201209144801.700778-6-trondmy@kernel.org>
 <20201209144801.700778-7-trondmy@kernel.org>
 <20201209144801.700778-8-trondmy@kernel.org>
 <20201209144801.700778-9-trondmy@kernel.org>
 <20201209144801.700778-10-trondmy@kernel.org>
 <20201209144801.700778-11-trondmy@kernel.org>
 <20201209144801.700778-12-trondmy@kernel.org>
 <20201209144801.700778-13-trondmy@kernel.org>
 <20201209144801.700778-14-trondmy@kernel.org>
 <20201209144801.700778-15-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we encode the data payload + padding, and that we truncate
the preallocated buffer to the actual read size.

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

