Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486336616A0
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjAHQ3s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjAHQ3s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AD0DEBD
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C4060C58
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03DFC433EF
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195385;
        bh=gqNscWSrdJDd9bmr8rIMD/zIJ5K1IRNoU0wzTTcpUyE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dUbTWh+hxCn9jl+BfogtmHUioS+W0sr7JtFtwMIXGJB0N9VB0qGox2nWEzrJI/ayg
         bjh2FmfDHwqsCwcOgesZTyfgaUkHZjB3Dy6Ac3fePGvhWS8mzGMbkwzTX26uVGBxt7
         iq1rkO3HiiwMdb+9pXxDCUsMYvhJaKIbZfAPMoxj/UwlOZm598DW3uLb2NUMji58tl
         651ONRp5mWQ9avsyOBKHiwQrNrz0ThDsN9AuK9rf7sJlp1tmcQ81/JgxNbQi2uQuTh
         ag9REZ7jqxtHnYBEx59h3TWrjp8tV6xrD19XXnA7ZUyNIYcL+tkU/gU2L4iZWC0Tfb
         PRKipLbVfcCEQ==
Subject: [PATCH v1 13/27] SUNRPC: Push svcxdr_init_encode() into
 svc_process_common()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:44 -0500
Message-ID: <167319538493.7490.10071921740622901364.stgit@bazille.1015granger.net>
In-Reply-To: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Now that all vs_dispatch functions invoke svcxdr_init_encode(), it
is common code and can be pushed down into the generic RPC server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc.c             |    1 -
 fs/nfs/callback_xdr.c      |    2 --
 fs/nfsd/nfscache.c         |    2 +-
 fs/nfsd/nfssvc.c           |    6 ------
 include/linux/sunrpc/xdr.h |   21 +++++++++++++++++++++
 net/sunrpc/svc.c           |    1 +
 6 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index e56d85335599..642e394e7a2d 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -704,7 +704,6 @@ static int nlmsvc_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	if (*statp != rpc_success)
 		return 1;
 
-	svcxdr_init_encode(rqstp);
 	if (!procp->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 46d3f5986b4e..b4c3b7182198 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -984,8 +984,6 @@ nfs_callback_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
 	const struct svc_procedure *procp = rqstp->rq_procinfo;
 
-	svcxdr_init_encode(rqstp);
-
 	*statp = procp->pc_func(rqstp);
 	return 1;
 }
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 3e64a3d50a1c..ef5ee548053b 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -488,7 +488,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	case RC_NOCACHE:
 		break;
 	case RC_REPLSTAT:
-		svc_putu32(&rqstp->rq_res.head[0], rp->c_replstat);
+		xdr_stream_encode_be32(&rqstp->rq_res_stream, rp->c_replstat);
 		rtn = RC_REPLY;
 		break;
 	case RC_REPLBUFF:
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1ed29eac80ed..dfa8ee6c04d5 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1052,12 +1052,6 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 		goto out_dropit;
 	}
 
-	/*
-	 * Need to grab the location to store the status, as
-	 * NFSv4 does some encoding while processing
-	 */
-	svcxdr_init_encode(rqstp);
-
 	*statp = proc->pc_func(rqstp);
 	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f3b6eb9accd7..72014c9216fc 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -474,6 +474,27 @@ xdr_stream_encode_u32(struct xdr_stream *xdr, __u32 n)
 	return len;
 }
 
+/**
+ * xdr_stream_encode_be32 - Encode a big-endian 32-bit integer
+ * @xdr: pointer to xdr_stream
+ * @n: integer to encode
+ *
+ * Return values:
+ *   On success, returns length in bytes of XDR buffer consumed
+ *   %-EMSGSIZE on XDR buffer overflow
+ */
+static inline ssize_t
+xdr_stream_encode_be32(struct xdr_stream *xdr, __be32 n)
+{
+	const size_t len = sizeof(n);
+	__be32 *p = xdr_reserve_space(xdr, len);
+
+	if (unlikely(!p))
+		return -EMSGSIZE;
+	*p = n;
+	return len;
+}
+
 /**
  * xdr_stream_encode_u64 - Encode a 64-bit integer
  * @xdr: pointer to xdr_stream
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 489c5d1b67f9..1cdf68fda3f8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1321,6 +1321,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *resv)
 	 */
 	if (procp->pc_xdrressize)
 		svc_reserve_auth(rqstp, procp->pc_xdrressize<<2);
+	svcxdr_init_encode(rqstp);
 
 	/* Call the function that processes the request. */
 	rc = process.dispatch(rqstp, statp);


