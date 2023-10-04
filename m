Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3157B812B
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjJDNlt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjJDNlt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:41:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3989B
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 06:41:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECEDC433C8;
        Wed,  4 Oct 2023 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426906;
        bh=Z2+uKJSDcWzdABCM+PJV9Cu3GHRam6rVRAWlWfgswxc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X4aHUNpwEsLLyDYs4JScHoF6cTpuwiynkfyjz7Jtyij61SkV8ZXeYcUu8bP+IBIHi
         9ixc5A9BYEbgB1MZRnrCWAdy4p97gDPv59Kh5V0OMjUUKKm3nQvme5qTB67mEWg7Zm
         2bUto5W+/NuC3YdgD9WEjy82HsZkOFW8znB/OtTT6kmMRQBKnRwlxfcRzoBI+dqk8z
         CfdwUV7d7nmIDZQBH9A9sQYewBUTZ4WUHa0zwLefAMAoiB9r0TMvraB0Cjb64nvDQG
         jfwo61us1MgW3yLnqaXKZkUydF6asTq1T3xm4+iu/pdnTrm0SQdJCKwveG2KX9v0jR
         jLXvfD5nixT1A==
Subject: [PATCH v1 1/5] NFSD: Rename nfsd4_encode_dirent()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 09:41:44 -0400
Message-ID: <169642690474.7503.14994605453994505408.stgit@klimt.1015granger.net>
In-Reply-To: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
References: <169642681764.7503.2925922561588558142.stgit@klimt.1015granger.net>
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

Rename nfsd4_encode_dirent() to match the naming convention already
used in the NFSv2 and NFSv3 readdir paths. The new name reflects the
name of the spec-defined XDR data type for an NFSv4 directory entry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f1f0b707c7d9..a6b6ff5819e9 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3670,8 +3670,8 @@ static inline int attributes_need_mount(u32 *bmval)
 }
 
 static __be32
-nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
-			const char *name, int namlen)
+nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
+			  int namlen)
 {
 	struct svc_export *exp = cd->rd_fhp->fh_export;
 	struct dentry *dentry;
@@ -3714,7 +3714,7 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 
 	}
 out_encode:
-	nfserr = nfsd4_encode_fattr4(cd->rd_rqstp, xdr, NULL, exp, dentry,
+	nfserr = nfsd4_encode_fattr4(cd->rd_rqstp, cd->xdr, NULL, exp, dentry,
 				     cd->rd_bmval, ignore_crossmnt);
 out_put:
 	dput(dentry);
@@ -3740,7 +3740,7 @@ nfsd4_encode_rdattr_error(struct xdr_stream *xdr, __be32 nfserr)
 }
 
 static int
-nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
+nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 		    loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct readdir_cd *ccd = ccdv;
@@ -3777,7 +3777,7 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 	p = xdr_encode_hyper(p, OFFSET_MAX);        /* offset of next entry */
 	p = xdr_encode_array(p, name, namlen);      /* name length & name */
 
-	nfserr = nfsd4_encode_dirent_fattr(xdr, cd, name, namlen);
+	nfserr = nfsd4_encode_entry4_fattr(cd, name, namlen);
 	switch (nfserr) {
 	case nfs_ok:
 		break;
@@ -4489,9 +4489,8 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
 	readdir->cookie_offset = 0;
 
 	offset = readdir->rd_cookie;
-	nfserr = nfsd_readdir(readdir->rd_rqstp, readdir->rd_fhp,
-			      &offset,
-			      &readdir->common, nfsd4_encode_dirent);
+	nfserr = nfsd_readdir(readdir->rd_rqstp, readdir->rd_fhp, &offset,
+			      &readdir->common, nfsd4_encode_entry4);
 	if (nfserr == nfs_ok &&
 	    readdir->common.err == nfserr_toosmall &&
 	    xdr->buf->len == starting_len + 8) {


