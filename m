Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3427A4EB6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIRQZc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRQZa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D2D25472
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:22:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488E3C433BF;
        Mon, 18 Sep 2023 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045447;
        bh=v8DyjZTKSK3Gu6mjjkXee8n4kS1b+G9Nl6vaA0VYFuk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cw0NONqSNuy5DmJC0E020Yh8el8daHlwV5Z04cKcQOd/oMlSH07sdhUs0iFpVthQs
         sNVXBLlipIrTstCa2z9SfTcPolDRTX8gWb5Fv2I0Mfh5+aIoL/wByB5cpSIXjTt5hQ
         dJUQ1XIsBGf4vItsU6BURpTGGl0LdpleizESa230J6QP3FQKCxOvJ8nelne1hmfKbz
         UUGnxe+nqNxlOaRvgwO+vwBwHlOxV31AwL6ieJ1XOpj5wCmvQPpluLpFneRranXaoE
         QYb7mq6X2IgjxTzilmBcRftALS/8p/2LtLVbwtc9Iifqzzhm3M4DGgZWsEOf5Li1Hy
         m+p45puf6lelA==
Subject: [PATCH v1 06/52] NFSD: Add nfsd4_encode_fattr4__false()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:57:26 -0400
Message-ID: <169504544625.133720.5531415222277888990.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add an encoding helper that encodes a single boolean "false" value.
Attributes that always return "false" can use this helper.

In a subsequent patch, this helper will be called from a bitmask
loop, so it is given a standardized synopsis.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ba07e97c206b..91f3b03f297b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2953,6 +2953,12 @@ static __be32 nfsd4_encode_fattr4__true(struct xdr_stream *xdr,
 	return nfsd4_encode_bool(xdr, true);
 }
 
+static __be32 nfsd4_encode_fattr4__false(struct xdr_stream *xdr,
+					 const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, false);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3144,10 +3150,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_NAMED_ATTR) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(0);
+		status = nfsd4_encode_fattr4__false(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FSID) {
 		p = xdr_reserve_space(xdr, 16);
@@ -3174,10 +3179,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		}
 	}
 	if (bmval0 & FATTR4_WORD0_UNIQUE_HANDLES) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(0);
+		status = nfsd4_encode_fattr4__false(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_LEASE_TIME) {
 		p = xdr_reserve_space(xdr, 4);
@@ -3234,10 +3238,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
-		p = xdr_reserve_space(xdr, 4);
-		if (!p)
-			goto out_resource;
-		*p++ = cpu_to_be32(0);
+		status = nfsd4_encode_fattr4__false(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
 		status = nfsd4_encode_fattr4__true(xdr, &args);


