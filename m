Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8E07AD910
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjIYN2G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIYN2G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:28:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88B107
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:27:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A859C433C8;
        Mon, 25 Sep 2023 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648479;
        bh=1tTbUutORxxnWXs1JIoDJ84j2wtsm5mET65+nefl3Mw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sUBe5i55PyW6UTz1kf58NXQQuqIk2u4cXPvMZZKlRe9Wqpnjeumx9Ra7Xvzz9UVt5
         thui0G+qwR2EJFH9jhivAKGXnY6h/0h9B3111zH8RwXia2rKGPaRJ4zoseejCZ3ys+
         fuBlG9XOCCEnHUDRbPzPDRKvJoni+WaGZ8IxIE2Wz5k3rFyyvohOpC5Ra9YD0JnWTy
         rYmdTtGB73Xn3CBkooFr4jkcaalGfF3jYBiTGaqtiNQBRyGiJmny3Ll4CVI936/VMM
         L4R/8j0jg8R2v30vqAajUjgi7wperv/i7vEwIJSbqyV8UG7Lr+1xzfUmnX73i723fk
         JDATi1y478ygQ==
Subject: [PATCH v1 4/8] NFSD: Clean up nfsd4_encode_layoutget()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:27:58 -0400
Message-ID: <169564847814.6013.6222010754023482772.stgit@klimt.1015granger.net>
In-Reply-To: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
References: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
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

De-duplicate the open-coded stateid4 encoder. Adopt the use of the
conventional current XDR encoding helpers. Refactor the encoder to
align with the XDR specification.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   52 ++++++++++++++++++++++++++++++++++------------------
 fs/nfsd/xdr4.h    |    2 ++
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 24caa1c5613b..13df5b021db6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4860,32 +4860,48 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfserr_toosmall;
 }
 
+static __be32
+nfsd4_encode_layout4(struct xdr_stream *xdr, const struct nfsd4_layoutget *lgp)
+{
+	const struct nfsd4_layout_ops *ops = nfsd4_layout_ops[lgp->lg_layout_type];
+	__be32 status;
+
+	/* lo_offset */
+	status = nfsd4_encode_offset4(xdr, lgp->lg_seg.offset);
+	if (status != nfs_ok)
+		return status;
+	/* lo_length */
+	status = nfsd4_encode_length4(xdr, lgp->lg_seg.length);
+	if (status != nfs_ok)
+		return status;
+	/* lo_iomode */
+	if (xdr_stream_encode_u32(xdr, lgp->lg_seg.iomode) != XDR_UNIT)
+		return nfserr_resource;
+	/* lo_content */
+	if (xdr_stream_encode_u32(xdr, lgp->lg_layout_type) != XDR_UNIT)
+		return nfserr_resource;
+	return ops->encode_layoutget(xdr, lgp);
+}
+
 static __be32
 nfsd4_encode_layoutget(struct nfsd4_compoundres *resp, __be32 nfserr,
 		union nfsd4_op_u *u)
 {
 	struct nfsd4_layoutget *lgp = &u->layoutget;
 	struct xdr_stream *xdr = resp->xdr;
-	const struct nfsd4_layout_ops *ops;
-	__be32 *p;
 
-	p = xdr_reserve_space(xdr, 36 + sizeof(stateid_opaque_t));
-	if (!p)
+	/* logr_return_on_close */
+	nfserr = nfsd4_encode_bool(xdr, true);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* logr_stateid */
+	nfserr = nfsd4_encode_stateid4(xdr, &lgp->lg_sid);
+	if (nfserr != nfs_ok)
+		return nfserr;
+	/* logr_layout<> */
+	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
 		return nfserr_resource;
-
-	*p++ = cpu_to_be32(1);	/* we always set return-on-close */
-	*p++ = cpu_to_be32(lgp->lg_sid.si_generation);
-	p = xdr_encode_opaque_fixed(p, &lgp->lg_sid.si_opaque,
-				    sizeof(stateid_opaque_t));
-
-	*p++ = cpu_to_be32(1);	/* we always return a single layout */
-	p = xdr_encode_hyper(p, lgp->lg_seg.offset);
-	p = xdr_encode_hyper(p, lgp->lg_seg.length);
-	*p++ = cpu_to_be32(lgp->lg_seg.iomode);
-	*p++ = cpu_to_be32(lgp->lg_layout_type);
-
-	ops = nfsd4_layout_ops[lgp->lg_layout_type];
-	return ops->encode_layoutget(xdr, lgp);
+	return nfsd4_encode_layout4(xdr, lgp);
 }
 
 static __be32
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 43b9c53b7795..1a99db22b25c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -118,6 +118,8 @@ nfsd4_encode_uint64_t(struct xdr_stream *xdr, u64 val)
 }
 
 #define nfsd4_encode_changeid4(x, v)	nfsd4_encode_uint64_t(x, v)
+#define nfsd4_encode_length4(x, v)	nfsd4_encode_uint64_t(x, v)
+#define nfsd4_encode_offset4(x, v)	nfsd4_encode_uint64_t(x, v)
 
 /**
  * nfsd4_encode_opaque_fixed - Encode a fixed-length XDR opaque type result


