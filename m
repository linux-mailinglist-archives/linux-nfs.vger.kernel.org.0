Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86BC57E802
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 22:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiGVUJU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVUJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 16:09:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7088AF85F
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 13:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 807DDB81EDB
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22679C341C6
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 20:09:05 +0000 (UTC)
Subject: [PATCH v1 5/8] NFSD: Optimize nfsd4_encode_readv()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jul 2022 16:09:04 -0400
Message-ID: <165852054418.11198.4464181129392548587.stgit@manet.1015granger.net>
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

write_bytes_to_xdr_buf() is pretty expensive to use for inserting
an XDR data item that is always 1 XDR_UNIT at an address that is
always XDR word-aligned.

Since both the readv and splice read paths encode EOF and maxcount
values, move both to a common code path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 16ae1be1bbac..1e59d4ce529f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3880,7 +3880,6 @@ static __be32 nfsd4_encode_splice_read(
 	struct xdr_buf *buf = xdr->buf;
 	int status, space_left;
 	__be32 nfserr;
-	__be32 *p = xdr->p - 2;
 
 	/* Make sure there will be room for padding if needed */
 	if (xdr->end - xdr->p < 1)
@@ -3899,9 +3898,6 @@ static __be32 nfsd4_encode_splice_read(
 		goto out_err;
 	}
 
-	*(p++) = htonl(read->rd_eof);
-	*(p++) = htonl(maxcount);
-
 	buf->page_len = maxcount;
 	buf->len += maxcount;
 	xdr->page_ptr += (buf->page_base + maxcount + PAGE_SIZE - 1)
@@ -3962,11 +3958,6 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr_io;
 	xdr_truncate_encode(xdr, starting_len + 8 + xdr_align_size(maxcount));
 
-	tmp = htonl(read->rd_eof);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
-	tmp = htonl(maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
-
 	tmp = xdr_zero;
 	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
@@ -4008,11 +3999,14 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
 		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
-
-	if (nfserr)
+	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
+		return nfserr;
+	}
 
-	return nfserr;
+	p = xdr_encode_bool(p, read->rd_eof);
+	*p = cpu_to_be32(read->rd_length);
+	return nfs_ok;
 }
 
 static __be32


