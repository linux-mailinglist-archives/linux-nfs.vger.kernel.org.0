Return-Path: <linux-nfs+bounces-21831-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO0rNIWyEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21831-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:46:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A315B995F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3D8A3047407
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA31388895;
	Fri, 22 May 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqM8bLJ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F437EFE4;
	Fri, 22 May 2026 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478987; cv=none; b=tA2mlY1JWYffmBSrw62ncijRSEbyVcxmY2nZp0Jd/ZDtAIkNGoEu/v+T3l3i34izg1FAMCVvrbH9seweftN2ITEeN7RNsdWYvbRWSMpBVZ2BBMZerUGO0BkaajI/qprrkRRRcqMXg9thOqZZeczFq4f3Q44x43+POotO7hjHPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478987; c=relaxed/simple;
	bh=ObaqPlpMBYi+3KqTXL6Uij26L0eMDEbY8kbhU/u7/vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urM4xKqE3lHPeNodzQ46vhNqyuVmdK3nwT4zq/PVs1ebguaGd9L5HlBkqIGm9TxgCXnk6ujG8EeJR529WIQpLqwYBYTsGf7Jt2k3pvU74SqWJtfGHgFLOISUhLKXYQzBvnk1IBvJFxd4/1p/YsDgJJ/ZtUQIKyKKR9V4ihbce4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqM8bLJ6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630901F00A3E;
	Fri, 22 May 2026 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478981;
	bh=P7GJcWlAnn9onaeiQvrINQHRw0BOo7qTCfQLKMtXhO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IqM8bLJ6GaoVNaFf6EF0q7rrJpqm5+GOCXESxA0nSgbESHWwSce4ffynpzR/EBgAR
	 DG9O62FqqEpjxQKVU49UIfx9rzyVfRTDVjkGuF2M2WR5iD9VOpXt+jGFV6kjyUQOjX
	 TPIP5f8ZmpRXcX6oy0lOpBRWoHxMfXi97wJLWudSbBi1hgFmf4spKdU8saf4NXilK3
	 5sg0b2Ryg5v/9AbHLqsMqCPGLWucfiqz5YbezRN6zfewHAyS8a1vfSE0DQJ7q1edc2
	 +odZFZxIp9kYx+d/Uwc4WpWbrUEariRdrWTqtNUPnkt+elfKiKw1h1ZRWoKlAeEy3M
	 8QvKFIp4n7wZw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:21 -0400
Subject: [PATCH v5 16/21] nfsd: allow encoding a filehandle into fattr4
 without a svc_fh
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-16-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ObaqPlpMBYi+3KqTXL6Uij26L0eMDEbY8kbhU/u7/vw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGh0PJVPRr+WErxp1Yvr/esjfC155ws3p2Q9
 FJxxhxBlR+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxoQAKCRAADmhBGVaC
 FQ05EAC5a52Inkaw3RbneoQbdgxnYUvWSXENEwkCzh/GB7zq+0ssPNnH7SGsPsnhK84uAk/K9LM
 HskSZ+tp9lHoYHGNP4LSvfp6/TlubUVO43jIsQNFrID65mLch3UzueQJywRHzCdolClAWzW+YBT
 Ui6EFtpKX2XzXYyd6VFJ4WEQ1NVUpoed3BToWuXNW6UwBZpqoIxdbFBIWpikEFOsKJl3Wuo/mxp
 oKMShbRBrpW2d+FjCTipbdfhUu920QcdIGM/1drRJj50v2NOlK6WYiU+h+UMimVhicOfla1rKwo
 jh0UpBxhows6l2OD1zgv9zman+VozpTFnnMbS2dLbJpr6UTAwls0aUqTA8G24KRKgjd/0wx/GJz
 pGAV22t/MZTZO0h6zOnLlV7aZFPRq9/KZ1nJuyWGIJ+f23jQJvP19PM24NaADdKwyjOfcZYJsA9
 Xm3dsHZ88PsSlwqNLktk9ir3kgWzZbBWKWF9+x4za+SLsPIKWlLPPoYusDzlEPamltmp0pksv0t
 dKXdfE35WW0a+N747ZPEhlfmkBZNWpId25B3PAp1sVBnF5otNaa+iUpUsgJHGtUM5xdUR+qCcXQ
 zbDjJaY/8t+udxCC5n6Whs4frJqgfPVuJMMF+6mn6QDOMYhw55zPCLlMw5SWGfOZDrQLaD5FHYh
 3vnM3LGhjsPCTCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21831-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 48A315B995F
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


