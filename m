Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FBA77E36B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Aug 2023 16:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbjHPOTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Aug 2023 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbjHPOTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Aug 2023 10:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF3271D
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 07:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D390C6562E
        for <linux-nfs@vger.kernel.org>; Wed, 16 Aug 2023 14:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9164C433C8;
        Wed, 16 Aug 2023 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692195538;
        bh=sG6yeKDcIHs4k/J2wX3EJVRGEUM/xNcxizxkMEKD6p4=;
        h=Subject:From:To:Cc:Date:From;
        b=Zp7KoHALDpkmFtryFD41L6IqUJWOS0X8sCppNo+R6j5UoQ9722ulTiLebfSXTm1Xh
         07U1cq4RUegaow+ay3kRltVjNhDw0gjvsRc262W/3L85kFazP8DB7LOZbFAj7/GN9I
         GLmUBIkkW1JgJ+C4sPYgbUKRnCYAR7VloJUUlFRAugnHoZpTWLRHyt35ij9sbg66V+
         F0l/qGPwIcHrKk4GvEbf3bmzxPjRqmV+aioNblHzk0NQF1AQDJnDyZGzBNiO8Igu3S
         m964mjEs7q6db0RakII7Zt6PruaK96n4TyGDfE/K53Cb1WW61Yw6n+5R6ik62KyJb3
         7msTjoAEQxgwA==
Subject: [PATCH] NFSD: da_addr_body missing in some GETDEVICEINFO replies
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Tom Haynes <logyr@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 16 Aug 2023 10:18:56 -0400
Message-ID: <169219553682.7499.12036179902194342289.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The XDR specification in RFC 8881 looks like this:

struct device_addr4 {
	layouttype4	da_layout_type;
	opaque		da_addr_body<>;
};

struct GETDEVICEINFO4resok {
	device_addr4	gdir_device_addr;
	bitmap4		gdir_notification;
};

union GETDEVICEINFO4res switch (nfsstat4 gdir_status) {
case NFS4_OK:
	GETDEVICEINFO4resok gdir_resok4;
case NFS4ERR_TOOSMALL:
	count4		gdir_mincount;
default:
	void;
};

Looking at nfsd4_encode_getdeviceinfo() ....

When the client provides a zero gd_maxcount, then the Linux NFS
server implementation encodes the da_layout_type field and then
skips the da_addr_body field completely, proceeding directly to
encode gdir_notification field.

There does not appear to be an option in the specification to skip
encoding da_addr_body. Moreover, Section 18.40.3 says:

> If the client wants to just update or turn off notifications, it
> MAY send a GETDEVICEINFO operation with gdia_maxcount set to zero.
> In that event, if the device ID is valid, the reply's da_addr_body
> field of the gdir_device_addr field will be of zero length.

Since the layout drivers are responsible for encoding the
da_addr_body field, put this fix inside the ->encode_getdeviceinfo
methods.

Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tom Haynes <logyr@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayoutxdr.c    |    9 +++++++++
 fs/nfsd/flexfilelayoutxdr.c |    9 +++++++++
 fs/nfsd/nfs4xdr.c           |   25 +++++++++++--------------
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 8e9c1a0f8d38..1ed2f691ebb9 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -83,6 +83,15 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int len = sizeof(__be32), ret, i;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	p = xdr_reserve_space(xdr, len + sizeof(__be32));
 	if (!p)
 		return nfserr_resource;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index e81d2a5cf381..bb205328e043 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -85,6 +85,15 @@ nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int addr_len;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	/* len + padding for two strings */
 	addr_len = 16 + da->netaddr.netid_len + da->netaddr.addr_len;
 	ver_len = 20;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d4de39404cde..2e40c74d2f72 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4686,20 +4686,17 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	*p++ = cpu_to_be32(gdev->gd_layout_type);
 
-	/* If maxcount is 0 then just update notifications */
-	if (gdev->gd_maxcount != 0) {
-		ops = nfsd4_layout_ops[gdev->gd_layout_type];
-		nfserr = ops->encode_getdeviceinfo(xdr, gdev);
-		if (nfserr) {
-			/*
-			 * We don't bother to burden the layout drivers with
-			 * enforcing gd_maxcount, just tell the client to
-			 * come back with a bigger buffer if it's not enough.
-			 */
-			if (xdr->buf->len + 4 > gdev->gd_maxcount)
-				goto toosmall;
-			return nfserr;
-		}
+	ops = nfsd4_layout_ops[gdev->gd_layout_type];
+	nfserr = ops->encode_getdeviceinfo(xdr, gdev);
+	if (nfserr) {
+		/*
+		 * We don't bother to burden the layout drivers with
+		 * enforcing gd_maxcount, just tell the client to
+		 * come back with a bigger buffer if it's not enough.
+		 */
+		if (xdr->buf->len + 4 > gdev->gd_maxcount)
+			goto toosmall;
+		return nfserr;
 	}
 
 	if (gdev->gd_notify_types) {


