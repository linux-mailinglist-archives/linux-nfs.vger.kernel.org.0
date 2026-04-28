Return-Path: <linux-nfs+bounces-21223-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIN7LHJe8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21223-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:14:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A922F47E97E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B66723017F24
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED43B635B;
	Tue, 28 Apr 2026 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5AQohbc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E93A7850;
	Tue, 28 Apr 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360270; cv=none; b=TsuirW8OdgmlEIazWU/cPBTdcaHRRZYZeiQSUEO7+5tJVmy7Nm0axDvLjnYlm8L8fEQ2/2MH8y2TFYdUU1hq8hZwC3yGhY/S4+haVvAZ7P/sRlzkDEFBS8p+kSIV1vXYwaD+gO8sUCL9cpAC10eCutswxAb7wMZLNyvj+nTEIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360270; c=relaxed/simple;
	bh=hhXLhx74Eemi9+cBWHx+kd/7BxQpq2o8mwtjMeiErng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pEZsLQVepBrvg773HEzX5loO/W9HnupLPWI2+U1ife1ZKAOHnOm9yufVxocrAe7+JVCwI3FExHlwu0J5Tvpqv0W7PTAQXSo7iPWEi3VZeG5yODKEWJtYTxQ8Usa3n/CIVT8A9s1blxLDX0Wn/uBFYlm+i8pc4tjuTvE7COSA7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5AQohbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52305C2BCAF;
	Tue, 28 Apr 2026 07:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360269;
	bh=hhXLhx74Eemi9+cBWHx+kd/7BxQpq2o8mwtjMeiErng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U5AQohbc5OVi4kFa24dGk4eamYXx0PykAOLwhPrRooTw6yUsatyoLfLbLPZ3A2fqc
	 ohiILhEm1MoPVbKYfGyEOVbjEai2+I4uM4XESYfrD1bFn6kZQ3A9RBLF6mfnkogDd5
	 fERdP1JiKhOQ0LrA2+e8ieAKYi0zpzPnhLfuZRd7skpx/oRlg1jFA6xlqZeqJvtlNT
	 dND55JF7i4wmKnglTyJWOVx6NkWUwCUlOQeTp3MxMnWCKsah7EcZ14KWaZ11Qnjsde
	 sqecg5w+nooVGguMXTD3XcVsZuBea2wHKqdZw094fva/pnCIm81Hud5GBZPMFwfrzx
	 OCmyIpZbCbYVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:55 +0100
Subject: [PATCH v3 11/28] nfsd: allow nfsd to get a dir lease with an
 ignore mask
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-11-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hhXLhx74Eemi9+cBWHx+kd/7BxQpq2o8mwtjMeiErng=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1QKEaBY8vzQl/lOHR9yCybiOtoU6fRMZfkf
 hHrneLC0yOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUAAKCRAADmhBGVaC
 Ffg8EACiFtRZ4MNzqg91nvdlpqOXh5L2kFziSZJf0xxHadqU5wRw4V7bx8zNBTEKVGHc89uA/3q
 XW8vkdkEekKlkgdVrjPCRDG1UQoIiRIe/KaGtr0Mj04gRW5CZZKUYHxIr/WCp2/lOqhRMdcuZfj
 IGBUq+zskJ8bqTuwBFxnO9k8GumHeDJv7BqJiHwynBZwnIamp5VAST4BliOUUaOgF4nqrAw5snG
 nTBiZDkfnd0Hymd5aAuOk5W8jhd90FW1qUzDO/BuILTbS5pkc6lXqr5nRRCLxU6cosAM4jscuLt
 5fzrE+7mUo/uG9fQgD5foOpPk6Dq5KSOgRG8F5CmR5oqs+Zw10FpQNdCo3SKFCQRDBLcqDLfSt3
 jAi0l/bP9UOs6tvAnXPKlxNAfmyWJUJZ9fVg2SgV1DPl1UFEc9e2OafWy2gcUzRYKpoXPj++6pc
 BzSnNHU30hndoUsZ8fQO8h9zBeZdvzseK6rAtfrzNxFgTHiwZkq8UWeAiU9OJ39J8S0IEIru5qw
 vFCYGvPGjxQhf0s4VjYgdlOnBmSb+9XK8SpfpPWMKKCWJBYq0KIWkjvN32ODQp0XxsdZeHFlBBj
 8kBceHf5E7r+cixtDVBZ2y/1CVA97e/sHGwA0NUUd6ZgLoJESU4S0bFQ4AM8iV8jgoyYijc82HQ
 UsYNqlp6BwiWv+Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: A922F47E97E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21223-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
2.54.0


