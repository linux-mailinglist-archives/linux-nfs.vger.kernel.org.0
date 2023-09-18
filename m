Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D247A4EBC
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjIRQZp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjIRQZg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 12:25:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6356225478
        for <linux-nfs@vger.kernel.org>; Mon, 18 Sep 2023 09:22:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA9EC433BC;
        Mon, 18 Sep 2023 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045415;
        bh=i8hXbphYJz2dndu7u6xWLow0rclV/VusffseX/IlkW8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QGlrgvmVUldLAYbJOSAyPebfLGD2zdgilvsWhBAeehKmGndJIMls+zZQTLgNybYP3
         7qqG2wRHhhEZbHYWAYjWU+APuTErSDpDG4K+jLtWMMGQLSaL0Wfi6f1+xeTFCG0liq
         fGNf32P7nfFAikorEVjkSxPJoQt355iY9UOx8ner0/clF+D2xQhHWIZutl0Fe50tXr
         nsxxVjABepLeRD2PLTW/SGTcyJe0hb7kbjXY9G/lOydK/JjNzicXPg/Y1hsUWB4SnL
         LWRI4qmbkcoQagDKd2zhuVgzFNlXujBrUmWD3MwlFMExx4jRmOPPGvJEMwBsF17l8V
         sYQFQ/cmrqqDQ==
Subject: [PATCH v1 01/52] NFSD: Add simple u32, u64, and bool encoders
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 18 Sep 2023 09:56:54 -0400
Message-ID: <169504541407.133720.808437380691220899.stgit@manet.1015granger.net>
In-Reply-To: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
References: <169504501081.133720.4162400017732492854.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The generic XDR encoders return a length or a negative errno. NFSv4
encoders want to know simply whether the encode ran out of stream
buffer space. The return values for server-side encoding are either
nfs_ok or nfserr_resource.

So far I've found it adds a lot of duplicate code to try to use the
generic XDR encoder utilities when encoding the simple data types in
the NFSv4 operation encoders.

Add a set of NFSv4-specific utilities that handle the basic XDR data
types. These are added in xdr4.h so they might eventually be used by
the callback server and pNFS driver encoders too.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 9d918a79dc16..5c3eb3691f8b 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -50,6 +50,117 @@
 #define HAS_CSTATE_FLAG(c, f) ((c)->sid_flags & (f))
 #define CLEAR_CSTATE_FLAG(c, f) ((c)->sid_flags &= ~(f))
 
+/**
+ * nfsd4_encode_bool - Encode an XDR bool type result
+ * @xdr: target XDR stream
+ * @val: boolean value to encode
+ *
+ * Return values:
+ *    %nfs_ok: @val encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_bool(struct xdr_stream *xdr, bool val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	*p = val ? xdr_one : xdr_zero;
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_uint32_t - Encode an XDR uint32_t type result
+ * @xdr: target XDR stream
+ * @val: integer value to encode
+ *
+ * Return values:
+ *    %nfs_ok: @val encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_uint32_t(struct xdr_stream *xdr, u32 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	*p = cpu_to_be32(val);
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_uint64_t - Encode an XDR uint64_t type result
+ * @xdr: target XDR stream
+ * @val: integer value to encode
+ *
+ * Return values:
+ *    %nfs_ok: @val encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_uint64_t(struct xdr_stream *xdr, u64 val)
+{
+	__be32 *p = xdr_reserve_space(xdr, XDR_UNIT * 2);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	put_unaligned_be64(val, p);
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_opaque_fixed - Encode a fixed-length XDR opaque type result
+ * @xdr: target XDR stream
+ * @data: pointer to data
+ * @size: length of data in bytes
+ *
+ * Return values:
+ *    %nfs_ok: @data encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_opaque_fixed(struct xdr_stream *xdr, const void *data,
+			  size_t size)
+{
+	__be32 *p = xdr_reserve_space(xdr, xdr_align_size(size));
+	size_t pad = xdr_pad_size(size);
+
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	memcpy(p, data, size);
+	if (pad)
+		memset((char *)p + size, 0, pad);
+	return nfs_ok;
+}
+
+/**
+ * nfsd4_encode_opaque - Encode a variable-length XDR opaque type result
+ * @xdr: target XDR stream
+ * @data: pointer to data
+ * @size: length of data in bytes
+ *
+ * Return values:
+ *    %nfs_ok: @data encoded; @xdr advanced to next position
+ *    %nfserr_resource: stream buffer space exhausted
+ */
+static __always_inline __be32
+nfsd4_encode_opaque(struct xdr_stream *xdr, const void *data, size_t size)
+{
+	size_t pad = xdr_pad_size(size);
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT + xdr_align_size(size));
+	if (unlikely(p == NULL))
+		return nfserr_resource;
+	*p++ = cpu_to_be32(size);
+	memcpy(p, data, size);
+	if (pad)
+		memset((char *)p + size, 0, pad);
+	return nfs_ok;
+}
+
 struct nfsd4_compound_state {
 	struct svc_fh		current_fh;
 	struct svc_fh		save_fh;


