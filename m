Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85457E805
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiGVUJ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiGVUJ1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741DEAF852
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC0C61F52
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E8AC341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:09:24 +0000 (UTC)
Subject: [PATCH v1 8/8] NFSD: Clean up nfsd_encode_readlink()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:09:23 -0400
Message-ID: <165852056314.11198.9481263320352443620.stgit@manet.1015granger.net>
In-Reply-To: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
References: <165852051841.11198.2929614302983292322.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Similar changes to nfsd4_encode_readv(), all bundled into a single
patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 71bac0039c42..358b3338c4cc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4008,16 +4008,13 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readlink *readlink)
 {
-	int maxcount;
-	__be32 wire_count;
-	int zero = 0;
+	__be32 *p, *maxcount_p, zero = xdr_zero;
 	struct xdr_stream *xdr = resp->xdr;
 	int length_offset = xdr->buf->len;
-	int status;
-	__be32 *p;
+	int maxcount, status;
 
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
+	maxcount_p = xdr_reserve_space(xdr, XDR_UNIT);
+	if (!maxcount_p)
 		return nfserr_resource;
 	maxcount = PAGE_SIZE;
 
@@ -4042,14 +4039,11 @@ nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd
 		nfserr = nfserrno(status);
 		goto out_err;
 	}
-
-	wire_count = htonl(maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, length_offset, &wire_count, 4);
-	xdr_truncate_encode(xdr, length_offset + 4 + ALIGN(maxcount, 4));
-	if (maxcount & 3)
-		write_bytes_to_xdr_buf(xdr->buf, length_offset + 4 + maxcount,
-						&zero, 4 - (maxcount&3));
-	return 0;
+	*maxcount_p = cpu_to_be32(maxcount);
+	xdr_truncate_encode(xdr, length_offset + 4 + xdr_align_size(maxcount));
+	write_bytes_to_xdr_buf(xdr->buf, length_offset + 4 + maxcount, &zero,
+			       xdr_pad_size(maxcount));
+	return nfs_ok;
 
 out_err:
 	xdr_truncate_encode(xdr, length_offset);


