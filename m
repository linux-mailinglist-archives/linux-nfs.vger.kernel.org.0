Return-Path: <linux-nfs+bounces-16990-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C19CAE1D9
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C9530402C1
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC832ED871;
	Mon,  8 Dec 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZIn5aJq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62427990A
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765223073; cv=none; b=Jk1M0rIAQy/K/HebWlSk0vbcq0vNqNtEQB7OqTT6DwVx6rorYVYrlNRqUlEdIl6EgmCI3pirjXSMkFk4wTrYKOPLFkqsyuMMk1ccpIrWnuqW+dXT7VeMVmQ6WPX/ovEjHYy2WMJQOE3IZLg/GWl4+EECQykPyL/gyAWsQ/n3syY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765223073; c=relaxed/simple;
	bh=g87A0OaKHVdQ2enbGkLzMyvU2MN/4InI3GPj6mc5GJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UT4je3tqDPYjI4e9xGK8Sx/Rip1k/9rVirItoLmWW4bGSJDxxDIBQ6h/pBVMwBE45Ysg1cfvLyCspLdSczQoV1V9r+mRCNDcWmMeIuLvGpbSHjTQdyV6m9+fOrqrnvcasMzLCb02uGN2NYcsiqZURVPl+UGXhygXVcADsMA4LhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZIn5aJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED83AC4CEF1;
	Mon,  8 Dec 2025 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765223071;
	bh=g87A0OaKHVdQ2enbGkLzMyvU2MN/4InI3GPj6mc5GJo=;
	h=From:To:Cc:Subject:Date:From;
	b=LZIn5aJqiCWxSpUUhgzTsM4DNA+RquFmdVm/Mxb3jrRn7pK/fhJNzzm9qLYptPGCi
	 AtHywoTHsTsPLxdA/7m2VJa//t8x8wf8976iSQ+PApzQEIcln9SoftmYVArLSy/+iA
	 8DMIwa9jJNcSkg5nPGIPhqb5XwUHyVKVT09TmwOZ8zIWEjIWeubUhbLR7HAMvNUhoK
	 5rmR5Qnm9donEhdvA8Y2+uZO9QySOQdPCpLAcgySXYRTQgv+OhVQpTc8WK8XUPswRM
	 ZByqzaj3k7RquRdWyYDSj9UX8uEe8CYC/aVuLgyqqJ+v9ecJH51lysx8QuGdfVwiNC
	 7Q+hQ4u3FE1uQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Thomas Haynes <loghyr@hammerspace.com>
Subject: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
Date: Mon,  8 Dec 2025 14:44:28 -0500
Message-ID: <20251208194428.174229-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In NFSD's pNFS flexfile layout implementation, struct pnfs_ff_layout
defines a struct nfs_fh field. This comes from <linux/nfs.h> :

> /*
>  * This is the kernel NFS client file handle representation
>  */
> #define NFS_MAXFHSIZE           128
> struct nfs_fh {
>         unsigned short          size;
>         unsigned char           data[NFS_MAXFHSIZE];
> };

But NFSD has an equivalent struct, knfsd_fh.

To reduce cross-subsystem header dependencies, avoid using a struct
defined by the kernel's NFS client implementation in NFSD's flexfile
layout implementation.

Cc: Thomas Haynes <loghyr@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/flexfilelayout.c    | 3 +--
 fs/nfsd/flexfilelayoutxdr.c | 4 ++--
 fs/nfsd/flexfilelayoutxdr.h | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 0f1a35400cd5..971368877006 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -61,8 +61,7 @@ nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 	if (error)
 		goto out_error;
 
-	fl->fh.size = fhp->fh_handle.fh_size;
-	memcpy(fl->fh.data, &fhp->fh_handle.fh_raw, fl->fh.size);
+	fh_copy_shallow(&fl->fh, &fhp->fh_handle);
 
 	/* Give whole file layout segments */
 	seg->offset = 0;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index f9f7e38cba13..88686532f03e 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -30,7 +30,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 	struct ff_idmap uid;
 	struct ff_idmap gid;
 
-	fh_len = 4 + fl->fh.size;
+	fh_len = 4 + fl->fh.fh_size;
 
 	uid.len = sprintf(uid.buf, "%u", from_kuid(&init_user_ns, fl->uid));
 	gid.len = sprintf(gid.buf, "%u", from_kgid(&init_user_ns, fl->gid));
@@ -63,7 +63,7 @@ nfsd4_ff_encode_layoutget(struct xdr_stream *xdr,
 				    sizeof(stateid_opaque_t));
 
 	*p++ = cpu_to_be32(1);			/* single file handle */
-	p = xdr_encode_opaque(p, fl->fh.data, fl->fh.size);
+	p = xdr_encode_opaque(p, fl->fh.fh_raw, fl->fh.fh_size);
 
 	p = xdr_encode_opaque(p, uid.buf, uid.len);
 	p = xdr_encode_opaque(p, gid.buf, gid.len);
diff --git a/fs/nfsd/flexfilelayoutxdr.h b/fs/nfsd/flexfilelayoutxdr.h
index 6d5a1066a903..5dee1722834f 100644
--- a/fs/nfsd/flexfilelayoutxdr.h
+++ b/fs/nfsd/flexfilelayoutxdr.h
@@ -39,7 +39,7 @@ struct pnfs_ff_layout {
 	kgid_t				gid;
 	struct nfsd4_deviceid		deviceid;
 	stateid_t			stateid;
-	struct nfs_fh			fh;
+	struct knfsd_fh			fh;
 };
 
 __be32 nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
-- 
2.52.0


