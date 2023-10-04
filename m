Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA007B8131
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjJDNmC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjJDNmB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 09:42:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7F8A9
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 06:41:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8E8C433CA;
        Wed,  4 Oct 2023 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696426918;
        bh=QsxiiP8P1LIewrRuytc8A8q6Tv7U/XL9DsRPg4me2aI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m1zJmBL1UYwE920Ds09sUYCysWqw8CQb/7uX8bRjjlb46Qc5eCncSdFT+iT23fuuo
         1FelI8gw85v/3U4LDHfzlxin7+dQitNHNh/WoK2LDGuKs4EpoKZewiGLCYLM5Ed8Sc
         rGMHPjExCdeh50PrH5dqWxpruSPXMV13AFN+o0Bs3v8OM44fdMz0j18+Gi4XB2hVs2
         UREnODEZrKSvFqnvJizP8z/KGh8aY0N7iQOzm/jbiU3Pi1VopreUkySQbPRIo3cCJd
         iZ8ebBW/I/+oA0nn+Kb8d15NwPcNIRp3jhqy0T2R8BEcADOuo1c9UYaFPcQnFCSQnw
         v7fm33fyHgB8w==
Subject: [PATCH v1 3/5] NFSD: Add an nfsd4_encode_nfs_cookie4() helper
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 09:41:57 -0400
Message-ID: <169642691755.7503.7423015225006996766.stgit@klimt.1015granger.net>
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

De-duplicate the entry4 cookie encoder, similar to the arrangement
for the NFSv2 and NFSv3 directory entry encoders.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 26a9391d7766..3eba3f316d97 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3660,6 +3660,22 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 	return ret;
 }
 
+/*
+ * The buffer space for this field was reserved during a previous
+ * call to nfsd4_encode_entry4().
+ */
+static void nfsd4_encode_entry4_nfs_cookie4(const struct nfsd4_readdir *readdir,
+					    u64 offset)
+{
+	__be64 cookie = cpu_to_be64(offset);
+	struct xdr_stream *xdr = readdir->xdr;
+
+	if (!readdir->cookie_offset)
+		return;
+	write_bytes_to_xdr_buf(xdr->buf, readdir->cookie_offset, &cookie,
+			       sizeof(cookie));
+}
+
 static inline int attributes_need_mount(u32 *bmval)
 {
 	if (bmval[0] & ~(FATTR4_WORD0_RDATTR_ERROR | FATTR4_WORD0_LEASE_TIME))
@@ -3752,7 +3768,6 @@ nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 	u32 name_and_cookie;
 	int entry_bytes;
 	__be32 nfserr = nfserr_toosmall;
-	__be64 wire_offset;
 	__be32 *p;
 
 	/* In nfsv4, "." and ".." never make it onto the wire.. */
@@ -3761,11 +3776,8 @@ nfsd4_encode_entry4(void *ccdv, const char *name, int namlen,
 		return 0;
 	}
 
-	if (cd->cookie_offset) {
-		wire_offset = cpu_to_be64(offset);
-		write_bytes_to_xdr_buf(xdr->buf, cd->cookie_offset,
-							&wire_offset, 8);
-	}
+	/* Encode the previous entry's cookie value */
+	nfsd4_encode_entry4_nfs_cookie4(cd, offset);
 
 	p = xdr_reserve_space(xdr, 4);
 	if (!p)
@@ -4447,7 +4459,6 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
 	int maxcount;
 	int bytes_left;
 	loff_t offset;
-	__be64 wire_offset;
 	struct xdr_stream *xdr = resp->xdr;
 	int starting_len = xdr->buf->len;
 	__be32 *p;
@@ -4505,11 +4516,8 @@ nfsd4_encode_readdir(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr)
 		goto err_no_verf;
 
-	if (readdir->cookie_offset) {
-		wire_offset = cpu_to_be64(offset);
-		write_bytes_to_xdr_buf(xdr->buf, readdir->cookie_offset,
-							&wire_offset, 8);
-	}
+	/* Encode the final entry's cookie value */
+	nfsd4_encode_entry4_nfs_cookie4(readdir, offset);
 
 	p = xdr_reserve_space(xdr, 8);
 	if (!p) {


