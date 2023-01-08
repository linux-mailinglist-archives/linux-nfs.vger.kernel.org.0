Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5866169F
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjAHQ3o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 11:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjAHQ3n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 11:29:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D55F64
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 08:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16EC4B801C1
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2E2C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195379;
        bh=6PAzxwEqD9ukhZNaFe3cyGdP9JoTNHBXO7Z6CLNET5c=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=r7RIxd2vU5DZrQcyy8sozkAJheFkY7+It4AvJLFkwS6c03ze14KtjxCJxnW1BX1QK
         UhhZcW9PYAOIbnypUiPRQETwRy9/WsO17yisdHOH1foTlL0vtoSPFuCeGnGtb2ULN2
         gtBf/nu0TMRkZ77vYek5NrnuYxiIMIGxLw0rF+zzDA/2YZ7Lnf6o5DIsnaPfFbdsqu
         RGUXAaQtC189ogI6J/4esHMFnFrrFuN8pqpu+tZw/Ao26jcTFleVQC+OmCCeRbgITm
         FLKayHT4dHyonBknifQ5I4dXDt6HXiSdU0WvzDYxfIlIfsKdvmNfYDxA/W8zx0ArS2
         t9E5qoBOkXLaQ==
Subject: [PATCH v1 12/27] SUNRPC: Add XDR encoding helper for opaque_auth
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 08 Jan 2023 11:29:38 -0500
Message-ID: <167319537874.7490.10030931409689592644.stgit@bazille.1015granger.net>
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

RFC 5531 defines an MSG_ACCEPTED Reply message like this:

	struct accepted_reply {
		opaque_auth verf;
		union switch (accept_stat stat) {
		case SUCCESS:
		   ...

In the current server code, struct opaque_auth encoding is open-
coded. Introduce a helper that encodes an opaque_auth data item
within the context of a xdr_stream.

Done as part of hardening the server-side RPC header decoding and
encoding paths.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |    2 ++
 net/sunrpc/xdr.c           |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 884df67009f4..f3b6eb9accd7 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -348,6 +348,8 @@ ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 		size_t maxlen, gfp_t gfp_flags);
 ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32 *flavor,
 		void **body, unsigned int *body_len);
+ssize_t xdr_stream_encode_opaque_auth(struct xdr_stream *xdr, u32 flavor,
+		void *body, unsigned int body_len);
 
 /**
  * xdr_align_size - Calculate padded size of an object
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 56d87c784c9e..6b2ec24ec62d 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -2310,3 +2310,32 @@ ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32 *flavor,
 	return len + ret;
 }
 EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque_auth);
+
+/**
+ * xdr_stream_encode_opaque_auth - Encode struct opaque_auth (RFC5531 S8.2)
+ * @xdr: pointer to xdr_stream
+ * @flavor: verifier flavor to encode
+ * @body: content of body to encode
+ * @body_len: length of body to encode
+ *
+ * Return values:
+ *   On success, returns length in bytes of XDR buffer consumed
+ *   %-EBADMSG on XDR buffer overflow
+ *   %-EMSGSIZE if the size of @body exceeds 400 octets
+ */
+ssize_t xdr_stream_encode_opaque_auth(struct xdr_stream *xdr, u32 flavor,
+				      void *body, unsigned int body_len)
+{
+	ssize_t ret, len;
+
+	if (unlikely(body_len > RPC_MAX_AUTH_SIZE))
+		return -EMSGSIZE;
+	len = xdr_stream_encode_u32(xdr, flavor);
+	if (unlikely(len < 0))
+		return len;
+	ret = xdr_stream_encode_opaque(xdr, body, body_len);
+	if (unlikely(ret < 0))
+		return ret;
+	return len + ret;
+}
+EXPORT_SYMBOL_GPL(xdr_stream_encode_opaque_auth);


