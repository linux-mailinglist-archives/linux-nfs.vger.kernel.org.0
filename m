Return-Path: <linux-nfs+bounces-21797-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMqKCpVOEGpnWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21797-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:39:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31F5B4435
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E975A30732D0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F73A7F6F;
	Fri, 22 May 2026 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXmon9H0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE13A7831;
	Fri, 22 May 2026 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452978; cv=none; b=gLNn9ZfiDZ9L7/deygEcht91B/Tyavg+NDnclioZyZHYtrvCTPX8M3ju2YjAHP2Xd2yb+1vfpaG/Lk+fPUwgPRcWc5iYrgQwSZZMLbPHqxnH5u86XaVV2zFuVrbgXQ5t8sXDlIIkQrqkAeY6h6Og8i3tNipzqQ6HCTYZcqoaeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452978; c=relaxed/simple;
	bh=ObaqPlpMBYi+3KqTXL6Uij26L0eMDEbY8kbhU/u7/vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SY2qnXp7g2i+0YJY4fM1YvKcuDNR9EmSL7I2i5zVM9hwSRihftAYIqBZO0w7+gmcoQe+Px2Zst6jXac2o+yXGT5tqNX2u2XBKCF4fLEI8LnDsQZ8twPqpXjoEIyiVPZWnpkkpSiItvRhPRHPdXULMr6QwctqLjUGlLKSTT+y0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXmon9H0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B251F000E9;
	Fri, 22 May 2026 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452976;
	bh=P7GJcWlAnn9onaeiQvrINQHRw0BOo7qTCfQLKMtXhO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lXmon9H0AqaUZRtJITdLeI+d3nSaFU7Dm8LVjpLqvUQ6XAhxVDmr/cj+pBHdyKy5l
	 7ltCrXev50Ut6rZwuV1Nlz8HtffzCDrwxVq8WDHwMVA19VkmfW69e4wXoo+TXBQxOR
	 y1Kuyjxno77x3SO5ZVovk/iTZAKu86LSm0FWgHEfV7WyCSlLKoNnOFrTg9xuSHrsEW
	 5y72QAW5o9JCka4Ohxf88I18CZj8PqSCgST3XGeW1ilVNcja92CrcRlAn2tApJcPmx
	 iE2SNnrWywYw5/RvxfcgxOKlJwEGJPqxmBmwDaegfa5XICAFZE/ahJf+XftkWXBMWI
	 taFgdX19kThiA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:05 -0400
Subject: [PATCH v4 16/21] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-16-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ObaqPlpMBYi+3KqTXL6Uij26L0eMDEbY8kbhU/u7/vw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwRIq7lhQgCSyGV+5XU8EeN1NLbBa/bT8y3v
 ebDsRidpXSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEQAKCRAADmhBGVaC
 FXjvD/4h15vcGkFB2WPLqgPIsGFcKImv++YuRY8Kl6la5b2QkUGkIbu44Y6gqhbGMmVc432DyPk
 SRBnDENzBcRpivvRVrFBA+Ky4qHXr93Tf6awxi6xW/q7BBSYPADth36JgksrGtS4ED3TWmNjBsx
 6RNoKchoJaiNfV1gNXYwQpj4SunDueQs1DyU/gsZakeWnevWcYSA/Nt0GEin1QgIPJIW1jIqsCg
 uKs4PA97FPusw80d13JZUd6grdqjPwcfGgH2tjM4f/2/Cer8oLprcV2QS1P2M3JbAhrLEoX62k0
 W1CV4O6PB+kw2bxb+nXZVwF7XAlF0RqsjCqMWCQsOg7tr/Ow2urHeZrqdlE0Il67NNkYb0SiRgh
 eDWns0eQ6uCWLjNl/kIVMpQnDz49U0yyNWSTxiAzes8+1PzonJXjD+b6JioebfefoojLaOG9D6T
 EETHviT7na968+uLePPM79NCuaV3WrQu47D9CQ9++k+cKmp7as2jX2b66acevnW5fW3k6bU4qYn
 o+Mv8WhT9tHSySwAEAbrO5EE5yMMGI/CzWBmnn21zEgNhvwFkbRSc/SnrNLIMwjdLr6rkchktC2
 eNRK58NUWTM7xOLNKffk02VPvIX/2zch1lrJGcEDAJPd1ZZ87XH5Tc7O2zOVytM4WghFsB8Pgat
 ULr3K6zrEYNkksQ==
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
	TAGGED_FROM(0.00)[bounces-21797-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 8F31F5B4435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current fattr4 encoder requires a svc_fh in order to encode the
filehandle. This is not available in a CB_NOTIFY callback. Add a a new
"fhandle" field to struct nfsd4_fattr_args and copy the filehandle into
there from the svc_fh. CB_NOTIFY will populate it via other means.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 61c555446f63..33b6cd492e56 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2702,7 +2702,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
 }
 
 static __be32 nfsd4_encode_nfs_fh4(struct xdr_stream *xdr,
-				   struct knfsd_fh *fh_handle)
+				   const struct knfsd_fh *fh_handle)
 {
 	return nfsd4_encode_opaque(xdr, fh_handle->fh_raw, fh_handle->fh_size);
 }
@@ -3145,6 +3145,7 @@ struct nfsd4_fattr_args {
 	struct svc_fh		*fhp;
 	struct svc_export	*exp;
 	struct dentry		*dentry;
+	struct knfsd_fh		fhandle;
 	struct kstat		stat;
 	struct kstatfs		statfs;
 	struct nfs4_acl		*acl;
@@ -3389,7 +3390,7 @@ static __be32 nfsd4_encode_fattr4_homogeneous(struct xdr_stream *xdr,
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
-	return nfsd4_encode_nfs_fh4(xdr, &args->fhp->fh_handle);
+	return nfsd4_encode_nfs_fh4(xdr, &args->fhandle);
 }
 
 static __be32 nfsd4_encode_fattr4_fileid(struct xdr_stream *xdr,
@@ -4002,19 +4003,24 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		if (err)
 			goto out_nfserr;
 	}
-	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) &&
-	    !fhp) {
-		tempfh = kmalloc_obj(struct svc_fh);
-		status = nfserr_jukebox;
-		if (!tempfh)
-			goto out;
-		fh_init(tempfh, NFS4_FHSIZE);
-		status = fh_compose(tempfh, exp, dentry, NULL);
-		if (status)
-			goto out;
-		args.fhp = tempfh;
-	} else
-		args.fhp = fhp;
+
+	args.fhp = fhp;
+	if ((attrmask[0] & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID))) {
+		if (!args.fhp) {
+			tempfh = kmalloc_obj(struct svc_fh);
+			status = nfserr_jukebox;
+			if (!tempfh)
+				goto out;
+			fh_init(tempfh, NFS4_FHSIZE);
+			status = fh_compose(tempfh, exp, dentry, NULL);
+			if (status)
+				goto out;
+			args.fhp = tempfh;
+		}
+		if (args.fhp)
+			fh_copy_shallow(&args.fhandle, &args.fhp->fh_handle);
+	}
+
 	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
 			   FATTR4_WORD0_CASE_PRESERVING)) {
 		/*

-- 
2.54.0


