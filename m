Return-Path: <linux-nfs+bounces-21820-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JVuNsixEGpWcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21820-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:43:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB755B987B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0E46300D4EA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF33803CC;
	Fri, 22 May 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKKLSSAt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89037DAA3;
	Fri, 22 May 2026 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478962; cv=none; b=Ch1vn9Ks49BltW/5yAz7k3eCuRpw+OfRAYZZVeMvqvKCjPZViSRINm2I+t1G8Me5cFUJTaJDaOL6YiJtSY7Z7LGpXx5eWxNkm7GIoQA7W6uXQ++p7xs03UM8jHeD5tut/pH4DeHCspQuyzLzCk3bu8Ic+DH1ZWKVI111Zp1I8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478962; c=relaxed/simple;
	bh=qKZ8zjvP2Xs35BWr9tiO7rsFDru5X9fTbNx6jHh/zrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvNfg+GN2Silasj8eFC3fTBBzFTiVgWfN1qq9E2TgnwYRl4ArhQSd51x6DTLG8LEkc2JTzBt8nXatK/jR9/gORfOzEiDaoN9VItfNXcmN7+y7nzuB7jZzuNNTge81wFgBsODI8m8ZVmQ6MQbVm+LvVNUNSTd6ntBRtllalBIXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKKLSSAt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4071F00ADF;
	Fri, 22 May 2026 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478959;
	bh=j4ljdTpxSG5wTs+lDKxX1dHcNes13mwmx+PX0QnrTgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KKKLSSAthz1qEfj3B73Ld+wNvd0+op4ftfGLjBimIkbogxRAbaovgmw8g26eXJA5d
	 fdVfIjBLAkB+zsnVS2K8ASgFT+MyCn6p46B8yWva50jSFAQ0xR8/MSUVkcgAutqjKd
	 jub9zl0tM/YROa4Mr1Cs4+Mp4SGmwZinXKR+lthTgksSebT19z8Bdl6Ki4fJagzFAD
	 NJEzqfGV/MDNGlaqKKBmNhwbZLG0bDCTAvBlvBrYsp4BdUUPSetvpjW0c3/1ru1PtR
	 CZKik399jPKzd2+Fz6puOFx0Yx+rF3JhdA+o0eI+5iuKdh5w8U5zdYP3y97tIou3lh
	 7GLVaEDbKgXAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:10 -0400
Subject: [PATCH v5 05/21] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-5-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qKZ8zjvP2Xs35BWr9tiO7rsFDru5X9fTbNx6jHh/zrc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGdUnSrM+7GqaXKEkmzDeA6+jmFiRrRE4P2L
 z0IxH95/amJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxnQAKCRAADmhBGVaC
 Ff60D/0U47/xb2hDeMtC3yll2CDOR5H8rXGbl3obNQk104SyLPXKgAXoT4YQRvfCDQ73RHGhod5
 yU59TfIxoUc4GPcD2idBq0Vdc/pRWAyu57lTIJNpc+UiBY37dL0xhATrJgHLlmOWksLx+oZgd4F
 oUtVOehsjdRaE14vUnJTBiHYJZffsz6cwL5ovLs9lSui/3EaZUwP3VL4pFoDsZjUI2xdiFNs9RE
 ZjD9GcPpTnK64EbOvH3/UhugbpeCoDnZ+O/FBmrN6LMEWFz9Cs/ntuStJrQb/k43BmRABjMx8q1
 HiOQsqHqx66qnSgbVUhkcXAHu8xoo9Txwef190facTp28xQKEmZjC0VnrMlfq6rnsXOkN4pKrZP
 8k06bvtNJcIrjrvuXRVTtS4ea65lUQUZ23nf36ZY8BUZklKaEekvg4X45djNYw0vcXFt6pxKxxW
 8bZWLCIlkaY7A00rnkhKzo/kERij6BG8Ou8NPZo7VxCeYdxqNY2Wg3zxNmqcawldUZ9XCKDWvlJ
 IXqtReLH4ZAYJoqlgU2YeRhLklvirJ99Aq0ws0lVFQgIOHVJKy/u/D6WEqak/2XObrxKxdD5IUL
 eLKbYcagJU9q+DmJJBhzE8LI4ggaVxtlNA+kKCdkLnZ5miMUnUd66FqcBxJ/jb5QZytOT2lSZiO
 0+lzu1rj34f6ffA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21820-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.cz:email]
X-Rspamd-Queue-Id: 7BB755B987B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new helper function that will update the mask on the nfsd_file's
fsnotify_mark to be a union of all current directory delegations on an
inode. Call that when directory delegations are added or removed.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2a34ba457b74..efbc99f0a965 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1246,6 +1246,38 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	nfsd_update_cmtime_attr(f, ATTR_ATIME);
 }
 
+static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+	u32 lease_mask, set = 0, clear = 0;
+	struct fsnotify_mark *mark;
+
+	/* This is only needed when adding or removing dir delegs */
+	if (!S_ISDIR(inode->i_mode) || !nf->nf_mark)
+		return;
+
+	/* Set up notifications for any ignored delegation events */
+	lease_mask = inode_lease_ignore_mask(inode);
+	mark = &nf->nf_mark->nfm_mark;
+
+	if (lease_mask & FL_IGN_DIR_CREATE)
+		set |= FS_CREATE | FS_MOVED_TO;
+	else
+		clear |= FS_CREATE | FS_MOVED_TO;
+
+	if (lease_mask & FL_IGN_DIR_DELETE)
+		set |= FS_DELETE | FS_MOVED_FROM;
+	else
+		clear |= FS_DELETE | FS_MOVED_FROM;
+
+	if (lease_mask & FL_IGN_DIR_RENAME)
+		set |= FS_RENAME;
+	else
+		clear |= FS_RENAME;
+
+	fsnotify_modify_mark_mask(mark, set, clear);
+}
+
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
@@ -1255,6 +1287,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
+	nfsd_fsnotify_recalc_mask(nf);
 	put_deleg_file(fp);
 }
 
@@ -9682,6 +9715,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	if (!status) {
 		put_nfs4_file(fp);
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
 	}
 

-- 
2.54.0


