Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139A07B3416
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjI2N73 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2N72 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 09:59:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3081AA
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 06:59:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9E2C433C8;
        Fri, 29 Sep 2023 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695995966;
        bh=wxzSbW218QG/F18fT5HyA7G5D9u74+BhVpjngnoJGWA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YyeMthW61xnqg9V5Qtmf9oLtJsQJqZxYinOdhDpQvWSZG3uVG3qepjG0n60f69+MH
         TaQodrJF5O5cfB0HkT6anBUW+uUm30uboP7pNw7A5XWC7WbO8wlEaiSV6c/IL2ZlFL
         t30VdcPY9HUoPexvpk0l8rebuY8nzEa8Y7MTv/ZrS4BqoUi15Q98Vut7gULhSMqWBz
         J8rRfsSll7UbvS6IuIqlyXNKJBtOkULKwOpVhebQFnBy5tfIfEZfx0T5+CMBeWqR4Z
         nAxmspLyLdHgymHiC4ZEISLGweKy0Ebb4UCWLRPxhRl7BPvUfYCuSOrxlhJzbtgPuD
         RoLAk7MUju2bw==
Subject: [PATCH v1 6/7] NFSD: Add nfsd4_encode_open_delegation4()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 09:59:24 -0400
Message-ID: <169599596495.5622.4730901021436965726.stgit@manet.1015granger.net>
In-Reply-To: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
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

To better align our implementation with the XDR specification,
refactor the part of nfsd4_encode_open() that encodes delegation
metadata.

As part of that refactor, remove an unnecessary BUG() call site and
a comment that appears to be stale.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   56 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b6c5ccb9351f..f37c370ceded 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4170,13 +4170,43 @@ nfsd4_encode_open_none_delegation4(struct xdr_stream *xdr,
 	return status;
 }
 
+static __be32
+nfsd4_encode_open_delegation4(struct xdr_stream *xdr, struct nfsd4_open *open)
+{
+	__be32 status;
+
+	/* delegation_type */
+	if (xdr_stream_encode_u32(xdr, open->op_delegate_type) != XDR_UNIT)
+		return nfserr_resource;
+	switch (open->op_delegate_type) {
+	case NFS4_OPEN_DELEGATE_NONE:
+		status = nfs_ok;
+		break;
+	case NFS4_OPEN_DELEGATE_READ:
+		/* read */
+		status = nfsd4_encode_open_read_delegation4(xdr, open);
+		break;
+	case NFS4_OPEN_DELEGATE_WRITE:
+		/* write */
+		status = nfsd4_encode_open_write_delegation4(xdr, open);
+		break;
+	case NFS4_OPEN_DELEGATE_NONE_EXT:
+		/* od_whynone */
+		status = nfsd4_encode_open_none_delegation4(xdr, open);
+		break;
+	default:
+		status = nfserr_serverfault;
+	}
+
+	return status;
+}
+
 static __be32
 nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  union nfsd4_op_u *u)
 {
 	struct nfsd4_open *open = &u->open;
 	struct xdr_stream *xdr = resp->xdr;
-	__be32 *p;
 
 	nfserr = nfsd4_encode_stateid4(xdr, &open->op_stateid);
 	if (nfserr)
@@ -4192,28 +4222,8 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (nfserr)
 		return nfserr;
 
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		return nfserr_resource;
-
-	*p++ = cpu_to_be32(open->op_delegate_type);
-	switch (open->op_delegate_type) {
-	case NFS4_OPEN_DELEGATE_NONE:
-		break;
-	case NFS4_OPEN_DELEGATE_READ:
-		/* read */
-		return nfsd4_encode_open_read_delegation4(xdr, open);
-	case NFS4_OPEN_DELEGATE_WRITE:
-		/* write */
-		return nfsd4_encode_open_write_delegation4(xdr, open);
-	case NFS4_OPEN_DELEGATE_NONE_EXT:
-		/* od_whynone */
-		return nfsd4_encode_open_none_delegation4(xdr, open);
-	default:
-		BUG();
-	}
-	/* XXX save filehandle here */
-	return 0;
+	/* delegation */
+	return nfsd4_encode_open_delegation4(xdr, open);
 }
 
 static __be32


