Return-Path: <linux-nfs+bounces-21828-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOR7ERyyEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21828-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:44:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9785B98F1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 335EF3027368
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D09385D9C;
	Fri, 22 May 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO25PpFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627F383990;
	Fri, 22 May 2026 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478979; cv=none; b=Harsws2LWiNc6YgwnJSUGXx5NF5X+Nbj/UBAXPhMfZ0kVBvcoZ8eBqpb/b2VdI0ZqtgWZjxvThr+pwpoYwIby+tmUuxGVNuO5vM7Zwmo1wpGu8a1fJBF95ZiyQjaQul7gmJ1D+eutnCqL5yKIkLqUEXMH/E/2kVa8ZHsqUGSX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478979; c=relaxed/simple;
	bh=AnXDCmJFZYm5CvJ/Tqx4ECFvxiyWh0qg/VdF8Hlk1hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMcjQ+dgX6+06fqbgE+/eAjJYLRjk7ARVy8SSaBN1Fh3l/49VaOAQpdEpc2zyr6J3n7NhLbJO49k5lYSi02mwSWQ9+zy1EMTEvmyxeQhHiCl3dCGh16DanB9H/wpi/LJE1YTTTzFRRVyvM0doCnRNawcRna3yfjeUOJrrK1rStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO25PpFD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934361F0155A;
	Fri, 22 May 2026 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478975;
	bh=DF5gZGDIA/XCxzRoqwszAdw1M2a+k5vgSFZ3a7XrlYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AO25PpFDfMjgr2PtMghhwoGlLsOdtxSUFKeCqKL/xO2bZFdSahrJuxpqgBF0Aqi+2
	 ymQ1SnQpGbmaFrQlD7fcC3fsEndRYX+Xg926JeinYUKYlLOB74eWqMuoYXpHBhVmSM
	 wpvmSVf7TEgaWXF2KUwK9BjA3r+1LY6aCp2lFnD1k57dAt9DRxETkkIV91VNZKo+7u
	 67f6okgL8IKDqZ49mRcpjIPsa1qLeYezbWxTvAIwoZEMRhbJZtMFEk7H1x81cadk8b
	 Ls24gr+VItOktb9bD2gFXDKN8/1ERbBAcmxw8w/2ep2JwJlZwcBxcvhxE1+mh1YFV+
	 c0Fsa4a0g+v5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:18 -0400
Subject: [PATCH v5 13/21] nfsd: add helper to marshal a fattr4 from
 completed args
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-13-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AnXDCmJFZYm5CvJ/Tqx4ECFvxiyWh0qg/VdF8Hlk1hE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGgu55ERAimtpOx+ttb2xhMhUq8zSijRrGXA
 TyB4g6HzD2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxoAAKCRAADmhBGVaC
 FZ4ZEACO06o9tQdf6FH6vPdt2/MxjmQvQtmfUkE7r18ez9MUREh4Wd3lQKTRwM4ABw/yTU2WKyP
 GnmY/djaAAA7pDbialgY1YS1gK3lMjWi/0iaaNVaFVRP6IKi2TG0Jba68GSCZ4y/DsxpxAWicT0
 e0ZxZyxqRyl8bsLCeARS7WLhsMrwG2bTviGAIz68knjmfbXA1jD7UFTYuDJj8oJeex9yHZOzmiK
 N3eKVaI/IhhQcuuT0BPV8uTORzmlaA4oekXAs3mZZjojx5aRvou/7r1xQxQKrysC/Kk61i3rb+8
 UL8I1pZEuvfxmsrXLx6nU+faVtmgPUu1PPNP+2Go2UkR7cAusZpN6J0+tPFkVh8Bb/BJe7upW5Z
 Dk5GafOScLKxx06QpAea1kbATifPNwVRgb01BDbvstao/fXjmZH613laS3itO5fZZCNRT83qtOM
 GVshNAOyqITfYhRl6HEGj/fN5XsVci+pkV8u5Mhhxna1o0RwsLO2CNVHlJ5hBiTgj4UbqcY2Qx3
 +bszB0wGXJLUYdpzcFJGMz02RbOXaSC0ECvdqqIP96DExuRefXyGCIwungPExHfrkdQgg34pHAE
 Ef43wZp3z0s1L2aLP0sAup4rDwQZGdU+Bng1cxXfnHx+0nY1JfwGmSwgo9xnY/CTSzP09Ej3C6i
 1FO0BJkKfeNZpuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21828-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE9785B98F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Break the loop that encodes the actual attr_vals field into a separate
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 31df04675713..703caa2ee7dc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3882,6 +3882,22 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
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
  * ourselves. @case_cache is NULL for callers that encode a single dentry
@@ -3895,7 +3911,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    int ignore_crossmnt,
 		    struct nfsd_case_attrs_cache *case_cache)
 {
-	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfs4_delegation *dp = NULL;
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
@@ -3910,7 +3925,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	unsigned long bit;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
 	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
@@ -4124,27 +4138,22 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 #endif /* CONFIG_NFSD_V4_POSIX_ACLS */
 
 	/* attrmask */
-	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1],
-				      attrmask[2]);
+	status = nfsd4_encode_bitmap4(xdr, attrmask[0], attrmask[1], attrmask[2]);
 	if (status)
 		goto out;
 
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
@@ -4167,9 +4176,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 out_nfserr:
 	status = nfserrno(err);
 	goto out;
-out_resource:
-	status = nfserr_resource;
-	goto out;
 }
 
 static bool

-- 
2.54.0


