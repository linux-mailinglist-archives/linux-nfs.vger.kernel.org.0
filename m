Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0357B55AE
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbjJBOvd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbjJBOv2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 10:51:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3A99F
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 07:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC3CC433C7;
        Mon,  2 Oct 2023 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696258285;
        bh=QT/qGxYT7x1chDmfFy4c5Lf0RMA5paJelk98Q8mtl4o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B6AA2EP9MDPqq908d8JyNdocD8nE0MObqlRn60kt3EM6SpB56fe8b/RQ9PiaGJBbM
         xRuwLrwespxKdzAHoTYGLCginO7CcNvNIlfYcm63HH3FrswtHGN3zMINpLJGV0RBp0
         gQg023fElt+OliBmpoxga6c6/owYcT+T6Cogx9WsBSJ+LlKyTkK3+hDHJVp9Y1vSUv
         xiQYIMV4HkfeBOIjlud7aYGIr6WhnTAsD1BokTx1F2zw2x1R7CW1/IlounurB4R9ec
         Zz/65l75Wxxwu1bv0KoEbef7S0pTVOxMvO8q8wHh5QxrcyjWqPQmBdtGavuqArslFG
         yxBAOXSEz4/mw==
Subject: [PATCH v1 2/4] NFSD: Add nfsd4_encode_channel_attr4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 02 Oct 2023 10:51:24 -0400
Message-ID: <169625828435.1640.4981323575080441000.stgit@klimt.1015granger.net>
In-Reply-To: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
References: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

De-duplicate the encoding of the fore channel and backchannel
attributes.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   80 +++++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e41e46213444..01820492c013 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4778,6 +4778,44 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return 0;
 }
 
+static __be32
+nfsd4_encode_channel_attrs4(struct xdr_stream *xdr,
+			    const struct nfsd4_channel_attrs *attrs)
+{
+	__be32 status;
+
+	/* ca_headerpadsize */
+	status = nfsd4_encode_count4(xdr, 0);
+	if (status != nfs_ok)
+		return status;
+	/* ca_maxrequestsize */
+	status = nfsd4_encode_count4(xdr, attrs->maxreq_sz);
+	if (status != nfs_ok)
+		return status;
+	/* ca_maxresponsesize */
+	status = nfsd4_encode_count4(xdr, attrs->maxresp_sz);
+	if (status != nfs_ok)
+		return status;
+	/* ca_maxresponsesize_cached */
+	status = nfsd4_encode_count4(xdr, attrs->maxresp_cached);
+	if (status != nfs_ok)
+		return status;
+	/* ca_maxoperations */
+	status = nfsd4_encode_count4(xdr, attrs->maxops);
+	if (status != nfs_ok)
+		return status;
+	/* ca_maxrequests */
+	status = nfsd4_encode_count4(xdr, attrs->maxreqs);
+	if (status != nfs_ok)
+		return status;
+	/* ca_rdma_ird<1> */
+	if (xdr_stream_encode_u32(xdr, attrs->nr_rdma_attrs) != XDR_UNIT)
+		return nfserr_resource;
+	if (attrs->nr_rdma_attrs)
+		return nfsd4_encode_uint32_t(xdr, attrs->rdma_attrs);
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
 			    union nfsd4_op_u *u)
@@ -4794,42 +4832,12 @@ nfsd4_encode_create_session(struct nfsd4_compoundres *resp, __be32 nfserr,
 	*p++ = cpu_to_be32(sess->seqid);
 	*p++ = cpu_to_be32(sess->flags);
 
-	p = xdr_reserve_space(xdr, 28);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(0); /* headerpadsz */
-	*p++ = cpu_to_be32(sess->fore_channel.maxreq_sz);
-	*p++ = cpu_to_be32(sess->fore_channel.maxresp_sz);
-	*p++ = cpu_to_be32(sess->fore_channel.maxresp_cached);
-	*p++ = cpu_to_be32(sess->fore_channel.maxops);
-	*p++ = cpu_to_be32(sess->fore_channel.maxreqs);
-	*p++ = cpu_to_be32(sess->fore_channel.nr_rdma_attrs);
-
-	if (sess->fore_channel.nr_rdma_attrs) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			return nfserr_resource;
-		*p++ = cpu_to_be32(sess->fore_channel.rdma_attrs);
-	}
-
-	p = xdr_reserve_space(xdr, 28);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(0); /* headerpadsz */
-	*p++ = cpu_to_be32(sess->back_channel.maxreq_sz);
-	*p++ = cpu_to_be32(sess->back_channel.maxresp_sz);
-	*p++ = cpu_to_be32(sess->back_channel.maxresp_cached);
-	*p++ = cpu_to_be32(sess->back_channel.maxops);
-	*p++ = cpu_to_be32(sess->back_channel.maxreqs);
-	*p++ = cpu_to_be32(sess->back_channel.nr_rdma_attrs);
-
-	if (sess->back_channel.nr_rdma_attrs) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			return nfserr_resource;
-		*p++ = cpu_to_be32(sess->back_channel.rdma_attrs);
-	}
-	return 0;
+	/* csr_fore_chan_attrs */
+	nfserr = nfsd4_encode_channel_attrs4(xdr, &sess->fore_channel);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* csr_back_chan_attrs */
+	return nfsd4_encode_channel_attrs4(xdr, &sess->back_channel);
 }
 
 static __be32


