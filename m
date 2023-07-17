Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCF756E98
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jul 2023 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGQUxY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jul 2023 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGQUxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jul 2023 16:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8F1705
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 13:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 210CE6123B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 20:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9F0C433CA;
        Mon, 17 Jul 2023 20:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689627162;
        bh=5K/O6d/K/+d5TAgDQ3H+rta/nMcJgFY0ZeUWcvzj8eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ih27qKoDujf3slw7DRBI9ll+VBrOoeyrIdUJk9OfVF127O3p1nOmmWZCu0QnLIwPh
         77YSdlMbBukre0O3qyl2qvAp9lJQQ5A0z2K2hSe0/H/IDQiUvASYuAzqH0XY76Smod
         gOzzUwEgLXf4nDHuar9C1/vB+bfHKxBkF7jAMm2VfwRAltBNCq5MC+SQgu3eREEYQK
         BTeSon9f+q6T+Pos51X0I4UKTZkdY7seYm8A14QPVkStXTVBB8ZZTQyzYOaz9AIpXM
         5CznFqqzHNSR6dpGfHkPxheVxNN64hU6WdftP5F4IrUN8C53ET2I/7ekeGD1Luk/zX
         LIPBAtmuPR/RA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v5 3/5] NFSv4.2: Rework scratch handling for READ_PLUS (again)
Date:   Mon, 17 Jul 2023 16:52:37 -0400
Message-ID: <20230717205239.921002-4-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717205239.921002-1-anna@kernel.org>
References: <20230717205239.921002-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I found that the read code might send multiple requests using the same
nfs_pgio_header, but nfs4_proc_read_setup() is only called once. This is
how we ended up occasionally double-freeing the scratch buffer, but also
means we set a NULL pointer but non-zero length to the xdr scratch
buffer. This results in an oops the first time decoding needs to copy
something to scratch, which frequently happens when decoding READ_PLUS
hole segments.

I fix this by moving scratch handling into the pageio read code. I
provide a function to allocate scratch space for decoding read replies,
and free the scratch buffer when the nfs_pgio_header is freed.

Fixes: fbd2a05f29a9 (NFSv4.2: Rework scratch handling for READ_PLUS)
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/internal.h |  1 +
 fs/nfs/nfs42.h    |  1 +
 fs/nfs/nfs42xdr.c |  2 +-
 fs/nfs/nfs4proc.c | 13 +------------
 fs/nfs/read.c     | 10 ++++++++++
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 913c09806c7f..41abea340ad8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -493,6 +493,7 @@ extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
+extern bool nfs_read_alloc_scratch(struct nfs_pgio_header *hdr, size_t size);
 extern int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 			       struct nfs_open_context *ctx,
 			       struct folio *folio);
diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aacbcfdf..b59876b01a1e 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -13,6 +13,7 @@
  * more? Need to consider not to pre-alloc too much for a compound.
  */
 #define PNFS_LAYOUTSTATS_MAXDEV (4)
+#define READ_PLUS_SCRATCH_SIZE (16)
 
 /* nfs4.2proc.c */
 #ifdef CONFIG_NFS_V4_2
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 78193f04d892..9e3ae53e2205 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1433,7 +1433,7 @@ static int nfs4_xdr_dec_read_plus(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
-	xdr_set_scratch_buffer(xdr, res->scratch, sizeof(res->scratch));
+	xdr_set_scratch_buffer(xdr, res->scratch, READ_PLUS_SCRATCH_SIZE);
 
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1a886b58354..c2bdbcef5c6c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5438,18 +5438,8 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 	return false;
 }
 
-static inline void nfs4_read_plus_scratch_free(struct nfs_pgio_header *hdr)
-{
-	if (hdr->res.scratch) {
-		kfree(hdr->res.scratch);
-		hdr->res.scratch = NULL;
-	}
-}
-
 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
-	nfs4_read_plus_scratch_free(hdr);
-
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
@@ -5469,8 +5459,7 @@ static bool nfs42_read_plus_support(struct nfs_pgio_header *hdr,
 	/* Note: We don't use READ_PLUS with pNFS yet */
 	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp) {
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
-		hdr->res.scratch = kmalloc(32, GFP_KERNEL);
-		return hdr->res.scratch != NULL;
+		return nfs_read_alloc_scratch(hdr, READ_PLUS_SCRATCH_SIZE);
 	}
 	return false;
 }
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index f71eeee67e20..7dc21a48e3e7 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -47,6 +47,8 @@ static struct nfs_pgio_header *nfs_readhdr_alloc(void)
 
 static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
 {
+	if (rhdr->res.scratch != NULL)
+		kfree(rhdr->res.scratch);
 	kmem_cache_free(nfs_rdata_cachep, rhdr);
 }
 
@@ -108,6 +110,14 @@ void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio)
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
 
+bool nfs_read_alloc_scratch(struct nfs_pgio_header *hdr, size_t size)
+{
+	WARN_ON(hdr->res.scratch != NULL);
+	hdr->res.scratch = kmalloc(size, GFP_KERNEL);
+	return hdr->res.scratch != NULL;
+}
+EXPORT_SYMBOL_GPL(nfs_read_alloc_scratch);
+
 static void nfs_readpage_release(struct nfs_page *req, int error)
 {
 	struct folio *folio = nfs_page_to_folio(req);
-- 
2.41.0

