Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95159477925
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Dec 2021 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhLPQdw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 11:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhLPQdw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 11:33:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB3C061574
        for <linux-nfs@vger.kernel.org>; Thu, 16 Dec 2021 08:33:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0144B82499
        for <linux-nfs@vger.kernel.org>; Thu, 16 Dec 2021 16:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDDEC36AE5;
        Thu, 16 Dec 2021 16:33:49 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anatoly.trosinenko@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC] NFSD: Fix READDIR buffer overflow
Date:   Thu, 16 Dec 2021 11:33:48 -0500
Message-Id:  <163967241284.22390.6037359441342197346.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; h=from:subject:message-id; bh=7r9gVIYS5vn/otAqJzwNShYPODxE6uxyRJFi0RSyXSM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhu2psgO6OIgCQ6NEwqHt5TIS6tsMEcGmMzw9aduKr LCjtZ7CJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbtqbAAKCRAzarMzb2Z/l4S8D/ 9eKt6tgcpUbsBl0akNsyMVRXsvmbFUvFYMw197um2Ae5pzyssHpQgajxxK5K1pbIYv1UlziXW9UUAv hcnTu5uz4o7LhzIdeTgKOQ9xzc9fXMthu8aXKbR+ic1HEtc3yW8hPbKkia+ehO0M9DYcxVQ7+P+IrV UvH7fYlr7PGF0IeG/NayMbHtoF+Fi4vFJsNNKBz1pIUwuOQdNZGeqEWUz5ncCYLtBiHEeAfTk3c/86 zzBY89AIUDrfNI2xgGEtTYDB/i50Kzi0Gg8BAge15CGP8W9mdrPznqnduTRxI0n42wRG7y60cGFVOQ Lret4bVh5OlibK4vxaSpY9wgzLF3bv8777+643j3ENRszg6twmS/pIrtL4jZBYDqYXXQCH03Ar4NuR 0RT1w9fyR2PrCPdjwgQzE45WF/W2puPuhWhsjYlHa+8jTWYfTbV6t6+GdFvyrXZawkjgWtsDOckUgN qV6/W+Tdf9by1TcarvResCC9kySo2EWXK+t7YRDf+2vuyx/HDQAhK/fAEqWxDMbsAg3D86Xhjn1A4v 7ZGPy3rt8MiLlGgN1Nz7w4tjUNHsNHL/aG8O2DL0OAhQA85Lu+xqPzDBMW3fqco6z3QcoGDvGve3qs 0zCMOYdBz0axpp8rACSJ+Adm4wttkbHKXvFKZU/nZh/8REalMP7do+6b29YA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a client sends a READDIR count argument that is too small (say,
zero), then the buffer size calculation in the new init_dirlist
helper functions results in an underflow, allowing the XDR stream
functions to write beyond the actual buffer.

This calculation has always been suspect. NFSD has never sanity-
checked the READDIR count argument, but the old entry encoders
managed the problem correctly.

With the commits below, entry encoding changed, exposing the
underflow to the pointer arithmetic in xdr_reserve_space().

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Fixes: f5dcccd647da ("NFSD: Update the NFSv2 READDIR entry encoder to use struct xdr_stream")
Fixes: 7f87fc2d34d4 ("NFSD: Update NFSv3 READDIR entry encoders to use struct xdr_stream")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    4 ++--
 fs/nfsd/nfsproc.c  |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Request for comments, compile-tested only.

(Apologies for the duplicates).

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 4418517f6f12..3d224ab36e19 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -438,12 +438,12 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 
 static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 				     struct nfsd3_readdirres *resp,
-				     int count)
+				     u32 count)
 {
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = min_t(u32, count, svc_max_payload(rqstp));
+	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
 
 	memset(buf, 0, sizeof(*buf));
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index eea5b59b6a6c..358e50063f0e 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -556,17 +556,17 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 
 static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 				    struct nfsd_readdirres *resp,
-				    int count)
+				    u32 count)
 {
 	struct xdr_buf *buf = &resp->dirlist;
 	struct xdr_stream *xdr = &resp->xdr;
 
-	count = min_t(u32, count, PAGE_SIZE);
+	count = clamp(count, (u32)(XDR_UNIT * 2), svc_max_payload(rqstp));
 
 	memset(buf, 0, sizeof(*buf));
 
 	/* Reserve room for the NULL ptr & eof flag (-2 words) */
-	buf->buflen = count - sizeof(__be32) * 2;
+	buf->buflen = count - XDR_UNIT * 2;
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 

