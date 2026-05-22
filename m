Return-Path: <linux-nfs+bounces-21786-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCRpMMtNEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21786-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:36:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992D5B42B2
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E139306E68D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA1391E55;
	Fri, 22 May 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbDzxpd1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE438237D;
	Fri, 22 May 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452959; cv=none; b=eUgNR9VMkY1jW4ZPoBic4W2NmcgVmhY4+EcSOcEGLLWsiCddAkviqh+uRS/UYxwqNGn+f0GUpxNLtsEPWLqFAU/KAYSFZRvi3qSr0q7qYhXFmaKHGoR10Dnb2R0V51oV/zcqYoGPGXkk+aYHqsgqyxD+N0EndFJM7B53nXZecTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452959; c=relaxed/simple;
	bh=niHRetJpdk8GdDu45WpThrb5QNns7NwqVudj1Z7UsxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ds3x2TMoyaLx9FjVCbVH4gjITziPAxltsEmkITkfP3tfcOFJKq93MwZIbf2zWkbXCZeMVdpPehv7Ysk+LRW1z4eljjzkPPK9JY9+hzzAmHxb1Cpc3Dg/yyR4DJKQuqOgpCijBNzorm1QlT8jEC0NzDir0SIauxx4ureM9SI4dpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbDzxpd1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F61F00A3E;
	Fri, 22 May 2026 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452957;
	bh=HYxzjQeJXDqfECCwC1Wng+6TWYv7L4DR2K7Z13hoaks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HbDzxpd1ec7V+vXBfNmYvpOMPE53/wW11i8BrwP48TbiTwdC2T74kt6MuKzVDREsv
	 cI3VUIoR7Lbv3rnTf37XaBy7VUTzAU79/npS6AU4VYdJwosnxyl8dJxg7F7h2sKB2I
	 8ueM4pxCMO0DBpL+sZQCqt8pi5ablsieRW5VAbPFKq/sahN7v/bWC/Et+yayWHOF/D
	 58bZ1BF8/qYG0UOxflehbKxTOo8GmkuSbPq1LAaO+hhMwPLPmC0Y5jKhBawqyEbFAD
	 SjTnglkCa9Y5po4dBjXG4IrDEUOe65/U9cdISMA2lRdULro+uSbZMKQMDNKPnSLapk
	 t21kTDKMD9Pgg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:28:54 -0400
Subject: [PATCH v4 05/21] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-5-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=niHRetJpdk8GdDu45WpThrb5QNns7NwqVudj1Z7UsxI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwOHPX4H/JbJEfH4Mbi05HZ9gWCjH24ntIb0
 P8BCcAccA6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDgAKCRAADmhBGVaC
 FQ2uD/4jHX82IdxjK2/OjFButxydi9cmrOXH9n2BhoUbAhB50lmFLTcJLSMztFrND4855VEUdbk
 2Qu5j4Awnrv0ViPWbVwgZVVqm4ye0sCtFdUVeefwgsBaKoZ5ns/052ZYZCeUxMQ2c6aMVovBz21
 7ysNIfTyKClPXmTDZf9+Tq5IzZiZcXezu6K+q/X62lrAEG9IugpZcqwJqDBUy7l5TDaM4AsDKC4
 LuY+WrRlfzct2wFzv6mcqDUr6MQPoHw55gL0jlvM+q+Ea8vA2hPolM/82q4/lJijOS8HQQqgamr
 57FlDxp+U0KCJXoDxaO5NFUc90FLDuXkxwVI1e3kkBXtuWY38RUhO8flXpZmwfP+lSxTZqxCZRi
 ghBkMjO9CYW3AAIGgTv9Mrd+APWQrVMKk1ErZkkDfbA8S8jxbz+hyZCkiNyiX97oLQ+czyMlsJh
 feHKrd79f46hCSLrEWRGAyogZrdiL7I5TgfXHTynbkMfBrj1T2uLvJz7U9Xpo2u8QEztNmwvs0c
 KcdmBjVv5YB6OmOEW8BUokhX/1kMiLYJYkKXyDrlA9S+Dl6E80X/0CjgvHWJFOrIA3Igs+PuD2z
 GlNPuEUbubiBkttH+VD6Olyl2MlOMFO7L1arogoIgTndGHWi9lWrJQhSmDHmJ+RJeDXDlXRUSHF
 WiRKzwn7dGrijOw==
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
	TAGGED_FROM(0.00)[bounces-21786-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7992D5B42B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new helper function that will update the mask on the nfsd_file's
fsnotify_mark to be a union of all current directory delegations on an
inode. Call that when directory delegations are added or removed.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2a34ba457b74..f559ce4422da 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1246,6 +1246,37 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	nfsd_update_cmtime_attr(f, ATTR_ATIME);
 }
 
+static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
+{
+	struct fsnotify_mark *mark = &nf->nf_mark->nfm_mark;
+	struct inode *inode = file_inode(nf->nf_file);
+	u32 lease_mask, set = 0, clear = 0;
+
+	/* This is only needed when adding or removing dir delegs */
+	if (!S_ISDIR(inode->i_mode))
+		return;
+
+	/* Set up notifications for any ignored delegation events */
+	lease_mask = inode_lease_ignore_mask(inode);
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
@@ -1255,6 +1286,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
+	nfsd_fsnotify_recalc_mask(nf);
 	put_deleg_file(fp);
 }
 
@@ -9682,6 +9714,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	if (!status) {
 		put_nfs4_file(fp);
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
 	}
 

-- 
2.54.0


