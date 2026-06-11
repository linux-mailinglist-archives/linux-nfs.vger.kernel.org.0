Return-Path: <linux-nfs+bounces-22485-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D9W7DR74Kmra0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22485-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395067443C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="h3/hvpXS";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22485-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22485-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABE13502F99
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83164D2ECF;
	Thu, 11 Jun 2026 17:51:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3E54C9554;
	Thu, 11 Jun 2026 17:50:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200260; cv=none; b=JUQbLc15KLA8lxFTkMz9UhFJ9+vWzPHtfQWH6mg2JvptW5Q5e9BTKOANKpZ/XDc96rGkerhox9x+PMF2GXPTGi5BSq0Tu9YZRWqAah561A4T5Ob1oU/zPQJjOz8qkhZH5QKaCROIz4LwsYt7ao9L+gPEqNkYRf6joqlL49MGc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200260; c=relaxed/simple;
	bh=wGyTokg3GKElfqJgrUe3TxVbVZk4gjS9Piw+ozcUGeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vhrier1hM9QoHhx5iViy7yaZ8hEsFdxrDrO/Tw/zHxKRJRz0dwg3jAab9cGJaPxKkJHpCqwfvGKIP25EF8X2dD8x2NKKNiYZM6LZyn5N2P1VEu4jZYPPlyGC3diraAqeN0uIkZp7JweGJaa/LVs2gkkDf/aD3IvtQ4ddtmyjFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3/hvpXS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375831F00899;
	Thu, 11 Jun 2026 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200254;
	bh=boUS2uP29CUMjPXaPJlVrj6lCotQJXHMxNRB/47GSTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h3/hvpXSuyz1eMKbduGBKbrW7a1r/0RHY/SB62k3V6soxSaSWR1vG3187Yn57+vcX
	 Q+XLwecaOFUOdC0Eao3gFzWJmwKkj3gVVrHTe5xuNI++59gy0pUyCt1ED8rr+vBj7p
	 mM9w6EXBrUOqkjS6womUAb3u9zQoU4gdCW2Z3+m1H9mDpFs4MQJBAvU6JnyG2o78T8
	 9GsAI/FTSBaBAWNl6/2WhOP0ARA3rfmcOD/Qr9eTI5ljmPEwmGDv/sndBgHz/GtmI3
	 dcHWuTc0CSNH7t3p5rl4oKVcz63Ukd7xaebMGg/iP5rGsiWPJvAXRr7/HhpZM9wPNL
	 zbVkcusxi9r/w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:18 -0400
Subject: [PATCH v6 12/20] nfsd: add helper to marshal a fattr4 from
 completed args
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-12-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wGyTokg3GKElfqJgrUe3TxVbVZk4gjS9Piw+ozcUGeY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVh2+hnPzb54Y1u398dAJ+ySepQoggcUsADU
 pSr3qrxoSuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1YQAKCRAADmhBGVaC
 FaSrD/9VLU61VA/Hq5PrCVRw1JMz099EAQfnA6XLVwJn51G/MfcCJPa2eSd/er+8ljjjZ6pYpZr
 YJbxiOvaF6bOLhTwPBWOEuu9F5Y+xlhSCx6LdqfYXZUMeTsXpJoF59PBwBhno3mpSE2u2vGdq10
 y1lIctNZ2Eczm+qAvcNvxkCFEB4oQUwPdWYYYgDjiduZdr7Zwq7ncIrvmbfVdcs8S+Mahc8eiTm
 Anxiy1WHvG6s+MR4ryXHXRy/eAlYJVQahauPbj1aGXGrv643EJ6HVGHE7SMZZRhzERWAaSnFEoi
 Hvfre3sHLxdAQk8XbHwuca5udSTQNUHIW3rOWKjzaQfMQJm/Jj5GyBJeQb2M/XlE3tjrDDeDz8n
 ptIOlSLAqSieZoJQf4b6DhCE/Z1Rtcmik7EQw71ZTtYoOb2y+wbyAxNQzA7Q3lShkO0o+gg65Vh
 /z7bIyb3UtxYG3pb6METPlnTvXvpS4AqQqKsnuzNVjCgVM/yFAsuoM2VG+OdTJRBTxnlSTCaUyw
 LxrY0AYTW1gEYl6e3D3/vHFtcqm32VHtXG9IgipMI49KaYbdziffDfXZkJE3b+XGkFJgGu5lnbx
 3bCZ5+oRNWCT/eQTyMjR37cs8ZXbWb8UrWZyaGxAodM9DHL4KTSDgejLIM/ri3YhKtGxT613Sg+
 TG3ZWuu31vDvILw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22485-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8395067443C

Break the loop that encodes the actual attr_vals field into a separate
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c6f92ddeb449..7d162e5fb6ec 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3895,6 +3895,22 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
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
@@ -3908,7 +3924,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		    int ignore_crossmnt,
 		    struct nfsd_case_attrs_cache *case_cache)
 {
-	DECLARE_BITMAP(attr_bitmap, ARRAY_SIZE(nfsd4_enc_fattr4_encode_ops));
 	struct nfs4_delegation *dp = NULL;
 	struct nfsd4_fattr_args args;
 	struct svc_fh *tempfh = NULL;
@@ -3923,7 +3938,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		.mnt	= exp->ex_path.mnt,
 		.dentry	= dentry,
 	};
-	unsigned long bit;
 
 	WARN_ON_ONCE(bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1);
 	WARN_ON_ONCE(!nfsd_attrs_supported(minorversion, bmval));
@@ -4137,27 +4151,22 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
@@ -4180,9 +4189,6 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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


