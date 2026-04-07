Return-Path: <linux-nfs+bounces-20695-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCAjLpcF1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20695-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6774F3AEFEC
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A4C306558F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140163B8928;
	Tue,  7 Apr 2026 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHY7U2w+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E53B7759;
	Tue,  7 Apr 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568160; cv=none; b=i5J5HlLYJP5xWFm9ULsR7KIgqn5IgyUoi6QMTwP0b3RDxsV1wSysZxZzRGbZZr/fvr2FFke56GO0yNj7Jn8xSYmK9LpZBrN3OX/rvY3QcmXVZY4YclHpZAv01+pVGNfTDiiX+5E1BKNHW5g3Zd77xpugm4Kdn3Q4Qo7MmTSqnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568160; c=relaxed/simple;
	bh=OIY77SIo0TepOZn2Lbp/Z+oBVvNUrVSYNZ0dZ7ULTgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h6jlpkk1u2doNJOZKYizLLY1YC95yZbHIGDmMWwtQMF8tATwuUUe+YMmE9z2S8Idw6gmZ0do0xBWgYnRbXyavvYEuQPEiRzhRkV3PzSRLvMXj8iv2j+n3WgSSx1IenvQm/sI6aLHzhSAHlUhbz1XRs4GkPTj5FCet1rinC7yBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHY7U2w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C62C19424;
	Tue,  7 Apr 2026 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568160;
	bh=OIY77SIo0TepOZn2Lbp/Z+oBVvNUrVSYNZ0dZ7ULTgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GHY7U2w+/ngRFQ49BDULSjbJu6vVaQJonachwzkaCciCfHQzOSeC44vjGcxPyC5tM
	 eQQy6bX9xX4r4h6sdA3rzTPd9K7JcIxjx3Nj6cOJ44vdpR0wBV6n5n7+2Bmc8FAwCs
	 hTvhkfBSupQoaq2W3Gi2ezvLgIliKdBSDlzLD8gmTg8eTizF7LQ5ITr+E0RpTjWJrt
	 Vtsx59U9DLPaWNVqAceFE342MfWtEDiXatXZgLyHvqN7oaCbPXO43K0g7B7JXsvHfV
	 shzKqVeyQECC11lKX8JIw462G5N+GTP+ec2/Q09WKV8q0ge1UM5fhwGWyuVQYv21SV
	 gjxaE8IrHBK+g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:21 -0400
Subject: [PATCH 08/24] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-8-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OIY77SIo0TepOZn2Lbp/Z+oBVvNUrVSYNZ0dZ7ULTgs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUFdtgoPAdYLHuBKgS0Uu2s8rL4VBmNelNiN
 2pRjxKa4zKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFBQAKCRAADmhBGVaC
 FRPdEACTtnF28Ax1HBFWpM+qQgY4KM6ZZ9Gq7Xm0SnWn3o0L6kGZ0c+KWnKw4hb47dFRP0JxKJ0
 +OyFwwKYeSzB1Ckngu9zRmQvY90Y4IIsK3kgOWu+WZX6gclAZptAe8Eh+vJ2Kc54uWpHASuAR8J
 bgVwytzoOfPthh/CzuFsXT99jDOdg2jxxWHKOdw/WjQLdNkc/kh9S0r/r5wiPOccd2ZihmhI92Y
 mE/E9CYmOftRIhf6JMOBdsXvRfqGmiz3UHnEznCfdvRW2QEappvEXCwIcjpNX88ADmRbFbCDuND
 AaXHa00sp6t6l5xOoqp3Z7GICl+/u1q5mGF/UiPKLmnMEGE5BUC5mZFZfpUhLdY/8yckbHSLA0f
 bMdLWX1/ZztfS+SORSqXmLhy9AAE4wPlTnyTc3m4wx5aQTsudrNSA/yOMlL66ORzvFmUg2ieuDz
 cYZFuJDsHtwewoxQob9KlvkT+3u85AaigyPPGq5TBit5CYdTkMrkUgSMOT2pbmJjffGOZuMef/9
 7Xa8wNPBPO0z5jnNQCINMGwAMRucPBLGr1rVuu9lL4q6Ra+nnsl/yHiL2XCO14lYmWkXK8IItaI
 r8G0rfgpYoJCO21dOyQh831cKMINEhKEtoD4MJcN2UYJVev/XexzmcmJpT0jtvnS1haa76ljSqX
 I0I7tYU4paIw4lw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20695-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6774F3AEFEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new helper function that will update the mask on the nfsd_file's
fsnotify_mark to be a union of all current directory delegations on an
inode. Call that when directory delegations are added or removed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c8fb84c38637..9a4cff08c67d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1258,6 +1258,37 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
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
+		set |= FS_CREATE;
+	else
+		clear |= FS_CREATE;
+
+	if (lease_mask & FL_IGN_DIR_DELETE)
+		set |= FS_DELETE;
+	else
+		clear |= FS_DELETE;
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
@@ -1266,6 +1297,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 	WARN_ON_ONCE(!fp->fi_delegees);
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
+	nfsd_fsnotify_recalc_mask(nf);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
@@ -9652,6 +9684,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	if (!status) {
 		put_nfs4_file(fp);
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
 	}
 

-- 
2.53.0


