Return-Path: <linux-nfs+bounces-21819-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIz7J9GyEGrRcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21819-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:47:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7355B99AF
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F02B3032807
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635F37F8C7;
	Fri, 22 May 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaGbHw9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68637DAC2;
	Fri, 22 May 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478960; cv=none; b=gNOBE6dXfRBeANF/GLFL9496Rw4wi7C4EHB0N5pcmhnDQzlWaw88r08EKomTxPgu58wbDFzQqw9jjBnrZRZYENd8Teeaa7uu4HVl1vp0is/14KsBSWuB1ly+1L1mEvgb1Iqv3ipoKi3vlg9zX4vAFo7erFd0nPQx0IwTmSMRqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478960; c=relaxed/simple;
	bh=6+xgS9Oi//iUZD1ri3viy4fOOkWtg6yKfKkrsgbZtwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxAmQm6rhHYpL15/3IIHo7N3XI/V6CKdBNZeXZlnkYDGNgjqgbixSI8t0urPGj9GZSNr4K9fQMzbtfBIoOumAml32G2XOmmddAd0ffDzc7LhZgr46J8AMaOkf3sYoc+q6ZR7vm+KQBrH211NzanDTuypuVzQQ62ks1a9p8w904Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaGbHw9u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE8E1F00A3D;
	Fri, 22 May 2026 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478957;
	bh=yn+E0MiyGHjI4tTcZW7VzxHDKSKAvs1i4UMk8wxbinU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gaGbHw9u7brDFj7avc7wDzaPMTRPI39HDoedRCPYSRitcECMKChVIHC8zEosH7b04
	 SUX2k5ACohh9GaA6Q1FLndnZQzBp4Jwxz0GsYc1T+Jqawlm3AN5VU7dwTDbh8tNr0X
	 hhh7U+lf+CEpiaXglD46rFXkvJeobM06vpkArBF22T5olRg6DroWU0nlpD1CX1o4Rz
	 LAwuJxpcHsjr1ttW1YFnu65ihqzo1E7d6EBeIyPXaMiysYuzf945tCnSp15uisUvPi
	 Vp+A3VH8vH3IPK692+cY+RZny4uDX0pdNtAhRrbXhpdbub9/8WZdN6HdbRZe5zvBHf
	 HpeQ4izYdDN8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:09 -0400
Subject: [PATCH v5 04/21] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-4-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6+xgS9Oi//iUZD1ri3viy4fOOkWtg6yKfKkrsgbZtwo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGdIfAeqY/TeCUSnSt3PnsVR37X5WfEtjz61
 p72CTTa3qaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxnQAKCRAADmhBGVaC
 FUStD/4hmSTwIH+z8GJlkcFPnFpSQtdWtAWO6vIqe4KSvNnvDu4LTCC5syJVuGvdayenSHY/Vxp
 tqE2Itwm3rVoOkwFslBewOmbEKQIs8QkrWDaAr6gDzVvK0268W88ncFItEkZ09xc+UA0uOL8aso
 cy1Fayyy4Z2f8tj4mgFqb5XP8sISgOcuLcBc0v6/f0RcsKO+9BQOTZ0kLpZHtpkJxhJqZDplVF5
 o7zTLxU+nB8iVDwbdzZhJg6iEj6w0hSOOWOBcchLnKd0e6dw29IhmWi60GQGOYrJeuqz66M0hc2
 pplEFM4fLQ1j9Jbwi73iTqi9nTd1lFP82/y8l3ZGTLaGcdIBwJco25zTHL05f6mkyYPbYFNtJQ5
 cyMcseaGY0jR431hBESIH7/h7/l1291ziKP92wnZFPd2O51tzpBAEEgZ2zMsiKJ2FFKQw1AGjMN
 izX+XiBn3j0yJ1FcWJmmL7d87IosPAn97UJTv7rRhDG4I5qqufxeHwIAZh1fUdVum4rp2QTA02f
 fik5YzsOxR+qJeGWkoB6gbBlCuXz1a4htO8sXTodQN2IEYQxXVY4gx/z63cnqQ3uZ+NxmLSb4/G
 5mO8eIFdrEwqs1sVPdooAfS8luY0f/iGJViaB3utZ0nvkNaK6ABTnTKDXr3t77g2Ac4leSVyZcL
 cuqwxBGYgFnd15w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21819-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A7355B99AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When requesting a directory lease, enable the FL_IGN_DIR_* bits that
correspond to the requested notification types.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 67e163ee13a2..2a34ba457b74 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6048,7 +6048,22 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
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
 
@@ -6056,7 +6071,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->c.flc_flags = FL_DELEG;
+	fl->c.flc_flags = FL_DELEG | nfsd_notify_to_ignore(notify);
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6273,7 +6288,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (stp->st_stid.sc_export)
 		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9642,12 +9657,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
2.54.0


