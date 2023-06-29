Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDBE742B8E
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjF2RvF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2RvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7C1FC3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A1D6615C9
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0FFC433C8;
        Thu, 29 Jun 2023 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061061;
        bh=klzDOfTsYz0J8xA4WNCKlzPGscK7UtGY5ZYEW7qw9Gs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=inNp4T1HBQw+HruMva40ijrxEdsJfuRJoHERuWPNgzGLHRMnl4Cbw8dhDaaZDEACx
         ZH6zkMcHZdQc8AcIh1IgD5LK8PL1GStSqJ0+1TlloJUoUxpnnC1vFu8SQH4ct0dY1R
         kE9z2vQbTUjMZIerGXvbYAPidbddjZZy4uDdWMUh7aBfGdzmZu/5QpuDv4jPZa/x8/
         KAw1zBrgBMQpBbiSW/d+kcta0uEx3PH6FnMO9ghXzmzqHMiwk1126Pacg+W6zRDkuj
         TTPvbLxO5Aska0BH1d7FeN4VCaNYHqi7k4qamHPNa9GQxKVKDY+7XuZ11yZMQdvz94
         GKfR0jAyURycQ==
Subject: [PATCH v1 4/9] SUNRPC: Remove code behind
 CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:51:00 -0400
Message-ID: <168806106050.507650.6464747452805338131.stgit@morisot.1015granger.net>
In-Reply-To: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
References: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

None of this code can be enabled any more.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    9 -
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   44 -----
 net/sunrpc/auth_gss/gss_krb5_seal.c     |   69 -------
 net/sunrpc/auth_gss/gss_krb5_unseal.c   |   77 --------
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |  287 -------------------------------
 5 files changed, 486 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index b673e2626acb..3471a574997a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -85,24 +85,15 @@ struct krb5_ctx {
  * GSS Kerberos 5 mechanism Per-Message calls.
  */
 
-u32 gss_krb5_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
-			struct xdr_netobj *token);
 u32 gss_krb5_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 			struct xdr_netobj *token);
 
-u32 gss_krb5_verify_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
-			   struct xdr_netobj *read_token);
 u32 gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 			   struct xdr_netobj *read_token);
 
-u32 gss_krb5_wrap_v1(struct krb5_ctx *kctx, int offset,
-		     struct xdr_buf *buf, struct page **pages);
 u32 gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
 		     struct xdr_buf *buf, struct page **pages);
 
-u32 gss_krb5_unwrap_v1(struct krb5_ctx *kctx, int offset, int len,
-		       struct xdr_buf *buf, unsigned int *slack,
-		       unsigned int *align);
 u32 gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 		       struct xdr_buf *buf, unsigned int *slack,
 		       unsigned int *align);
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 39160a8ca3b6..890ad877792f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -30,10 +30,6 @@
 
 static struct gss_api_mech gss_kerberos_mech;
 
-#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
-static int gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask);
-static int gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask);
-#endif
 #if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 static int gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask);
 #endif
@@ -414,46 +410,6 @@ gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
 	return PTR_ERR(p);
 }
 
-#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
-static int
-gss_krb5_import_ctx_des(struct krb5_ctx *ctx, gfp_t gfp_mask)
-{
-	return -EINVAL;
-}
-
-static int
-gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
-{
-	struct xdr_netobj keyin, keyout;
-
-	keyin.data = ctx->Ksess;
-	keyin.len = ctx->gk5e->keylength;
-
-	ctx->seq = gss_krb5_alloc_cipher_v1(ctx, &keyin);
-	if (ctx->seq == NULL)
-		goto out_err;
-	ctx->enc = gss_krb5_alloc_cipher_v1(ctx, &keyin);
-	if (ctx->enc == NULL)
-		goto out_free_seq;
-
-	/* derive cksum */
-	keyout.data = ctx->cksum;
-	keyout.len = ctx->gk5e->keylength;
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_SIGN,
-			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
-		goto out_free_enc;
-
-	return 0;
-
-out_free_enc:
-	crypto_free_sync_skcipher(ctx->enc);
-out_free_seq:
-	crypto_free_sync_skcipher(ctx->seq);
-out_err:
-	return -EINVAL;
-}
-#endif
-
 #if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 
 static struct crypto_sync_skcipher *
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 146aa755f07d..ce540df9bce4 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -71,75 +71,6 @@
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
-#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
-
-static void *
-setup_token(struct krb5_ctx *ctx, struct xdr_netobj *token)
-{
-	u16 *ptr;
-	void *krb5_hdr;
-	int body_size = GSS_KRB5_TOK_HDR_LEN + ctx->gk5e->cksumlength;
-
-	token->len = g_token_size(&ctx->mech_used, body_size);
-
-	ptr = (u16 *)token->data;
-	g_make_token_header(&ctx->mech_used, body_size, (unsigned char **)&ptr);
-
-	/* ptr now at start of header described in rfc 1964, section 1.2.1: */
-	krb5_hdr = ptr;
-	*ptr++ = KG_TOK_MIC_MSG;
-	/*
-	 * signalg is stored as if it were converted from LE to host endian, even
-	 * though it's an opaque pair of bytes according to the RFC.
-	 */
-	*ptr++ = (__force u16)cpu_to_le16(ctx->gk5e->signalg);
-	*ptr++ = SEAL_ALG_NONE;
-	*ptr = 0xffff;
-
-	return krb5_hdr;
-}
-
-u32
-gss_krb5_get_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *text,
-		    struct xdr_netobj *token)
-{
-	char			cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj	md5cksum = {.len = sizeof(cksumdata),
-					    .data = cksumdata};
-	void			*ptr;
-	time64_t		now;
-	u32			seq_send;
-	u8			*cksumkey;
-
-	dprintk("RPC:       %s\n", __func__);
-	BUG_ON(ctx == NULL);
-
-	now = ktime_get_real_seconds();
-
-	ptr = setup_token(ctx, token);
-
-	if (ctx->gk5e->keyed_cksum)
-		cksumkey = ctx->cksum;
-	else
-		cksumkey = NULL;
-
-	if (make_checksum(ctx, ptr, 8, text, 0, cksumkey,
-			  KG_USAGE_SIGN, &md5cksum))
-		return GSS_S_FAILURE;
-
-	memcpy(ptr + GSS_KRB5_TOK_HDR_LEN, md5cksum.data, md5cksum.len);
-
-	seq_send = atomic_fetch_inc(&ctx->seq_send);
-
-	if (krb5_make_seq_num(ctx, ctx->seq, ctx->initiate ? 0 : 0xff,
-			      seq_send, ptr + GSS_KRB5_TOK_HDR_LEN, ptr + 8))
-		return GSS_S_FAILURE;
-
-	return (ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
-}
-
-#endif
-
 static void *
 setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
 {
diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index 7d6d4ae4a3c9..4fbc50a0a2c4 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -69,83 +69,6 @@
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
-
-#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
-/* read_token is a mic token, and message_buffer is the data that the mic was
- * supposedly taken over. */
-u32
-gss_krb5_verify_mic_v1(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
-		       struct xdr_netobj *read_token)
-{
-	int			signalg;
-	int			sealalg;
-	char			cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj	md5cksum = {.len = sizeof(cksumdata),
-					    .data = cksumdata};
-	s32			now;
-	int			direction;
-	u32			seqnum;
-	unsigned char		*ptr = (unsigned char *)read_token->data;
-	int			bodysize;
-	u8			*cksumkey;
-
-	dprintk("RPC:       krb5_read_token\n");
-
-	if (g_verify_token_header(&ctx->mech_used, &bodysize, &ptr,
-					read_token->len))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	if ((ptr[0] != ((KG_TOK_MIC_MSG >> 8) & 0xff)) ||
-	    (ptr[1] !=  (KG_TOK_MIC_MSG & 0xff)))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	/* XXX sanity-check bodysize?? */
-
-	signalg = ptr[2] + (ptr[3] << 8);
-	if (signalg != ctx->gk5e->signalg)
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	sealalg = ptr[4] + (ptr[5] << 8);
-	if (sealalg != SEAL_ALG_NONE)
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	if ((ptr[6] != 0xff) || (ptr[7] != 0xff))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	if (ctx->gk5e->keyed_cksum)
-		cksumkey = ctx->cksum;
-	else
-		cksumkey = NULL;
-
-	if (make_checksum(ctx, ptr, 8, message_buffer, 0,
-			  cksumkey, KG_USAGE_SIGN, &md5cksum))
-		return GSS_S_FAILURE;
-
-	if (memcmp(md5cksum.data, ptr + GSS_KRB5_TOK_HDR_LEN,
-					ctx->gk5e->cksumlength))
-		return GSS_S_BAD_SIG;
-
-	/* it got through unscathed.  Make sure the context is unexpired */
-
-	now = ktime_get_real_seconds();
-
-	if (now > ctx->endtime)
-		return GSS_S_CONTEXT_EXPIRED;
-
-	/* do sequencing checks */
-
-	if (krb5_get_seq_num(ctx, ptr + GSS_KRB5_TOK_HDR_LEN, ptr + 8,
-			     &direction, &seqnum))
-		return GSS_S_FAILURE;
-
-	if ((ctx->initiate && direction != 0xff) ||
-	    (!ctx->initiate && direction != 0))
-		return GSS_S_BAD_SIG;
-
-	return GSS_S_COMPLETE;
-}
-#endif
-
 u32
 gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 		       struct xdr_netobj *read_token)
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 6d6b082380b2..b3e1738ff6bf 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -40,293 +40,6 @@
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
-#if defined(CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED)
-
-static inline int
-gss_krb5_padding(int blocksize, int length)
-{
-	return blocksize - (length % blocksize);
-}
-
-static inline void
-gss_krb5_add_padding(struct xdr_buf *buf, int offset, int blocksize)
-{
-	int padding = gss_krb5_padding(blocksize, buf->len - offset);
-	char *p;
-	struct kvec *iov;
-
-	if (buf->page_len || buf->tail[0].iov_len)
-		iov = &buf->tail[0];
-	else
-		iov = &buf->head[0];
-	p = iov->iov_base + iov->iov_len;
-	iov->iov_len += padding;
-	buf->len += padding;
-	memset(p, padding, padding);
-}
-
-static inline int
-gss_krb5_remove_padding(struct xdr_buf *buf, int blocksize)
-{
-	u8 *ptr;
-	u8 pad;
-	size_t len = buf->len;
-
-	if (len <= buf->head[0].iov_len) {
-		pad = *(u8 *)(buf->head[0].iov_base + len - 1);
-		if (pad > buf->head[0].iov_len)
-			return -EINVAL;
-		buf->head[0].iov_len -= pad;
-		goto out;
-	} else
-		len -= buf->head[0].iov_len;
-	if (len <= buf->page_len) {
-		unsigned int last = (buf->page_base + len - 1)
-					>>PAGE_SHIFT;
-		unsigned int offset = (buf->page_base + len - 1)
-					& (PAGE_SIZE - 1);
-		ptr = kmap_atomic(buf->pages[last]);
-		pad = *(ptr + offset);
-		kunmap_atomic(ptr);
-		goto out;
-	} else
-		len -= buf->page_len;
-	BUG_ON(len > buf->tail[0].iov_len);
-	pad = *(u8 *)(buf->tail[0].iov_base + len - 1);
-out:
-	/* XXX: NOTE: we do not adjust the page lengths--they represent
-	 * a range of data in the real filesystem page cache, and we need
-	 * to know that range so the xdr code can properly place read data.
-	 * However adjusting the head length, as we do above, is harmless.
-	 * In the case of a request that fits into a single page, the server
-	 * also uses length and head length together to determine the original
-	 * start of the request to copy the request for deferal; so it's
-	 * easier on the server if we adjust head and tail length in tandem.
-	 * It's not really a problem that we don't fool with the page and
-	 * tail lengths, though--at worst badly formed xdr might lead the
-	 * server to attempt to parse the padding.
-	 * XXX: Document all these weird requirements for gss mechanism
-	 * wrap/unwrap functions. */
-	if (pad > blocksize)
-		return -EINVAL;
-	if (buf->len > pad)
-		buf->len -= pad;
-	else
-		return -EINVAL;
-	return 0;
-}
-
-/* Assumptions: the head and tail of inbuf are ours to play with.
- * The pages, however, may be real pages in the page cache and we replace
- * them with scratch pages from **pages before writing to them. */
-/* XXX: obviously the above should be documentation of wrap interface,
- * and shouldn't be in this kerberos-specific file. */
-
-/* XXX factor out common code with seal/unseal. */
-
-u32
-gss_krb5_wrap_v1(struct krb5_ctx *kctx, int offset,
-		 struct xdr_buf *buf, struct page **pages)
-{
-	char			cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj	md5cksum = {.len = sizeof(cksumdata),
-					    .data = cksumdata};
-	int			blocksize = 0, plainlen;
-	unsigned char		*ptr, *msg_start;
-	time64_t		now;
-	int			headlen;
-	struct page		**tmp_pages;
-	u32			seq_send;
-	u8			*cksumkey;
-	u32			conflen = crypto_sync_skcipher_blocksize(kctx->enc);
-
-	dprintk("RPC:       %s\n", __func__);
-
-	now = ktime_get_real_seconds();
-
-	blocksize = crypto_sync_skcipher_blocksize(kctx->enc);
-	gss_krb5_add_padding(buf, offset, blocksize);
-	BUG_ON((buf->len - offset) % blocksize);
-	plainlen = conflen + buf->len - offset;
-
-	headlen = g_token_size(&kctx->mech_used,
-		GSS_KRB5_TOK_HDR_LEN + kctx->gk5e->cksumlength + plainlen) -
-		(buf->len - offset);
-
-	ptr = buf->head[0].iov_base + offset;
-	/* shift data to make room for header. */
-	xdr_extend_head(buf, offset, headlen);
-
-	/* XXX Would be cleverer to encrypt while copying. */
-	BUG_ON((buf->len - offset - headlen) % blocksize);
-
-	g_make_token_header(&kctx->mech_used,
-				GSS_KRB5_TOK_HDR_LEN +
-				kctx->gk5e->cksumlength + plainlen, &ptr);
-
-
-	/* ptr now at header described in rfc 1964, section 1.2.1: */
-	ptr[0] = (unsigned char) ((KG_TOK_WRAP_MSG >> 8) & 0xff);
-	ptr[1] = (unsigned char) (KG_TOK_WRAP_MSG & 0xff);
-
-	msg_start = ptr + GSS_KRB5_TOK_HDR_LEN + kctx->gk5e->cksumlength;
-
-	/*
-	 * signalg and sealalg are stored as if they were converted from LE
-	 * to host endian, even though they're opaque pairs of bytes according
-	 * to the RFC.
-	 */
-	*(__le16 *)(ptr + 2) = cpu_to_le16(kctx->gk5e->signalg);
-	*(__le16 *)(ptr + 4) = cpu_to_le16(kctx->gk5e->sealalg);
-	ptr[6] = 0xff;
-	ptr[7] = 0xff;
-
-	krb5_make_confounder(msg_start, conflen);
-
-	if (kctx->gk5e->keyed_cksum)
-		cksumkey = kctx->cksum;
-	else
-		cksumkey = NULL;
-
-	/* XXXJBF: UGH!: */
-	tmp_pages = buf->pages;
-	buf->pages = pages;
-	if (make_checksum(kctx, ptr, 8, buf, offset + headlen - conflen,
-					cksumkey, KG_USAGE_SEAL, &md5cksum))
-		return GSS_S_FAILURE;
-	buf->pages = tmp_pages;
-
-	memcpy(ptr + GSS_KRB5_TOK_HDR_LEN, md5cksum.data, md5cksum.len);
-
-	seq_send = atomic_fetch_inc(&kctx->seq_send);
-
-	/* XXX would probably be more efficient to compute checksum
-	 * and encrypt at the same time: */
-	if ((krb5_make_seq_num(kctx, kctx->seq, kctx->initiate ? 0 : 0xff,
-			       seq_send, ptr + GSS_KRB5_TOK_HDR_LEN, ptr + 8)))
-		return GSS_S_FAILURE;
-
-	if (gss_encrypt_xdr_buf(kctx->enc, buf,
-				offset + headlen - conflen, pages))
-		return GSS_S_FAILURE;
-
-	return (kctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
-}
-
-u32
-gss_krb5_unwrap_v1(struct krb5_ctx *kctx, int offset, int len,
-		   struct xdr_buf *buf, unsigned int *slack,
-		   unsigned int *align)
-{
-	int			signalg;
-	int			sealalg;
-	char			cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj	md5cksum = {.len = sizeof(cksumdata),
-					    .data = cksumdata};
-	time64_t		now;
-	int			direction;
-	s32			seqnum;
-	unsigned char		*ptr;
-	int			bodysize;
-	void			*data_start, *orig_start;
-	int			data_len;
-	int			blocksize;
-	u32			conflen = crypto_sync_skcipher_blocksize(kctx->enc);
-	int			crypt_offset;
-	u8			*cksumkey;
-	unsigned int		saved_len = buf->len;
-
-	dprintk("RPC:       gss_unwrap_kerberos\n");
-
-	ptr = (u8 *)buf->head[0].iov_base + offset;
-	if (g_verify_token_header(&kctx->mech_used, &bodysize, &ptr,
-					len - offset))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	if ((ptr[0] != ((KG_TOK_WRAP_MSG >> 8) & 0xff)) ||
-	    (ptr[1] !=  (KG_TOK_WRAP_MSG & 0xff)))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	/* XXX sanity-check bodysize?? */
-
-	/* get the sign and seal algorithms */
-
-	signalg = ptr[2] + (ptr[3] << 8);
-	if (signalg != kctx->gk5e->signalg)
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	sealalg = ptr[4] + (ptr[5] << 8);
-	if (sealalg != kctx->gk5e->sealalg)
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	if ((ptr[6] != 0xff) || (ptr[7] != 0xff))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	/*
-	 * Data starts after token header and checksum.  ptr points
-	 * to the beginning of the token header
-	 */
-	crypt_offset = ptr + (GSS_KRB5_TOK_HDR_LEN + kctx->gk5e->cksumlength) -
-					(unsigned char *)buf->head[0].iov_base;
-
-	buf->len = len;
-	if (gss_decrypt_xdr_buf(kctx->enc, buf, crypt_offset))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	if (kctx->gk5e->keyed_cksum)
-		cksumkey = kctx->cksum;
-	else
-		cksumkey = NULL;
-
-	if (make_checksum(kctx, ptr, 8, buf, crypt_offset,
-					cksumkey, KG_USAGE_SEAL, &md5cksum))
-		return GSS_S_FAILURE;
-
-	if (memcmp(md5cksum.data, ptr + GSS_KRB5_TOK_HDR_LEN,
-						kctx->gk5e->cksumlength))
-		return GSS_S_BAD_SIG;
-
-	/* it got through unscathed.  Make sure the context is unexpired */
-
-	now = ktime_get_real_seconds();
-
-	if (now > kctx->endtime)
-		return GSS_S_CONTEXT_EXPIRED;
-
-	/* do sequencing checks */
-
-	if (krb5_get_seq_num(kctx, ptr + GSS_KRB5_TOK_HDR_LEN,
-			     ptr + 8, &direction, &seqnum))
-		return GSS_S_BAD_SIG;
-
-	if ((kctx->initiate && direction != 0xff) ||
-	    (!kctx->initiate && direction != 0))
-		return GSS_S_BAD_SIG;
-
-	/* Copy the data back to the right position.  XXX: Would probably be
-	 * better to copy and encrypt at the same time. */
-
-	blocksize = crypto_sync_skcipher_blocksize(kctx->enc);
-	data_start = ptr + (GSS_KRB5_TOK_HDR_LEN + kctx->gk5e->cksumlength) +
-					conflen;
-	orig_start = buf->head[0].iov_base + offset;
-	data_len = (buf->head[0].iov_base + buf->head[0].iov_len) - data_start;
-	memmove(orig_start, data_start, data_len);
-	buf->head[0].iov_len -= (data_start - orig_start);
-	buf->len = len - (data_start - orig_start);
-
-	if (gss_krb5_remove_padding(buf, blocksize))
-		return GSS_S_DEFECTIVE_TOKEN;
-
-	/* slack must include room for krb5 padding */
-	*slack = XDR_QUADLEN(saved_len - buf->len);
-	/* The GSS blob always precedes the RPC message payload */
-	*align = *slack;
-	return GSS_S_COMPLETE;
-}
-
-#endif
-
 /*
  * We can shift data by up to LOCAL_BUF_LEN bytes in a pass.  If we need
  * to do more than that, we shift repeatedly.  Kevin Coffman reports


