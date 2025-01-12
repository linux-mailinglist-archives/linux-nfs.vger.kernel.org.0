Return-Path: <linux-nfs+bounces-9146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02468A0AACE
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976E77A3604
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61841BD9DB;
	Sun, 12 Jan 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YcPqqP9f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55731BC9F6;
	Sun, 12 Jan 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698830; cv=none; b=OSvgBViSJn8W3F4X00bQvzY4aDX24COnq2pEEnNYePuvbA+nY24Bvn7QI63W8IBgiNAy0me/QFDxGSFl/k+MryFrbw5uPPEMZagO3T45u7CCEjxv0DOJnfNEWtmArAWrP2W2DW3f+O3ZF7+RQZiDoTu3ncEnfeMIXTbqHxBN2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698830; c=relaxed/simple;
	bh=k3rhOPm+JlLBuJ6F2LQrCCchnXFzlSMT5gVt/z6KXjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNm9Q61ruzw55iImpL1Xw0i6vLUraSGJlRxnuAjmDAMOyCUJHb1LdcdfHKhsqaKimLw6LEawb1DzwK/JgEdr0ghLr30qVbfGsRO2ZRClrljVY+26OQwEnmFfZR0E+CHq8qFghiAjXoaqQtMsMBwbD7PxuefTuIWbth5hvG4EsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YcPqqP9f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=xynriCTSwyj3bHiNJJZCR/5Q2eJaiIdOXWz7EYI+upA=; b=YcPqqP9fH4JxUXsl
	X38cLSdbNgcRqkwFrA6PwlXryXcGFunTyc+ezxmrtoMIsmjC7feTmMOhSX56mGk776XvbrMv0UHpe
	Bo9O0ktUFJ/g5DkC1wXv61rwAefiXk4335DAqgY3RsUuKUNDIFXEAIz7ts7wBhbCE53QZh+q/Mzjg
	TLaAKQskw1Ilu70toMcANPgR9Ofn0Ov2QKTJqorKoJSWtzUR5kqt1u5GjcpKRBuG5/CUvyBt7/Ko7
	tBu4D6n2XbuX9VUy8J1DbGtrDW/53xM2Ror/ovPAslLmryc/pZ1kW8PGth/qImRVBMLtKIoQbxAZO
	I0ozBmPo6WtRjd+VeQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tX0hE-009kQH-0L;
	Sun, 12 Jan 2025 16:20:16 +0000
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
Subject: [PATCH] SUNRPC: Remove unused krb5_decrypt
Date: Sun, 12 Jan 2025 16:20:15 +0000
Message-ID: <20250112162015.454346-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of krb5_decrypt() was removed in 2023 by
commit 2a9893f796a3 ("SUNRPC:
Remove net/sunrpc/auth_gss/gss_krb5_seqnum.c")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 54 -------------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |  3 --
 2 files changed, 57 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 9a27201638e2..7e09b15c5538 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -138,60 +138,6 @@ krb5_encrypt(
 	return ret;
 }
 
-/**
- * krb5_decrypt - simple decryption of an RPCSEC GSS payload
- * @tfm: initialized cipher transform
- * @iv: pointer to an IV
- * @in: ciphertext to decrypt
- * @out: OUT: plaintext
- * @length: length of input and output buffers, in bytes
- *
- * @iv may be NULL to force the use of an all-zero IV.
- * The buffer containing the IV must be as large as the
- * cipher's ivsize.
- *
- * Return values:
- *   %0: @in successfully decrypted into @out
- *   negative errno: @in not decrypted
- */
-u32
-krb5_decrypt(
-     struct crypto_sync_skcipher *tfm,
-     void * iv,
-     void * in,
-     void * out,
-     int length)
-{
-	u32 ret = -EINVAL;
-	struct scatterlist sg[1];
-	u8 local_iv[GSS_KRB5_MAX_BLOCKSIZE] = {0};
-	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
-
-	if (length % crypto_sync_skcipher_blocksize(tfm) != 0)
-		goto out;
-
-	if (crypto_sync_skcipher_ivsize(tfm) > GSS_KRB5_MAX_BLOCKSIZE) {
-		dprintk("RPC:       gss_k5decrypt: tfm iv size too large %d\n",
-			crypto_sync_skcipher_ivsize(tfm));
-		goto out;
-	}
-	if (iv)
-		memcpy(local_iv, iv, crypto_sync_skcipher_ivsize(tfm));
-
-	memcpy(out, in, length);
-	sg_init_one(sg, out, length);
-
-	skcipher_request_set_sync_tfm(req, tfm);
-	skcipher_request_set_callback(req, 0, NULL, NULL);
-	skcipher_request_set_crypt(req, sg, sg, length, local_iv);
-
-	ret = crypto_skcipher_decrypt(req);
-	skcipher_request_zero(req);
-out:
-	dprintk("RPC:       gss_k5decrypt returns %d\n",ret);
-	return ret;
-}
-
 static int
 checksummer(struct scatterlist *sg, void *data)
 {
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index a47e9ec228a5..0bda0078d7d8 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -166,9 +166,6 @@ u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 u32 krb5_encrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 		 void *out, int length);
 
-u32 krb5_decrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
-		 void *out, int length);
-
 int xdr_extend_head(struct xdr_buf *buf, unsigned int base,
 		    unsigned int shiftlen);
 
-- 
2.47.1


