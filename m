Return-Path: <linux-nfs+bounces-9832-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50BA25132
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 03:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3939A188495D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8B1172A;
	Mon,  3 Feb 2025 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ASOfH7nX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BC2A1C9;
	Mon,  3 Feb 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738548477; cv=none; b=RuPPhb22UkA1LQJSeNtjHEQ5uJUScRSmrVGANfGxSonQPlvJmPIvBBx+PO8nspg5c4lbdu4Rk92gOMl1wsu+h/yzKxZRj9wv2msmtf+QXiynRST4ypuJa8jKhmIhtvzkfuEpp7yCTFGQ0cX/t2WZno4xar+JbfsHuxUlaJjm59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738548477; c=relaxed/simple;
	bh=wM5JKs2VrkY+2Ns9prRRGqSjkqtzOmYrYFesP1QwiKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MA468LsomAgG5lRDEPKn95KVGwx9ES8JG4eQNwUZ7Ynvb4kg/spG5v+Khz8O1gR7ly3A6TJ04JHHTZoh/OL7fIu/uif6pR38f/C/3vnHXxMmrUQud2L4Hu0GprXmX6q1p/YvNlgilusIjRs+Wry9eoj3TnXZ7CRgI1lAsQHhNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ASOfH7nX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Xzk/e1yuIM8mk0vycxZvqalEYX9nnB92dHj7/duvLM8=; b=ASOfH7nXcPUvWWpR
	2qCUPrxh4Xbwtp+FVs+hcKzaSXGiPAVNe1bfpp1MWh61MaZ08rqOr6ziZf+bcLayWx9TeLaDMW7xM
	5FPogiuld9bsiL1u3r0k8oq533jFbixq2bFNv9ZuOh7NHbxbDMaEK+/a/keRBPoqgtSTp7L8ExsSG
	O1PmhMGhFlp1whYjW+YnAL9AJGbUvqvu4hYcmzjF8VMOfjfLAbSLPrK3NtLHwkoj9hNtrqxq4vp97
	5r7BN6J6M2X4I8BzgVV9zvz8qn1KRkzPIpouwxv9UaNag7ttWsPqEWOJVbP7E/xhIDGncw+63Cjwd
	Va0WXlhh7QRCFnBxNw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1telsG-00DAMr-0l;
	Mon, 03 Feb 2025 02:07:44 +0000
From: linux@treblig.org
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] SUNRPC: Remove unused make_checksum
Date: Mon,  3 Feb 2025 02:07:43 +0000
Message-ID: <20250203020743.280722-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit ec596aaf9b48 ("SUNRPC: Remove code behind
CONFIG_RPCSEC_GSS_KRB5_SIMPLIFIED") was the last user of the
make_checksum() function.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 90 -------------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |  4 --
 2 files changed, 94 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 7e09b15c5538..8f2d65c1e831 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -148,96 +148,6 @@ checksummer(struct scatterlist *sg, void *data)
 	return crypto_ahash_update(req);
 }
 
-/*
- * checksum the plaintext data and hdrlen bytes of the token header
- * The checksum is performed over the first 8 bytes of the
- * gss token header and then over the data body
- */
-u32
-make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
-	      struct xdr_buf *body, int body_offset, u8 *cksumkey,
-	      unsigned int usage, struct xdr_netobj *cksumout)
-{
-	struct crypto_ahash *tfm;
-	struct ahash_request *req;
-	struct scatterlist              sg[1];
-	int err = -1;
-	u8 *checksumdata;
-	unsigned int checksumlen;
-
-	if (cksumout->len < kctx->gk5e->cksumlength) {
-		dprintk("%s: checksum buffer length, %u, too small for %s\n",
-			__func__, cksumout->len, kctx->gk5e->name);
-		return GSS_S_FAILURE;
-	}
-
-	checksumdata = kmalloc(GSS_KRB5_MAX_CKSUM_LEN, GFP_KERNEL);
-	if (checksumdata == NULL)
-		return GSS_S_FAILURE;
-
-	tfm = crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		goto out_free_cksum;
-
-	req = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!req)
-		goto out_free_ahash;
-
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
-
-	checksumlen = crypto_ahash_digestsize(tfm);
-
-	if (cksumkey != NULL) {
-		err = crypto_ahash_setkey(tfm, cksumkey,
-					  kctx->gk5e->keylength);
-		if (err)
-			goto out;
-	}
-
-	err = crypto_ahash_init(req);
-	if (err)
-		goto out;
-	sg_init_one(sg, header, hdrlen);
-	ahash_request_set_crypt(req, sg, NULL, hdrlen);
-	err = crypto_ahash_update(req);
-	if (err)
-		goto out;
-	err = xdr_process_buf(body, body_offset, body->len - body_offset,
-			      checksummer, req);
-	if (err)
-		goto out;
-	ahash_request_set_crypt(req, NULL, checksumdata, 0);
-	err = crypto_ahash_final(req);
-	if (err)
-		goto out;
-
-	switch (kctx->gk5e->ctype) {
-	case CKSUMTYPE_RSA_MD5:
-		err = krb5_encrypt(kctx->seq, NULL, checksumdata,
-				   checksumdata, checksumlen);
-		if (err)
-			goto out;
-		memcpy(cksumout->data,
-		       checksumdata + checksumlen - kctx->gk5e->cksumlength,
-		       kctx->gk5e->cksumlength);
-		break;
-	case CKSUMTYPE_HMAC_SHA1_DES3:
-		memcpy(cksumout->data, checksumdata, kctx->gk5e->cksumlength);
-		break;
-	default:
-		BUG();
-		break;
-	}
-	cksumout->len = kctx->gk5e->cksumlength;
-out:
-	ahash_request_free(req);
-out_free_ahash:
-	crypto_free_ahash(tfm);
-out_free_cksum:
-	kfree(checksumdata);
-	return err ? GSS_S_FAILURE : 0;
-}
-
 /**
  * gss_krb5_checksum - Compute the MAC for a GSS Wrap or MIC token
  * @tfm: an initialized hash transform
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 0bda0078d7d8..8769e9e705bf 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -155,10 +155,6 @@ static inline int krb5_derive_key(struct krb5_ctx *kctx,
 
 void krb5_make_confounder(u8 *p, int conflen);
 
-u32 make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
-		  struct xdr_buf *body, int body_offset, u8 *cksumkey,
-		  unsigned int usage, struct xdr_netobj *cksumout);
-
 u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 		      const struct xdr_buf *body, int body_offset,
 		      struct xdr_netobj *cksumout);
-- 
2.48.1


