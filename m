Return-Path: <linux-nfs+bounces-21785-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIeGJ59NEGoJWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21785-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:35:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE65B422A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BC7630995A4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FB738BF9E;
	Fri, 22 May 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4o8ZFNf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231F38AC79;
	Fri, 22 May 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452957; cv=none; b=JcD9EuR/JCDOGxSjKD2j1YhsfeWjbY+8aEJ/qiVEo9q8f2ozXyW1K8F3J1TBK53lzIelA7fwmWXpBzwu6Ip8fw8nznQyFR2b8QaVIUUrSdGqKBP8jlLmYpqmkuohsgZc0AzqhcCkabtCPdgSQ5WoYPkj+FThz8etBHlQR7XZk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452957; c=relaxed/simple;
	bh=6+xgS9Oi//iUZD1ri3viy4fOOkWtg6yKfKkrsgbZtwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YjomVdn6PTWXj5N8zl3Dopn2Z5T8JRwjxGLwr5Hyak1LFU9+sjuj64ggwfov6sYOw9dbdDbw2OgUZ6V2CqiBRiHrDaKPYsOEw2seMZWjkIHQEleP7fcvLWU4M3TXPjz0G/LzaKihBxontz9lc7GBUGrAdIXgRz1IldTLa7OIVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4o8ZFNf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9081F00A3D;
	Fri, 22 May 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452956;
	bh=yn+E0MiyGHjI4tTcZW7VzxHDKSKAvs1i4UMk8wxbinU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A4o8ZFNfgK1M4UcKU0rzETyTnyHkLYY7IOngI8GZx0aVRB0UlaeMRnybyQcepF2S5
	 dqGbiyDkqkxfOISPn3lRzWwlxkPyfErH3hyUX4JqA3govP3kNPNtfmW7lyAmfun3t1
	 78sy6fIcpe+cfGjv+cPwx8zKmV0W5Rl7qwUp7SQSExEfL+39kgTBupBax/7WU19wgV
	 PdeX0MamXzQ0JjIk558s86In5shQRrQX1oKYPi9K27jp+mjiFfOhf5bGh/+rgo1C00
	 PqjTHpYR32+Ja0Vyd6s+Qo23vAuEVIZ/KpPskft+M0n3KJYmPfX2DijTc1YM1ihTti
	 jUZiX9cq1NPaQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:28:53 -0400
Subject: [PATCH v4 04/21] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-4-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6+xgS9Oi//iUZD1ri3viy4fOOkWtg6yKfKkrsgbZtwo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwNyS3iS+O65mi02G1HOQSk/h3hjTqaiETd1
 NqTW1f/ieaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDQAKCRAADmhBGVaC
 FYlFD/kBkidjyXGjn0htQxSzguYDgexBj2U1yjoFPYCyqUnavfBfi97GhESk0DQZFvcH8y7tUBN
 +7I1+/AanV48puiTTWpdl4WI2ZYu+eKcIWS4bx8Gqi/ipMEimSeJ1EuDiwVtxXHDIPgWrDrLMrJ
 MA/xd2BxwMZfgcJHmotRQtQ4jtE06BdnnZXXZikkcrup1Sj7sAjWObqRTxOL5IaIbjnf1GAX1Oj
 72Dpb689I8lu31aPOcEmvj746sqaG2DZNhRJTZnd4m+nGdwx9/HyXPtgDod7u/B4WOzicp3x0Qx
 +xk6tH8cUH7jQe00dQ8iFHmvMWb/wgkXVPEt4sOlgijMRp6uV39jHcScL7SytZMDyzN9fyxbp46
 sBul34A4v4oP5a2FM91TycPVVSqMFSWiPqDBWkAK/JXXcsBCzNYn5lPTo+KDTnf7IJtVVuQ3qDN
 JrAUUhP0VJnO8fLbREQ0RVSE5VvP1xNSjK8ZtKH3YQZZ13Vumy4SOqrsGljgNT133ftxdmLqUnR
 KASOB5gTFAa7pey8zzeSY+RkZiNi9cr6KSGdKk7/Lk0lCdCN6HiSdEfBIotYxPFLLnm8b3vjHaX
 Ka8Z2Ml6wh+gv9r1qFiYzJLE0JfFyNbCPT3dFekgOV9T0CvPRNDfmBbUv+7IDIaoulRFz/lFFus
 LHj4Ru6uF5KxPZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21785-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58BE65B422A
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


