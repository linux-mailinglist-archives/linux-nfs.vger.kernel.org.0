Return-Path: <linux-nfs+bounces-8491-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74D9EA40F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 02:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6731682C0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 01:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA713B58C;
	Tue, 10 Dec 2024 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KOWgrwKb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940C5474C;
	Tue, 10 Dec 2024 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792573; cv=none; b=bGyGzf0s4d4ULiDQd06FJxRRKw+gBRcQlNsY4goA0tO7VDX8x0z96CleGIk794P7dVLdidundvBVRNYWOeW+QOznPyUSG4D5Zls4isnw7hR2VOk58AZ9JZDU22jcIbOCcGPG2uv8+3pXRt+qxx7eamHrwWXWd2MQRMjW8cA/i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792573; c=relaxed/simple;
	bh=Mi4R10fc6D0UG1ykrzFINIkrlpryLoSgpy/zCpwnInM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSkHZZvmiBaHiDNA2H1KhoV4zbQ2X2w7tN5eDY30sE2/G4Y7ZRh0YXI4IfzEGmf5iR+jclbDKV2SxwL4pbepp9lDleIGLraoh0Nse+pgZ1MggOT76tYqJTfsmybSr7fxaLoSZzr5F/e0ab0KsL3scUjHDsIAoXUo4jc6TtyBfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KOWgrwKb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=5B4ouTrfxMGgmCIM/C5GmAPRV6HRICqep5cx1w2PwJY=; b=KOWgrwKbB1Ikp21D
	XzO9tb01IzcShm3/Pl0mvLHmelEwmaWibosoArIgawg1hd6ESuf4PvsJisKh3WBGVRUKRKKu/fEmT
	gdiROW8Z1r9hu02cTb4o83F4R7/P4ZW/zZ+xarrKEGshimTywwu6LqDF0YODUGZoCvUYCsa8ZdRZu
	wTVC4eBAA0aVuaCaTx8aqM0G1Ooe7Yi62WwZJyFQm/T+Xn/ja6kL9lypQmiUCZX4RLHWofjh/Ks+s
	KxxjCU6nrR6a4f6WWNQTwvQOSFBVHrefz3PJo1UXW/fPVsneHXOYXh4Iie3zK/iDRxPbNI9GqThmd
	CJVwErrZInizD5StGg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tKoe1-004Oea-03;
	Tue, 10 Dec 2024 01:02:33 +0000
From: linux@treblig.org
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] sunrpc: Remove gss_{de,en}crypt_xdr_buf deadcode
Date: Tue, 10 Dec 2024 01:02:25 +0000
Message-ID: <20241210010225.343017-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210010225.343017-1-linux@treblig.org>
References: <20241210010225.343017-1-linux@treblig.org>
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
gss_decrypt_xdr_buf() and gss_encrypt_xdr_buf() functions.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 55 -------------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |  7 ----
 2 files changed, 62 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index d2b02710ab07..9a27201638e2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -442,35 +442,6 @@ encryptor(struct scatterlist *sg, void *data)
 	return 0;
 }
 
-int
-gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *buf,
-		    int offset, struct page **pages)
-{
-	int ret;
-	struct encryptor_desc desc;
-	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
-
-	BUG_ON((buf->len - offset) % crypto_sync_skcipher_blocksize(tfm) != 0);
-
-	skcipher_request_set_sync_tfm(req, tfm);
-	skcipher_request_set_callback(req, 0, NULL, NULL);
-
-	memset(desc.iv, 0, sizeof(desc.iv));
-	desc.req = req;
-	desc.pos = offset;
-	desc.outbuf = buf;
-	desc.pages = pages;
-	desc.fragno = 0;
-	desc.fraglen = 0;
-
-	sg_init_table(desc.infrags, 4);
-	sg_init_table(desc.outfrags, 4);
-
-	ret = xdr_process_buf(buf, offset, buf->len - offset, encryptor, &desc);
-	skcipher_request_zero(req);
-	return ret;
-}
-
 struct decryptor_desc {
 	u8 iv[GSS_KRB5_MAX_BLOCKSIZE];
 	struct skcipher_request *req;
@@ -525,32 +496,6 @@ decryptor(struct scatterlist *sg, void *data)
 	return 0;
 }
 
-int
-gss_decrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *buf,
-		    int offset)
-{
-	int ret;
-	struct decryptor_desc desc;
-	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
-
-	/* XXXJBF: */
-	BUG_ON((buf->len - offset) % crypto_sync_skcipher_blocksize(tfm) != 0);
-
-	skcipher_request_set_sync_tfm(req, tfm);
-	skcipher_request_set_callback(req, 0, NULL, NULL);
-
-	memset(desc.iv, 0, sizeof(desc.iv));
-	desc.req = req;
-	desc.fragno = 0;
-	desc.fraglen = 0;
-
-	sg_init_table(desc.frags, 4);
-
-	ret = xdr_process_buf(buf, offset, buf->len - offset, decryptor, &desc);
-	skcipher_request_zero(req);
-	return ret;
-}
-
 /*
  * This function makes the assumption that it was ultimately called
  * from gss_wrap().
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 3afd4065bf3d..a47e9ec228a5 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -172,13 +172,6 @@ u32 krb5_decrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 int xdr_extend_head(struct xdr_buf *buf, unsigned int base,
 		    unsigned int shiftlen);
 
-int gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm,
-			struct xdr_buf *outbuf, int offset,
-			struct page **pages);
-
-int gss_decrypt_xdr_buf(struct crypto_sync_skcipher *tfm,
-			struct xdr_buf *inbuf, int offset);
-
 u32 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 			 struct xdr_buf *buf, struct page **pages);
 
-- 
2.47.1


