Return-Path: <linux-nfs+bounces-11298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3653AA9E3FA
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Apr 2025 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146363A7785
	for <lists+linux-nfs@lfdr.de>; Sun, 27 Apr 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BF1DD525;
	Sun, 27 Apr 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhdeROZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6B1D5CC7
	for <linux-nfs@vger.kernel.org>; Sun, 27 Apr 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771957; cv=none; b=QgCoT8N5rUpaaBMXDCwV6ecg7iUFcRyO88ckz4N+EGbgt0cg+EbQGDqaqTlV3zBTW6OGKwo7AhQf+p8MTRLG6tj6x3EPIEXgk85W6/doQDBMhwiRYXJpNs5Emz4YiLAnqJJp5ipqdlcE1axmfrsgx8q2FGPwiXB0trVX9tVPEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771957; c=relaxed/simple;
	bh=VlFpPuCrkjkdrZjstUD9O2JJh15RyAGzIzJE7Xi4KpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUYDBMv02iB8JmevxTQv2bWozHvtM1ivO65e/n9i9ADSpOx97vsqEUJBybuGMUM4VhptwBXEX7rHmZTRNZuFambXFUagbCAsK3T4hnp7iiLkA0XuU8qPVST2SCqXhlnhIzvvdxHWP/gRu8eRzpnc0moFiEztr9wO7CEwTtmez+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhdeROZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDACC4CEE3;
	Sun, 27 Apr 2025 16:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745771957;
	bh=VlFpPuCrkjkdrZjstUD9O2JJh15RyAGzIzJE7Xi4KpA=;
	h=From:To:Cc:Subject:Date:From;
	b=mhdeROZANFnPwPNOu/SyBgSLVMlikmGdZiSAeZvo7+RQ35KMwb6FQz+IYVvXFxZeZ
	 kW+PYAcrwRigqGF4AF795TsZm0qMZMBmPserNzcF9HWxqRQsWMBry7AlsiZDv3ov3U
	 qsFrMNxoGHEo/RQJ0bPXhkYmQcCz+0FBGMeIGDkZe9K29iKlJJEq/Sw1YXIXeuRbQ7
	 mXET6xfTpnXABEiWz5WyO6+1rhdT+EbvfnNPj+4eD6k2N9ZijtDWDt9ERIsCeXa4r4
	 uwh9KvJG5QJbPcf1W4+gcRCX46ONRzyKq4bVgrAAFktYg4rNpeWg4PUPZGd5jOs20j
	 GhDSJgJH6PMMw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
Date: Sun, 27 Apr 2025 12:39:14 -0400
Message-ID: <20250427163914.5053-1-cel@kernel.org>
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

NFSD can return 0 here, as at least one client implementation we
are aware of (the Linux NFS client) treats 0 as meaning "CLONE has
no alignment restrictions".

Meanwhile we need to consult the nfsv4 Working Group to clarify the
meaning and use of the value of this attribute.

Reported-by: Roland Mainz <roland.mainz@nrubsig.org>
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e67420729ecd..44e7fb34f433 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3391,6 +3391,13 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcreat(struct xdr_stream *xdr,
 	return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
 }
 
+static __be32 nfsd4_encode_fattr4_clone_blksize(struct xdr_stream *xdr,
+						const struct nfsd4_fattr_args *args)
+{
+	/* Linux filesystems have no clone alignment restrictions */
+	return nfsd4_encode_uint32_t(xdr, 0);
+}
+
 #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
 static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
 					    const struct nfsd4_fattr_args *args)
@@ -3545,7 +3552,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_MODE_SET_MASKED]	= nfsd4_encode_fattr4__noop,
 	[FATTR4_SUPPATTR_EXCLCREAT]	= nfsd4_encode_fattr4_suppattr_exclcreat,
 	[FATTR4_FS_CHARSET_CAP]		= nfsd4_encode_fattr4__noop,
-	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4__noop,
+	[FATTR4_CLONE_BLKSIZE]		= nfsd4_encode_fattr4_clone_blksize,
 	[FATTR4_SPACE_FREED]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CHANGE_ATTR_TYPE]	= nfsd4_encode_fattr4__noop,
 
-- 
2.49.0


