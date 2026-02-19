Return-Path: <linux-nfs+bounces-19049-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGpuLUeLl2n/0AIAu9opvQ
	(envelope-from <linux-nfs+bounces-19049-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:31 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C8163114
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 23:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B6E304A6CD
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Feb 2026 22:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08938328B4E;
	Thu, 19 Feb 2026 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoWNLrTC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5661DE3B5
	for <linux-nfs@vger.kernel.org>; Thu, 19 Feb 2026 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539242; cv=none; b=bzWwQCSyuFlDhs9gM4L8NIpfYq7DIts7NEW0DahEQBbb8OsS3KFPpz2F12pvxQvkQDP1UhnVyHww2QlX0kJOCNoQ8SvPvZB6oOUlY0TfDj1zCoBXgLlAroVvmpzIgJE5f3UdvRvxYgs8sdADwRE16vSuj/O88gLIIXgrOg0zUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539242; c=relaxed/simple;
	bh=UJLhG0JhK0Au+vCEbhi4MkvdN0mj4wx+xe/cmz66p1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWEWV1XGP7RN+4G80XBX18V99keNSUyGaTiHmqN9Hrj8Wr9qvGHzeKZ/BuK8/ym6QewHNZA3IFU6n+UdTd4xJ4dJUMnfQ3qqgC0NdTSkVEkF9MMQVvrBcRM8+9xZDpFRzuxGFveNDFN03LoVd4Z/gfMb/IIA3k5bpJUQ3/abGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoWNLrTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20675C2BCB0;
	Thu, 19 Feb 2026 22:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539242;
	bh=UJLhG0JhK0Au+vCEbhi4MkvdN0mj4wx+xe/cmz66p1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoWNLrTCxAnFFC8L17kQrYBjIBAecQEpaAZGIt4aAaj9ATQC0SMAy5tLZ5WXfIrXh
	 wTuBpB3674OF/w/FS3Vb9p5frZNgWZYfY7PYEGugrmS2VlGQzawcWmxVKiJDKjNwRr
	 ge0rB2+irSfw/Dqgk7+gavgM447EE4N1BPewlSWiWaVWw9mjGmfo9QA3eApTQFFB7s
	 akAQeUAeaHCt1kdx/GrBrXjvlx2k/ZdmfUCSrMN9IeDTPCnq2NcoiUBlkcd/Ubm1Yw
	 xTkwn5m/jiRSjPHetVe1zo5KkpLmOkOgoUp1c2/9LCzfvmvASojbatBwVfzo83akHv
	 EfXy6bEwezD2w==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 06/11] NFSD: add NFS4 reexport support for GETACL nfs4_acl passthru
Date: Thu, 19 Feb 2026 17:13:47 -0500
Message-ID: <20260219221352.40554-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260219221352.40554-1-snitzer@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19049-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:email]
X-Rspamd-Queue-Id: 226C8163114
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Allow NFSD's 4.1 reexport of a 4.2 mount to perform GETACL by passing
thru nfs4_acl whose pages are allocated in nfsd4_get_nfs4_acl_passthru
and then passed down to exported filesystem's ops->getacl(). Once
nfs4_acl is retrieved nfsd4_encode_fattr4_acl() will send the
ACL payload to the client using nfsd4_encode_nfs4_acl_passthru().

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/acl.h     |  3 ++-
 fs/nfsd/nfs4acl.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfs4xdr.c | 33 ++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 699a3b19bdb8..488be04551e4 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -42,13 +42,14 @@ struct svc_fh;
 struct svc_rqst;
 struct nfsd_attrs;
 enum nfs_ftype4;
+enum nfs4_acl_type;
 
 int nfs4_acl_bytes(int entries);
 int nfs4_acl_get_whotype(char *, u32);
 __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
 
 int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
-		struct nfs4_acl **acl);
+		enum nfs4_acl_type acl_type, struct nfs4_acl **acl);
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
 			 struct nfsd_attrs *attr);
 void sort_pacl_range(struct posix_acl *pacl, int start, int end);
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 2c2f2fd89e87..2d494909e63a 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -37,6 +37,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/posix_acl.h>
+#include <linux/nfsacl.h>
 
 #include "nfsfh.h"
 #include "nfsd.h"
@@ -125,9 +126,62 @@ static short ace2type(struct nfs4_ace *);
 static void _posix_to_nfsv4_one(struct posix_acl *, struct nfs4_acl *,
 				unsigned int);
 
+static int
+nfsd4_get_nfs4_acl_passthru(struct inode *inode,
+			    const struct export_operations *ops,
+			    enum nfs4_acl_type acl_type,
+			    u32 acl_len, struct nfs4_acl **acl)
+{
+	int error = 0;
+	int i = 0;
+	unsigned int npages;
+
+	npages = DIV_ROUND_UP(acl_len, PAGE_SIZE);
+	*acl = kmalloc(sizeof(struct nfs4_acl) +
+		       npages * sizeof(struct page *), GFP_KERNEL);
+	if (*acl == NULL)
+		return -ENOMEM;
+
+	(*acl)->type = acl_type;
+	(*acl)->len = acl_len = npages * PAGE_SIZE;
+	(*acl)->pgbase = 0;
+
+	for (; i < npages; i++) {
+		(*acl)->pages[i] = alloc_page(GFP_KERNEL);
+		if (!(*acl)->pages[i]) {
+			error = -ENOMEM;
+			goto out;
+		}
+	}
+
+	if (unlikely(!ops->getacl)) {
+		error = -EOPNOTSUPP;
+		goto out;
+	}
+
+	error = ops->getacl(inode, *acl);
+	if (likely(error > 0)) {
+		error = 0; /* don't error out below */
+		if ((*acl)->len < acl_len) {
+			/* free any unused pages */
+			npages = DIV_ROUND_UP((*acl)->len, PAGE_SIZE);
+			while (--i >= npages)
+				__free_page((*acl)->pages[i]);
+		}
+	}
+out:
+	if (error) {
+		while (--i >= 0)
+			__free_page((*acl)->pages[i]);
+		kfree(*acl);
+		*acl = NULL;
+	}
+	return error;
+}
+
 int
 nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
-		struct nfs4_acl **acl)
+		   enum nfs4_acl_type acl_type, struct nfs4_acl **acl)
 {
 	struct inode *inode = d_inode(dentry);
 	int error = 0;
@@ -157,6 +211,19 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 			size += 2 * dpacl->a_count;
 	}
 
+	if (!IS_POSIXACL(inode) &&
+	    exportfs_may_passthru_nfs4acl(dentry->d_sb->s_export_op)) {
+		/* Ensure NFSv4 ACL has adequate space based on POSIX ACL size */
+		u32 acl_len = min_t(u32, svc_max_payload(rqstp),
+				    (2 * nfs4_acl_bytes(size) -
+				     2 * sizeof(struct nfs4_acl)));
+		const struct export_operations *ops = dentry->d_sb->s_export_op;
+
+		error = nfsd4_get_nfs4_acl_passthru(inode, ops, acl_type,
+						    acl_len, acl);
+		goto out;
+	}
+
 	*acl = kmalloc(nfs4_acl_bytes(size), GFP_KERNEL);
 	if (*acl == NULL) {
 		error = -ENOMEM;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index f14c2fb45142..01d362a486f8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3391,6 +3391,33 @@ static __be32 nfsd4_encode_fattr4_aclsupport(struct xdr_stream *xdr,
 	return nfsd4_encode_uint32_t(xdr, mask);
 }
 
+static __be32 nfsd4_encode_nfs4_acl_passthru(struct xdr_stream *xdr,
+					     struct nfs4_acl *acl)
+{
+	uint32_t pgbase = acl->pgbase;
+	uint32_t remaining = acl->len;
+	unsigned int npages = DIV_ROUND_UP(remaining, PAGE_SIZE);
+
+	for (int i = 0; i < npages; i++) {
+		void *vaddr = page_address(acl->pages[i]);
+		size_t len = (remaining < PAGE_SIZE) ? remaining : PAGE_SIZE;
+
+		if (pgbase) {
+			vaddr += pgbase;
+			pgbase = 0;
+		}
+		WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, vaddr, len) < 0);
+		remaining -= len;
+		/*
+		 * Free each page that was allocated using alloc_page()
+		 * in nfsd4_get_nfs4_acl_passthru().
+		 */
+		__free_page(acl->pages[i]);
+	}
+
+	return nfs_ok;
+}
+
 static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 				      const struct nfsd4_fattr_args *args)
 {
@@ -3403,6 +3430,10 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
 			return nfserr_resource;
 	} else {
+		if (!IS_POSIXACL(d_inode(args->dentry)) &&
+		    exportfs_may_passthru_nfs4acl(args->dentry->d_sb->s_export_op))
+			return nfsd4_encode_nfs4_acl_passthru(xdr, acl);
+
 		if (xdr_stream_encode_u32(xdr, acl->naces) != XDR_UNIT)
 			return nfserr_resource;
 		for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
@@ -4029,7 +4060,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = fhp;
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
-		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);
+		err = nfsd4_get_nfs4_acl(rqstp, dentry, NFS4ACL_ACL, &args.acl);
 		if (err == -EOPNOTSUPP)
 			attrmask[0] &= ~FATTR4_WORD0_ACL;
 		else if (err == -EINVAL) {
-- 
2.44.0


