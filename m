Return-Path: <linux-nfs+bounces-22059-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNE3Lsi7GGoumwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22059-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:03:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 530985FABE9
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 00:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F2AA3202421
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698F36998A;
	Thu, 28 May 2026 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf0LkbbK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10051367B61;
	Thu, 28 May 2026 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005341; cv=none; b=AIBwjNjQqlsBRBYEZKoxZ1mY5BduEbjDVdVVSNdy1va9GPugzMIQ9FEeP0B4iKWIUkTJmL+jNTQm58mL3MocGUuMENQ2+HXNre+GH3S+lZG0xTLOj3zjIwj/kenLA7Cvx9rhah07qKJ3Yq6XP3ICzD+kEf8IG4HgYQYSTXstBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005341; c=relaxed/simple;
	bh=jgYcUIiphYc8dlvt0fojriSWgHKg3YiGXZh7FqNN5XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPawOCRk5JmNpTEoFTr1B8TX+5/Sp1dd2pKINEz5ZX4m85VZqeGgCdH3b9lRunRnLijdZZvOg5SHM78fjVf4JuOIQRF/XP3hQ5eM9WBHhKYj9syo7lpxDit0kIv0090zZ1Qo3Rcit48ZRvFn5bibHUQYy/TMMOJ9tSgaj7Sbe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf0LkbbK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9B01F00A3E;
	Thu, 28 May 2026 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005336;
	bh=wcZk3CrZ4fiHMhIJQ2nzC7yu+rHDdCAtsGvzEQSLHn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xf0LkbbKRT9M/sfmxF4TR0SLbPdpW+uGYAPNGlpVLovZP4PbI6ZqVlGmtVy9nyIA4
	 SLlgCaf3eoiwS/pWBrdxaP7rwD/shUFTyeT0UeQd5nC0ytnPjipzmex7XhzBjTGbCg
	 U97KxGgTe7cXXP6omh8aq8ExvFbc6WprZJjWWCtHb1QiQ+is+Mc+KOvDhTPdOGiomh
	 uwkjjxfB7hkWt1Pvg9Vu0p6oiooWO4aylcd1DVWaTVOxrZ7xc2t0arU83kfDZmDZ3L
	 XTKS8M+hTpCITe+uj6yOg8xftBwa+IPVY0/U4lXmQPTbU3xIgCwjYTCW1+7EcF783M
	 EmKMzhNkran8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:18 -0400
Subject: [PATCH 07/10] NFSD: check truncate permission under inode lock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-7-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AAlZJXNIsMumJGVH4o3U3ITTLWLG40+qhCg1DeCr/QE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnLUyeTBR8LsM8bq3p47OlijSdiqUwP2TZd/
 lXrOZJYLFqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ywAKCRAADmhBGVaC
 FZ2TD/wI5YCrGR0FmHEqiTBEINokaWC0GgQvWfWm7ImYyGO8SfaugHDdsk6sim//Xdun+rKui49
 o8IK7uJM46d1pW64GnP81x0VQqRVXltmWwN5bKJdNNrDyMJb228ZbyAhLvp1uOYgRkE4A0JFLFH
 wUENTDexbdeaQe8tq5FVKgGyjikkOYentf9ZMduZHJ+BwQL0ohsYoLK7K0QLwIikYcjXdORDeOl
 qAzdNe+yWpO6i+j3IZ2HEwMge3/TztcyTNWMh+9shZg332W0+QyEG0tflwbJVA1M3vBJDof/7ou
 cEky72dnf/nCBtkBIUGtoaH0dV9p1GZz59UDab9xEWl6WJ1NFCOopi2BYOPYIopCRc/I2v5EySq
 1xsROyuDKWeXACmqSD3zkSinDUTHekE90kHPAoiI3iLotjXrcklFyCnQ69+NvGHxkMW+fhC8CyJ
 ztIBl4X8cGqhXDfnBsbgA1yda4cFu9tEj6SF0cVBcQMcCQklK86WpFjwNWLx7yaAp4tQbiNRn3x
 EFoVC7C2kZFv1Ir4A8ccb8LlxHrJNu5NznB434E1mX9RVkcU0jWFM642rwMxku/xigejA9TVdTZ
 Sglh39mcovR1KOTBKOGw0X2mbOabLORenne29G8T6OrF0yeMT+aiu0Q/yRlG79ZLyGcZdx+x5Qu
 ibnXizXlOa3K+Cw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22059-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 530985FABE9
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

Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7f07292d1569..980217f755b7 100644
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


