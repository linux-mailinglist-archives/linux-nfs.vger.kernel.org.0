Return-Path: <linux-nfs+bounces-21768-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBHiCzZDD2r/IQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21768-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 19:39:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA05AA64F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 19:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312C632B46A1
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7373803C7;
	Thu, 21 May 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHa+Xgrj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8D37DEA9;
	Thu, 21 May 2026 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381468; cv=none; b=rUHQL6X6tFusaiqO6EHnZzP4ubJT6pW0E78gRQnaSe6DaO67mdnB/iy14t1pi2OYkZ2aQKrJKtUI/b1FlaO7pUmtVOtICbqwYixIR0+3jz0rHQv9AT4v8nnlZn0OHAkoKJKV7gXVRh1msW5zVCwjRPoUaO+0m8G36FI0Z/Rk1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381468; c=relaxed/simple;
	bh=W6z9vIS9ehBdqDDdgqnoY4qHhGMEDJM7UDKWv0oLUjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HdTfA+TJWNgISHsrfHNbMBM+ADK085tQZ513CdSiytSeLIo6BfoGj5xRa3fe3PKci+6xw4R/jBM3tqm/8AGeAt2h/tScZCqoJJ/7UMZ+zl66XDlky7COWlyFsuI6yhqZMxNc8KuRI1Ddfg+VmuA67ia1IRExBY4ZQePGWwGGbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHa+Xgrj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01241F000E9;
	Thu, 21 May 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381466;
	bh=K6L7LB6EdUowx3ruqlhdtOVGYhMSacY7PNclBQH3tNQ=;
	h=From:Date:Subject:To:Cc;
	b=MHa+XgrjbfBNYcRXd5RtnnMgejDrxVPe4B6HD7bgIm/VMDiVA6F+nUM6aLXPVuWVB
	 fsr9roYzeoRAwmYKB75QVHadmmyWpXd/dzkP3+xI/2Shg6b8Tabdrb0MNb1RPBDwzD
	 SaEVMvApmIkgLVL5ZiSB7/64cpjXXrnne/kjo751Mg6QoaPWk5Cdu1JPpYIouhCaGN
	 Q7X+DnLPn9GLuu55bOvYKBzWhmGo1odJoIfH3DGNtEujlt+K0fh2BbQhKjMQ+bNAXh
	 sS8MI3GHoKjCl1B00oPcxb2D3pYgcEMQWUn9O0Q6Il/ItJotFOAACoKNrGCifbU2P3
	 Isea1t0B2S0Mg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 21 May 2026 12:37:33 -0400
Subject: [PATCH] nfsd: fix posix_acl leak and ignored error in
 nfsd4_create_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nfsd4_create_file_leaks_attrs_on_start_creating_err-v1-1-646697806453@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNUQrCMBAFr1LybSANasSriCxL81IXSyq7QYTSu
 xv0c2CY2ZxBBeauw+YUbzFZa4fxMLjpwXWGl9zZxRDP4RRHX4vlI00KbqAiC2gBP424NTVaK1l
 jbX9B6kxQ9RwYKaaccCmul1+KIp/f9Xbf9y+ism6YhQAAAA==
X-Change-ID: 20260521-nfsd4_create_file_leaks_attrs_on_start_creating_err-a0ae727d7e8f
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=W6z9vIS9ehBdqDDdgqnoY4qHhGMEDJM7UDKWv0oLUjU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqDzTUeHDRRLdEmllt81fTTr04scY9T0bUM0Q4a
 6VAlTHOf4eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCag801AAKCRAADmhBGVaC
 FXYbD/9AfG9fPkrnYzZJO2yJWBhqb0RDnCsktcWwKd6zmEI4sabz1DYIXaI5/VoCny4eEh1kS3c
 OuDzhm3yJa6LSItf/PuCMc8fPmDay/qe+7pNbGx46ARgIlv/RMQgS2LYAS58vBmRG/ck5AWEH7X
 cl2wCUOXhEsAGRdEiF6irD12lk+UKBPirRTVXtxKhlHSdIuHnBWuyq9qHdWRSYNbD+n64SiVWSr
 OUi8xj4gHsmCkHAnZjmJFvx/wGlMvSJEJzszTIJeAS6sTUaQhsfqhwn0OQzznWzxOMi/p/3LgVE
 NjeespnIRn3AEP26erFX+FucG7Zfh0JTFjiDcoE7ZT1CDF4GIxG6z+HpJY1XJT/ZVd9LwGjmrep
 5zxKTfpvfY2kLpHuhcQgVmsB50jNT5wMtJy4eFW6cYbezdAvIbaUFxf7xHBiLZZOvFxwY6OsULp
 cBM5OBm+GhuAlDR2duD3sX+0fWA85myo1mCRd+ap3XXkW2DFgYRF7f8q+DomM9NikhDjfvBc+4/
 d6J34gN1leLuSbwXwKSvi93Lfb5TkuAE1NLUybcz5/rn5W6oJ1bYaxR/dKrFCmqSBHZbZOYGyr5
 Nhi0LMi4tqmBNgnlGTV8skivuTFSjdSxOpUbXqxZvyMyrNQzIQSYumHGmAQEB5LGF5zFI4lh3go
 AHEeb6W4iCMdLGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21768-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DCA05AA64F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_create_file() has two bugs in its ACL handling:

The return value of nfsd4_acl_to_attr() is silently discarded.  When
the NFSv4-to-POSIX ACL conversion fails (e.g., -EINVAL for
unsupported ACE types), the file is created without any ACL and the
client receives NFS4_OK.  This violates RFC 7530/8881 which require
the server to reject unsupported attributes on CREATE.

When start_creating() fails after ACL attributes have been populated
in attrs (either via nfsd4_acl_to_attr or via ownership transfer from
open->op_dpacl/op_pacl), the function jumps to out_write which skips
nfsd_attrs_free().  The posix_acl allocations are leaked.  A client
can trigger this repeatedly with OPEN(CREATE), ACL attributes, and an
invalid filename (e.g., longer than NAME_MAX).

Fix both by capturing the nfsd4_acl_to_attr() return value and by
changing the early error paths to jump to out instead of out_write.
Initialize child to ERR_PTR(-EINVAL) so that end_creating() is safe
to call even if start_creating() was never reached.

Fixes: 7ab96df840e6 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
Reported-by: Chris Mason <clm@meta.com>
Assisted-by: kres:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 85e94c30285a..c82f7c1a3cc8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -253,7 +253,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		.na_iattr	= iap,
 		.na_seclabel	= &open->op_label,
 	};
-	struct dentry *parent, *child;
+	struct dentry *parent, *child = ERR_PTR(-EINVAL);
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
@@ -277,10 +277,14 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (open->op_acl) {
 		if (open->op_dpacl || open->op_pacl) {
 			status = nfserr_inval;
-			goto out_write;
+			goto out;
+		}
+		if (is_create_with_attrs(open)) {
+			status = nfsd4_acl_to_attr(NF4REG, open->op_acl,
+						   &attrs);
+			if (status)
+				goto out;
 		}
-		if (is_create_with_attrs(open))
-			nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
 	} else if (is_create_with_attrs(open)) {
 		/* The dpacl and pacl will get released by nfsd_attrs_free(). */
 		attrs.na_dpacl = open->op_dpacl;
@@ -293,7 +297,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
 	if (IS_ERR(child)) {
 		status = nfserrno(PTR_ERR(child));
-		goto out_write;
+		goto out;
 	}
 
 	if (d_really_is_negative(child)) {
@@ -407,7 +411,6 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	end_creating(child);
 	nfsd_attrs_free(&attrs);
-out_write:
 	fh_drop_write(fhp);
 	return status;
 }

---
base-commit: 910a469edfa98eb15e2a5f7d5f668d19da7b2e6a
change-id: 20260521-nfsd4_create_file_leaks_attrs_on_start_creating_err-a0ae727d7e8f

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


