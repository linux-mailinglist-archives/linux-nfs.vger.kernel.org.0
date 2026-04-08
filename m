Return-Path: <linux-nfs+bounces-20736-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBIvIZlO1mm8DQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20736-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:48:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851583BC600
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2294E3064A63
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1303CA4A4;
	Wed,  8 Apr 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu3RyEXw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9783CA49C;
	Wed,  8 Apr 2026 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651415; cv=none; b=dBIIS1LJchRbxbSOSbrRHDHPti9PETso3IyoTT1+FmJyxDWw+dajLtH2Jf92XBiKHjSS1ND4ZOsK8pyzvXA0P49c17BBBnc5BxCaqoU+mdHNoujrUF1RUawq5FNWO/1EnOH4ltzqKJyHxksU8oZWmRPL40kPdunaIvug9Lfk2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651415; c=relaxed/simple;
	bh=qj8RcgzfBYrmGADej0AtURx9KQnQitRLEwf2smaXIh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OjPfpUcspWpTbEZrz6GaXFvUFZIO1m+MA58lV62z5N5rHKfny6x7Qz6paxz+JS2lUC+4181GDleYxBxVihiriBg7mwW5o9QGIzMbAZEUJo8U5XkTL/9+N7t2hLNExGRjnpl6Oa3KaClAghMjlJFxnQlev4XEMXyQ+yC8/QKumno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu3RyEXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F3C4AF09;
	Wed,  8 Apr 2026 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775651414;
	bh=qj8RcgzfBYrmGADej0AtURx9KQnQitRLEwf2smaXIh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nu3RyEXwwHCbCkWFTBQiSQSof8hW1QIhgkijo9QTTC8oXzhnR3inmsmM68F+CxvRn
	 BcSHUUa1Bnv1FRAwPXIhk++oB2tpgWdzu85L4L8UFDtGuYP7pAJhI6PoKoX7daaSLg
	 +a43j7NozlfeqZtJbwB9EnycIC/mIZa5oD+fV34rNlhdZDTFARMBZSnIl4HNJLF9eM
	 Gb1jSRnZuvYNvOSJik3ri1jwvBqH70WMTi4nmJmPYS6hr6JhYdE7nVEuRg41hWCXKS
	 WT2pUSZOEFnMZYncbOL6H3N5hlcKOxP9zcij9VBlMN4H4AvRbG6i4FvsV+I2gXempK
	 Olp16vWvCsp6A==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 08 Apr 2026 08:29:57 -0400
Subject: [PATCH v8 7/9] NFSD: Track svc_export in nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-umount-kills-nfsv4-state-v8-7-6e02a1d03d60@oracle.com>
References: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
In-Reply-To: <20260408-umount-kills-nfsv4-state-v8-0-6e02a1d03d60@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3715;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=PYXZWUUc/qsI0Ig8d2Ys2cRCvV1DKt/oUX45r1970qc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp1kpP8bPhWwaE9lEyxcZ/vp2g+e49BkLbeYPDe
 dhbZge/xeuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCadZKTwAKCRAzarMzb2Z/
 l8zJEACTzY6dN6f6bxMQDtNYzbMy0zE76ilel0ZF6s+aJY+zaVPExGhQ93kDil+txNOg2ck3mvE
 aHGBPSLejUm3a3TPpq2jl/7RP4c+kPMSkUfqOkN/SFqp2GebYIxcyi3qR6Rq2daQoZQvm8sdaLe
 em54FOkPmPqqL7v+ZwHKfoRUrAfyzTHtNvhx+qSl4rkFOslO4c4sDyfH+A5ZSxp8NvYDkS4WSSn
 LcFocEpVFU7ErLlD/88UKxjI/IEy5QBhfWdDOwV8ieDr9qyIb2QgNXxsBwWYVoksInGWlkZm/WE
 G+vj3s9OD7+5fR/SUK8iGIO7apvPmUL8jUj2kC1c+m5lGagXPJni08+qD2ab/fl/2rl724jZuIC
 Aad0+AAWxgl0oSLukQDL5cIEGpO/KEkmqJf70qqDQ1ylKAqUeysaSGlgvXT9D3utq90yWwj3p10
 P9RLoPeq6DtNYaDHhJG7Hrz6fCeCSLvUxyLUhCaoyxc0zItWF67YBe0R6Z03tpyjqimtmPoTNlk
 PM23THPiMSiSfYU98Sklp9799zk/gZFawtNY7h3gyIb7FVD2CVAWpZccJqMjgmfV35ngmeaXr6A
 p7EVkOmAwS/zGg1V6gAsSKqRFtlMt9jpQy7bUxhQYVyv02FHfyLL2F2GsUnXqb2UIMHtspCCM5g
 ghTdSED+C2hu0/A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20736-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 851583BC600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Add an sc_export field to struct nfs4_stid so that each stateid
records the export under which it was acquired.  The export
reference is taken via exp_get() at stateid creation and released
via exp_put() in nfs4_put_stid().

Open stateids record the export from current_fh->fh_export.
Lock stateids and delegations inherit the export from their
parent open stateid. Layout stateids inherit from their
parent stateid. Directory delegations record the export from
cstate->current_fh.

A subsequent commit uses sc_export to scope state revocation to a
specific export, avoiding the need to walk inode dentry aliases at
revocation time.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c |  2 ++
 fs/nfsd/nfs4state.c   | 16 +++++++++++++++-
 fs/nfsd/state.h       |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index c3543d456702..c550b83f4432 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -234,6 +234,8 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 
 	get_nfs4_file(fp);
 	stp->sc_file = fp;
+	if (parent->sc_export)
+		stp->sc_export = exp_get(parent->sc_export);
 
 	ls = layoutstateid(stp);
 	INIT_LIST_HEAD(&ls->ls_perclnt);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1478ff741b79..7b010fa21188 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1168,6 +1168,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
+	struct svc_export *exp = s->sc_export;
 	struct nfs4_file *fp = s->sc_file;
 	struct nfs4_client *clp = s->sc_client;
 
@@ -1183,6 +1184,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
+	if (exp)
+		exp_put(exp);
 	if (fp)
 		put_nfs4_file(fp);
 }
@@ -6186,6 +6189,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	dp = alloc_init_deleg(clp, fp, odstate, dl_type);
 	if (!dp)
 		goto out_delegees;
+	if (stp->st_stid.sc_export)
+		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
 	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
@@ -6520,8 +6525,11 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 
-		if (!open->op_stp)
+		if (!open->op_stp) {
 			new_stp = true;
+			stp->st_stid.sc_export =
+				exp_get(current_fh->fh_export);
+		}
 	}
 
 	/*
@@ -8217,6 +8225,9 @@ init_lock_stateid(struct nfs4_ol_stateid *stp, struct nfs4_lockowner *lo,
 	stp->st_stateowner = nfs4_get_stateowner(&lo->lo_owner);
 	get_nfs4_file(fp);
 	stp->st_stid.sc_file = fp;
+	if (open_stp->st_stid.sc_export)
+		stp->st_stid.sc_export =
+			exp_get(open_stp->st_stid.sc_export);
 	stp->st_access_bmap = 0;
 	stp->st_deny_bmap = open_stp->st_deny_bmap;
 	stp->st_openstp = open_stp;
@@ -9543,6 +9554,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
 	if (!dp)
 		goto out_delegees;
+	if (cstate->current_fh.fh_export)
+		dp->dl_stid.sc_export =
+			exp_get(cstate->current_fh.fh_export);
 
 	fl = nfs4_alloc_init_lease(dp);
 	if (!fl)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 953675eba5c3..7d7e99eeffa5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -145,6 +145,7 @@ struct nfs4_stid {
 	spinlock_t		sc_lock;
 	struct nfs4_client	*sc_client;
 	struct nfs4_file	*sc_file;
+	struct svc_export	*sc_export;
 	void			(*sc_free)(struct nfs4_stid *);
 };
 

-- 
2.53.0


