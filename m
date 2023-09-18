Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE097A4BA5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 17:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIRPUJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjIRPUJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 11:20:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B59D
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 08:18:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2A6C116A9;
        Mon, 18 Sep 2023 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045536;
        bh=1h9D3uLyrIFnieq2Dat4g6QoaOTnBtZKMZzU7+jA84M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UnOElsntEeI99XI5vGjiXHZXuYhCa18WuEmod+roKqnaLizX3BDNMHZqHnd8eCaDq
         aLzWRAbT+JMURUJsgL+cuTE9gQAkFWSgqcjOSsO4UMcvZSka+r20pr0O6t7Ql/oe9e
         AhpuUPH7y3NLWlVwiPOqwip/99UCNeHaBDF/v/ti7+A4m5cOO60iaCg6gvxT7OYZ2+
         k9VlugxocvaCZ81Oq0PAMUhCFJzEZxytZ46H7fWqpzxCisqFwi+ucQHt8ckVE90pNV
         nV8Yh3J4H4d+OSzjfs7/eMgRiCSDxhI5K6mQePwx6fmiLG06SXlXWBBMaL3I5m34vZ
         NLIa/7xw4b0gg==
Subject: [PATCH v1 20/52] NFSD: Add nfsd4_encode_fattr4_files_avail()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:58:55 -0400
Message-ID: <169504553560.133720.17115534414934358128.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_FILES_AVAIL into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e3dd05f8d28f..737c13c4bf82 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3142,6 +3142,12 @@ static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
 	return nfsd4_encode_uint64_t(xdr, args->stat.ino);
 }
 
+static __be32 nfsd4_encode_fattr4_files_avail(struct xdr_stream *xdr,
+					      const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_uint64_t(xdr, args->statfs.f_ffree);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3366,10 +3372,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
-		p = xdr_reserve_space(xdr, 8);
-		if (!p)
-			goto out_resource;
-		p = xdr_encode_hyper(p, (u64) args.statfs.f_ffree);
+		status = nfsd4_encode_fattr4_files_avail(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_FREE) {
 		p = xdr_reserve_space(xdr, 8);


