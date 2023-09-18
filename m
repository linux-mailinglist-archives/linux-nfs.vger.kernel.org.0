Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F87A4BEB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjIRPXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbjIRPXs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:23:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C4F10C9
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:20:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68270C116B2;
        Mon, 18 Sep 2023 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045606;
        bh=FHAAE6TUbfavTm7dq4dD82FCYvzIisEOnVuUD+XO8os=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OxkFSoGl1zFeIeyOkqVB1vTMQ2Dgo4+ff2AhexqFdiNkIuURXG5getegmvAtX8185
         WIBfxOIwNtmWdxc3cydI/Ux1SHeceeFI5gczyZKp3kMubF00RhfcS2Hn7rxP9mm4pA
         Wzf9uZOPZpy0CERSkSK/vyfeu0LXyOAcYnspArhWmV7W00eyjLoRwF3Y86CJCXCFGa
         rDtslbFtra021/8SjOFYrRNox7qigU3GLBD8Iu4pmIKhLWft+Rva8MTeMvdwPI7VD9
         n6VT3wHx02mqMAUL1RY0Nx6dqrVtM+vY3Qo5jBVCNtH6D194NmILce9nFbqD57OZv0
         xMiczdoTdSXDA==
Subject: [PATCH v1 31/52] NFSD: Add nfsd4_encode_fattr4_owner()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:00:05 -0400
Message-ID: <169504560541.133720.17707540313238672641.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_OWNER into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e3d9ec44c817..11922b18f357 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3194,6 +3194,12 @@ static __be32 nfsd4_encode_fattr4_numlinks(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, args->stat.nlink);
 }
 
+static __be32 nfsd4_encode_fattr4_owner(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_user(xdr, args->rqstp, args->stat.uid);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3483,8 +3489,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_OWNER) {
-		status = nfsd4_encode_user(xdr, rqstp, args.stat.uid);
-		if (status)
+		status = nfsd4_encode_fattr4_owner(xdr, &args);
+		if (status != nfs_ok)
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_OWNER_GROUP) {


