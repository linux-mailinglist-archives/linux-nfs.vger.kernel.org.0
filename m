Return-Path: <linux-nfs+bounces-9867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A9A26A81
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 04:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3E17A3EDC
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5734155759;
	Tue,  4 Feb 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkwJURUI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C714AD20;
	Tue,  4 Feb 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738638225; cv=none; b=LJgwz4cRPVNMymt7w2mJY6FkTYg/ih3JGFP+EH3FWW3saIkWmNjiSY2T/cKm2si1LcR+ycBAacMqDGxqr3Uu3RZCKXIVvxqUZrnKzNJnNZLsUtm3tRirIUbERr59wTXadvTzYiyEnm3bivxN1hSx4gIeoLs0F9vLY6jU5dZctJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738638225; c=relaxed/simple;
	bh=zfB93JeM7MiYyZSDcH+Cv62cIp0qVV5wlF6CFxF1K18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eoHO131zES5aG6T3E0F/N6pqtPPP/vbXLnLugyokXY/qcMdsg6ohz/RVCbjoFNTywGcbvo7d2K9vNEIOMHal7w1/ojXFVRVRlHWpRME5J9C+FY8FEo6/wHAotYXVxbj/t6EPIBOLWDxUfhJxJChvHvflyBfHKV72GndVMxLAF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkwJURUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322B7C4CEE0;
	Tue,  4 Feb 2025 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738638224;
	bh=zfB93JeM7MiYyZSDcH+Cv62cIp0qVV5wlF6CFxF1K18=;
	h=Date:From:To:Cc:Subject:From;
	b=CkwJURUI28A9HkD3AJVyabrekuC939zg3Z/0a4mA95JiCLvxBk3jOwJi8KXYT+4Ge
	 x/pQKjlbJLCMz7nvIiqVEgfxhb1exR/wthN/l6owOa7xG93iyWdbOILNYlEi+YJ27X
	 6QOONtrPNxrETRW5XsvXAOV5dPkygHvqEtSHVU9votsedau7dBYeZEWgj2tOlK6rG5
	 xWDkIy1jP3K/IvtzYaHj/NfjqMlziVLJzDzBdoZn2gJLduCp9sWy/vJUk1wzGmM4uP
	 wHZShmNwGxwdiFf8/ZFKL50Eo0QhFI9RoW06gB9FHXv1wMLLwwfjdrfbKr9AS1RO9M
	 gfKwJnmsYtQBQ==
Date: Tue, 4 Feb 2025 13:33:36 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH][next] fs: nfs: acl: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z6GDiLZo5u4CqxBr@kspp>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of other structs, we use the `struct_group_tagged()` helper
to create a new tagged `struct posix_acl_hdr`. This structure
groups together all the members of the flexible `struct posix_acl`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct posix_acl` to `struct posix_acl_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct posix_acl_hdr` as a
completely separate structure, thus preventing having to maintain two
independent but basically identical structures, closing the door to
potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

So, with these changes, fix the following warning:

fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/nfs_common/nfsacl.c    |  8 +++++---
 include/linux/posix_acl.h | 11 ++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index ea382b75b26c..e2eaac14fd8e 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
 };
 
 struct nfsacl_simple_acl {
-	struct posix_acl acl;
+	struct posix_acl_hdr acl;
 	struct posix_acl_entry ace[4];
 };
 
@@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
 	    xdr_encode_word(buf, base, entries))
 		return -EINVAL;
 	if (encode_entries && acl && acl->a_count == 3) {
-		struct posix_acl *acl2 = &aclbuf.acl;
+		struct posix_acl *acl2 =
+			container_of(&aclbuf.acl, struct posix_acl, hdr);
 
 		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
 		 * invoked in contexts where a memory allocation failure is
@@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
 		return false;
 
 	if (encode_entries && acl && acl->a_count == 3) {
-		struct posix_acl *acl2 = &aclbuf.acl;
+		struct posix_acl *acl2 =
+			container_of(&aclbuf.acl, struct posix_acl, hdr);
 
 		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
 		 * invoked in contexts where a memory allocation failure is
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index e2d47eb1a7f3..62d497763e25 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -27,11 +27,16 @@ struct posix_acl_entry {
 };
 
 struct posix_acl {
-	refcount_t		a_refcount;
-	unsigned int		a_count;
-	struct rcu_head		a_rcu;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(posix_acl_hdr, hdr,
+		refcount_t		a_refcount;
+		unsigned int		a_count;
+		struct rcu_head		a_rcu;
+	);
 	struct posix_acl_entry	a_entries[] __counted_by(a_count);
 };
+static_assert(offsetof(struct posix_acl, a_entries) == sizeof(struct posix_acl_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 #define FOREACH_ACL_ENTRY(pa, acl, pe) \
 	for(pa=(acl)->a_entries, pe=pa+(acl)->a_count; pa<pe; pa++)
-- 
2.43.0


