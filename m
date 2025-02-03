Return-Path: <linux-nfs+bounces-9851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B329DA25C89
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 15:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C2B166E60
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016020CCDD;
	Mon,  3 Feb 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+e4a+xT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93A20A5C9
	for <linux-nfs@vger.kernel.org>; Mon,  3 Feb 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592726; cv=none; b=ioRRA596s5mZAXBDw43wTZ/maEWI9jMGI5r+/sOzdKxISO3vXaS9oZA76zwa42RWid9AVK6JymMVt43fnMuvC1UtpZ4RgVft5QDXIlChvf0KZ+896QOVhJBJ9G07Yx93xWeDjawyBwA7p/myVNd3UpEh4S+pxqu34l6YiqF+1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592726; c=relaxed/simple;
	bh=8x96hgPuesNlUAGA+JMlvjxwTTAaMbEYDrU16OaAngQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1qIgF9WVUpWQ2HQ6F2de9fSNjf+qT6T2juuQ25G81M51Y/MJR1yo2Do2COdxnVgYeV0mvQsoHjCZri8wp4D7NlZrn32hkGjbUND+QO2EXxW+8o7/T04EEmgQYAZTR5ebt6EaZFg/XiHzEJbfP/EYRalHYWWfCVkphL+XpPcwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+e4a+xT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sg1tiXasZdYVJfd0X98IXXCbsi9UiqsxMqNF6D78daY=;
	b=g+e4a+xTr0cygiDwG1ASpUDZoN6MEwRJPmF5izy76stPK79XbXOK5u3HLiyPNGccYHT7uO
	cmWLr3Uuge4VzZ0D8CMJFTL2/lHwn0GxXTUSaN/61jepcB309zow4ynH8/4qlbHhwgQy4z
	pGve9HFjEsUCbrVg8WqXQOJXVPF2jTA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-HVjKrsO5NF6kI9dQyrPzPQ-1; Mon,
 03 Feb 2025 09:25:18 -0500
X-MC-Unique: HVjKrsO5NF6kI9dQyrPzPQ-1
X-Mimecast-MFC-AGG-ID: HVjKrsO5NF6kI9dQyrPzPQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F7BF1801F28;
	Mon,  3 Feb 2025 14:25:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A75C195608E;
	Mon,  3 Feb 2025 14:25:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 13/24] crypto/krb5: Implement the Kerberos5 rfc3961 get_mic and verify_mic
Date: Mon,  3 Feb 2025 14:23:29 +0000
Message-ID: <20250203142343.248839-14-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add functions that sign and verify a message according to rfc3961 sec 5.4,
using Kc to generate a checksum and insert it into the MIC field in the
skbuff in the sign phase then checksum the data and compare it to the MIC
in the verify phase.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 crypto/krb5/internal.h           |  10 +++
 crypto/krb5/rfc3961_simplified.c | 130 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index c8deb112b604..07a47ddf3ea9 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -169,3 +169,13 @@ int krb5_aead_decrypt(const struct krb5_enctype *krb5,
 		      struct crypto_aead *aead,
 		      struct scatterlist *sg, unsigned int nr_sg,
 		      size_t *_offset, size_t *_len);
+ssize_t rfc3961_get_mic(const struct krb5_enctype *krb5,
+			struct crypto_shash *shash,
+			const struct krb5_buffer *metadata,
+			struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			size_t data_offset, size_t data_len);
+int rfc3961_verify_mic(const struct krb5_enctype *krb5,
+		       struct crypto_shash *shash,
+		       const struct krb5_buffer *metadata,
+		       struct scatterlist *sg, unsigned int nr_sg,
+		       size_t *_offset, size_t *_len);
diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simplified.c
index 58323ce5838a..c1dcb0dd3a00 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -653,6 +653,134 @@ int krb5_aead_decrypt(const struct krb5_enctype *krb5,
 	return ret;
 }
 
+/*
+ * Generate a checksum over some metadata and part of an skbuff and insert the
+ * MIC into the skbuff immediately prior to the data.
+ */
+ssize_t rfc3961_get_mic(const struct krb5_enctype *krb5,
+			struct crypto_shash *shash,
+			const struct krb5_buffer *metadata,
+			struct scatterlist *sg, unsigned int nr_sg, size_t sg_len,
+			size_t data_offset, size_t data_len)
+{
+	struct shash_desc *desc;
+	ssize_t ret, done;
+	size_t bsize;
+	void *buffer, *digest;
+
+	if (WARN_ON(data_offset != krb5->cksum_len))
+		return -EMSGSIZE;
+
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	/* Calculate the MIC with key Kc and store it into the skb */
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	if (metadata) {
+		ret = crypto_shash_update(desc, metadata->data, metadata->len);
+		if (ret < 0)
+			goto error;
+	}
+
+	ret = crypto_shash_update_sg(desc, sg, data_offset, data_len);
+	if (ret < 0)
+		goto error;
+
+	digest = buffer + krb5_shash_size(shash);
+	ret = crypto_shash_final(desc, digest);
+	if (ret < 0)
+		goto error;
+
+	ret = -EFAULT;
+	done = sg_pcopy_from_buffer(sg, nr_sg, digest, krb5->cksum_len,
+				    data_offset - krb5->cksum_len);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	ret = krb5->cksum_len + data_len;
+
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
+/*
+ * Check the MIC on a region of an skbuff.  The offset and length are updated
+ * to reflect the actual content of the secure region.
+ */
+int rfc3961_verify_mic(const struct krb5_enctype *krb5,
+		       struct crypto_shash *shash,
+		       const struct krb5_buffer *metadata,
+		       struct scatterlist *sg, unsigned int nr_sg,
+		       size_t *_offset, size_t *_len)
+{
+	struct shash_desc *desc;
+	ssize_t done;
+	size_t bsize, data_offset, data_len, offset = *_offset, len = *_len;
+	void *buffer = NULL;
+	int ret;
+	u8 *cksum, *cksum2;
+
+	if (len < krb5->cksum_len)
+		return -EPROTO;
+	data_offset = offset + krb5->cksum_len;
+	data_len = len - krb5->cksum_len;
+
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) * 2;
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	cksum = buffer +
+		krb5_shash_size(shash);
+	cksum2 = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+
+	/* Calculate the MIC */
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error;
+
+	if (metadata) {
+		ret = crypto_shash_update(desc, metadata->data, metadata->len);
+		if (ret < 0)
+			goto error;
+	}
+
+	crypto_shash_update_sg(desc, sg, data_offset, data_len);
+	crypto_shash_final(desc, cksum);
+
+	ret = -EFAULT;
+	done = sg_pcopy_to_buffer(sg, nr_sg, cksum2, krb5->cksum_len, offset);
+	if (done != krb5->cksum_len)
+		goto error;
+
+	if (memcmp(cksum, cksum2, krb5->cksum_len) != 0) {
+		ret = -EBADMSG;
+		goto error;
+	}
+
+	*_offset += krb5->cksum_len;
+	*_len -= krb5->cksum_len;
+	ret = 0;
+
+error:
+	kfree_sensitive(buffer);
+	return ret;
+}
+
 const struct krb5_crypto_profile rfc3961_simplified_profile = {
 	.calc_PRF		= rfc3961_calc_PRF,
 	.calc_Kc		= rfc3961_calc_DK,
@@ -664,4 +792,6 @@ const struct krb5_crypto_profile rfc3961_simplified_profile = {
 	.load_checksum_key	= rfc3961_load_checksum_key,
 	.encrypt		= krb5_aead_encrypt,
 	.decrypt		= krb5_aead_decrypt,
+	.get_mic		= rfc3961_get_mic,
+	.verify_mic		= rfc3961_verify_mic,
 };


