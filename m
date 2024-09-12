Return-Path: <linux-nfs+bounces-6423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F2977424
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A51F24E6C
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D0191F64;
	Thu, 12 Sep 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaOlEU77"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2619006A;
	Thu, 12 Sep 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179404; cv=none; b=eLkwdFOSGdshJd5E0P0T4siiAY6r3chhGmiGZywhleXFqVVrohb3hkSktlsSt2erDAglmFPQZAFLc9g2gRNuMXm/8+FPczLWkEjigwBxyTlrQ7V8U8Rx47VORogzYGFcm0jh9OvzPcBqqtG7IWLFg44f2V3qFvMGxTRQDj3ANi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179404; c=relaxed/simple;
	bh=7K5ZA3xyLZ5Zawo8LNXHGDZJZimyusew9fvsxGSDspE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I84MXLvkhC3crOlOUZVVznqgpG291Zqm5Sm4AlchlDox2ewMqjw/qCxJCQGU5jS3m8bsI2rPY9jNoyarhBIcD6e1uY5rjlm6ozQzpIFOEiHFLHnejKkkOVGqU2XjWZDHo7eks4RRG43lriK46kjfE7b6V768LOEogbs+TJqh5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaOlEU77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D58C4CEC3;
	Thu, 12 Sep 2024 22:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726179404;
	bh=7K5ZA3xyLZ5Zawo8LNXHGDZJZimyusew9fvsxGSDspE=;
	h=From:To:Cc:Subject:Date:From;
	b=AaOlEU77PFtzJC83z8RA3F69oqCG8pk/qAbREjMllC/OAH3rK55Oo6Cx/sKsujCMS
	 4vY5b3+QzjPks634HwK0Hn8+YaDSssWektyYzU/1VH3YA0U4dJSe32NyUpydCKBwJR
	 b9mmonUhe7jeKlRr8b6hK7dQE6T4u3s0jtJKA3Ye8A6nrt5ZDZjzfgRkGQU58Thfk0
	 JAtRQdWPsn+Sv+zVIJOKIV7rMHg/HCRRdrOudoz6Z8OQ7rHFtCYJKj4ND9SSye96Jv
	 NzwLcM16cYppuIFhTsFEDCgpOTE7NBsvgKVGZMarT2IRzBQE9GDFGFWKy0QOZiWRXj
	 bGkKp+12e9lBw==
Received: by pali.im (Postfix)
	id E370B5E9; Fri, 13 Sep 2024 00:16:38 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
Date: Fri, 13 Sep 2024 00:15:23 +0200
Message-Id: <20240912221523.23648-1-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the directory restricted deletion flag (sticky bit, SVTX) is not
mapped into NFS4 ACL by knfsd. Which means that the NFS4 ACL client is not
aware of the fact that it cannot delete some files if the sticky bit is set
on the server on parent directory. If the client copies sticky bit
directory recursively to some other storage which implements the NFS4-like
ACL (e.g. to NTFS filesystem or to SMB server) then the directory's
restricted deletion flag is completely lost.

This change aims to improve interoperability of the POSIX directory
restricted deletion flag (sticky bit, SVTX) and NFS4 ACL structure in
knfsd. It transparently maps POSIX directory's sticky bit into NFS4 ACL
and vice-versa similarly like it already maps POSIX ACL into NFS4 ACL.
It covers NFS4 GETATTR ACL, NFS4 SETATTR ACL, NFS4 CREATE+OPEN operations.
When creating a new object over NFS4, it is possible to optionally specify
NFS4 ACL, so this is covered too.

For client SETATTR ACL, CREATE with ACL and OPEN-create with ACL
operations, detection pattern for restricted deletion flag is ACE entry
INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE together with check that
nobody except the OWNER@ has DELETE_CHILD permission. Note that the OWNER@
does not have to have DELETE_CHILD permission in case it does not have
write access to directory.

For client GETATTR ACL operation, when restricted deletion flag is present
in inode, following ACE entries are prepended before any other ACEs:

  ALLOW OWNER@ DELETE_CHILD                                 (1)
  DENY EVERYONE@ DELETE_CHILD
  INHERIT_ONLY NO_PROPAGATE DENY user_owner_of_dir DELETE   (3)
  INHERIT_ONLY NO_PROPAGATE DENY OWNER@ DELETE              (4)
  INHERIT_ONLY NO_PROPAGATE DENY user1 DELETE               (ACL user1)
  ...
  INHERIT_ONLY NO_PROPAGATE DENY userN DELETE               (ACL userN)
  INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE

ACE entry (1) is present only when user OWNER@ has write access (can modify
directory, including removing child entries), because it is possible to
have sticky bit set also on read-only directory.

ACE entry (3) is present only when user OWNER@ does not have write access
(cannot modify directory) and it is required to override effect of the last
ACE entry which allows child entry OWNER@ to remove entry itself. This is
needed for example for POSIX mode 1577.

ACE entry (4) is present only when anybody else except the directory owner
has no write access to the directory. This is the case when sticky bit is
set but nobody can use it because of missing directory write access. So
this explicit DENY covers this edge case.

ACE entries (ACL user1...userN) are for POSIX users which do not have write
access to directory and therefore they cannot remove directory entries
which they own. This is again needed for overriding the effect of the last
ACE entry.

When restricted deletion flag is not present then nothing is added.

This is probably the best approximation of the directory restricted
deletion flag. It covers directory's OWNER@ grant access, child OWNER@
grant access and also restrictions for all other users. It also covers the
situation when OWNER@ or some POSIX user does not have write access to the
directory, and also covers situation when nobody except directory owner has
write access to the directory.

What this does not cover is the restriction when some POSIX group does not
have directory write access, and another POSIX group has directory write
access. This is probably not possible to express in NFS4 ACL language
without ability to evaluate if user is member of some group or not. NFS4
ACL in this case says for the owner of the file that the delete operation
is allowed.

The whole change is only about the mapping of the sticky bit into NFS4 ACL
and only for NFS4 GET and SET ACL operations. It does not change any access
permission checks.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/nfsd/acl.h      |   2 +-
 fs/nfsd/nfs4acl.c  | 242 ++++++++++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfs4proc.c |  31 +++++-
 3 files changed, 255 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 4b7324458a94..e7e7909bf03a 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -48,6 +48,6 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
 int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct nfs4_acl **acl);
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
-			 struct nfsd_attrs *attr);
+			 struct nfsd_attrs *attr, int *dir_sticky);
 
 #endif /* LINUX_NFS4_ACL_H */
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 96e786b5e544..6a53772c2a13 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -46,6 +46,7 @@
 #define NFS4_ACL_TYPE_DEFAULT	0x01
 #define NFS4_ACL_DIR		0x02
 #define NFS4_ACL_OWNER		0x04
+#define NFS4_ACL_DIR_STICKY	0x08
 
 /* mode bit translations: */
 #define NFS4_READ_MODE (NFS4_ACE_READ_DATA)
@@ -73,7 +74,7 @@ mask_from_posix(unsigned short perm, unsigned int flags)
 		mask |= NFS4_READ_MODE;
 	if (perm & ACL_WRITE)
 		mask |= NFS4_WRITE_MODE;
-	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR))
+	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR) && !(flags & NFS4_ACL_DIR_STICKY))
 		mask |= NFS4_ACE_DELETE_CHILD;
 	if (perm & ACL_EXECUTE)
 		mask |= NFS4_EXECUTE_MODE;
@@ -89,7 +90,7 @@ deny_mask_from_posix(unsigned short perm, u32 flags)
 		mask |= NFS4_READ_MODE;
 	if (perm & ACL_WRITE)
 		mask |= NFS4_WRITE_MODE;
-	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR))
+	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR) && !(flags & NFS4_ACL_DIR_STICKY))
 		mask |= NFS4_ACE_DELETE_CHILD;
 	if (perm & ACL_EXECUTE)
 		mask |= NFS4_EXECUTE_MODE;
@@ -110,7 +111,7 @@ low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
 {
 	u32 write_mode = NFS4_WRITE_MODE;
 
-	if (flags & NFS4_ACL_DIR)
+	if ((flags & NFS4_ACL_DIR) && !(flags | NFS4_ACL_DIR_STICKY))
 		write_mode |= NFS4_ACE_DELETE_CHILD;
 	*mode = 0;
 	if ((perm & NFS4_READ_MODE) == NFS4_READ_MODE)
@@ -123,7 +124,7 @@ low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
 
 static short ace2type(struct nfs4_ace *);
 static void _posix_to_nfsv4_one(struct posix_acl *, struct nfs4_acl *,
-				unsigned int);
+				unsigned int, kuid_t);
 
 int
 nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
@@ -142,8 +143,11 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 	if (IS_ERR(pacl))
 		return PTR_ERR(pacl);
 
-	/* allocate for worst case: one (deny, allow) pair each: */
-	size += 2 * pacl->a_count;
+	/*
+	 * allocate for worst case: one (deny, allow) pair for each
+	 * plus for restricted deletion flag (sticky bit): 4 + one for each
+	 */
+	size += 2 * pacl->a_count + (4 + pacl->a_count);
 
 	if (S_ISDIR(inode->i_mode)) {
 		flags = NFS4_ACL_DIR;
@@ -155,6 +159,10 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 
 		if (dpacl)
 			size += 2 * dpacl->a_count;
+
+		/* propagate restricted deletion flag (sticky bit) */
+		if (inode->i_mode & S_ISVTX)
+			flags |= NFS4_ACL_DIR_STICKY;
 	}
 
 	*acl = kmalloc(nfs4_acl_bytes(size), GFP_KERNEL);
@@ -164,10 +172,10 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 	}
 	(*acl)->naces = 0;
 
-	_posix_to_nfsv4_one(pacl, *acl, flags & ~NFS4_ACL_TYPE_DEFAULT);
+	_posix_to_nfsv4_one(pacl, *acl, flags & ~NFS4_ACL_TYPE_DEFAULT, inode->i_uid);
 
 	if (dpacl)
-		_posix_to_nfsv4_one(dpacl, *acl, flags | NFS4_ACL_TYPE_DEFAULT);
+		_posix_to_nfsv4_one(dpacl, *acl, (flags | NFS4_ACL_TYPE_DEFAULT) & ~NFS4_ACL_DIR_STICKY, inode->i_uid);
 
 out:
 	posix_acl_release(dpacl);
@@ -231,7 +239,7 @@ summarize_posix_acl(struct posix_acl *acl, struct posix_acl_summary *pas)
 /* We assume the acl has been verified with posix_acl_valid. */
 static void
 _posix_to_nfsv4_one(struct posix_acl *pacl, struct nfs4_acl *acl,
-						unsigned int flags)
+		    unsigned int flags, kuid_t owner_uid)
 {
 	struct posix_acl_entry *pa, *group_owner_entry;
 	struct nfs4_ace *ace;
@@ -243,9 +251,149 @@ _posix_to_nfsv4_one(struct posix_acl *pacl, struct nfs4_acl *acl,
 	BUG_ON(pacl->a_count < 3);
 	summarize_posix_acl(pacl, &pas);
 
-	pa = pacl->a_entries;
 	ace = acl->aces + acl->naces;
 
+	/*
+	 * Translate restricted deletion flag (sticky bit, SVTX) set on the
+	 * directory to following NFS4 ACEs prepended before any other ACEs:
+	 *
+	 *   ALLOW OWNER@ DELETE_CHILD                                 (1)
+	 *   DENY EVERYONE@ DELETE_CHILD
+	 *   INHERIT_ONLY NO_PROPAGATE DENY user_owner_of_dir DELETE   (3)
+	 *   INHERIT_ONLY NO_PROPAGATE DENY OWNER@ DELETE              (4)
+	 *   INHERIT_ONLY NO_PROPAGATE DENY user1 DELETE               (ACL user1)
+	 *   ...
+	 *   INHERIT_ONLY NO_PROPAGATE DENY userN DELETE               (ACL userN)
+	 *   INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE
+	 *
+	 *   (1) - only if user-owner has write access
+	 *   (3) - only if user-owner does not have write access
+	 *   (4) - only if non-user-owner does not have write access
+	 *   (ACL user1) - only if user1 does not have write access
+	 *   (ACL userN) - only if userN does not have write access
+	 *
+	 * These ACEs describe behavior of set restricted deletion flag (sticky
+	 * bit) on directory as they allow only owner of individual child entries
+	 * and owner of the directory to delete individual child entries.
+	 * Everyone else is denied to remove child entries in this directory.
+	 *
+	 * For deleting entry in NFS4 ACL model it is needed either DELETE_CHILD
+	 * permission (access mask) from the parent directory or DELETE permission
+	 * (access mask) on the child. Just one of these two permissions is enough.
+	 * So if there is explicit DENY DELETE_CHILD on the parent together with
+	 * explicit ALLOW DELETE on the child, it means that deleting is allowed
+	 * (evaluation of permissions is independent in NFS4 ACL model). OWNER@
+	 * for inherited ACEs means owner of the child entry and not the owner
+	 * of the parent from which was ACE inherited.
+	 *
+	 * This translation is imperfect just for a case when some group
+	 * (including group-owner and others-group) does not have write access
+	 * to directory. Handled is only the edge case (via rule 4) when
+	 * everyone else except owner has no write access to the directory.
+	 * This information is not present in NFS4 ACL because it looks like that
+	 * this is not possible to express in this ACL model. So for ACL consumer
+	 * it could look like that owner of the file can delete its own file even
+	 * when group or other mode bits of the directory do not allow it.
+	 */
+	if (flags & NFS4_ACL_DIR_STICKY) {
+		/*
+		 * Explicitly allow directory owner to delete child entries
+		 * if directory owner has write access
+		 */
+		if (pas.owner & ACL_WRITE) {
+			ace->type = NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE;
+			ace->flag = 0;
+			ace->access_mask = NFS4_ACE_DELETE_CHILD;
+			ace->whotype = NFS4_ACL_WHO_OWNER;
+			ace++;
+			acl->naces++;
+		}
+
+		/*
+		 * And then deny deleting child entries for all other users
+		 * which do not have explicit DELETE permission granted by
+		 * last rule in this section.
+		 */
+		ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
+		ace->flag = 0;
+		ace->access_mask = NFS4_ACE_DELETE_CHILD;
+		ace->whotype = NFS4_ACL_WHO_EVERYONE;
+		ace++;
+		acl->naces++;
+
+		/*
+		 * Do not grant directory owner to delete child entries (by the
+		 * last rule in this section) if it does not have write access.
+		 */
+		if (!(pas.owner & ACL_WRITE)) {
+			ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
+			ace->flag = NFS4_INHERITANCE_FLAGS |
+				    NFS4_ACE_INHERIT_ONLY_ACE |
+				    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
+			ace->access_mask = NFS4_ACE_DELETE;
+			ace->whotype = NFS4_ACL_WHO_NAMED;
+			ace->who_uid = owner_uid;
+			ace++;
+			acl->naces++;
+		}
+
+		if (!(pas.users & ACL_WRITE) && !(pas.group & ACL_WRITE) &&
+		    !(pas.groups & ACL_WRITE) && !(pas.other & ACL_WRITE)) {
+			/*
+			 * Do not grant child owner who is not directory owner
+			 * (handled by the first rule in this section) to
+			 * delete own child entries if there is no possible
+			 * directory write permission (checked for named users,
+			 * group-owner, named groups and others-groups).
+			 * This handles special edge case when only directory
+			 * owner has write access to directory.
+			 */
+			ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
+			ace->flag = NFS4_INHERITANCE_FLAGS |
+				    NFS4_ACE_INHERIT_ONLY_ACE |
+				    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
+			ace->access_mask = NFS4_ACE_DELETE;
+			ace->whotype = NFS4_ACL_WHO_OWNER;
+			ace++;
+			acl->naces++;
+		} else {
+			/*
+			 * Do not grant individual named users to delete child
+			 * entries (by the last rule in this section) if user
+			 * does not have write access to directory.
+			 */
+			for (pa = pacl->a_entries + 1; pa->e_tag == ACL_USER; pa++) {
+				if (pa->e_perm & pas.mask & ACL_WRITE)
+					continue;
+				ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
+				ace->flag = NFS4_INHERITANCE_FLAGS |
+					    NFS4_ACE_INHERIT_ONLY_ACE |
+					    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
+				ace->access_mask = NFS4_ACE_DELETE;
+				ace->whotype = NFS4_ACL_WHO_NAMED;
+				ace->who_uid = pa->e_uid;
+				ace++;
+				acl->naces++;
+			}
+		}
+
+		/*
+		 * Above rules filtered out users which do not have write access
+		 * to the directory. Now allow child-owner to delete its own
+		 * directory entries.
+		 */
+		ace->type = NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE;
+		ace->flag = NFS4_INHERITANCE_FLAGS |
+			    NFS4_ACE_INHERIT_ONLY_ACE |
+			    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
+		ace->access_mask = NFS4_ACE_DELETE;
+		ace->whotype = NFS4_ACL_WHO_OWNER;
+		ace++;
+		acl->naces++;
+	}
+
+	pa = pacl->a_entries;
+
 	/* We could deny everything not granted by the owner: */
 	deny = ~pas.owner;
 	/*
@@ -517,7 +665,8 @@ posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
 
 	pace = pacl->a_entries;
 	pace->e_tag = ACL_USER_OBJ;
-	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags);
+	/* owner is never affected by restricted deletion flag, so clear NFS4_ACL_DIR_STICKY */
+	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags & ~NFS4_ACL_DIR_STICKY);
 
 	for (i=0; i < state->users->n; i++) {
 		pace++;
@@ -691,9 +840,14 @@ static void process_one_v4_ace(struct posix_acl_state *state,
 
 static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 		struct posix_acl **pacl, struct posix_acl **dpacl,
+		int *dir_sticky,
 		unsigned int flags)
 {
 	struct posix_acl_state effective_acl_state, default_acl_state;
+	bool dir_allow_nonowner_delete_child = false;
+	bool dir_deny_everyone_delete_child = false;
+	bool dir_allow_child_owner_delete = false;
+	unsigned int eflags = 0;
 	struct nfs4_ace *ace;
 	int ret;
 
@@ -705,6 +859,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 		goto out_estate;
 	ret = -EINVAL;
 	for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
+		/*
+		 * Process and parse ACE entry INHERIT_ONLY NO_PROPAGATE DELETE
+		 * for detecting restricted deletion flag (sticky bit). Allow
+		 * SYNCHRONIZE access mask to be present as NFS4 clients can
+		 * include this access mask together with any other one.
+		 *
+		 * It needs to be done before validation as NFS4_SUPPORTED_FLAGS
+		 * does not contain NFS4_ACE_NO_PROPAGATE_INHERIT_ACE and this
+		 * ACE must not throw error.
+		 */
+		if ((flags & NFS4_ACL_DIR) &&
+		    !(ace->flag & ~(NFS4_SUPPORTED_FLAGS|NFS4_ACE_NO_PROPAGATE_INHERIT_ACE)) &&
+		    (ace->flag & NFS4_INHERITANCE_FLAGS) &&
+		    (ace->flag & NFS4_ACE_INHERIT_ONLY_ACE) &&
+		    (ace->flag & NFS4_ACE_NO_PROPAGATE_INHERIT_ACE) &&
+		    (ace->access_mask & ~NFS4_ACE_SYNCHRONIZE) == NFS4_ACE_DELETE) {
+			if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
+			    ace->whotype == NFS4_ACL_WHO_OWNER)
+				dir_allow_child_owner_delete = true;
+			continue;
+		}
+
 		if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
 		    ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
 			goto out_dstate;
@@ -725,6 +901,38 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 
 		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
 			process_one_v4_ace(&effective_acl_state, ace);
+
+		/*
+		 * Process and parse ACE entry with DELETE_CHILD access mask
+		 * for detecting restricted deletion flag (sticky bit).
+		 */
+		if ((flags & NFS4_ACL_DIR) &&
+		    !(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE) &&
+		    (ace->access_mask & NFS4_ACE_DELETE_CHILD)) {
+			if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
+			    !dir_deny_everyone_delete_child &&
+			    ace->whotype != NFS4_ACL_WHO_OWNER)
+				dir_allow_nonowner_delete_child = true;
+			else if (ace->type == NFS4_ACE_ACCESS_DENIED_ACE_TYPE &&
+				 ace->whotype == NFS4_ACL_WHO_EVERYONE)
+				dir_deny_everyone_delete_child = true;
+		}
+	}
+
+	/*
+	 * Recognize restricted deletion flag (sticky bit) from directory ACL
+	 * if ACEs on directory allow only owner of directory child entry to
+	 * delete entry itself.
+	 *
+	 * This is relaxed check for rules generated by _posix_to_nfsv4_one().
+	 * Relaxed check of restricted deletion flag is for security reasons
+	 * and means that permissions would be more stricter, to prevent
+	 * granting more access than what was specified in NFS4 ACL packet.
+	 */
+	if (flags & NFS4_ACL_DIR) {
+		*dir_sticky = !dir_allow_nonowner_delete_child && dir_allow_child_owner_delete;
+		if (*dir_sticky)
+			eflags |= NFS4_ACL_DIR_STICKY;
 	}
 
 	/*
@@ -750,7 +958,7 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 			default_acl_state.other = effective_acl_state.other;
 	}
 
-	*pacl = posix_state_to_acl(&effective_acl_state, flags);
+	*pacl = posix_state_to_acl(&effective_acl_state, flags | eflags);
 	if (IS_ERR(*pacl)) {
 		ret = PTR_ERR(*pacl);
 		*pacl = NULL;
@@ -776,19 +984,23 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
 }
 
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
-			 struct nfsd_attrs *attr)
+			 struct nfsd_attrs *attr, int *dir_sticky)
 {
 	int host_error;
 	unsigned int flags = 0;
 
-	if (!acl)
+	if (!acl) {
+		if (type == NF4DIR)
+			*dir_sticky = -1;
 		return nfs_ok;
+	}
 
 	if (type == NF4DIR)
 		flags = NFS4_ACL_DIR;
 
 	host_error = nfs4_acl_nfsv4_to_posix(acl, &attr->na_pacl,
-					     &attr->na_dpacl, flags);
+					     &attr->na_dpacl, dir_sticky,
+					     flags);
 	if (host_error == -EINVAL)
 		return nfserr_attrnotsupp;
 	else
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0f67f4a7b8b2..56aeb745d108 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -259,7 +259,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return nfserrno(host_err);
 
 	if (is_create_with_attrs(open))
-		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs, NULL);
 
 	inode_lock_nested(inode, I_MUTEX_PARENT);
 
@@ -791,6 +791,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	struct svc_fh resfh;
 	__be32 status;
+	int dir_sticky;
 	dev_t rdev;
 
 	fh_init(&resfh, NFS4_FHSIZE);
@@ -804,7 +805,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
-	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
+	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs, &dir_sticky);
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
@@ -848,6 +849,11 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		break;
 
 	case NF4DIR:
+		if (dir_sticky == 1) {
+			/* Set directory sticky bit deduced from the ACL attr. */
+			create->cr_iattr.ia_valid |= ATTR_MODE;
+			create->cr_iattr.ia_mode |= S_ISVTX;
+		}
 		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
 		status = nfsd_create(rqstp, &cstate->current_fh,
 				     create->cr_name, create->cr_namelen,
@@ -1144,6 +1150,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct inode *inode;
 	__be32 status = nfs_ok;
 	bool save_no_wcc;
+	int dir_sticky;
 	int err;
 
 	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
@@ -1165,10 +1172,26 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	inode = cstate->current_fh.fh_dentry->d_inode;
 	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
-				   setattr->sa_acl, &attrs);
-
+				   setattr->sa_acl, &attrs, &dir_sticky);
 	if (status)
 		goto out;
+
+	if (S_ISDIR(inode->i_mode) && dir_sticky != -1 && !!(inode->i_mode & S_ISVTX) != dir_sticky) {
+		/*
+		 * Set directory sticky bit deduced from the ACL attr.
+		 * Do not clear sticky bit if it was explicitly set in MODE attr
+		 * but was not deduced from ACL attr because clients can send
+		 * both MODE and ACL attrs where sticky bit is only in MODE attr.
+		 */
+		if (!(attrs.na_iattr->ia_valid & ATTR_MODE))
+			attrs.na_iattr->ia_mode = inode->i_mode;
+		if (dir_sticky)
+			attrs.na_iattr->ia_mode |= S_ISVTX;
+		else if (!(attrs.na_iattr->ia_valid & ATTR_MODE))
+			attrs.na_iattr->ia_mode &= ~S_ISVTX;
+		attrs.na_iattr->ia_valid |= ATTR_MODE;
+	}
+
 	save_no_wcc = cstate->current_fh.fh_no_wcc;
 	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
-- 
2.20.1


