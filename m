Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120867A4C0C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjIRPZb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjIRPZ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:25:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A428E5A
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BBBC116A4;
        Mon, 18 Sep 2023 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045517;
        bh=DiIy/9dHyZXGiXiWZAsGqUR7XE4E69RNs5XGyzBP/TQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YAD2mHCfO5htu7sdUD5UtCf0xU56dOselPPAFMUCKAoCOZAmTTvtsExUvom7h63B7
         xZ1qZ8mTbNgtHDkMqLhPkQltO6oj7mUnWrMavRIh72llMXuDg92drZ+UWdPIa8JkB/
         A7/XIVaAaQ1YdR200DSlxdTiqxd53rukbOGy5av+KojpyHT8isTXt66Mc03xLHeCg/
         cN01Lef2XgO6RE5NeaxoOwaiaPVpg1NiosdCof4UZq+E0cBUPUc1+okFsvVpVy98oo
         tGNqlQYgOSqaQZcji1U8YRt85gN/EALsjydVbO6aT1HvPt6dcn7DMlW6OJdd2rtRV2
         /AZysMcyWY4gA==
Subject: [PATCH v1 17/52] NFSD: Add nfsd4_encode_fattr4_acl()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:36 -0400
Message-ID: <169504551644.133720.1056760362211885614.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_ACL into a helper. In a subsequent
patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 89d3b276a494..5e91ed6ae0f7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3101,6 +3101,29 @@ static __be32 nfsd4_encode_fattr4_aclsupport(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, mask);
 }
 
+static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
+				      const struct nfsd4_fattr_args *args)
+{
+	struct nfs4_acl *acl = args->acl;
+	struct nfs4_ace *ace;
+	__be32 status;
+
+	/* nfsace4<> */
+	if (!acl) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+	} else {
+		if (xdr_stream_encode_u32(xdr, acl->naces) != XDR_UNIT)
+			return nfserr_resource;
+		for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
+			status = nfsd4_encode_nfsace4(xdr, args->rqstp, ace);
+			if (status != nfs_ok)
+				return status;
+		}
+	}
+	return nfs_ok;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3285,28 +3308,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_ACL) {
-		struct nfs4_ace *ace;
-
-		if (args.acl == NULL) {
-			p = xdr_reserve_space(xdr, 4);
-			if (!p)
-				goto out_resource;
-
-			*p++ = cpu_to_be32(0);
-			goto out_acl;
-		}
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.acl->naces);
-
-		for (ace = args.acl->aces; ace < args.acl->aces + args.acl->naces; ace++) {
-			status = nfsd4_encode_nfsace4(xdr, args.rqstp, ace);
-			if (status != nfs_ok)
-				goto out;
-		}
+		status = nfsd4_encode_fattr4_acl(xdr, &args);
+		if (status)
+			goto out;
 	}
-out_acl:
 	if (bmval0 & FATTR4_WORD0_ACLSUPPORT) {
 		status = nfsd4_encode_fattr4_aclsupport(xdr, &args);
 		if (status != nfs_ok)


