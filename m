Return-Path: <linux-nfs+bounces-19192-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPgiCjP7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19192-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4018C09D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6BD0306377C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA663ACEE6;
	Tue, 24 Feb 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic4L5g8x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72323ACEF7
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961086; cv=none; b=V59h2IQ7TRzqMjXT7FQQE+iZPjfCZgYW6UmTz2XQwGYHplhz2AlmUowYpqa5P1O4JamKsvtf/h6/bBob0L8KtAtNhjhqPM35ftS/v662BGBXZsxOU8SNlo7LnYCX4gHQf2v/SR+0C/WUHmwJWmKapk9SBt62ITsGk2oGg55G+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961086; c=relaxed/simple;
	bh=2nrYNcvPLK95yLAiLQA3UW4jmWZmQ7g61ijS28jYQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUdpQZsJiSZu6t9HoFzQKaz0mY0C0XZdh9A2wpxJrf3+TN38jr1BOEXqrgIJOx/tR+unLYqbiqRY+FU1TJ9k/zLyKJuimG4Na7z2rHJKWfHPEw6QuyZlECh4mXM+a2yW3YzLXGT/mtinKb+LJSCeXGVvaEQHbV2JGveEQApbrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic4L5g8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E5C19423;
	Tue, 24 Feb 2026 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961086;
	bh=2nrYNcvPLK95yLAiLQA3UW4jmWZmQ7g61ijS28jYQxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ic4L5g8xj1JRt5Qhr+XG8i4W3WsP8tOOFHpUd9b0OZ6gEC9rvoH1vQ5D/H2ZsIDN/
	 4aYquZ0bTK8bwXVRoQPl3PlQw/I+nHNxyGCoOk6O1tVDuMtWavOl4jVeyc48VTf4TO
	 Slnm2bvKmlarhYgJJfeke3nH1eg7ToGrVKxxVZYdmQ0UHX2ilBwmg4kmaahNNrKZq4
	 zG+HquwrhwbmujSJXILzRB5WYIUoARms47n+UV/lw0qx98CfY1tT1f4mhzNn9tyRFe
	 jAoGR552GyC/2IpR+4OpZRRF5fj/vUn8XfruLCXk0eh1GXFrNpcFEyqYbOrOVM6DLq
	 agxWE8YF/OU5w==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 05/11] NFSD: add NFS4 reexport support for SETACL nfs4_acl passthru
Date: Tue, 24 Feb 2026 14:24:32 -0500
Message-ID: <20260224192438.25351-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224192438.25351-1-snitzer@kernel.org>
References: <20260224192438.25351-1-snitzer@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19192-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: A0D4018C09D
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Allow NFSD's 4.1 reexport of a 4.2 mount to perform SETACL by passing
thru nfs4_acl that was decoded from 4.1 client directly to 4.2
client.

Update nfsd4_decode_acl() to save the ACL's payload off to an xdr_buf
in the nfs4_acl. But only do the work to decode that ACL payload into
pages stored in the nfs4_acl, via nfsd4_decode_nfs4_acl_passthru(), if
the exported filesystem supports nfs4_acl passthru (like NFSv4 client
does).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/nfs4proc.c | 27 +++++++++++++++++++++------
 fs/nfsd/nfs4xdr.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/xdr4.h     |  2 ++
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index bd847db8b8b4..d05ac00f934e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1224,6 +1224,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	};
 	bool save_no_wcc, deleg_attrs;
 	struct nfs4_stid *st = NULL;
+	struct dentry *dentry;
 	struct inode *inode;
 	__be32 status = nfs_ok;
 	int err;
@@ -1281,12 +1282,14 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	inode = cstate->current_fh.fh_dentry->d_inode;
-	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
-				   setattr->sa_acl, &attrs);
-
-	if (status)
-		goto out;
+	dentry = cstate->current_fh.fh_dentry;
+	inode = dentry->d_inode;
+	if (IS_POSIXACL(inode)) {
+		status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
+					   setattr->sa_acl, &attrs);
+		if (status)
+			goto out;
+	}
 	save_no_wcc = cstate->current_fh.fh_no_wcc;
 	cstate->current_fh.fh_no_wcc = true;
 	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
@@ -1297,6 +1300,18 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = nfserrno(attrs.na_dpaclerr);
 	if (!status)
 		status = nfserrno(attrs.na_paclerr);
+	if (!status && !IS_POSIXACL(inode) && setattr->sa_acl &&
+	    exportfs_may_passthru_nfs4acl(dentry->d_sb->s_export_op)) {
+		const struct export_operations *ops = dentry->d_sb->s_export_op;
+		if (likely(ops->setacl)) {
+			status = nfsd4_decode_nfs4_acl_passthru(rqstp->rq_argp,
+					setattr->sa_bmval, &setattr->sa_acl);
+			if (status)
+				goto out;
+			status = nfserrno(ops->setacl(inode, setattr->sa_acl));
+		} else
+			status = nfserr_attrnotsupp;
+	}
 out:
 	fh_drop_write(&cstate->current_fh);
 out_err:
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 464c301d6655..62b1d79f80cb 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -287,6 +287,45 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
 	return status == -EBADMSG ? nfserr_bad_xdr : nfs_ok;
 }
 
+__be32 nfsd4_decode_nfs4_acl_passthru(struct nfsd4_compoundargs *argp,
+				      u32 *bmval, struct nfs4_acl **acl)
+{
+	u32 acl_len = (*acl)->payload.len;
+	unsigned int pgbase, num_pages;
+	struct xdr_stream xdr;
+	__be32 status = nfs_ok;
+	void *p;
+
+	xdr_init_decode(&xdr, &(*acl)->payload,
+			(*acl)->payload.head[0].iov_base, NULL);
+
+	p = xdr_inline_decode(&xdr, acl_len);
+	if (p == NULL) {
+		status = nfserr_bad_xdr;
+		goto out;
+	}
+
+	pgbase = (unsigned long)p & ~PAGE_MASK;
+	num_pages = DIV_ROUND_UP(pgbase + acl_len, PAGE_SIZE);
+
+	*acl = svcxdr_tmpalloc(argp, (sizeof(struct nfs4_acl) +
+				      num_pages * sizeof(struct page *)));
+	if (*acl == NULL) {
+		status = nfserr_jukebox;
+		goto out;
+	}
+
+	(*acl)->type = NFS4ACL_ACL;
+	(*acl)->len = acl_len;
+	(*acl)->pgbase = pgbase;
+
+	for (int i = 0; i < num_pages; i++)
+		(*acl)->pages[i] = virt_to_page(p + (i << PAGE_SHIFT));
+out:
+	xdr_finish_decode(&xdr);
+	return status;
+}
+
 static __be32
 nfsd4_decode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqstp,
 		     struct nfs4_ace *ace)
@@ -325,7 +364,7 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
 		 u32 acl_len)
 {
 
-	struct xdr_buf payload;
+	struct xdr_buf payload, saved_payload;
 	struct xdr_stream xdr;
 	struct nfs4_ace *ace;
 	__be32 status = nfs_ok;
@@ -333,6 +372,7 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
 
 	if (!xdr_stream_subsegment(argp->xdr, &payload, acl_len))
 		return nfserr_bad_xdr;
+	memcpy(&saved_payload, &payload, sizeof(struct xdr_buf));
 
 	xdr_init_decode(&xdr, &payload, payload.head[0].iov_base, NULL);
 
@@ -356,6 +396,7 @@ nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
 		status = nfserr_jukebox;
 		goto out;
 	}
+	memcpy(&(*acl)->payload, &saved_payload, sizeof(struct xdr_buf));
 
 	(*acl)->naces = count;
 	for (ace = (*acl)->aces; ace < (*acl)->aces + count; ace++) {
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 417e9ad9fbb3..d3561ce76a12 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -1011,6 +1011,8 @@ extern __be32 nfsd4_test_stateid(struct svc_rqst *rqstp,
 extern __be32 nfsd4_free_stateid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *);
 extern void nfsd4_bump_seqid(struct nfsd4_compound_state *, __be32 nfserr);
+__be32 nfsd4_decode_nfs4_acl_passthru(struct nfsd4_compoundargs *,
+		u32 *bmval, struct nfs4_acl **acl);
 
 enum nfsd4_op_flags {
 	ALLOWED_WITHOUT_FH = 1 << 0,    /* No current filehandle required */
-- 
2.44.0


