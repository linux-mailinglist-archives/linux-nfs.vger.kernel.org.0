Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678F7A4C65
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjIRPcl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjIRPcV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:32:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB4D128
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:28:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C11C116B5;
        Mon, 18 Sep 2023 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045612;
        bh=oWnM++4sTTDXhDcWv911bJNzVpUnPd9jMvyXntU1aI0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FGUhh3CONTDUP/aWzCiUjTKjYm1kOMGPxvZ7aoxMihon5JayiUlpOKha+V7OhKM0V
         V+760dXDp4rVvw8gxnY6Aan0riDyezK/QG/7CUjabLvpBVfrbS0/MUpA90bvMJYDMj
         fa9r3mbK32p53udUF9gAvTd5qrtj7mdddFtlpvZyHYl+mi9zrjXWwUSiJWTt/SFeFI
         IS7aXcZaQky+E5nPGgD/SSS6wro6vr3TdGh4Xt2aqm9Sg5jmy3o4+qcXyDhQ94dW8N
         oE76oEfQIsJExZr+DRqk3YuE/mBnbJwXgzui4TN1Kzp3V5kajprdpg3XnZ3g6glV12
         H4sJ7dIgQmVnw==
Subject: [PATCH v1 32/52] NFSD: Add nfsd4_encode_fattr4_owner_group()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:11 -0400
Message-ID: <169504561180.133720.5689851436829082956.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_OWNER_GROUP into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 11922b18f357..91ac991dea9d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3200,6 +3200,12 @@ static __be32 nfsd4_encode_fattr4_owner(struct xdr_stream *xdr,
 	return nfsd4_encode_user(xdr, args->rqstp, args->stat.uid);
 }
 
+static __be32 nfsd4_encode_fattr4_owner_group(struct xdr_stream *xdr,
+					      const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_group(xdr, args->rqstp, args->stat.gid);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3494,8 +3500,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {
-		status = nfsd4_encode_group(xdr, rqstp, args.stat.gid);
-		if (status)
+		status = nfsd4_encode_fattr4_owner_group(xdr, &args);
+		if (status != nfs_ok)
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_RAWDEV) {


