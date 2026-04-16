Return-Path: <linux-nfs+bounces-20883-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOfPKSQf4Wl0pQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20883-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:40:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34D41307F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29369317F06F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9583BA24E;
	Thu, 16 Apr 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auDqlz+D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C993264DF;
	Thu, 16 Apr 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360947; cv=none; b=LOuvl/GSIyZiTU1UusamN/f9UnX9tk1rZglROkx+7TObh+/fTq/3GShWTtqM69+nb+McvvRMEHbnuQ0ShxqzUYEp2aUp4MqMCGE7fB2C7Dx8u2DPLV7Y9pKYAluUW3IOgcy/a0Ai0Z4KGaGirql8NeeM8YBO0YLJHwQ9xA9U/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360947; c=relaxed/simple;
	bh=tTquUQjAs7X3Y76/uPUM1voj0FXU+cwoVHWvPbEVL/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbe+3wXxddEzHAYUjRtz3qKx55Kha+/C/E+k+qN97sh4z5lb2J7fNPZHp1rOI9mqt3o8Edj3N1kmhBNbqeYcQFE10iGVoACHpC/KqASQBXpJDzDqPMHTIZOKXwvggrNBREXT/iGVlS+2Qcc0CxITY9qSq2EXF2cOxblxHxcOPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auDqlz+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09942C2BCB4;
	Thu, 16 Apr 2026 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360946;
	bh=tTquUQjAs7X3Y76/uPUM1voj0FXU+cwoVHWvPbEVL/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=auDqlz+DROY3AG6lnpTvnQY5iuNi+kdDH14V9I4aH4HNszMzUga7OaaO4P0mpvkmC
	 By7BcvLrYzFeeAZyPB2VbllNZZ/kTNsfco7u+mhb9/hbI6YY60/bVP4TNLwGA74580
	 yRWIYyCKkAdy00X78wwsDZFX/XXumZ2VYSjT/kECE2MDLk7/9/ihubcxqciNnx2Z4A
	 W1STaNdU45N4itWGD/ywklRK4Pwu8NS2IgisP4pmzx179+xEId4JPBAwZFZL2RdQ6x
	 2a8VNnsp5NSuYnRPicpyRff1+8mufJsFZLwlkCOUDIfoNcWrYVCM/lR0V/+NFuxYuH
	 uVHYt9gup/Rlw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:12 -0700
Subject: [PATCH v2 11/28] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-11-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tTquUQjAs7X3Y76/uPUM1voj0FXU+cwoVHWvPbEVL/4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3k3vk9pm3Uvbsvokm+IM38JXSAcz4SJ+GtL
 ZV0A+DmylCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5AAKCRAADmhBGVaC
 FZbUD/sG6J4vjbSYTFAcWEn3LQuzs1IJCQUdItYJpVHJSHqgydZyJ0eYyXffcsxRQ5SzzRvnU8O
 nMcVY6Z2BCcCyoI4EIlAzXANjogK910LThIHantUqZQAMUT5HLsy8x/fAslV0Ec7hu/u47/qO5D
 0G+yA0C7Lekp8xL0Gwl6ufvbwd1b3bAUmquu8TioPpQV3EG9Jj14NKVRus70FO2ZLLrUwiT9pwk
 2J//skBauH+PFf5CCuCdM80N1YzORSFK1y2crJVWG21NpqKxST/f8ipafATG3Uu+RyF2XXmm0ye
 ePF26t8SMkiND/mLgbCKc1hfXJZ8fDRLhFHPTPrCOL2DBxL2V2Z0fv7yQdNBB7bOfLeiVy1874c
 ecmhaxxTnVlroNPVAV98+EXJOkHnbXaRZyJauVyP5jezmzNHIwxfZdJLZPWkN4QLLHPwPPFddxT
 2Jcx4vcv9HVSuwjUuavknmzRpK0qG6qD8ddukL21NrhTYoCnSwoNzLCIXf77+SLNyL9CbRkfro2
 PUDc8D3JtQZ4i1jHe/p2KerFTbCV+abbg8GGo25x9eYjM0SJn1zhp08aLKNNd4hAKa3viAwvQXK
 8R8yIiUnzf2sVETJNiY5GTiq4L3PIySfDs+MiRizBlpH5wWdsxeJqof8sO300VPsLBpRBpFvDv5
 6wnO7coVCLtSH2Q==
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
	TAGGED_FROM(0.00)[bounces-20883-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 1F34D41307F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When requesting a directory lease, enable the FL_IGN_DIR_* bits that
correspond to the requested notification types.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35f5c098717e..bd7e4f9cdaa5 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6040,7 +6040,22 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
 	return clp->cl_minorversion && clp->cl_cb_state == NFSD4_CB_UNKNOWN;
 }
 
-static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
+static unsigned int
+nfsd_notify_to_ignore(u32 notify)
+{
+	unsigned int mask = 0;
+
+	if (notify & BIT(NOTIFY4_REMOVE_ENTRY))
+		mask |= FL_IGN_DIR_DELETE;
+	if (notify & BIT(NOTIFY4_ADD_ENTRY))
+		mask |= FL_IGN_DIR_CREATE;
+	if (notify & BIT(NOTIFY4_RENAME_ENTRY))
+		mask |= FL_IGN_DIR_RENAME;
+
+	return mask;
+}
+
+static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32 notify)
 {
 	struct file_lease *fl;
 
@@ -6048,7 +6063,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->c.flc_flags = FL_DELEG;
+	fl->c.flc_flags = FL_DELEG | nfsd_notify_to_ignore(notify);
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6265,7 +6280,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (stp->st_stid.sc_export)
 		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9634,12 +9649,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
 	if (!fl)
 		goto out_put_stid;
 
-	status = kernel_setlease(nf->nf_file,
-				 fl->c.flc_type, &fl, NULL);
+	status = kernel_setlease(nf->nf_file, fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
 	if (status)

-- 
2.53.0


