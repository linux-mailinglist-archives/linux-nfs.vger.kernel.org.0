Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF965B57F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jan 2023 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjABRFu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Jan 2023 12:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjABRFr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Jan 2023 12:05:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD15DE
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 09:05:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEF360F79
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E266BC433D2
        for <linux-nfs@vger.kernel.org>; Mon,  2 Jan 2023 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672679145;
        bh=ba7aEDFoW0GLRndA7nigDNpfAdAPCXMz0+Qe6gtJuUA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=PdwTE3RX9Fu/G7SQcd3V6/UIV24+5S89vFDuUT3bw82unWZRVIT6HJ8/zlAfyhVP6
         9kogB7a/SKSzNw7TQ7xa3jRdp30G7N8dX+7ZQN7Y2mNUik5fbRhYR53y5V6AoBR3ag
         NJOcltopCGv2M+CNuzMJa8ptyD52uPXFxyeRJd3Ai9rb5mwyKdQ4Kz/iumFY6l/Uq/
         e9xJMiCGoCUooWJyGzDnv+di5lJKGJ7FBotAF64zcQc53aUZY965iMoYCbDtfrPqix
         zbm0/RTRpkNoHGWpQLqok+EXP6fYR+ZKxzepU5bZvhOOfO/G5LN3d19AnpSMTcU4Vc
         gKW50tcvpO6CA==
Subject: [PATCH v1 03/25] SUNRPC: Add an XDR decoding helper for struct
 opaque_auth
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 02 Jan 2023 12:05:43 -0500
Message-ID: <167267914377.112521.795556329232106586.stgit@manet.1015granger.net>
In-Reply-To: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
References: <167267753484.112521.4826748148788735127.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
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

RFC 5531 defines the body of an RPC Call message like this:

	struct call_body {
		unsigned int rpcvers;
		unsigned int prog;
		unsigned int vers;
		unsigned int proc;
		opaque_auth cred;
		opaque_auth verf;
		/* procedure-specific parameters start here */
	};

In the current server code, decoding a struct opaque_auth type is
open-coded in several places, and is thus difficult to harden
everywhere.

Introduce a helper for decoding an opaque_auth within the context
of a xdr_stream. This helper can be shared with all authentication
flavor implemenations, even on the client-side.

Done as part of hardening the server-side RPC header decoding paths.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h |    3 +++
 net/sunrpc/xdr.c           |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f84e2a1358e1..8b5c9d0cdcb5 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -346,6 +346,9 @@ ssize_t xdr_stream_decode_string(struct xdr_stream *xdr, char *str,
 		size_t size);
 ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 		size_t maxlen, gfp_t gfp_flags);
+ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32 *flavor,
+		void **body, unsigned int *body_len);
+
 /**
  * xdr_align_size - Calculate padded size of an object
  * @n: Size of an object being XDR encoded (in bytes)
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f7767bf22406..4845ba2113fd 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -2274,3 +2274,31 @@ ssize_t xdr_stream_decode_string_dup(struct xdr_stream *xdr, char **str,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xdr_stream_decode_string_dup);
+
+/**
+ * xdr_stream_decode_opaque_auth - Decode struct opaque_auth (RFC5531 S8.2)
+ * @xdr: pointer to xdr_stream
+ * @flavor: location to store decoded flavor
+ * @body: location to store decode body
+ * @body_len: location to store length of decoded body
+ *
+ * Return values:
+ *   On success, returns the number of buffer bytes consumed
+ *   %-EBADMSG on XDR buffer overflow
+ *   %-EMSGSIZE if the decoded size of the body field exceeds 400 octets
+ */
+ssize_t xdr_stream_decode_opaque_auth(struct xdr_stream *xdr, u32 *flavor,
+				      void **body, unsigned int *body_len)
+{
+	ssize_t ret, len;
+
+	len = xdr_stream_decode_u32(xdr, flavor);
+	if (unlikely(len < 0))
+		return len;
+	ret = xdr_stream_decode_opaque_inline(xdr, body, RPC_MAX_AUTH_SIZE);
+	if (unlikely(ret < 0))
+		return ret;
+	*body_len = ret;
+	return len + ret;
+}
+EXPORT_SYMBOL_GPL(xdr_stream_decode_opaque_auth);


