Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BC7AD917
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjIYN2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjIYN2b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:28:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F0B8
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:28:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68218C433C8;
        Mon, 25 Sep 2023 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648504;
        bh=G/bXoA9mKPp9YLw+SvEAo0eiZMYNcLkppZYWlcWGEhw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LTm/eh2PhM8Tq8wEJ3oRSDB17QCs89tk1Z0E3uLXKGyMCk7vXOHCUwbjIrSUSyNhq
         qGo5CIEp+SFe9xmoYeavAqtBH6LA5KttbtzOqQnt3N9tZgQlBFMwrjYNI83DJVFufS
         /m5z65sgpS8UkBOyGy0QczXHQ8ooatdCAlHzrQguRniwFXzMuTh+r0GUpeSynyFRHT
         qZfpd/T80I2Hv7H7nt/wfNfX1DOX1a0OBgsW8bOrZaLgEpHBeQjWluqWMuqLkkhQ+M
         8tG0rVJg5p/EzJP5a9fyQg6xKlIrLvKF14Ai60m9CuOIRo+LY6PuTcy83PMjfMe41w
         1PKRxQcVcY83Q==
Subject: [PATCH v1 8/8] NFSD: Clean up nfsd4_encode_getdeviceinfo()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:28:23 -0400
Message-ID: <169564850350.6013.3077886286377364961.stgit@klimt.1015granger.net>
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

Adopt the conventional XDR utility functions. Also, restructure to
make the function align more closely with the spec -- there doesn't
seem to be a performance need for speciality code, so prioritize
readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   72 ++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 38217ac74b01..d21aaa56c49a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4807,59 +4807,57 @@ nfsd4_encode_test_stateid(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 #ifdef CONFIG_NFSD_PNFS
 static __be32
-nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
-		union nfsd4_op_u *u)
+nfsd4_encode_device_addr4(struct xdr_stream *xdr,
+			  const struct nfsd4_getdeviceinfo *gdev)
 {
-	struct nfsd4_getdeviceinfo *gdev = &u->getdeviceinfo;
-	struct xdr_stream *xdr = resp->xdr;
+	u32 needed_len, starting_len = xdr->buf->len;
 	const struct nfsd4_layout_ops *ops;
-	u32 starting_len = xdr->buf->len, needed_len;
-	__be32 *p;
+	__be32 status;
 
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
+	/* da_layout_type */
+	if (xdr_stream_encode_u32(xdr, gdev->gd_layout_type) != XDR_UNIT)
 		return nfserr_resource;
-
-	*p++ = cpu_to_be32(gdev->gd_layout_type);
-
+	/* da_addr_body */
 	ops = nfsd4_layout_ops[gdev->gd_layout_type];
-	nfserr = ops->encode_getdeviceinfo(xdr, gdev);
-	if (nfserr) {
+	status = ops->encode_getdeviceinfo(xdr, gdev);
+	if (status != nfs_ok) {
 		/*
-		 * We don't bother to burden the layout drivers with
-		 * enforcing gd_maxcount, just tell the client to
-		 * come back with a bigger buffer if it's not enough.
+		 * Don't burden the layout drivers with enforcing
+		 * gd_maxcount. Just tell the client to come back
+		 * with a bigger buffer if it's not enough.
 		 */
-		if (xdr->buf->len + 4 > gdev->gd_maxcount)
+		if (xdr->buf->len + XDR_UNIT > gdev->gd_maxcount)
 			goto toosmall;
-		return nfserr;
+		return status;
 	}
 
-	if (gdev->gd_notify_types) {
-		p = xdr_reserve_space(xdr, 4 + 4);
-		if (!p)
-			return nfserr_resource;
-		*p++ = cpu_to_be32(1);			/* bitmap length */
-		*p++ = cpu_to_be32(gdev->gd_notify_types);
-	} else {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			return nfserr_resource;
-		*p++ = 0;
-	}
+	return nfs_ok;
 
-	return 0;
 toosmall:
-	dprintk("%s: maxcount too small\n", __func__);
-	needed_len = xdr->buf->len + 4 /* notifications */;
+	needed_len = xdr->buf->len + XDR_UNIT;	/* notifications */
 	xdr_truncate_encode(xdr, starting_len);
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		return nfserr_resource;
-	*p++ = cpu_to_be32(needed_len);
+
+	status = nfsd4_encode_count4(xdr, needed_len);
+	if (status != nfs_ok)
+		return status;
 	return nfserr_toosmall;
 }
 
+static __be32
+nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
+		union nfsd4_op_u *u)
+{
+	struct nfsd4_getdeviceinfo *gdev = &u->getdeviceinfo;
+	struct xdr_stream *xdr = resp->xdr;
+
+	/* gdir_device_addr */
+	nfserr = nfsd4_encode_device_addr4(xdr, gdev);
+	if (nfserr)
+		return nfserr;
+	/* gdir_notification */
+	return nfsd4_encode_bitmap4(xdr, gdev->gd_notify_types, 0, 0);
+}
+
 static __be32
 nfsd4_encode_layout4(struct xdr_stream *xdr, const struct nfsd4_layoutget *lgp)
 {


