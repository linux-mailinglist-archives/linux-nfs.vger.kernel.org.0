Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3044F7A4BF9
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbjIRPX5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbjIRPXz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64514131
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A857AC116B0;
        Mon, 18 Sep 2023 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045593;
        bh=d2XeAT7z58UAmZE6/pqypsYM53v61CZ2QZKJG0Ipqdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XG9viIT8tIGnOOBQVrpPaRyk7pKRnzqbVRIrzb042x3Qg+c0js+FI7+kV+PHbs5sC
         E2N+/OeFs8ryjHU9fQ58gM9adgzS9isFEVDV4AsHhJutV53+s1NskcFXYAkXBpluIe
         eRQlnyz2tnlYkmGavOpxjLbDH87i8B3QjAfnkbeSrErSfGDQ/pzksyCxAdqBiIoQAR
         WbHjjqVzA+r5n+VI2hG6xRj0acdDo4Zyj9/C5zlpBszyT6yIxiV/n7nM6s7yTZGrcT
         Exx2dxNhsNfEsxeSiK2Oc68UizNpDIPPeBmw6a9Mvr0yL2VI/BvmULjq2MmloOVKpj
         Nt0GFDhBP4jjQ==
Subject: [PATCH v1 29/52] NFSD: Add nfsd4_encode_fattr4_mode()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:59:52 -0400
Message-ID: <169504559274.133720.18210392905469993992.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_MODE into a helper. In a subsequent
patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 fs/nfsd/xdr4.h    |    1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 39ff6d1bd41d..91f5f154428b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3182,6 +3182,12 @@ static __be32 nfsd4_encode_fattr4_maxwrite(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, svc_max_payload(args->rqstp));
 }
 
+static __be32 nfsd4_encode_fattr4_mode(struct xdr_stream *xdr,
+				       const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_mode4(xdr, args->stat.mode & S_IALLUGO);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3456,10 +3462,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_MODE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(args.stat.mode & S_IALLUGO);
+		status = nfsd4_encode_fattr4_mode(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_NO_TRUNC) {
 		status = nfsd4_encode_fattr4__true(xdr, &args);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index f0866a55fd91..52322acc1e9f 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -93,6 +93,7 @@ nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
 #define nfsd4_encode_aceflag4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_acemask4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_acetype4(x, v)	nfsd4_encode_uint32_t(x, v)
+#define nfsd4_encode_mode4(x, v)	nfsd4_encode_uint32_t(x, v)
 #define nfsd4_encode_nfs_lease4(x, v)	nfsd4_encode_uint32_t(x, v)
 
 /**


