Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933597A4BCD
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbjIRPWV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbjIRPWT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:22:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F9A2119
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09397C116B1;
        Mon, 18 Sep 2023 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045600;
        bh=Elr81gt1Uwkp0uU5QSI+l9l5F4aRXahecdoJHJRnVvk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GmkPLi5FAHVdQxEimz33asJBxFyuOxfs+2CbCUHHXROvpyOZjjbsGLYlgghGGR+m3
         ez4zQQTUq0xc5HVzcOvOVpgGXpyjv+Z2bSeSfjr+QsMzhdhULE91MxaRHA7Cs+9Y1F
         E+KBsFrSReSpA3OkdwRBj7GX4qg4eLRNe85OiVcWpVG/vu7Wy7nZQKZCeN7MKdq2DK
         yKVGV9vqh8838I3/47vYx0A8/ocfdHrk6QoY3D3CcLSWlPU9EqOrYzZ2CbUlGeBPd1
         Nq42boBY5AgvK63UpJhLTopwLm7hOO4glfSOSMxnxuEkauABISUmziCwUX0EYCunV1
         E4MVZlxHJK2yg==
Subject: [PATCH v1 30/52] NFSD: Add nfsd4_encode_fattr4_numlinks()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:59 -0400
Message-ID: <169504559906.133720.8071462922786084487.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_NUMLINKS into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 91f5f154428b..e3d9ec44c817 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3188,6 +3188,12 @@ static __be32 nfsd4_encode_fattr4_mode(struct xdr_stream *xdr,
 	return nfsd4_encode_mode4(xdr, args->stat.mode & S_IALLUGO);
 }
 
+static __be32 nfsd4_encode_fattr4_numlinks(struct xdr_stream *xdr,
+					   const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint32_t(xdr, args->stat.nlink);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3472,10 +3478,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_NUMLINKS) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.stat.nlink);
+		status = nfsd4_encode_fattr4_numlinks(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_OWNER) {
 		status = nfsd4_encode_user(xdr, rqstp, args.stat.uid);


