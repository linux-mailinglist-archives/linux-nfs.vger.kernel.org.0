Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90A62B879F
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 23:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKRWTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 17:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgKRWTp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Nov 2020 17:19:45 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EF5246DC
        for <linux-nfs@vger.kernel.org>; Wed, 18 Nov 2020 22:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605737984;
        bh=aZmrGsheszoo3wyL9VbIIzf5/t57BUubvxhuJpQQqXE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eUdpZi3hnbObS7fdjjKy0wHy0wfhEUZjGuX1o/oY4dPKyyG30z+XWHoftnbm3MOU/
         TJZmBFYkjMxrmdPfHOx95V4yLgnxiuBz9LJSCFY9L/v71ZG5dX081Cojfms1AQauVx
         QIV64MKfPSCz7gamlnHiHjmldM8Wq9cJKVzsvovU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Date:   Wed, 18 Nov 2020 17:19:39 -0500
Message-Id: <20201118221939.20715-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201118221939.20715-2-trondmy@kernel.org>
References: <20201118221939.20715-1-trondmy@kernel.org>
 <20201118221939.20715-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When doing a read() into a page, we also don't care if the nul padding
stays in that last page when the data length is not 32-bit aligned.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs2xdr.c | 2 +-
 fs/nfs/nfs3xdr.c | 2 +-
 fs/nfs/nfs4xdr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index db9c265ad9e1..468bfbfe44d7 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -102,7 +102,7 @@ static int decode_nfsdata(struct xdr_stream *xdr, struct nfs_pgio_res *result)
 	if (unlikely(!p))
 		return -EIO;
 	count = be32_to_cpup(p);
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_read_pages(xdr, xdr_align_size(count));
 	if (unlikely(count > recvd))
 		goto out_cheating;
 out:
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index d3e1726d538b..8ef7c961d3e2 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1611,7 +1611,7 @@ static int decode_read3resok(struct xdr_stream *xdr,
 	ocount = be32_to_cpup(p++);
 	if (unlikely(ocount != count))
 		goto out_mismatch;
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_read_pages(xdr, xdr_align_size(count));
 	if (unlikely(count > recvd))
 		goto out_cheating;
 out:
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 755b556e85c3..5baa767106dc 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -5202,7 +5202,7 @@ static int decode_read(struct xdr_stream *xdr, struct rpc_rqst *req,
 		return -EIO;
 	eof = be32_to_cpup(p++);
 	count = be32_to_cpup(p);
-	recvd = xdr_read_pages(xdr, count);
+	recvd = xdr_read_pages(xdr, xdr_align_size(count));
 	if (count > recvd) {
 		dprintk("NFS: server cheating in read reply: "
 				"count %u > recvd %u\n", count, recvd);
-- 
2.28.0

