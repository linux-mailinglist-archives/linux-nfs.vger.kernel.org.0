Return-Path: <linux-nfs+bounces-21794-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMO8CipOEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21794-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:38:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C738B5B439F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42F1D303A5D9
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F938D41A;
	Fri, 22 May 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjgiMdF2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A83A48D7;
	Fri, 22 May 2026 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452973; cv=none; b=m4D5sk5OIwgsE4q8dtmYf4A3HjkpbgJx7o5r1AefDrxRGgxp9lOshmX0jvz2RtC8+o1LE60o+OwMjZL2paQ1mT1KIJuUQCLlUYwPKYtSR33bmoMwFg+I2A6/fE2L6xClShnASImLD8n4RRM9CiPzxD4A+e9PoH+CzfQlhha2+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452973; c=relaxed/simple;
	bh=AnXDCmJFZYm5CvJ/Tqx4ECFvxiyWh0qg/VdF8Hlk1hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rg71vnDRgiII2JSZ23wIz+p+4SIZa46YDXYcB6Zc/8I1jfs0xtIyWDgvmNFZM95OMQQZe8FhnNo33xCIyibOTB9cCbJkyfg+10YCFi3436cwxodwTEczU9mcI71VhviGzosWKpOx6BJxxXQyTK/C5cSfOUFS/mxeaFBunHvVV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjgiMdF2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEEA1F000E9;
	Fri, 22 May 2026 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452971;
	bh=DF5gZGDIA/XCxzRoqwszAdw1M2a+k5vgSFZ3a7XrlYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TjgiMdF274AtYLga4CFcFoiYm1itTPjMItwSrX+kNfTSvmz4T+5CZoRCLtUbTP03z
	 V7DhRwfgVRuAYJ/58+Rglz3qDxOT8rLKeLPyoRVvHNzMukOxQJE+iYS79Vr1EDfrMl
	 MXG5FcgVW5ap3DmPNFoFXULMDNnew14ODJcroIFyH3pOiAYJeFzDi6DlGT+HRgQ1nt
	 uJWSDJVYT0VK6o7TTNMBqEVz3/3JqW9LFR0zPIdCNsRQGYPeD3h6KYf6Qcxm3Y/GuH
	 8omUGGuF5QH6OzXAH5y0UlGpn9vlKDui5j84hXvkAfACKh4drJUmin5uSJmVyOkXUO
	 kgBmh9KvE5aSg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:02 -0400
Subject: [PATCH v4 13/21] nfsd: add helper to marshal a fattr4 from
 completed args
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-13-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AnXDCmJFZYm5CvJ/Tqx4ECFvxiyWh0qg/VdF8Hlk1hE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwQ1Xy4/+h15uJyIJgCjn5Myku7W3gEQQ3K9
 uwHfuK0Ls+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEAAKCRAADmhBGVaC
 FQuQEACwkhh+QxwgKAXrDjpeCkNBgW5Chaq1anscNlAOeRQkfX40WS9lCkE+4o6ucCoMTt+WDZm
 iu1e3Cx8eNtSJDxHC9sOoBJmMPOSvIDR08BVDewPFiFk8hHv2GqNcH490d7lO0F7BcICw2xxtKg
 uY4/mm/z/itbrSbPB0UOONvab1t4xbSwGDgZiROcMROFZdPALLS3apMTXjMu2dTBZJATH5lR+y1
 3KwmmGl+K3NlowD8/0lPtp1H4+65B6xXF2EtqzLqY9NWey2lUDw1hPDKvMF6I9uuZx0wjL+Ud1x
 u18IJ8/noJfkG9sPOJ2U5P+XGUAGVy744MWpgn3Bu1K00sIuK6dPUcnHofT1Nrd+OM3kIuF4kK8
 qatIKNtx76QxshniNtNhqSYOQf0NYAuTotcC0/f+2t2aAjHP9afmTHazxjyxvtflvJtX/TW1HX1
 D0SQgVUSJYNWqeScvsT6qgj+wJHYIazg4DsH5+SBffa83csiXX1GXNIlN5dLrlySt/mUYTo1qOC
 wXTTeophVnoHt8ZXRK83Mj0SQkj6VjgNHvlOdrg6jekwLtn1a8Zn1Mk0wAxL6UnU9kjP1gSEayu
 /kb2mspoSvUlutM97wGEDienWMNEfWz1xWcYvvnJKLuLiXGgCWXz/M2l95kenMUg8TsTsjdiX0T
 T/0v+ZOq/bDy7dA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21794-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C738B5B439F
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


