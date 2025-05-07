Return-Path: <linux-nfs+bounces-11557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46190AAD9EB
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 10:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00B09A4B1E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2E221708;
	Wed,  7 May 2025 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fD6V3t99"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE82236E5;
	Wed,  7 May 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605392; cv=none; b=CJmFs2OF3TmFMYjaOo6hQPF+IfhaH5ap1wdotZxnmBViEpSrC9GSnK/fwBVsIZblCkQpgcdZU7zrImOk8+/ryKbhrPuarVwJC9OZ4jGCAchtU78Vxd6rGzndvMTx/51q9dCBguLkRdvWW1IL/PtnF8WjgJKfT7eBgX9DQjKCO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605392; c=relaxed/simple;
	bh=h3PtaA9t9D+yBYE72CyOxr89YUzDBs2bin4mCmdBuWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6zqvhZykoZ2No1Vf3xKNCnyteJHoG+ORW3jORn/toKfrqKtjdZ5tV81d7A4KL/YxN/X/5Dbd1GXAox5jogGf27gNYLVvbQn+uVw6T3LHlhgLRIDXQHhhiK2Ndw/EOOWKbIdjT6hrznkKiRQS/kmLgyLpLy4mAzX6YWpEppad8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fD6V3t99; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KaOkGOmTmBrQvBRfepMifUTJNW6pkGN5asgaU/RxoQs=; b=fD6V3t99bZfzIYFqwfzJKHzFJd
	5oMp8u3Fijh8mjECuAeclwSnJh1HdrCJeXwOdKNJjUM9FKNgJ5BRalNfaz4OFdBVnowXkvEpOw+jh
	KZ16LYaP9kIZ3YaPTHV3nZRCUEcEDRYyANtF1JelpM+dL+ZEmHl8yTAPiGlDQBmIlZd3HlzOA+vny
	nADjQXWx9IxzfAjVR3IT4AeF/K3trYc2izw22ukBIFm5t7KxljYEiAAAHgUDSBZZHisJHqFtQFyrs
	zxf7YgXXn0xcce+Ci4eciI3tGPKSKIpHD/MB4lZjybtaexsTPfeWt5Rdof5NaRhI8Cd0S3iZstRhC
	qEu/oNKQ==;
Received: from [2001:4bb8:2ae:8c08:f874:4a3:a9ae:2540] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZqg-0000000EfjK-0yGL;
	Wed, 07 May 2025 08:09:50 +0000
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
Date: Wed,  7 May 2025 10:09:40 +0200
Message-ID: <20250507080944.3947782-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507080944.3947782-1-hch@lst.de>
References: <20250507080944.3947782-1-hch@lst.de>
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
 fs/nfs/fs_context.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 13f71ca8c974..58845c414893 100644
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
 
@@ -551,6 +555,25 @@ static int nfs_parse_version_string(struct fs_context *fc,
 	return 0;
 }
 
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
+
 /*
  * Parse a single mount parameter.
  */
@@ -807,6 +830,18 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
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


