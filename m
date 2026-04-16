Return-Path: <linux-nfs+bounces-20892-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPygEf4g4WmapQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20892-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:48:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB916413469
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA9B03121799
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59A3E9594;
	Thu, 16 Apr 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAXIBWS+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BF3E9292;
	Thu, 16 Apr 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360954; cv=none; b=CL0Mbs+z/av2Dmwk803jnsMOs4RDOYLmKxDmF5kZy16Tm6T+1zugX6GbQgyEwFps82ahD42A1hs2vpJOTUB3xZvIg6vUx6yFJmMTgxGxRRzrZEJyqPb6mUXGdc9+wkQGWyicUVexyL47ycxzEyNcOM2bv2AcCpyxZn9h75srQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360954; c=relaxed/simple;
	bh=zc4I4aMHPzDjEQnh/xOeFfSGEX46qvOSZgvWobP7q3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QPJYu2htIRsuJUocWCvq0N939WGkVi9y0A/FUkUd6dKCzztRHFkwgd5RPtG8QPD+NeeDMjMQuWe6awq20Q+yD/hKUlyDhu8cHgnO4upqcP8tA1+ECMOUVdXjKzLt5dqk0o/iLrn207fCkPvV9yvXroUezKhQ0xSoyKQMTjY9pZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAXIBWS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39653C2BCB9;
	Thu, 16 Apr 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360953;
	bh=zc4I4aMHPzDjEQnh/xOeFfSGEX46qvOSZgvWobP7q3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZAXIBWS+s8qMETo+o3Rkeh4+3QFWNFKmQdKNld5DkFmXETazs6EZNt1Jcw7bGt+hd
	 e/vOnLdSremipMP+0AUQy2JiXPyszIRdyARt6oAttwf4joVyDIm3itltyEoJpGsy9W
	 xC5hbINz7dblZTZqgT4Q/gEAFTxvTtu6x8PQEOx14tHRH5lNCbqXQhlapn48RNkGgY
	 aBfGs2f301pTqdi3QIQ4xE2GXVHw772JBE5T0NwV2xoIShHQs/T/QmY5l/9tOj91Ls
	 DzR6zsIrFf1LoE2txF07AHwDQtW2eZKWK6CP+FMkhXp/K4kbj4bVmrVPx27LjQISDi
	 DRRGcbaBRa7Jg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:21 -0700
Subject: [PATCH v2 20/28] nfsd: add helper to marshal a fattr4 from
 completed args
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-20-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3351; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zc4I4aMHPzDjEQnh/xOeFfSGEX46qvOSZgvWobP7q3w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3mHMIIJX+f6/jEMp+XBzMSIXqPW7IVqsdvj
 2Gx1Z0Bp9OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5gAKCRAADmhBGVaC
 FWUzD/95hQNUBoojlmqr8AyRZq+xFfciLcdZgS6klS5NdSJn+DIfRZh3hvuEVl5ceqQQewHJcWq
 tXWchgCghLjNnb8Yi28q6mZLSbpJ3lvYt+436dxh0pXmV4A/0B0Y8nu5HOAvab/PTy7evha9l8c
 RAlAUV6RIHVU0IU7rwDf37HPBQKHf+l4JKLCj9hW5MnCJzL32PWT2BEhNzy1nmNJYRSq8oIbU/U
 ZTnZdaYQKvESjcgCLSOSFsz1hFxXJtTq5kFXE0q0E8OrKwH51mOqL19llyeEe8qmNZReP+iB4Hg
 CiVcqotcMKrVB+dgu9NkjsKpjwHQe82SSQITDR3W/7Ds4WoWMjqk7F214aQ9l3rtzGZDpsMcP4l
 8dG38dtLrlR22Rb0WwtOaXiWImsbHmPpB8reo6o/ZvaHQoaYifrqTD41lnMcMMOxf8cMVzsSHWc
 x5uzGMr4F/jHbx1VPUn5vfKHne3ujJ/smRmmm1Hp3L3KwjtVmpquMRd1GwWs8aBPJY64q8TFn6y
 heSTxRJsgR+ktFbvq1AyortS1kkyg4JUMOIipekeFn3k43Ydw3iq3ZJcC8x1F0KxqHGOmjVTsyF
 1n0+jHalLePAZHN0dFYCKxWT3PqLM+JUqUD6fFjVpubtbS+1mdtS1tYdF81Rt6i99yUArRNg8NY
 /+eOtoeNepUp4eg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20892-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB916413469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Break the loop that encodes the actual attr_vals field into a separate
function.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8af1e15e1102..b9b173ec7421 100644
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


