Return-Path: <linux-nfs+bounces-21224-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAFyKJVe8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21224-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:15:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9381047E9A8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB5A7303A7D0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388243AC0FC;
	Tue, 28 Apr 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZugNVWe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363240DFB9;
	Tue, 28 Apr 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360275; cv=none; b=hgWy8/mvlsCumzpA+ERS3Nsq/U7vDZa35HSF1Bt2nRrYZjcBy+V3SNKPknqvZD0DwmNzu018X93csONG95Wp+N8eiFPSAPb9sfvLxgnE5E5nVv3czuwDPqsj/DaElGx54LiZyi0dmFWcl+w94zUkGgGtglITg+zMZyb2ig00/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360275; c=relaxed/simple;
	bh=xIXwEMi++lz7TkwN1XPOxxuo4FKTtSHQdly2xOtVsVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqHyQCOBxdEmSnb8UpHcDhCk1wYByU4lxHtaBEbDHMD1Hx/tACKeOnPZAemZWKmT/afF81SDJLX35ML2vfjT91i10DwGb8HI/J5Q4RzLrOr9tskiZELYX2xs5PjCdcX3Vnp4f8/kZBcNJNsyUWzNyWW2M1/dyl1xmDYNKXf7U4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZugNVWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB85C2BCB5;
	Tue, 28 Apr 2026 07:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360274;
	bh=xIXwEMi++lz7TkwN1XPOxxuo4FKTtSHQdly2xOtVsVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZugNVWesUquaZbfC6vm4Si3UGLNC/v8MpK0qws/6JN+FAmjy4v2+TosvtzzXFk/+
	 2O7nDI4AohxZZMubE3jyYwfvLtMG08SUyfhuL3IS239fXKPGol8FfJrjKYQhFuWi2L
	 NGtEiBR/U9E1+Up+ufmsW83kY+YWvcS7lFIC6cSzEWZJlWBbJduPY5mGsO4ITiDwWu
	 XYcqC/nipTDUD1ePLpGYnSGxpbCUHU0C+D3eeppSxhNf/zBVNhzWPSe4MzGsuq61N1
	 u8N7J6zVZ2jtdcurmiZRgOrWUJc8x1aVtkwBg7a3qBFMncqH48w8/uJ35YCCfwXrl3
	 wcKMDeJdzcrtA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:56 +0100
Subject: [PATCH v3 12/28] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-12-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
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
 h=from:subject:message-id; bh=xIXwEMi++lz7TkwN1XPOxxuo4FKTtSHQdly2xOtVsVI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1Q87hysKm+0KpbORTQfRKw9X777HkSZyhtb
 /6bt9ED2sCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUAAKCRAADmhBGVaC
 FaLVD/9L4NyC+g0ctsdDO9vZ2JEcHbWol1EYUo8qlqP61kcRufIkGsurOBSg6xvo8gKCc3HgISP
 F6YiltD28Z1+Ofw+Rx6QVe9BjBwT/02WLkDmsPGVLW7RT4/3IhBsO5KaPM5uw2MezVvcKdECSLg
 mZ5qtVHGenJ/5KUFcgWSynlofj21Maj+zSPndhPHqKmBK744j/VTkM0StgULJf3bE1Ef2w5/uKp
 O1w/jBInRYMoAnT6NUu/K688omVPXJypwmkpJdHNVCPdwOszi4vM56vpfp+BCl4hAXfo7BcBaLA
 5iMvkYrERjOcUU85a1/wgC0LvTEPOowfEFdlzGiCtycEW7Rk0LKeS74o0VMaiA83LcgVT/0zoT8
 GIRwAsRfI6iu1dJru4QW/vB5R7PFC7CVLYwrZ4fQbuCcDnPXGNH0feIfFhzXnPmWCsNQiS4ejgG
 y0c0f/gj08qJ7Nc1hvbodWc2kCCYv+j1GWzqv9XTv3Yc31IT1NKiR4v4yuN4/9BBDWDIGuxcv5w
 /TG0Au/VQf2bShSZf/ieFG12WykbJwqcSy/oDtw05fGlo4aqnZpYNor3z1e7MPN5O62muh+sXJg
 AaPfrigQn9U9WMnos1+k7WCvGo+MC92wIC+ThJW3r3eKgAsxl+AqtydY2cyGhpdoK1VElzkQLDg
 EbfiSH6L/3Mw2YQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 9381047E9A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21224-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email]

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
2.54.0


