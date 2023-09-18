Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0A7A4C1E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbjIRP0g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjIRP0f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:26:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082FECF7
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:24:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE457C193E8;
        Mon, 18 Sep 2023 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045720;
        bh=4vsR15IVGU06iZtarv4SttIYOkjf26iIBQmJQ/9hrZU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DPCFphlEmt/zQJYP6cM6jOcmMLgY6kbrSRLSmRlKFb9rFHc8FhDGMu/nOgU8p+r/q
         rWnsm7i4PDILNwIziGIVctw4Eb2UL53mvuq+7EjMn92sC2uCQg//9i4aweMTzENe0E
         vNycyVjdLOe4pgfIQl2yyiicC7ZovuzUd11OFz7jpTqRcKylvvaEwlZ379kyg1sazK
         ZciqqJbU4pUR0NpGMWujs8a2QzIyzZEYIMVj+Fm9jmacvgP8Yzk+vvI9qMlBHKiRlB
         i6AFtOZOJNNpBvijng2SB9ZsKCOz0jrkhzWxIw+GF0FmZ7jhVWZI0KVmqmnCxkfn1Z
         WM7cx9xazdDnA==
Subject: [PATCH v1 49/52] NFSD: Add nfsd4_encode_fattr4_xattr_support()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:59 -0400
Message-ID: <169504571981.133720.8100882888549390817.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the encoder for FATTR4_XATTR_SUPPORT into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 137e7368dbfd..97654a2b876f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3346,6 +3346,14 @@ static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 }
 #endif
 
+static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
+						const struct nfsd4_fattr_args *args)
+{
+	int err = xattr_supports_user_prefix(d_inode(args->dentry));
+
+	return nfsd4_encode_bool(xdr, err == 0);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3361,10 +3369,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	u32 bmval1 = bmval[1];
 	u32 bmval2 = bmval[2];
 	struct svc_fh *tempfh = NULL;
-	__be32 *p, *attrlen_p;
 	int starting_len = xdr->buf->len;
+	__be32 *attrlen_p, status;
 	int attrlen_offset;
-	__be32 status;
 	int err;
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
@@ -3730,11 +3737,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 #endif
 
 	if (bmval2 & FATTR4_WORD2_XATTR_SUPPORT) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		err = xattr_supports_user_prefix(d_inode(dentry));
-		*p++ = cpu_to_be32(err == 0);
+		status = nfsd4_encode_fattr4_xattr_support(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 
 	*attrlen_p = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);


