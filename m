Return-Path: <linux-nfs+bounces-22055-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGY2G/i5GGptmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22055-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:56:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7F5FA9BE
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48382306C51A
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109F367B7C;
	Thu, 28 May 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWwOfy3p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B8364022;
	Thu, 28 May 2026 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005334; cv=none; b=SshIDKYkggbR1NrCjweaaqRtDioEwt/QQB3g031hIOiNz/zDteajuKQvX0IqyCHajfflV6nZuZ5EY1QRMcDaLkAmEeui2m/ZNhgsfNG/qtF5JPea3bFCEd7iWqe8Oax0RpK+7vVmrleihe4p8fNcFdRhsXMJP3hUaMTIZaYZswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005334; c=relaxed/simple;
	bh=YAH9aYuQ/asSkIDfru6IiARavtx0MGFCnZ91OnZ6PFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNy82WB2m5a/5tyb/77xOHqXVhC+iAIjA5TEjRJEIBewlFkBDan0hdyrod2orljeQ+TGLmH7VVG4tNGQmoxVBLU0Mv1i2aP9xnBjlXjaBOMQ25HEgU8f2QtYzQ0DBzeKSqOQfSlNXeVkHnEruJuMVi/UecaYq4domBhZcQsYJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWwOfy3p; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063E11F000E9;
	Thu, 28 May 2026 21:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005333;
	bh=XweS3kpwFRW8Ff1+y4OnFCCxftQN7f5Y1CuJL5J4wJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dWwOfy3pASJq0nV27PEN0JziH6gmpJ+oxyVjFH1kpX7+dN2ttuLkkDEKNawr1+6Dh
	 6SfJGaf9/VmgsLImbMoG1EXwQSDAU9ThEDoWYwuVBqXvkXRabv7buu1TY/9qHXC8Gj
	 Lm4/lFJaqYXe1iZUshELPlbstkn1+oJPZE0HKloQrTUlSsZVjpJrp37KYTqhU9dgdO
	 qYM/EnG/gLB4hUZmeLXu3eKc8zdz1w08DlUJxaiG5ngEYCRrH7LOD86TeAiAVLD0se
	 pGIHV0ySsXdyHzJDZKLB82Clt06UK70MgtoavLLQ9MvPJgRKHrCzpulLvGL3m9xjzm
	 61eA2oYz+ZvyQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:16 -0400
Subject: [PATCH 05/10] nfsd: gate nfs3 setacl by argp->mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-5-e78708eff77d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yVYZuP8p+I7kHsmp4bD8/GooOKvKdgjutKo3ZY9ai3c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnKsJJ7bay0rDB8IbSNdFmWLWnzIkMAgrNvM
 Tkl9ekbMQWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5ygAKCRAADmhBGVaC
 FZb1D/9oGuSsOs2UBP0hH3k3DCeMBqnPhfoD/3g8YcwR509bIAVn7o/n7SI21j+1qyO3pPdZYRp
 A2526jXo1Lb5WsmmP86JpmpaUr9Wbp1qlic3v9R0a7K0hiB4HaOqCCI4Jx0CjAB5kUR4cjr11zq
 eOjP0WJc+wjNhHWNePbcYyLKqDmR3SMP+GJwccFBRHW9fdMTkZKgWrm4nDVr5HUYsAPquEFEQFD
 oYS1UGrOY7o18nsds6/jzTw2C52mFoJtkKe9oQx8cjLi2qKdQiBFn8HDw/dorN0ab0/cz2imSK3
 cB61XIksY3SH2JcBAmRZJTd0GlCbgnSj5XcEV4E8I78JrpNVMR7DbndezBNz8c08ks/iOFCSegO
 UC0bV0bWrC7UGZ8LeeldWORyAmcMhgiIHcxGSMC6IqCU9RvJUGt1ykUEvkhhpMCPrIpHN+PV0K9
 GywThL/xnsxH9hPkFe0VxoLYdtaJPudNnjx7lbJbp0kNLBTPqFg0JnCOcbLK4drbBCsA+ScGSAx
 DxlfiG1X2aVFKUkvcBaCbEQmMCOLkdEiODXAC/TVjhVzg3Q+XXClb19L8fBEAdP/rBikzWTeMp1
 42c2OcfGyhE4gnafqgaEPRZzrxoDaK9KOYRlcDBlMm7waVBkf+cNeE/YWV+8pGjoIprYjsrOh8J
 v7Jhu5+ezlSi9iQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22055-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 0FE7F5FA9BE
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


