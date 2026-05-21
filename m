Return-Path: <linux-nfs+bounces-21769-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ+PB6BRD2qQJAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21769-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 20:40:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185785AB2C1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51D9B3037500
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5E3ED3A6;
	Thu, 21 May 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUhm7WBn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2E383999;
	Thu, 21 May 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385925; cv=none; b=d37dZ96+GbOT85KWnT6ZQW5ZjaR7xWpktmTY1Wx54lVQGi2KEu8jDRdbfsJ9ckB0a3lFsk78DBo7kc1pr+DICyV/yYkSIlEgbBRG3fMT6PAqCc/Igg8b+ZxM/a3YA8A24UY6IroVoHwFk+V3Zx8jdXWbcjG4JavYjVJ6s4/Oa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385925; c=relaxed/simple;
	bh=8OQtRy7YhzKrPNJN5P591KPLgR+MJh1DL9FBS1oR5yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s59Fpwb4sHuPEVm92FnDGFEQGAYFbFSC5NaXpd3pBRUQXmFMRDjh+FFWfo3DUVePteopHtL3yJPSAv7xNgwnzOCV+1P8YI162XUfwQU6GHsXM14W5iKv2fkZGyJ3r5AHsT508MgIK1kRbkA2eRQCKYby01or95aEQ98ISQ/wS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUhm7WBn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BFF1F000E9;
	Thu, 21 May 2026 17:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779385923;
	bh=iqOcyW8mVYRnv1j9W3mD0qOFPdf/wuTmiTMb5Z0f2NM=;
	h=From:Date:Subject:To:Cc;
	b=TUhm7WBndbQZ5vL8avRUlpEqrw9Zp5gdQJ+vNlGSp0yDUZ3FvRjGOwgws0z3XPuRC
	 7vj7DdgajWZFDhX9X/x8MITuL4IPj6yGi0Dd1b0fXmO17iuaHbqVdYvrkXyUl5QuXX
	 t4Q4WbWMcliVzhhHv7C4a0HY1Td63oIlu+FIn+5XX5bazgGsLL8hBfF33eSY5IpysC
	 WSBc0qMt9SeUXON/NwY29/ggLLzWGT32DPElpmzfWd0Wo5XWjE3EoSJgZaQr0yP2Pc
	 ZCiuIr6LeOgj8puVN7jhp01pj9+rSaZW1pK0OnugglFiKOZbCOYnYbQ+KUSjRHgbFc
	 hnYVdLoS9RPDA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 May 2026 13:51:43 -0400
Subject: [PATCH] nfsd: fix posix_acl leak on SETACL decode failure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-nfsd3_setacl_decode_failure_acl_leak-v1-1-8165ee755b48@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQrCMBAFf6Xs2UCaaBV/RSTE7IsuhlSyKkLpv
 xs9zhxmFlI0gdJxWKjhLSpz7TBuBkq3WK8wwp3JWTfZnRtNzco+KJ4xlcBIMyPkKOXVEH6qIN7
 N3jp/8BPb7YWppx4NWT7/zem8rl8fxPlMdgAAAA==
X-Change-ID: 20260521-nfsd3_setacl_decode_failure_acl_leak-7023836d04bd
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5165; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8OQtRy7YhzKrPNJN5P591KPLgR+MJh1DL9FBS1oR5yE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqD0Y8c+6c4eR7mlCoe6mel9biGzP3M0TUHO6Lo
 TO+ub5m/p6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCag9GPAAKCRAADmhBGVaC
 FeWHD/9I28u0mA/efE/KHH7HWOl45AqzZVDmQ1+Zw+INmwfJAZ3otXyn3CQKRyl4ks1ZjNqV++h
 4S7X4vpxF40o0gfzNGwx8Av5piUWA3hU1Q7QYR2FUs9FyFsdQIetei7jU1CpcwCmQrfWtwyT0vl
 Tt+c+bkbTc9wipo2cKCfdDtN9OzU2noJGP5B8iyRIgKqCYL/fd3f09IuAHz5z0J69n0DDyGWiiK
 UQwXfddLEn/lm/iK9KQfaLIoynoPInc0wPFbHy/i1t+TQsSybWfepP/8f6dDIvUHrYSeNf2jDdV
 10L2KNTvGCQy25XUAHyeNZ+cp47V5YGlkMeZaOy/BdF9UpmMPmUTsw85a6VLuLW2YH8H3fVGAUj
 Eiiv5telWO9yblThuovXILLdsaEHKk+UJ4+CEacrwDTjoXpFTnUZyxSPHPCvNHthkMM+aTOr6Pv
 aVQzlaZ5XDIncglUjoUZfZ28UU9teiUC4m3NSaXDRTZEmt6YGOvH3Q4x1C6mENDEGH+RJrNv1MM
 IsvQVB6Cj5sgOCMu9kd2qlF909eWRDMXZJOFFxMct6WGKyWuTuwpuSqRBXnAJF78QJPSVBfFyCx
 WGIb3n28qJRjtNuFJcse361Xktohbk3xPH+sphU9IyrxCXsTbXCoiEPeOJ7nzTrAaA98EfVSfHE
 q6r/BzPniM5xLNA==
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
	TAGGED_FROM(0.00)[bounces-21769-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 185785AB2C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsaclsvc_decode_setaclargs() and nfs3svc_decode_setaclargs() each
call nfs_stream_decode_acl() twice, first for NFS_ACL and then for
NFS_DFACL.  Each successful call transfers ownership of a freshly
allocated posix_acl into argp->acl_access or argp->acl_default.  If
the first call succeeds but the second fails, the decoder returns
false and argp->acl_access is left dangling.

ACLPROC2_SETACL.pc_release was wired to nfssvc_release_attrstat and
ACLPROC3_SETACL.pc_release was wired to nfs3svc_release_fhandle.
Both only call fh_put() and have no knowledge of the ACL fields on
argp.  The posix_acl_release() pairs sat at the out: labels inside
nfsacld_proc_setacl() and nfsd3_proc_setacl(), but svc_process()
skips pc_func when pc_decode returns false, so that cleanup is
unreachable on decode failure:

    svc_process_common()
      pc_decode()                  /* decode_setaclargs: false */
      /* pc_func skipped */
      pc_release()                 /* fh_put only — ACLs leaked */

The orphaned posix_acl is leaked for the lifetime of the server.

Fix by adding nfsaclsvc_release_setacl() and nfs3svc_release_setacl(),
which release both argp->acl_access and argp->acl_default in addition
to fh_put(), and wiring them as pc_release for their respective SETACL
procedures.  pc_release runs on every path svc_process() takes after
decode, including decode failure, so the posix_acl_release() pairs are
removed from the proc functions' out: labels to keep ownership in one
place.  This matches the existing release_getacl() pattern used by
the sibling GETACL procedures.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs2acl.c | 17 ++++++++++++-----
 fs/nfsd/nfs3acl.c | 17 ++++++++++++-----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 0ac538c76180..76305b86c1a9 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -131,10 +131,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	resp->status = fh_getattr(fh, &resp->stat);
 
 out:
-	/* argp->acl_{access,default} may have been allocated in
-	   nfssvc_decode_setaclargs. */
-	posix_acl_release(argp->acl_access);
-	posix_acl_release(argp->acl_default);
+	/* argp->acl_{access,default} are released in nfsaclsvc_release_setacl. */
 	return rpc_success;
 
 out_drop_lock:
@@ -310,6 +307,16 @@ static void nfsaclsvc_release_access(struct svc_rqst *rqstp)
 	fh_put(&resp->fh);
 }
 
+static void nfsaclsvc_release_setacl(struct svc_rqst *rqstp)
+{
+	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
+	struct nfsd_attrstat *resp = rqstp->rq_resp;
+
+	fh_put(&resp->fh);
+	posix_acl_release(argp->acl_access);
+	posix_acl_release(argp->acl_default);
+}
+
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
@@ -343,7 +350,7 @@ static const struct svc_procedure nfsd_acl_procedures2[5] = {
 		.pc_func = nfsacld_proc_setacl,
 		.pc_decode = nfsaclsvc_decode_setaclargs,
 		.pc_encode = nfssvc_encode_attrstatres,
-		.pc_release = nfssvc_release_attrstat,
+		.pc_release = nfsaclsvc_release_setacl,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
 		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd_attrstat),
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7b5433bd3019..e87731380be8 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -118,10 +118,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 out_errno:
 	resp->status = nfserrno(error);
 out:
-	/* argp->acl_{access,default} may have been allocated in
-	   nfs3svc_decode_setaclargs. */
-	posix_acl_release(argp->acl_access);
-	posix_acl_release(argp->acl_default);
+	/* argp->acl_{access,default} are released in nfs3svc_release_setacl. */
 	return rpc_success;
 }
 
@@ -223,6 +220,16 @@ static void nfs3svc_release_getacl(struct svc_rqst *rqstp)
 	posix_acl_release(resp->acl_default);
 }
 
+static void nfs3svc_release_setacl(struct svc_rqst *rqstp)
+{
+	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
+	struct nfsd3_attrstat *resp = rqstp->rq_resp;
+
+	fh_put(&resp->fh);
+	posix_acl_release(argp->acl_access);
+	posix_acl_release(argp->acl_default);
+}
+
 #define ST 1		/* status*/
 #define AT 21		/* attributes */
 #define pAT (1+AT)	/* post attributes - conditional */
@@ -256,7 +263,7 @@ static const struct svc_procedure nfsd_acl_procedures3[3] = {
 		.pc_func = nfsd3_proc_setacl,
 		.pc_decode = nfs3svc_decode_setaclargs,
 		.pc_encode = nfs3svc_encode_setaclres,
-		.pc_release = nfs3svc_release_fhandle,
+		.pc_release = nfs3svc_release_setacl,
 		.pc_argsize = sizeof(struct nfsd3_setaclargs),
 		.pc_argzero = sizeof(struct nfsd3_setaclargs),
 		.pc_ressize = sizeof(struct nfsd3_attrstat),

---
base-commit: a5e8cc71582ff32960163a9ec5fa6d8911682c68
change-id: 20260521-nfsd3_setacl_decode_failure_acl_leak-7023836d04bd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


