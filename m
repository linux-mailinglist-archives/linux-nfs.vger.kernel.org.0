Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF87A4C30
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjIRP2W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIRP15 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:27:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BAEE78
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:25:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB2C116D2;
        Mon, 18 Sep 2023 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045670;
        bh=vVxaXwBNqYVp9Tr8tf6Zt/VPqh7Mco63r7P50T5BHO4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HXUiK6m2/qU9FWltAY3JeohlqlmO7oY3ygZ1wPDDSfJP/WxuU4cWGMR0OPuowcwBi
         fuEmxvegQ96SqJEWv93O7jyRlRoZ84cXBRNRw71lG/H31im5r/aZRUtaWdlonaFE/R
         bjLcOb5K4wGV/HWtanomxNpym7PJYQDqdvDgHJisG/mt6gmdmKT8Cm3EtO/7Vl32vH
         9HQTMGQfyyrYqX/qqPPwwL1x836klCJ3xSTiqBQL1OpjnoLJmhGIYKGHXTrgfcG/I9
         uL/+AGam/jmMkbDd1fD3HNZ+ow8Q+S/W1eKhan8Hf/hMtxLGkX1RX53xrE5OVTjATY
         DdHklYZgHGKCg==
Subject: [PATCH v1 41/52] NFSD: Add nfsd4_encode_fattr4_time_metadata()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:09 -0400
Message-ID: <169504566918.133720.1802016538751714347.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_TIME_METADATA into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 28eb777f82d2..75121b4a6020 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3262,6 +3262,12 @@ static __be32 nfsd4_encode_fattr4_time_delta(struct xdr_stream *xdr,
 	return nfsd4_encode_nfstime4(xdr, &ts);
 }
 
+static __be32 nfsd4_encode_fattr4_time_metadata(struct xdr_stream *xdr,
+						const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_nfstime4(xdr, &args->stat.ctime);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3600,7 +3606,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
-		status = nfsd4_encode_nfstime4(xdr, &args.stat.ctime);
+		status = nfsd4_encode_fattr4_time_metadata(xdr, &args);
 		if (status)
 			goto out;
 	}


