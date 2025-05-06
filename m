Return-Path: <linux-nfs+bounces-11526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3172AAC8FC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 17:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7313A591A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409942820AF;
	Tue,  6 May 2025 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PShHJtHF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAB281371
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543669; cv=none; b=pDXlOAHytPxn3RBTMzO4kNnwI87muB7Bu/WYF0fBAKjkkv+boGJaJRRGqNO2dPllqGCWb2kwkiRg7fyrYhq4V9PjN96e7LBh+sJEBfoXoMpLvKt6y7mOaKlElnXJvGKab71hJYvfY2LBQXMo5WwJ8CLvCFRl/9XyZ4ps9zUAQrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543669; c=relaxed/simple;
	bh=fhy5X0bHbSJvsOLVyKCWgidABpMXqDhd1NrwfjnK2Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOOaK4HQZsb2s4Hk/TxL+ZuFF7XXHiEV1Kq4uMcTpjUZGdrqauO3nQ38RZjjeANh+0/HvYbh/ay5leQEJm9eHekF5p8vEQ+7aBiNeN5gqsehpzweMgtvqpXqemqQPT2lwUEfeTerVxPv0ZnFSRcaO/4fJuPr9sBwIQ8QR8x53wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PShHJtHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE511C4CEE4;
	Tue,  6 May 2025 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746543668;
	bh=fhy5X0bHbSJvsOLVyKCWgidABpMXqDhd1NrwfjnK2Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=PShHJtHFysU7Pe/rihst3xryJIRfq0G9sleiWbPql6e/19NZjDKVf/i9ruwqbxcOg
	 5k8l4Uq5Nfd5znE+O58cxqhRBsg/+xttZXLWXA9TghGQT2OjxEyVmyp8+NENTXhFOj
	 FudHmQzPdH2QNVW8+qjDUchZz/DLYQ+rXOloMgvJksC0WDy/LTVHVkCXsPYwkeTHAC
	 RhDKcdb19DhKjug/E1wU6I4qjTEz1MwmMQtt7YnwhdKxOXWJAD0Y3EhoMI/Ncq7xu8
	 XfNTlHazkKtjGKR7fxw92v5qMT5+QzgNDxnOEDNcZ9ckQNWTH4dVeOcNbm3V9+8clJ
	 bGM5NILgESNJQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
Date: Tue,  6 May 2025 11:01:05 -0400
Message-ID: <20250506150105.11874-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 7862 states that if an NFS server implements a CLONE operation,
it MUST also implement FATTR4_CLONE_BLKSIZE. NFSD implements CLONE,
but does not implement FATTR4_CLONE_BLKSIZE.

Note that in Section 12.2, RFC 7862 claims that
FATTR4_CLONE_BLKSIZE is RECOMMENDED, not REQUIRED. Likely this is
because a minor version is not permitted to add a REQUIRED
attribute. Confusing.

We assume this attribute reports a block size as a count of bytes,
as RFC 7862 does not specify a unit.

Reported-by: Roland Mainz <roland.mainz@nrubsig.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
X-Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e67420729ecd..59d186ea11dc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3391,6 +3391,14 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 }
 
+static __be32 nfsd4_encode_fattr4_clone_blksize(struct xdr_stream *xdr,
+						const struct nfsd4_fattr_args *args)
+{
+	struct inode *inode = d_inode(args->dentry);
+
+	return nfsd4_encode_uint32_t(xdr, inode->i_sb->s_blocksize);
+}
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
@@ -3545,7 +3553,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_MODE_SET_MASKED]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_SUPPATTR_EXCLCREAT]	= nfsd4_encode_fattr4_suppattr_exclcreat,
 	[FATTR4_FS_CHARSET_CAP]		= nfsd4_encode_fattr4__noop,
-	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4_clone_blksize,
 	[FATTR4_SPACE_FREED]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CHANGE_ATTR_TYPE]	= nfsd4_encode_fattr4__noop,
 
-- 
2.49.0


