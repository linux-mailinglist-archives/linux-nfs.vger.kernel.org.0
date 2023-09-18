Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9C7A4BD0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbjIRPWX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbjIRPWU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:22:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED010C8
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC31C116B6;
        Mon, 18 Sep 2023 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045625;
        bh=7UlAzVQCyxw8WrqdUycPn4PtvnvgbPr9juX8TTFC9yQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c6+O4KNDhABNHF/eQlcFOsP+cQ7QPxyhl8yxVjQlU45V4cuO/rHgbursDcpp/J+rD
         Gj5aKMbV6FKgRcvN8/WQQkFQ4a48fE4v22fA6yRy75eisHarhZ+BSJ81GeDCqfgQrs
         iEKpblDWivyaCbNr7KXwXQY/dB6s9Hw1eMOGrakriTch4eQ4Ki5b1DTYnu1If8hC+n
         m9cC5RAhcg7DdxN2qpQ/8CRdBEeHI/OwMH5C7hREmR5tOeR7NmUVGoaw1LGS3Mm6n8
         n6NiBj42ZhYOjmcjOhaDbjscUWBuwcQNufydTTnt8wTD9nuzbKvFdKUK2bEYJqEsMs
         M4MwqPMTrpyHw==
Subject: [PATCH v1 34/52] NFSD: Add nfsd4_encode_fattr4_space_avail()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:24 -0400
Message-ID: <169504562450.133720.15612884724683454845.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_SPACE_AVAIL into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 146ac641ef8e..42ce95b8db43 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3224,6 +3224,14 @@ static __be32 nfsd4_encode_fattr4_rawdev(struct xdr_stream *xdr,
 				      MINOR(args->stat.rdev));
 }
 
+static __be32 nfsd4_encode_fattr4_space_avail(struct xdr_stream *xdr,
+					      const struct nfsd4_fattr_args *args)
+{
+	u64 avail = (u64)args->statfs.f_bavail * (u64)args->statfs.f_bsize;
+
+	return nfsd4_encode_uint64_t(xdr, avail);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3528,11 +3536,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_AVAIL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		dummy64 = (u64)args.statfs.f_bavail * (u64)args.statfs.f_bsize;
-		p = xdr_encode_hyper(p, dummy64);
+		status = nfsd4_encode_fattr4_space_avail(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_SPACE_FREE) {
 		p = xdr_reserve_space(xdr, 8);


