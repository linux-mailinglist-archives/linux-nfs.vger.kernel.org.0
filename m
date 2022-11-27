Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB6639BEC
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Nov 2022 18:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK0RRe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Nov 2022 12:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiK0RRe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Nov 2022 12:17:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0CABD5
        for <linux-nfs@vger.kernel.org>; Sun, 27 Nov 2022 09:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C807CE0B16
        for <linux-nfs@vger.kernel.org>; Sun, 27 Nov 2022 17:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D78C433D6
        for <linux-nfs@vger.kernel.org>; Sun, 27 Nov 2022 17:17:28 +0000 (UTC)
Subject: [PATCH] SUNRPC: Fix crasher in unwrap_integ_data()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 27 Nov 2022 12:17:27 -0500
Message-ID: <166956944745.113279.2771726273440100988.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a zero length is passed to kmalloc() it returns 0x10, which is
not a valid address. gss_verify_mic() subsequently crashes when it
attempts to dereference that pointer.

Instead of allocating this memory on every call based on an
untrusted size value, use a piece of dynamically-allocated scratch
memory that is always available.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   55 ++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 9a5db285d4ae..148bb0a7fa5b 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -49,11 +49,36 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/cache.h>
+#include <linux/sunrpc/gss_krb5.h>
 
 #include <trace/events/rpcgss.h>
 
 #include "gss_rpc_upcall.h"
 
+/*
+ * Unfortunately there isn't a maximum checksum size exported via the
+ * GSS API. Manufacture one based on GSS mechanisms supported by this
+ * implementation.
+ */
+#define GSS_MAX_CKSUMSIZE (GSS_KRB5_TOK_HDR_LEN + GSS_KRB5_MAX_CKSUM_LEN)
+
+/*
+ * This value may be increased in the future to accommodate other
+ * usage of the scratch buffer.
+ */
+#define GSS_SCRATCH_SIZE GSS_MAX_CKSUMSIZE
+
+struct gss_svc_data {
+	/* decoded gss client cred: */
+	struct rpc_gss_wire_cred	clcred;
+	/* save a pointer to the beginning of the encoded verifier,
+	 * for use in encryption/checksumming in svcauth_gss_release: */
+	__be32				*verf_start;
+	struct rsc			*rsci;
+
+	/* for temporary results */
+	u8				gsd_scratch[GSS_SCRATCH_SIZE];
+};
 
 /* The rpcsec_init cache is used for mapping RPCSEC_GSS_{,CONT_}INIT requests
  * into replies.
@@ -887,13 +912,11 @@ read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 static int
 unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
 {
+	struct gss_svc_data *gsd = rqstp->rq_auth_data;
 	u32 integ_len, rseqno, maj_stat;
-	int stat = -EINVAL;
 	struct xdr_netobj mic;
 	struct xdr_buf integ_buf;
 
-	mic.data = NULL;
-
 	/* NFS READ normally uses splice to send data in-place. However
 	 * the data in cache can change after the reply's MIC is computed
 	 * but before the RPC reply is sent. To prevent the client from
@@ -917,11 +940,9 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	/* copy out mic... */
 	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
 		goto unwrap_failed;
-	if (mic.len > RPC_MAX_AUTH_SIZE)
-		goto unwrap_failed;
-	mic.data = kmalloc(mic.len, GFP_KERNEL);
-	if (!mic.data)
+	if (mic.len > sizeof(gsd->gsd_scratch))
 		goto unwrap_failed;
+	mic.data = gsd->gsd_scratch;
 	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
 		goto unwrap_failed;
 	maj_stat = gss_verify_mic(ctx, &integ_buf, &mic);
@@ -932,20 +953,17 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 		goto bad_seqno;
 	/* trim off the mic and padding at the end before returning */
 	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
-	stat = 0;
-out:
-	kfree(mic.data);
-	return stat;
+	return 0;
 
 unwrap_failed:
 	trace_rpcgss_svc_unwrap_failed(rqstp);
-	goto out;
+	return -EINVAL;
 bad_seqno:
 	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
-	goto out;
+	return -EINVAL;
 bad_mic:
 	trace_rpcgss_svc_mic(rqstp, maj_stat);
-	goto out;
+	return -EINVAL;
 }
 
 static inline int
@@ -1023,15 +1041,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	return -EINVAL;
 }
 
-struct gss_svc_data {
-	/* decoded gss client cred: */
-	struct rpc_gss_wire_cred	clcred;
-	/* save a pointer to the beginning of the encoded verifier,
-	 * for use in encryption/checksumming in svcauth_gss_release: */
-	__be32				*verf_start;
-	struct rsc			*rsci;
-};
-
 static int
 svcauth_gss_set_client(struct svc_rqst *rqstp)
 {


