Return-Path: <linux-nfs+bounces-20693-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFVXB0QG1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20693-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:27:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6C73AF119
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C25F30F20D2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F93B7B61;
	Tue,  7 Apr 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prUxAruW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6325D527;
	Tue,  7 Apr 2026 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568156; cv=none; b=F2aEbk5cXN3UrDRIz2CQofjSBRp02M4aomWG0d8nWH+EpDgZd6xGq1/13zDU3F+2UcFz1lZ2reiUPv7mxcmw0TPtZLrRYhkaCFCKAqimIePmMVHTRYnTZU8PkgBTvJAmZ+qKUymR1wGf/2c04lQO+qMHecJutTweTNM/atHMh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568156; c=relaxed/simple;
	bh=o+x2LCRljjVywCu2fUOpIb31IQvgXIq8do452s8pusw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfnHUHEPx8p2LrZYjCa7uIoQ1W1Y+YWsZfGJQ7BkQ3lY68lQvYIvgr5rFGXx3uQSHQyyB+gpQ+2e8SfH2b8vy5kpLaqF1z+byipO7MIrG+PLcG2I81uuFhwdXHR+gW2TdHyOr5jJ0hXVQ04GFMEpmbvmS8cZmf+wQwJX3prPPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prUxAruW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D580C116C6;
	Tue,  7 Apr 2026 13:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568156;
	bh=o+x2LCRljjVywCu2fUOpIb31IQvgXIq8do452s8pusw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=prUxAruWTe/rhAxxTh+tk0VxwbzHQJ6PlHAfM1Yc01i+AgkhLWovhyYiPmdhCcRuy
	 zO+bw5wndQgCg81t1GcDbdX6t1IfSk0y+cEKXmG0oEXeIP9r6LJYTsOPUovx5iNU9B
	 TXxjC0f74kd+VaikEK+urJOwzr/gLAhtFUUV9LdMHErEz5q8u629mh98qINd0TIdlC
	 IguPlkJ/FwnJrch1O18bxFCqGwUWTEpM+SETXiFE2G0YUp7vyuIEJJDE+z0VxKPPsz
	 t+Q9iFwhj/ZYHYilgV7tLSrzWnK6x8dRGzBzLWgQlwsoMplHBmA2SLhkRAffmcZ5YS
	 nLex3/B16Lr1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:19 -0400
Subject: [PATCH 06/24] nfsd: allow nfsd to get a dir lease with an ignore
 mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-6-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=o+x2LCRljjVywCu2fUOpIb31IQvgXIq8do452s8pusw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUFStqft3I9/+53osV6YZkoIhpSZ9wLWB1Qj
 1gi2wwZC4GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFBQAKCRAADmhBGVaC
 FVNdD/0QElF/ydNopPAGqjNQOt1Bdr5PxncTQVPsyyr53m3P+gzsFJJfeFhLMpH0/HIukPpTB/Q
 db8Qz3aplWW8Gt+6aB133jsudBKjCtyCiZGRx7YqZvnxiYKSUDY6awEEnfUt64Lnrb2Uc+zeb23
 DglvZyHHmtXDZQGEOKnxijjyLOsfjFydBR/CEVwB0kVBQZbIGQBZ8O3x7MszgLFzmoOw2zWZbSs
 byQoZbkYOhRmCUMLguP+whyWPQrdbDAYnPe2sl/85pyLqsylSjaaVoxnhsQhdmwUJtWCBTgPh9G
 Wz1SCUF1+90eJMHSUlq0ylm2zitPJ6cqDkdiGMCDwssMvXZ4dzm6nN3taLUrOaXbZWRfQRwef0K
 aFnC/A0BLKMUsZAw4XwExBGlAXbQ1hLXhaX/ZLWSTnP9qOmhjPyCZuD3aQ6GgDPsySvKgIz59mt
 fgRTyBI9DXdqLVCoOFxO01YpzzwuPcR0GNySZ5KsJS+B4rx0s8MzWgC9L1sY4zap0kDUvqxsfmz
 3YuNEaMkb79inTMR4scskfyzpEeGCsUt0FqjQGpPLT2MBX6NAg6U2nzx8mcUN7YYX/j6lnC9sMU
 eMKHGDsT5IyN7ihEHaLwd6zyL8ZsxN0212/Fn8NA17Y3lS3F00gBpEVRZ3UsR3rBfaYJBquHaLG
 qfZGTwZCWNZYdrA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20693-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E6C73AF119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When requesting a directory lease, enable the FL_IGN_DIR_* bits that
correspond to the requested notification types.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa657badf5f8..c8fb84c38637 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6021,7 +6021,22 @@ static bool nfsd4_cb_channel_good(struct nfs4_client *clp)
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
 
@@ -6029,7 +6044,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->c.flc_flags = FL_DELEG;
+	fl->c.flc_flags = FL_DELEG | nfsd_notify_to_ignore(notify);
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
@@ -6246,7 +6261,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (stp->st_stid.sc_export)
 		dp->dl_stid.sc_export = exp_get(stp->st_stid.sc_export);
 
-	fl = nfs4_alloc_init_lease(dp);
+	fl = nfs4_alloc_init_lease(dp, 0);
 	if (!fl)
 		goto out_clnt_odstate;
 
@@ -9612,12 +9627,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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


