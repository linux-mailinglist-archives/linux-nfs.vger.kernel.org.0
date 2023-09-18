Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1C7A4F48
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjIRQhS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjIRQhG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:37:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05410E6
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:32:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD7C116CB;
        Mon, 18 Sep 2023 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045664;
        bh=eLAMI+04+0pa1jhKRCTkyUFIbNQssVlNGe8wkM70w3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SvF5H5sBS/U6/neWupfecms+heNrLq+vlIQ62eIz/ekz2T7nzD/jV3zL3klJGk3YJ
         wR3LLvGRgScHHjt6g88SDIHCEujS0fmvJ5l3YRUFxnooWikSxA0Vz4XkM09ezd+yix
         IOvyydD0xp6l7EhksOtTf2PrgzVHVvdyKBxKxeegU9v6mLFqSi9gUhsk0kopkveB6r
         7On81Rx131YEesaGc7gEoc40Ds0DMekJKPJ/OydP3/bS+e/vsyx1V7M84wUR7e+yRv
         h3Nv3Vc6jKdFkFslAHQu9MUfa4UxDasQUltykNFjujGISLwYcBkSlWUqhCxblj5XNc
         6ZVVhFie1r3Jg==
Subject: [PATCH v1 40/52] NFSD: Add nfsd4_encode_fattr4_time_delta()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 10:01:02 -0400
Message-ID: <169504566285.133720.8429913510077918237.stgit@manet.1015granger.net>
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

Refactor the encoder for FATTR4_TIME_DELTA into a helper. In a
subsequent patch, this helper will be called from a bitmask loop.

fattr4_time_delta is specified as an nfstime4, so de-duplicate this
encoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   53 ++++++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a98dc3910ef..28eb777f82d2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2561,31 +2561,6 @@ static __be32 nfsd4_encode_specdata4(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, minor);
 }
 
-/*
- * ctime (in NFSv4, time_metadata) is not writeable, and the client
- * doesn't really care what resolution could theoretically be stored by
- * the filesystem.
- *
- * The client cares how close together changes can be while still
- * guaranteeing ctime changes.  For most filesystems (which have
- * timestamps with nanosecond fields) that is limited by the resolution
- * of the time returned from current_time() (which I'm assuming to be
- * 1/HZ).
- */
-static __be32 *encode_time_delta(__be32 *p, struct inode *inode)
-{
-	struct timespec64 ts;
-	u32 ns;
-
-	ns = max_t(u32, NSEC_PER_SEC/HZ, inode->i_sb->s_time_gran);
-	ts = ns_to_timespec64(ns);
-
-	p = xdr_encode_hyper(p, ts.tv_sec);
-	*p++ = cpu_to_be32(ts.tv_nsec);
-
-	return p;
-}
-
 static __be32
 nfsd4_encode_change_info4(struct xdr_stream *xdr, const struct nfsd4_change_info *c)
 {
@@ -3266,6 +3241,27 @@ static __be32 nfsd4_encode_fattr4_time_create(struct xdr_stream *xdr,
 	return nfsd4_encode_nfstime4(xdr, &args->stat.btime);
 }
 
+/*
+ * ctime (in NFSv4, time_metadata) is not writeable, and the client
+ * doesn't really care what resolution could theoretically be stored by
+ * the filesystem.
+ *
+ * The client cares how close together changes can be while still
+ * guaranteeing ctime changes.  For most filesystems (which have
+ * timestamps with nanosecond fields) that is limited by the resolution
+ * of the time returned from current_time() (which I'm assuming to be
+ * 1/HZ).
+ */
+static __be32 nfsd4_encode_fattr4_time_delta(struct xdr_stream *xdr,
+					     const struct nfsd4_fattr_args *args)
+{
+	const struct inode *inode = d_inode(args->dentry);
+	u32 ns = max_t(u32, NSEC_PER_SEC/HZ, inode->i_sb->s_time_gran);
+	struct timespec64 ts = ns_to_timespec64(ns);
+
+	return nfsd4_encode_nfstime4(xdr, &ts);
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3599,10 +3595,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_DELTA) {
-		p = xdr_reserve_space(xdr, 12);
-		if (!p)
-			goto out_resource;
-		p = encode_time_delta(p, d_inode(dentry));
+		status = nfsd4_encode_fattr4_time_delta(xdr, &args);
+		if (status != nfs_ok)
+			goto out;
 	}
 	if (bmval1 & FATTR4_WORD1_TIME_METADATA) {
 		status = nfsd4_encode_nfstime4(xdr, &args.stat.ctime);


