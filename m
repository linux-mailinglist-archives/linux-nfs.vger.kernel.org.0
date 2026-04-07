Return-Path: <linux-nfs+bounces-20703-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI+lFqEF1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20703-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806C3AF011
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C35DA3028C6D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEAC3BE64B;
	Tue,  7 Apr 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5SQdmtR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0D3B8949;
	Tue,  7 Apr 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568179; cv=none; b=UN097utwKLYmYUMw5BQyxQfaJVcOHIwgAZFP5nRvdPnIWqWrnTm5TSksikNoQ6sXynbNuGryuJ3nqA9lGqqL5eU5T3aFpb1n+9LNkFPinc2PTBIX+NQ+WpGMyl/+Gqcy4bRcEh1R54ijbzanyHPD3+on5xNoENnlXcVVx+kfHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568179; c=relaxed/simple;
	bh=rXPUzV+gnDxb/8xomIAbdxx5WejVQ90e/6v5r6rmuwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BP4/751FLRFYe90xj9LKrPk9ZeOu4phtm3MjhsdYxn3pVCi4cibY9y0tNzAYkjgII8aGNdTp4LFBEZf56U2LBDgEizw/84c89coTqKmeHwcWWNDWGE8WxMJBQnjlLRGQNnQ0CWG8tmBQp1YzobXk9pWgNT4mP/1kWO8YpyYDddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5SQdmtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F192C2BCAF;
	Tue,  7 Apr 2026 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568179;
	bh=rXPUzV+gnDxb/8xomIAbdxx5WejVQ90e/6v5r6rmuwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o5SQdmtRqevhJEIGSh3SVtBwijR/+PiDuCX981c9ylPwWuv1VyYTq7n08unVyfHYX
	 YpNq5gQz4JiB126YOtdqICA8CsoieOzrB8S+80lMy2GkPbQQMPcGi+vX8LqgdTAEjl
	 sEBbUEGND8RP+BYrdG26ocObgmeo4ufkZJCpkvUUvD+djAGTixeXJ+94e6eL+BFYFs
	 WrKidJqQf0W21+EL5lb/Vct1ZruVy5rvyZVRc/Ek3prfrzqDyjAtEG130RavAJRGYJ
	 lwWVDB3O9QjFBY56316aoMt0pHBpkIkglCc5YmUyYo5z8Qt6G0pGigOwPOoaQsRUwd
	 IiCkAe8gURiNg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:29 -0400
Subject: [PATCH 16/24] nfsd: add helper to marshal a fattr4 from completed
 args
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-16-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3372; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rXPUzV+gnDxb/8xomIAbdxx5WejVQ90e/6v5r6rmuwg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUIe8RcNM+t4MP0C74pNO5Q1QHFsL1JDB4q+
 NKS7Z3+/SCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCAAKCRAADmhBGVaC
 FT6dEACk483WLPz/InDepEOHF0t/b1NYTy6BiXmtgqT+0uL/nak6AX4c6u0+edsRF5qcHm/SPQ8
 ltSZCzA4l/5KnP6dIJ0173Xz8Fb7ZQMugjBFPsLsQ6Up8avRWYbw0lNnABLO+/AC7C0qJRqMKV6
 hT+ZBYWwY+Y+CJiOcVtvi2zYPaGNgPa0ZedY42xAnZS259XmjfZjg+kFXMUpBaBZfJ0/smaAxzT
 sBX7yN7NykydSZtcHnbWNLDdKL4DD7LoyiHXHbB1iBsPwTxkKhUg4+//NbsJvmTC4nQcypufPmJ
 vLTuDUFcXZlDRKB/+sV+l4FxwFcfi7/H8IZNiKeys5raclfo1dUT6z45HZqEcx/KpjV+W+UAcN8
 9i5ezWDAJlO8lLtJLuUpdGT56hryJI7K2gVwAgehu0ancj40JMwip+gG00BxbQmlWmwZhg0MY5+
 MofrYCxc+21TNGEJ+EKDHwmvKRA3NqHd+NwYhZPVo8qjo2vP+rfyOWWpYHesBIkkAQwz7V+5O1q
 lfNhFETJOBsgFKcQyQDUj7UwchBXGOhtC7IUj4YoyjlFndA6oEEekgBil1iZ/LWWBcY4HCM+ORj
 AhfAwSFKEKJ6ZPoDjVXv3N8QAXgeKNudwaKt/LIQAQo3PmAgNUtyVnEaUUcJ3ShBjcxiDPq4R15
 al2GmsNBpQe22YQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20703-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0806C3AF011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Break the loop that encodes the actual attr_vals field into a separate
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9ad13f96c219..2ba3fcadb742 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3852,6 +3852,22 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 #endif
 };
 
+static __be32
+nfsd4_encode_attr_vals(struct xdr_stream *xdr, u32 *attrmask, struct nfsd4_fattr_args *args)
+{
+	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	unsigned long bit;
+	__be32 status;
+
+	bitmap_from_arr32(attr_bitmap, attrmask, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
+	for_each_set_bit(bit, attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
+		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, args);
+		if (status != nfs_ok)
+			return status;
+	}
+	return nfs_ok;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -3862,7 +3878,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    struct dentry *dentry, const u32 *bmval,
 		    int ignore_crossmnt)
 {
-	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfs4_delegation *dp = NULL;
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
@@ -3877,7 +3892,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	unsigned long bit;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
 	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
@@ -4050,27 +4064,22 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 
 	/* attrmask */
-	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
-				      attrmask[2]);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1], attrmask[2]);
 	if (status)
-		goto out;
+		return status;
 
 	/* attr_vals */
 	attrlen_offset = xdr->buf->len;
-	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT)))
-		goto out_resource;
-	bitmap_from_arr32(attr_bitmap, attrmask,
-			  ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
-	for_each_set_bit(bit, attr_bitmap,
-			 ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops)) {
-		status = nfsd4_enc_fattr4_encode_ops[bit](xdr, &args);
-		if (status != nfs_ok)
-			goto out;
+	if (unlikely(!xdr_reserve_space(xdr, XDR_UNIT))) {
+		status = nfserr_resource;
+		goto out;
 	}
-	attrlen = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
-	write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, XDR_UNIT);
-	status = nfs_ok;
 
+	status = nfsd4_encode_attr_vals(xdr, attrmask, &args);
+	if (status == nfs_ok) {
+		attrlen = cpu_to_be32(xdr->buf->len - attrlen_offset - XDR_UNIT);
+		write_bytes_to_xdr_buf(xdr->buf, attrlen_offset, &attrlen, XDR_UNIT);
+	}
 out:
 #ifdef CONFIG_NFSD_V4_POSIX_ACLS
 	if (args.dpacl)
@@ -4093,9 +4102,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 out_nfserr:
 	status = nfserrno(err);
 	goto out;
-out_resource:
-	status = nfserr_resource;
-	goto out;
 }
 
 static bool

-- 
2.53.0


