Return-Path: <linux-nfs+bounces-17437-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792BCF11E3
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 17:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41F9730047BD
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2193F271440;
	Sun,  4 Jan 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxjEF9n1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31D26F291
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767543025; cv=none; b=f+4+nUJ/oDMAP/rXnJ+Dx4sqlkr4MKvjwfBpFUThbB1JXGQ/CWsOALbS7ZEZDnosXQKcOPtcD+zlpcmldoqqQWSDhJp52PWNoOZNoCHTVH1RsZ80SYBftDKgN3LO0g6wV+Yx4OilPxFYR2Q8d4BLEINRhAnIiJ3CDj+67TYqGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767543025; c=relaxed/simple;
	bh=xq6O2NCazhToHgUxeNQQlJObKRdWLg09JGOZany5V2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDu3ZvEl8nPtgaxQijCiI68X2Bpn9VLaNvnedD6C7WBPlR7IyeWQi6IArooyBN2MqgpguMol35Vz39Hsh9zzvGo4LpU+Wpv3uLkDzTG/lYUbWIBWdrtHiO2qnXi0uyU33HClsji+UqohPrRqmiMuYyBfeenqkCHKK0lEJXRStVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxjEF9n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4645AC19424;
	Sun,  4 Jan 2026 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767543024;
	bh=xq6O2NCazhToHgUxeNQQlJObKRdWLg09JGOZany5V2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxjEF9n1Q4MNIbuXFkVnJohSV7z6n7Y8ImnS+6D4liXG30/FWamHJDXT80Qt5w8pY
	 gpjF31mbVvpEqlOMqfxFYUInxpFmyeu2O3VWR6VukaL097Khout8RDkqnd1DktBluG
	 AyBeWa9TUmdwkrWUBnHI68isR3JvDVrfqm4nXD3upLb/YBj/t5dBCz+X0aXtB9WXDQ
	 l4mImjZ6KmgjQiyHyvxXek6k5WxvzX9bfkjcts7YfJTzQjYgGWkp7kJgGexgRKozkx
	 ic9F+blVAuzA0JaNcjaqmt5X3V6WAKgLNjzF1GU7pK3xGpGR8ZWgFFDkBSq+GyoLrE
	 P6ad0JLbxjZ3g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 03/12] NFSD: Add nfsd4_encode_fattr4_acl_trueform
Date: Sun,  4 Jan 2026 11:10:13 -0500
Message-ID: <20260104161019.3404489-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104161019.3404489-1-cel@kernel.org>
References: <20260104161019.3404489-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Mapping between NFSv4 ACLs and POSIX ACLs is semantically imprecise:
a client that sets an NFSv4 ACL and reads it back may see a different
ACL than it wrote. The proposed NFSv4 POSIX ACL extension introduces
the FATTR4_ACL_TRUEFORM attribute, which reports whether a file
object stores its access control permissions using NFSv4 ACLs or
POSIX ACLs.

A client aware of this extension can avoid lossy translation by
requesting and setting ACLs in their native format.

When NFSD is built with CONFIG_NFSD_V4_POSIX_ACLS, report
ACL_MODEL_POSIX_DRAFT for file objects on file systems with the
SB_POSIXACL flag set, and ACL_MODEL_NONE otherwise. Linux file
systems do not store NFSv4 ACLs natively, so ACL_MODEL_NFS4 is never
reported.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5065727204b9..9b47cf17ddde 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3470,6 +3470,22 @@ static __be32 nfsd4_encode_fattr4_open_arguments(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+
+static __be32 nfsd4_encode_fattr4_acl_trueform(struct xdr_stream *xdr,
+					       const struct nfsd4_fattr_args *args)
+{
+	aclmodel4 trueform = ACL_MODEL_NONE;
+
+	if (IS_POSIXACL(d_inode(args->dentry)))
+		trueform = ACL_MODEL_POSIX_DRAFT;
+	if (!xdrgen_encode_aclmodel4(xdr, trueform))
+		return nfserr_resource;
+	return nfs_ok;
+}
+
+#endif /* CONFIG_NFSD_V4_POSIX_ACLS */
+
 static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_SUPPORTED_ATTRS]	= nfsd4_encode_fattr4_supported_attrs,
 	[FATTR4_TYPE]			= nfsd4_encode_fattr4_type,
@@ -3573,6 +3589,16 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_TIME_DELEG_ACCESS]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_TIME_DELEG_MODIFY]	= nfsd4_encode_fattr4__inval,
 	[FATTR4_OPEN_ARGUMENTS]		= nfsd4_encode_fattr4_open_arguments,
+
+	/* Reserved */
+	[87]				= nfsd4_encode_fattr4__inval,
+	[88]				= nfsd4_encode_fattr4__inval,
+
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4_acl_trueform,
+#else
+	[FATTR4_ACL_TRUEFORM]		= nfsd4_encode_fattr4__noop,
+#endif
 };
 
 /*
-- 
2.52.0


