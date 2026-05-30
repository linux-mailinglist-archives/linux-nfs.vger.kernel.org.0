Return-Path: <linux-nfs+bounces-22104-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O6xFz/kGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22104-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:21:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A0460CF22
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1098F3017E9D
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC53C769B;
	Sat, 30 May 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opCpewAf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EC3C5DCD;
	Sat, 30 May 2026 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147183; cv=none; b=kc5wZPQB6Ew5kvozMp6h1x8UhGK3ONVR/zSsbwMQl5MR+T2AsJcufkWo904RjHmTuDkRLlTE/Nwmy2xe8+s7zk9rVH7DGlQyezKdWRo9jxeiXhq1EYWJU7U0RS3FJIRUR/w7d9jgvIKw/bUE4+iYXbL/G9QdnWnwZZYhoTrIxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147183; c=relaxed/simple;
	bh=biIgfr91EnCBGwV20bIsbijQLD/T7mIzZF5vlT0w8+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqxfN2xTCITlCM/x+1V9Ta+AnCU/WWRHgGgGaHjqrTGb378FoCGEmXdq7O2dzXdozoXK0jYRm+K2V2ZGtX6PiSO+NnNPsug/LfpVWT9aV/J2Gb+8Ou9CTdnoPQEvU9J+KGr/amwKdNq7iI8Omq5jBdgf43NcU3IAAGgJEu9FqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opCpewAf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D25C1F00899;
	Sat, 30 May 2026 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147181;
	bh=j1SGvhP04m7LjXX1rgheDhvNoRzX0v1uPfNOcNP4jE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=opCpewAfPiY4+zJkcbKhWkJYD4+0o8g2T772R/ebhsQE49tukPMySYK+QX6IQ4NXY
	 Bpp1sAkl32h8vz0b0xJjmINchyFQW6I+ohxJRF6Kmn83YZwIBG7QH5z4rwPJEy1nu+
	 AWXFkwBk7ntIFYWKdheabKvdS2Ugy9soQtslYBnIWMvYBkAd82eywcSQjnY+ZjsNZs
	 1HgQ6kmdYq1mbxtuOtiFEIT9O3FV0f4HiyK5wxlvN+UQ3VxAeJqOOq9J4C8EjhHMsf
	 qMKQw7Gt6laYjOqkMU7Hg89xJx8PzsIbFvCW7bretSPKpSx3C9/eKdcU2kimZGvvYe
	 IOeNQtuqKJ8Nw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:22 -0400
Subject: [PATCH v2 6/9] NFSD: check truncate permission under inode lock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-6-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3086; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ub0qxmYkGrQH3JKYormkTZYBwNi2mgWx/DdAJ5Wa+/M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPi+2dIfA1x7nuLryLPP9WOz2LtA54itsURj
 8WcUH8SDhuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4gAKCRAADmhBGVaC
 FRFdD/4xTg+sA6mYjj89oepEQzGL8H5W8LabQu9GyR6NjuMpkJwrI69GNMq1buBiBTcj9jFBoJg
 ujE/n3skn7pAd4YnoqC/lz6/sw92TDY9rv3RTKBQjwReVvNOpNljeFhDlmJzEF3237lNMkUC02p
 3kXBzEdU2Mpmw7+ucg5UFww3d/FeJ5h+GfhYnlj4aWFTbOd3deOJhuZWN9mubCXl8lvGrCflvKO
 y7Q58HgcGf5/huO4K4xjDe1jS7K2CPBXZrEnVAocy7LpprIRcecW08IrpjpuyPn5hPuNoosF8Dq
 nBzd6P4FxzHZsk/Gn+4m/6V1qYQUjgIizboWvnSsYxOQgEOdS6NJRmBD3XiVIbdegvpA+UXo9Fy
 4DDssGI9TnfeekqObrK99e68qNHykkIOAAb4mcz50J4BQO3hzBUsDYwKTvfwVAbylQ/ue60r/IA
 rfN1J/D+JsKYzPoy+6psxElE2wJf5oVTYZ4CyHS6ER9Vozz6nXm+85wawBb9tzNPjFEJoYeC6ZG
 /efTFDrDlOXwAn3d1pMb8ZHk5Dn7Ep2nBLmHfVyRYRWgjRtpVKH/fxkeDrYfOKl4Q7yilFKpx80
 FvwPlbq1Xy+dsob65NjSdrlxeSzmIhwsZFUAnNxoCs32aqrN1mS3V6V8qiPUROoyzuf2WEUICQA
 noxbk6purr5dcOg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22104-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:email,oracle.com:email]
X-Rspamd-Queue-Id: 86A0460CF22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nfsd_setattr() checks whether a size update needs NFSD_MAY_TRUNC
before it takes inode_lock(). The comparison uses the file size sampled
by that unlocked read, but the actual ATTR_SIZE update is applied later
under inode_lock() by notify_change().

This leaves a TOCTOU window for append-only files. If a client sends a
SETATTR that does not shrink the file at the time of the unlocked
sample, a concurrent append can extend the file before nfsd_setattr()
takes inode_lock(). notify_change() then applies a real truncation
without the NFSD_MAY_TRUNC check that rejects IS_APPEND(inode). The VFS
truncate syscall paths perform their own append-only checks before
calling notify_change(), so NFSD must make this decision against the
locked size it is about to change.

Split the write-count acquisition from the truncation permission check.
Keep get_write_access() before the locked setattr work, then recheck
whether the requested size is below i_size_read(inode) after inode_lock()
has been acquired and before notify_change(ATTR_SIZE). This also avoids
the plain unlocked inode->i_size load.

Fixes: 783112f7401f ("nfsd: special case truncates some more")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7e6468bdc723..07a9a68408ba 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -419,21 +419,22 @@ nfsd_sanitize_attrs(struct inode *inode, struct iattr *iap)
 }
 
 static __be32
-nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		struct iattr *iap)
+nfsd_may_truncate(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct iattr *iap)
 {
 	struct inode *inode = d_inode(fhp->fh_dentry);
 
-	if (iap->ia_size < inode->i_size) {
-		__be32 err;
+	if (iap->ia_size >= i_size_read(inode))
+		return nfs_ok;
 
-		err = nfsd_permission(&rqstp->rq_cred,
-				      fhp->fh_export, fhp->fh_dentry,
-				      NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
-		if (err)
-			return err;
-	}
-	return nfserrno(get_write_access(inode));
+	return nfsd_permission(&rqstp->rq_cred, fhp->fh_export, fhp->fh_dentry,
+			       NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
+}
+
+static __be32
+nfsd_get_write_access(struct svc_fh *fhp)
+{
+	return nfserrno(get_write_access(d_inode(fhp->fh_dentry)));
 }
 
 static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
@@ -560,12 +561,17 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	 * setattr call.
 	 */
 	if (size_change) {
-		err = nfsd_get_write_access(rqstp, fhp, iap);
+		err = nfsd_get_write_access(fhp);
 		if (err)
 			return err;
 	}
 
 	inode_lock(inode);
+	if (size_change) {
+		err = nfsd_may_truncate(rqstp, fhp, iap);
+		if (err)
+			goto out_unlock;
+	}
 	err = fh_fill_pre_attrs(fhp);
 	if (err)
 		goto out_unlock;

-- 
2.54.0


