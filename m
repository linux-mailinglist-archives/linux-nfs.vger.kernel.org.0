Return-Path: <linux-nfs+bounces-22103-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLUCLCfkGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22103-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF40E60CF11
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6CD8301286A
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0B3C5536;
	Sat, 30 May 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGrZ6HQf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4F3C455B;
	Sat, 30 May 2026 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147181; cv=none; b=FT+j1CX93QkuOqvVMXMiiTSxakLMZdPQKsBfcAXhHynGbD6LIMq4o2+Odrrx2ERapGocXdK9qOBoEA6QPnRzp5gOV6r94WNC4wlo0TTJyhDYXiUImeWgt62RH81ppJdwY39kmF4c69dI2aCSKVXYUw6boUBMub4OAYnuZ2p5p/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147181; c=relaxed/simple;
	bh=sot5+tKVgtaC160u4M8TGQraPyvQTXydRcusfzEUg2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TC7VTRRkKiKIZwLGps9pMigs+y8WhZorHpxMF9AIMyMEBYL18tNF1flnFr1EES1HITsTR5/PxxTPtKAc3pcS7/fykut2EFcr07BdF91d7VjwVrJT8EQdFrbmb2dv6UUVoWPJQ9YdghNGC30y3TpQ7clVRfoB86R9G56Oox56Orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGrZ6HQf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D901F0089B;
	Sat, 30 May 2026 13:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147180;
	bh=sFaI/a/4xWXZcC/5jNWNbgjAN4Llr7aadrkx5DJdv58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fGrZ6HQfg3L+vnGq0fAjNDiZScVKSKf1jaofAzBm8XPt3hjFWTE/HcKRP/AACec+p
	 anoWRoV73KlAEfaFGwiWdTPNUDBM/7FV3m3IPV0XPnyOBbQlccxXr0+isf+08BTJji
	 x8p7zaodcfYDqg+EgXGzpPv1hgHAC093Ah+Y4nmUPluGhjilcYjBCd32SbE/cO62Ic
	 c1I7bmqGfgLJU+Vi8OG2pT7ffjlYRDN1P+IHcv9eqpYFzufCKGLqjdgvh59YHor2Wn
	 nf8FDj3ispwmdb8gVrhyP93FOktX+zHHycYknuHfbQtM+ELbTglVkNXrrnVksff8UE
	 TPrKtsa0i1Emw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:21 -0400
Subject: [PATCH v2 5/9] nfsd: gate nfs3 setacl by argp->mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-5-f27e8eb4d974@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2589; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gO0GOBKMvg8PUpOwP9lvo2CvRA28Q1EzXJkDWsmA54g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPhADN7oq4012TcNukxq4S4xYMcXga3Ok6b7
 EifOYACBSCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4QAKCRAADmhBGVaC
 FcSYD/0St2HxGCu3cNzD/54z9a3K9vshABwbubiW7ACGJoGYKkdsl6ZyKb/gcHVTRxVf9isGQ7v
 +DY4TCUo0WvGxV+gkJdeu9cp+6sP/0m6HaFrutNBnvOUagtPVQ9nSuhGS5qrFlyVHu0foYaP+Ny
 AI1iqpoSbaHKHaBhnxjmJ3WQoU9LSIPciUEb3Uc440ZPRj6bfwvlbTFFIncVc4HYGnbnBfRWJEK
 /ZBXFZs+rHSURJwDK81VIiUw5hj3xcuzrH7fShzGO6IdiU3LJTPC+FKT0Q3mYAAaSoPGIzAKZWm
 r549A/N4U2YxjCaX26AOsxRCXBd/8DEynu9EswITqgmS9r+h1bLXc1wq0MEqxizoUS/2deR2M9Q
 QC+1OJTeRbjH3fjbVzWQJ/o5VSczUSl6Ym9QPI43KBRiXkg3BdxZJv8nwJcta7w2lJQQYn8JyK8
 oWunY13+xmSqOOAE6418lXyFh+q7srG25LyvR1iQFopmuizUSGwIpPvKmNUTGcAZIrUaeHORPoU
 nD2mBBLiVb9b4vgLmgHtEiaaf8UbYgldc+2FQmlKInj6u2gVd0+37HGqQG0iNlF9Cdv4kQDl0N7
 gEtkwquEkFEyePkW1HHM5Lw9Jijk8GOSM29hn5icJRh7AneUiVQ7YMuPzs8swjngk7HbgXpmi5L
 fqfIgaJ9cd5AiWA==
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
	TAGGED_FROM(0.00)[bounces-22103-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DF40E60CF11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd3_proc_setacl() calls set_posix_acl() unconditionally for both
ACL_TYPE_ACCESS and ACL_TYPE_DEFAULT, passing argp->acl_access and
argp->acl_default verbatim. The NFSv3 ACL decoder only populates
those pointers when the corresponding mask bit is set:

    nfs3svc_decode_setaclargs()
      if (args->mask & NFS_ACL)    decode into acl_access
      if (args->mask & NFS_DFACL)  decode into acl_default
      /* otherwise the pointer stays NULL (pc_argzero) */

    nfsd3_proc_setacl()
      set_posix_acl(.., ACL_TYPE_ACCESS,  argp->acl_access)
      set_posix_acl(.., ACL_TYPE_DEFAULT, argp->acl_default)

set_posix_acl(idmap, dentry, type, NULL) is the VFS "remove this
ACL type" operation. A NULL pointer that means "the client did not
send this arm" is therefore indistinguishable from "the client
asked to remove this ACL". A SETACL with mask=NFS_ACL silently
drops the directory's default ACL; mask=0 drops both.

The sibling nfsd3_proc_getacl() already consults argp->mask before
touching each arm; mirror that in setacl.

Fix by wrapping each set_posix_acl() call in the matching mask bit
check and initializing error to 0 before inode_lock so that a
request with neither bit set leaves the on-disk ACLs untouched and
returns nfs_ok. The out_drop_lock path and the unconditional
posix_acl_release() at out: are preserved; both NULL-tolerate the
skipped arms.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs3acl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index e87731380be8..a87f9d7f32be 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -105,12 +105,17 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	inode_lock(inode);
 
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_ACCESS,
-			      argp->acl_access);
-	if (error)
-		goto out_drop_lock;
-	error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry, ACL_TYPE_DEFAULT,
-			      argp->acl_default);
+	error = 0;
+	if (argp->mask & NFS_ACL) {
+		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+				      ACL_TYPE_ACCESS, argp->acl_access);
+		if (error)
+			goto out_drop_lock;
+	}
+	if (argp->mask & NFS_DFACL) {
+		error = set_posix_acl(&nop_mnt_idmap, fh->fh_dentry,
+				      ACL_TYPE_DEFAULT, argp->acl_default);
+	}
 
 out_drop_lock:
 	inode_unlock(inode);

-- 
2.54.0


