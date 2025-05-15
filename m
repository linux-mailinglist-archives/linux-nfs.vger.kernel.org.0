Return-Path: <linux-nfs+bounces-11739-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB8AB854E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B110188E3F5
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F0298C13;
	Thu, 15 May 2025 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l98KoKiT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12229826D;
	Thu, 15 May 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309877; cv=none; b=STCh94dzjdmSi4cdlN+LcK/GFoAMhZwL8Ywo/+Ah5ebO+D26O9nlTfOhDxp0YHWuf41yXY3g4GbzbHAyf6hXb6fn0Wx11xlKhaLEqi35PIu2L8Q32agmEMjURQ1FBGsYqPpVzlovq52bG45mlE9o1p2R7Dsie1wDKp5bXtW6dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309877; c=relaxed/simple;
	bh=S2FTRwPMzA58Um3ZNlMMTicoX2rltyoDd/7/6nCinuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kot6rzbtuxXyz5mxR2WEXFD/Y5hMifadZTptV8TIapNq3OhVFACgI6+ZlbR8OiksKrrbtz9z/d0uKjcqK+sgEUTgG+uOxfb1iWZsQa030eZh3FL9zPXkIUypxiAng/4jhkh+hpZB6/BUtmTD9RWy8WHD4ytA02vbjEzHlB8lQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l98KoKiT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MLcZ3j1HE+1MJFqcehr6CqBE6b/APbGGqIN0KyskaKY=; b=l98KoKiT5C7g9vcbls8eDcBJ06
	68daEUr1dnWSQEpx2BtAffS7KbuZeGm7mijC2uq/4LTzDjP8g48S5rSFsZ+8Y1TXj526ki0Uxu3P4
	kKymKPdal/vR2OmnoUbCwyugG17I4GKAY3BTIGq/0g4mPZeJ56NOWykNy6GI1u7hZjnRYdH6IlwQb
	aB7DIQxH788H5qyPHtBU/gwn+kjgi6W+9zegrng1r7uHfz5tqVjsGcRX4TnCyJn1Ei1UVuBtgezgz
	c5zturAOhPdXl1JY/CdElt9ji/NWR3XCy9O74PnOUIoi9DncYcjtY7zQJfE6jXTXz676iQvJvtWUK
	ppcMV84g==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX7K-00000000SbX-3ec2;
	Thu, 15 May 2025 11:51:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: [PATCH 1/2] NFS: support the kernel keyring for TLS
Date: Thu, 15 May 2025 13:50:55 +0200
Message-ID: <20250515115107.33052-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515115107.33052-1-hch@lst.de>
References: <20250515115107.33052-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow tlshd to use a per-mount key from the kernel keyring similar
to NVMe over TCP.

Note that tlshd expects keys and certificates stored in the kernel
keyring to be in DER format, not the PEM format used for file based keys
and certificates, so they need to be converted before they are added
to the keyring, which is a bit unexpected.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/fs_context.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 13f71ca8c974..9e94d18448ff 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -96,6 +96,8 @@ enum nfs_param {
 	Opt_wsize,
 	Opt_write,
 	Opt_xprtsec,
+	Opt_cert_serial,
+	Opt_privkey_serial,
 };
 
 enum {
@@ -221,6 +223,8 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
 	fsparam_enum  ("write",		Opt_write, nfs_param_enums_write),
 	fsparam_u32   ("wsize",		Opt_wsize),
 	fsparam_string("xprtsec",	Opt_xprtsec),
+	fsparam_s32("cert_serial",	Opt_cert_serial),
+	fsparam_s32("privkey_serial",	Opt_privkey_serial),
 	{}
 };
 
@@ -551,6 +555,32 @@ static int nfs_parse_version_string(struct fs_context *fc,
 	return 0;
 }
 
+#ifdef CONFIG_KEYS
+static int nfs_tls_key_verify(key_serial_t key_id)
+{
+	struct key *key = key_lookup(key_id);
+	int error = 0;
+
+	if (IS_ERR(key)) {
+		pr_err("key id %08x not found\n", key_id);
+		return PTR_ERR(key);
+	}
+	if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
+	    test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
+		pr_err("key id %08x revoked\n", key_id);
+		error = -EKEYREVOKED;
+	}
+
+	key_put(key);
+	return error;
+}
+#else
+static inline int nfs_tls_key_verify(key_serial_t key_id)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_KEYS */
+
 /*
  * Parse a single mount parameter.
  */
@@ -807,6 +837,18 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		if (ret < 0)
 			return ret;
 		break;
+	case Opt_cert_serial:
+		ret = nfs_tls_key_verify(result.int_32);
+		if (ret < 0)
+			return ret;
+		ctx->xprtsec.cert_serial = result.int_32;
+		break;
+	case Opt_privkey_serial:
+		ret = nfs_tls_key_verify(result.int_32);
+		if (ret < 0)
+			return ret;
+		ctx->xprtsec.privkey_serial = result.int_32;
+		break;
 
 	case Opt_proto:
 		if (!param->string)
-- 
2.47.2


