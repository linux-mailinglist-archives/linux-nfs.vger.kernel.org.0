Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277AB7AD916
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 15:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjIYN20 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjIYN2Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 09:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD911F
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 06:28:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD7BC433C7;
        Mon, 25 Sep 2023 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695648498;
        bh=KPfg0qUNcF5vkrb3XKEZod2OcluDdVl+u1SjrMS0EGg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BpZo2jsCMS7qpZofmW/x2DexE+LAthDeqsPcNnrCiyImQ0FDVa3037tRghV+7vvaK
         B7nBSQEragLOfHwFLJAs8VKI/VebZWTFxbiqXJwJq7h0kzIHUDBOvxjU2ZgVJlbwef
         6g5uR3lwaDyZrvxq61awVzQYqLykKnf5WGoDF7FcKSLY7dnYHMr6pCllfN65PiZyil
         VmLtK7Eh0dq+VXW/o/jg07Tutsp2bhVf6AMBDA0UYqSycZhiLjaF2SHkhDHhnMsN0u
         6Q4lpoHI+Jerq4bAWyJYvWyD66MB9JcG8Zf2T1q7NvTHuLZQFi6jAbfKkkKPDOGQW5
         KX64vdxar4SUw==
Subject: [PATCH v1 7/8] NFSD: Make @gdev parameter of ->encode_getdeviceinfo a
 const pointer
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 25 Sep 2023 09:28:17 -0400
Message-ID: <169564849717.6013.13526635118089448794.stgit@klimt.1015granger.net>
In-Reply-To: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
References: <169564827064.6013.5014460767978657478.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This enables callers to be passed const pointer parameters.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayoutxdr.c    |    2 +-
 fs/nfsd/blocklayoutxdr.h    |    2 +-
 fs/nfsd/flexfilelayoutxdr.c |    2 +-
 fs/nfsd/flexfilelayoutxdr.h |    2 +-
 fs/nfsd/pnfs.h              |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index f8469348e06e..ce78f74715ee 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -77,7 +77,7 @@ nfsd4_block_encode_volume(struct xdr_stream *xdr, struct pnfs_block_volume *b)
 
 __be32
 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
-		struct nfsd4_getdeviceinfo *gdp)
+		const struct nfsd4_getdeviceinfo *gdp)
 {
 	struct pnfs_block_deviceaddr *dev = gdp->gd_device;
 	int len = sizeof(__be32), ret, i;
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 5f88539e81a1..b0361e8aa9a7 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -51,7 +51,7 @@ struct pnfs_block_deviceaddr {
 };
 
 __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
-		struct nfsd4_getdeviceinfo *gdp);
+		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
 int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index 5319cb97d8a7..aeb71c10ff1b 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -77,7 +77,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 
 __be32
 nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
-		struct nfsd4_getdeviceinfo *gdp)
+		const struct nfsd4_getdeviceinfo *gdp)
 {
 	struct pnfs_ff_device_addr *da = gdp->gd_device;
 	int len;
diff --git a/fs/nfsd/flexfilelayoutxdr.h b/fs/nfsd/flexfilelayoutxdr.h
index a447efb7759b..6d5a1066a903 100644
--- a/fs/nfsd/flexfilelayoutxdr.h
+++ b/fs/nfsd/flexfilelayoutxdr.h
@@ -43,7 +43,7 @@ struct pnfs_ff_layout {
 };
 
 __be32 nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
-		struct nfsd4_getdeviceinfo *gdp);
+		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
 
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index d8e1a333fa0a..de1e0dfed06a 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -27,7 +27,7 @@ struct nfsd4_layout_ops {
 			struct nfs4_client *clp,
 			struct nfsd4_getdeviceinfo *gdevp);
 	__be32 (*encode_getdeviceinfo)(struct xdr_stream *xdr,
-			struct nfsd4_getdeviceinfo *gdevp);
+			const struct nfsd4_getdeviceinfo *gdevp);
 
 	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
 			struct nfsd4_layoutget *lgp);


