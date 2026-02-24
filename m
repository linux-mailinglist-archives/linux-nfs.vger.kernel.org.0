Return-Path: <linux-nfs+bounces-19191-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PGwLSP7nWmeSwQAu9opvQ
	(envelope-from <linux-nfs+bounces-19191-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72118C095
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B60BA30ED50B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA63ACA7B;
	Tue, 24 Feb 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqBNKwlv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931903ACA75
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961085; cv=none; b=eFRd/2o2E063ZQJyeA8mBEUoa37qbQ6KRJm1pcDvddY0r70OjBLijud5vgDFIbzNVieiK+5u2aQhzNpwLaxpWe6nmShQvBsVmMIQxF44NAkwfWlaScwzx2g4uubjwpqLKJ7V46dhp84uw7VTKdxJPkmlqu0od0EwUXBHHgHuS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961085; c=relaxed/simple;
	bh=gcG4eaYUR3LXyAEZNS4vMikEVnrbLPhffb+RnSAm0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUyVkYU2QIgpIwr38FEGeBO6fHyNA5VnRrEVq7Nf1AFAEQDVr6X4SSBNslfo1D9HxJ0NlsqEpcnWYF1GxVQl1FHN+YhHrcLpZ/THaTOpTQqxGSNVtNCIN/yoyKJ75+kNMi+zxNRF+76eATUA/qB2sDVJoCSMdwIx21e+STZq3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqBNKwlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5676C19422;
	Tue, 24 Feb 2026 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961085;
	bh=gcG4eaYUR3LXyAEZNS4vMikEVnrbLPhffb+RnSAm0BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqBNKwlvWI7NM1WlKBZi36vW8Z7jhf8ReFEXkJvb5A1+qJDeXZAXenKQjoH0iJlhO
	 QNRkCEVflxjM0lX+Ltd7LDLd0896+y/ZgI7Thcva4Bj5wUi01zfyyrP3ihYsQ0hH9v
	 2AvAiyMUE9Vqah3YQ50UEvWabIhcANlzEuU4WPUGIds7xzb4BcIMchfkE9hNGZN3UA
	 gUBRb4WZZlSNf2KOLHJCZWyPgF0xwv+uT8DWZzukVWvGqrT+32ko9mihE3YLvtC3+t
	 zg19F8wMkbvYL9/2vYJf+qM/yfKO4ZykZeIynBgdDZfKLnNi0JMPBw8Uxw2kA25GoN
	 YJM6SJQRf6ClQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 04/11] NFSD: prepare to support SETACL nfs4_acl passthru
Date: Tue, 24 Feb 2026 14:24:31 -0500
Message-ID: <20260224192438.25351-5-snitzer@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19191-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 1C72118C095
X-Rspamd-Action: no action

From: Mike Snitzer <snitzer@hammerspace.com>

Use a separate xdr_buf and xdr_stream in both nfsd4_decode_acl() and
nfsd4_decode_nfsace4().

This prepares for nfsd4_decode_acl() to save off the xdr_buf
associated with the ACL payload so that deferred decode is possible
when nfs4_acl passthru is needed (in next commit).

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/nfs4xdr.c | 57 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e7793c53d214..464c301d6655 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -288,31 +288,32 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
 }
 
 static __be32
-nfsd4_decode_nfsace4(struct nfsd4_compoundargs *argp, struct nfs4_ace *ace)
+nfsd4_decode_nfsace4(struct xdr_stream *xdr, struct svc_rqst *rqstp,
+		     struct nfs4_ace *ace)
 {
 	__be32 *p, status;
 	u32 length;
 
-	if (xdr_stream_decode_u32(argp->xdr, &ace->type) < 0)
+	if (xdr_stream_decode_u32(xdr, &ace->type) < 0)
 		return nfserr_bad_xdr;
-	if (xdr_stream_decode_u32(argp->xdr, &ace->flag) < 0)
+	if (xdr_stream_decode_u32(xdr, &ace->flag) < 0)
 		return nfserr_bad_xdr;
-	if (xdr_stream_decode_u32(argp->xdr, &ace->access_mask) < 0)
+	if (xdr_stream_decode_u32(xdr, &ace->access_mask) < 0)
 		return nfserr_bad_xdr;
 
-	if (xdr_stream_decode_u32(argp->xdr, &length) < 0)
+	if (xdr_stream_decode_u32(xdr, &length) < 0)
 		return nfserr_bad_xdr;
-	p = xdr_inline_decode(argp->xdr, length);
+	p = xdr_inline_decode(xdr, length);
 	if (!p)
 		return nfserr_bad_xdr;
 	ace->whotype = nfs4_acl_get_whotype((char *)p, length);
 	if (ace->whotype != NFS4_ACL_WHO_NAMED)
 		status = nfs_ok;
 	else if (ace->flag & NFS4_ACE_IDENTIFIER_GROUP)
-		status = nfsd_map_name_to_gid(argp->rqstp,
+		status = nfsd_map_name_to_gid(rqstp,
 				(char *)p, length, &ace->who_gid);
 	else
-		status = nfsd_map_name_to_uid(argp->rqstp,
+		status = nfsd_map_name_to_uid(rqstp,
 				(char *)p, length, &ace->who_uid);
 
 	return status;
@@ -320,35 +321,51 @@ nfsd4_decode_nfsace4(struct nfsd4_compoundargs *argp, struct nfs4_ace *ace)
 
 /* A counted array of nfsace4's */
 static noinline __be32
-nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl)
+nfsd4_decode_acl(struct nfsd4_compoundargs *argp, struct nfs4_acl **acl,
+		 u32 acl_len)
 {
+
+	struct xdr_buf payload;
+	struct xdr_stream xdr;
 	struct nfs4_ace *ace;
-	__be32 status;
+	__be32 status = nfs_ok;
 	u32 count;
 
-	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
+	if (!xdr_stream_subsegment(argp->xdr, &payload, acl_len))
 		return nfserr_bad_xdr;
 
-	if (count > xdr_stream_remaining(argp->xdr) / 20)
+	xdr_init_decode(&xdr, &payload, payload.head[0].iov_base, NULL);
+
+	if (xdr_stream_decode_u32(&xdr, &count) < 0) {
+		status = nfserr_bad_xdr;
+		goto out;
+	}
+
+	if (count > xdr_stream_remaining(&xdr) / 20) {
 		/*
 		 * Even with 4-byte names there wouldn't be
 		 * space for that many aces; something fishy is
 		 * going on:
 		 */
-		return nfserr_fbig;
+		status = nfserr_fbig;
+		goto out;
+	}
 
 	*acl = svcxdr_tmpalloc(argp, nfs4_acl_bytes(count));
-	if (*acl == NULL)
-		return nfserr_jukebox;
+	if (*acl == NULL) {
+		status = nfserr_jukebox;
+		goto out;
+	}
 
 	(*acl)->naces = count;
 	for (ace = (*acl)->aces; ace < (*acl)->aces + count; ace++) {
-		status = nfsd4_decode_nfsace4(argp, ace);
+		status = nfsd4_decode_nfsace4(&xdr, argp->rqstp, ace);
 		if (status)
-			return status;
+			goto out;
 	}
-
-	return nfs_ok;
+out:
+	xdr_finish_decode(&xdr);
+	return status;
 }
 
 static noinline __be32
@@ -514,7 +531,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_valid |= ATTR_SIZE;
 	}
 	if (bmval[0] & FATTR4_WORD0_ACL) {
-		status = nfsd4_decode_acl(argp, acl);
+		status = nfsd4_decode_acl(argp, acl, attrlist4_count);
 		if (status)
 			return status;
 	} else
-- 
2.44.0


