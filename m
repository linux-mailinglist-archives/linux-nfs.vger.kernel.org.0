Return-Path: <linux-nfs+bounces-17704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A75D0B419
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C5B63121050
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6114363C62;
	Fri,  9 Jan 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy4f7mvl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389D316904
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975717; cv=none; b=S/rgW22eaYo28595J0WRAN8+uBHmAoa73ScD9JddjsSEHVNbRYQcahNovQpQHtTci+COD6ZlFF9P3xZsBEkgOVDcalldGnuyhHWE1M8LHJA63co16AlmVuNwDmVTndwOKGDS+tzEow/TA5lmzKgn1wlQwakNeYfKA8Fba7V42eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975717; c=relaxed/simple;
	bh=zNNT/jtTzjX4GE5gBna5HmNp59cKBu+sduUfARetgRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA6sBhTJc1xtK5aFiJZCKXto3DuXYIxabhyWb6tkgYeCu9Yb7AK06HdiNdM2LTdlEXz3l5IXlJlFXd4kAU1el87RQGftz2/Ch3gBykginw7yWJQlttd/OCXMWm87Xn09yYj7K8H+5wNQOG5HyV818WWHdiDMBvMP7PWyJZWyc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy4f7mvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF172C4CEF7;
	Fri,  9 Jan 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975717;
	bh=zNNT/jtTzjX4GE5gBna5HmNp59cKBu+sduUfARetgRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy4f7mvlEW+iHfPDGDGbRBm+th1gowA5QZCCD8jti8KzlcZLmV5zffLRHQUFM09Bp
	 dwC2ZohU1OM6AwSOWiDu2IlVmbAiYVHLBLa3CtU/NRnvw65JuV0GQOM6I0hyiocmj2
	 8zmgk7OeeQdJQAfcxoBzOX3NhYFcmixlwoKuKiXBvoEpSfvyg8ugoerHwX74zZK7Nz
	 LRfs9xdmAIGzg04/E7imhfm2Btboe9REjEDWZAaQrGbc8RtVZCCIG7AAk0/vll3dnG
	 1mPTwmEfq/p+94ZVHsifMS9p2GVvZ7A4J9fffzC9UqOBMhfwbuu0Fy0j87ydlILD16
	 aa3Ii3Pk97++g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v3 10/13] NFSD: Add support for XDR decoding POSIX draft ACLs
Date: Fri,  9 Jan 2026 11:21:39 -0500
Message-ID: <20260109162143.4186112-11-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109162143.4186112-1-cel@kernel.org>
References: <20260109162143.4186112-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The POSIX ACL extension to NFSv4 defines FATTR4_POSIX_ACCESS_ACL
and FATTR4_POSIX_DEFAULT_ACL for setting access and default ACLs
via CREATE, OPEN, and SETATTR operations. This patch adds the XDR
decoders for those attributes.

The nfsd4_decode_fattr4() function gains two additional parameters
for receiving decoded POSIX ACLs. CREATE, OPEN, and SETATTR
decoders pass pointers to these new parameters, enabling clients
to set POSIX ACLs during object creation or modification.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/acl.h     |   1 +
 fs/nfsd/nfs4acl.c |  17 ++++--
 fs/nfsd/nfs4xdr.c | 148 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/xdr4.h    |   6 ++
 4 files changed, 162 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 4b7324458a94..2003523d0e65 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -49,5 +49,6 @@ int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct nfs4_acl **acl);
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
 			 struct nfsd_attrs *attr);
+void sort_pacl_range(struct posix_acl *pacl, int start, int end);
 
 #endif /* LINUX_NFS4_ACL_H */
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 936ea1ad9586..2c2f2fd89e87 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -369,12 +369,21 @@ pace_gt(struct posix_acl_entry *pace1, struct posix_acl_entry *pace2)
 	return false;
 }
 
-static void
-sort_pacl_range(struct posix_acl *pacl, int start, int end) {
+/**
+ * sort_pacl_range - sort a range of POSIX ACL entries by tag and id
+ * @pacl: POSIX ACL containing entries to sort
+ * @start: starting index of range to sort
+ * @end: ending index of range to sort (inclusive)
+ *
+ * Sorts ACL entries in place so that USER entries are ordered by UID
+ * and GROUP entries are ordered by GID. Required before calling
+ * posix_acl_valid().
+ */
+void sort_pacl_range(struct posix_acl *pacl, int start, int end)
+{
 	int sorted = 0, i;
 
-	/* We just do a bubble sort; easy to do in place, and we're not
-	 * expecting acl's to be long enough to justify anything more. */
+	/* Bubble sort: acceptable here because ACLs are typically short. */
 	while (!sorted) {
 		sorted = 1;
 		for (i = start; i < end; i++) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 358fa014be15..5172dbd0cb05 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -378,10 +378,111 @@ nfsd4_decode_security_label(struct nfsd4_compoundargs *argp,
 	return nfs_ok;
 }
 
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+
+static short nfsd4_posixacetag4_to_tag(posixacetag4 tag)
+{
+	switch (tag) {
+	case POSIXACE4_TAG_USER_OBJ:	return ACL_USER_OBJ;
+	case POSIXACE4_TAG_GROUP_OBJ:	return ACL_GROUP_OBJ;
+	case POSIXACE4_TAG_USER:	return ACL_USER;
+	case POSIXACE4_TAG_GROUP:	return ACL_GROUP;
+	case POSIXACE4_TAG_MASK:	return ACL_MASK;
+	case POSIXACE4_TAG_OTHER:	return ACL_OTHER;
+	}
+	return ACL_OTHER;
+}
+
+static __be32
+nfsd4_decode_posixace4(struct nfsd4_compoundargs *argp,
+		       struct posix_acl_entry *ace)
+{
+	posixaceperm4 perm;
+	__be32 *p, status;
+	posixacetag4 tag;
+	u32 len;
+
+	if (!xdrgen_decode_posixacetag4(argp->xdr, &tag))
+		return nfserr_bad_xdr;
+	ace->e_tag = nfsd4_posixacetag4_to_tag(tag);
+
+	if (!xdrgen_decode_posixaceperm4(argp->xdr, &perm))
+		return nfserr_bad_xdr;
+	if (perm & ~S_IRWXO)
+		return nfserr_bad_xdr;
+	ace->e_perm = perm;
+
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, len);
+	if (!p)
+		return nfserr_bad_xdr;
+	switch (tag) {
+	case POSIXACE4_TAG_USER:
+		if (len > 0)
+			status = nfsd_map_name_to_uid(argp->rqstp,
+					(char *)p, len, &ace->e_uid);
+		else
+			status = nfserr_bad_xdr;
+		break;
+	case POSIXACE4_TAG_GROUP:
+		if (len > 0)
+			status = nfsd_map_name_to_gid(argp->rqstp,
+					(char *)p, len, &ace->e_gid);
+		else
+			status = nfserr_bad_xdr;
+		break;
+	default:
+		status = nfs_ok;
+	}
+
+	return status;
+}
+
+static noinline __be32
+nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
+{
+	struct posix_acl_entry *ace;
+	__be32 status;
+	u32 count;
+
+	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+		return nfserr_bad_xdr;
+
+	*acl = posix_acl_alloc(count, GFP_KERNEL);
+	if (*acl == NULL)
+		return nfserr_resource;
+
+	(*acl)->a_count = count;
+	for (ace = (*acl)->a_entries; ace < (*acl)->a_entries + count; ace++) {
+		status = nfsd4_decode_posixace4(argp, ace);
+		if (status) {
+			posix_acl_release(*acl);
+			*acl = NULL;
+			return status;
+		}
+	}
+
+	/*
+	 * posix_acl_valid() requires the ACEs to be sorted.
+	 * If they are already sorted, sort_pacl_range() will return
+	 * after one pass through the ACEs, since it implements bubble sort.
+	 * Note that a count == 0 is used to delete a POSIX ACL and a count
+	 * of 1 or 2 will always be found invalid by posix_acl_valid().
+	 */
+	if (count >= 3)
+		sort_pacl_range(*acl, 0, count - 1);
+
+	return nfs_ok;
+}
+
+#endif /* CONFIG_NFSD_V4_POSIX_ACLS */
+
 static __be32
 nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		    struct iattr *iattr, struct nfs4_acl **acl,
-		    struct xdr_netobj *label, int *umask)
+		    struct xdr_netobj *label, int *umask,
+		    struct posix_acl **dpaclp, struct posix_acl **paclp)
 {
 	unsigned int starting_pos;
 	u32 attrlist4_count;
@@ -544,9 +645,40 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
 
+	*dpaclp = NULL;
+	*paclp = NULL;
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+	if (bmval[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) {
+		struct posix_acl *dpacl;
+
+		status = nfsd4_decode_posixacl(argp, &dpacl);
+		if (status)
+			return status;
+		*dpaclp = dpacl;
+	}
+	if (bmval[2] & FATTR4_WORD2_POSIX_ACCESS_ACL) {
+		struct posix_acl *pacl;
+
+		status = nfsd4_decode_posixacl(argp, &pacl);
+		if (status) {
+			posix_acl_release(*dpaclp);
+			*dpaclp = NULL;
+			return status;
+		}
+		*paclp = pacl;
+	}
+#endif /* CONFIG_NFSD_V4_POSIX_ACLS */
+
 	/* request sanity: did attrlist4 contain the expected number of words? */
-	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos)
+	if (attrlist4_count != xdr_stream_pos(argp->xdr) - starting_pos) {
+#ifdef CONFIG_NFSD_V4_POSIX_ACLS
+		posix_acl_release(*dpaclp);
+		posix_acl_release(*paclp);
+		*dpaclp = NULL;
+		*paclp = NULL;
+#endif
 		return nfserr_bad_xdr;
+	}
 
 	return nfs_ok;
 }
@@ -850,7 +982,8 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	status = nfsd4_decode_fattr4(argp, create->cr_bmval,
 				    ARRAY_SIZE(create->cr_bmval),
 				    &create->cr_iattr, &create->cr_acl,
-				    &create->cr_label, &create->cr_umask);
+				    &create->cr_label, &create->cr_umask,
+				    &create->cr_dpacl, &create->cr_pacl);
 	if (status)
 		return status;
 
@@ -1001,7 +1134,8 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 		status = nfsd4_decode_fattr4(argp, open->op_bmval,
 					     ARRAY_SIZE(open->op_bmval),
 					     &open->op_iattr, &open->op_acl,
-					     &open->op_label, &open->op_umask);
+					     &open->op_label, &open->op_umask,
+					     &open->op_dpacl, &open->op_pacl);
 		if (status)
 			return status;
 		break;
@@ -1019,7 +1153,8 @@ nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open
 		status = nfsd4_decode_fattr4(argp, open->op_bmval,
 					     ARRAY_SIZE(open->op_bmval),
 					     &open->op_iattr, &open->op_acl,
-					     &open->op_label, &open->op_umask);
+					     &open->op_label, &open->op_umask,
+					     &open->op_dpacl, &open->op_pacl);
 		if (status)
 			return status;
 		break;
@@ -1346,7 +1481,8 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	return nfsd4_decode_fattr4(argp, setattr->sa_bmval,
 				   ARRAY_SIZE(setattr->sa_bmval),
 				   &setattr->sa_iattr, &setattr->sa_acl,
-				   &setattr->sa_label, NULL);
+				   &setattr->sa_label, NULL, &setattr->sa_dpacl,
+				   &setattr->sa_pacl);
 }
 
 static __be32
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 1be2814b5288..417e9ad9fbb3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -245,6 +245,8 @@ struct nfsd4_create {
 	int		cr_umask;           /* request */
 	struct nfsd4_change_info  cr_cinfo; /* response */
 	struct nfs4_acl *cr_acl;
+	struct posix_acl *cr_dpacl;
+	struct posix_acl *cr_pacl;
 	struct xdr_netobj cr_label;
 };
 #define cr_datalen	u.link.datalen
@@ -397,6 +399,8 @@ struct nfsd4_open {
 	struct nfs4_ol_stateid *op_stp;	    /* used during processing */
 	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
 	struct nfs4_acl *op_acl;
+	struct posix_acl *op_dpacl;
+	struct posix_acl *op_pacl;
 	struct xdr_netobj op_label;
 	struct svc_rqst *op_rqstp;
 };
@@ -483,6 +487,8 @@ struct nfsd4_setattr {
 	struct iattr	sa_iattr;           /* request */
 	struct nfs4_acl *sa_acl;
 	struct xdr_netobj sa_label;
+	struct posix_acl *sa_dpacl;
+	struct posix_acl *sa_pacl;
 };
 
 struct nfsd4_setclientid {
-- 
2.52.0


