Return-Path: <linux-nfs+bounces-20884-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGtYDzcf4Wl0pQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20884-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:41:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E050C4130CB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D517E318C5CA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D563D34B7;
	Thu, 16 Apr 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ3Ni/xm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E703BD22E;
	Thu, 16 Apr 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360947; cv=none; b=GmlHE5CD6uyBRKALL0qyDW6vww0GgDqmoRSnpg+9bo3jUrN3h+1rDsGDKvzYexGZn7iwiBMu9md+yJQtkQxtei4frR7ZjwGHchkMo/giYn2fRM/8uUf6kQmw5/McTTBiVWi40fm5W63e81SN6PfgcDZn6+Ag6hBuxadqxaV/Us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360947; c=relaxed/simple;
	bh=9G/ip8vcVyOFHKvuu+8SPrBglYdUuTi3uOEL/o3qwLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Se9/JXNtI3o2Ulsleu6LINs0zKVw+qPI7QX60SV84x2PXi9GCoZbdol1temx4T3ykR+pLGeNixMLBdt5Y5HhZFelwCMtDxHSN8OWlfXtwKKdVqo7Y3wgDwZMKB/CBOmLuG94Vn3aeF1xdRFc7Iw/eVLME0jZtg1CBK7g+VP5MLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ3Ni/xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC73DC2BCB7;
	Thu, 16 Apr 2026 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360947;
	bh=9G/ip8vcVyOFHKvuu+8SPrBglYdUuTi3uOEL/o3qwLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CZ3Ni/xmBOVUqLTKP2GSGNIt8KEdum6eBGdcg9+Iow6Ljla3Xpbi6U623098ABrkd
	 WXAz1YB7XSJSOh6uVfxR/kERRuEV4o91Xm+K3sFoqtyRy9J0WmL2qE/zWfFdHs8ZKX
	 zF9cKx0+oyF3/yrXNi3OGYlbnJMFt6lXnpY/1O75WX/3i/sMv9zrN/2ICH+vOVY5iC
	 Oe6tbSVz6T3HxB7h+VnlgSb4k4WQMB4aIuiCDkW0C8xQBrZ2nEVpvlcRq9IrQBAMrP
	 DuEz14HWfa1StK1Yz2niXq+4kQOvA8OBRoiBdO6XLp3Ixvcp+iD5y7bYCn6tIbM7Ha
	 pkF1zm84KxrUA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:13 -0700
Subject: [PATCH v2 12/28] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-12-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9G/ip8vcVyOFHKvuu+8SPrBglYdUuTi3uOEL/o3qwLM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3kZ4HmgzmGKOhLVLMhD9W3b4OOkjdcobFJO
 xCwV2K8smmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5AAKCRAADmhBGVaC
 FX8sEADGgZOtLsVACMdauTymO+jpJSdtr14tviPJJ+0W82d8KUOYNSJMQLCO1cZu9DKfsy4u5yZ
 F88G2E7t4+XnWbkJ369M+6FaQvTHnv2VF15ug+OfohOusjM1Qr/v1sVq141mUT4BgkLNDHaFXtM
 gWZUa422E/bPK0dQY/KUcsmNOkZBG7dzKVfEyqs9DKIeuDe47HqRqE6Gg/qB95EMHpXmlb7NrMa
 eju5K9pgU4lWI3nmwyoNIM97kWYe54VlwdFgn1mx1up2aaqgeC5reffUSXHmL2JhGgY9OI3R9xE
 GqGwLvS4XvsNPe0JpHK8bcZyAPvTRNAPABmeTrDw0pAAmZw5lwiriAELDHVr17iIxH1VdSKOyi8
 qOM6W0T6IjniN7xBSs8lmmf748Jpurg69BXOvy9RcXqaiBOgaqCRA2WFu67lvVtNBQZJgZ548q/
 N6cKB05uKaeK5ZtSYqNmYGnz1f1jNvGMKPxdWuCGiNYkmO2yNSBiFjW40rVQ4cncVCPsih7ZAu2
 r/hzhlrzJnDbUdmYDBibVsHe91VITs+9GFBfbFP2rG+5qI+zmYN2B1ZFuIyaTwJlevTLSQH/X5/
 aTT26dPdUOn0ZfcVPTkxk4yArYApeJSCMAxqJ4211PQ1a/S0uOjx/hZtY6+lmGYwoDswEiCiweu
 87mFfI8kJjMzAXg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20884-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: E050C4130CB
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
index bd7e4f9cdaa5..6adce94e9fdb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1260,6 +1260,37 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	}
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
@@ -1269,6 +1300,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
+	nfsd_fsnotify_recalc_mask(nf);
 	put_deleg_file(fp);
 }
 
@@ -9674,6 +9706,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	if (!status) {
 		put_nfs4_file(fp);
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
 	}
 

-- 
2.53.0


