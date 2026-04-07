Return-Path: <linux-nfs+bounces-20698-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEn+E+wG1WnbzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20698-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:30:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C52513AF23D
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DC173122428
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF03BA229;
	Tue,  7 Apr 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7Iy/0my"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B1C3B7B70;
	Tue,  7 Apr 2026 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568168; cv=none; b=pClbEnyVyh47wuYsR8ZXvG/kHFwnhCTbiNlSzF8XWnndfoSTM8OTK2N7wuQjQ4QRzBaTAvX7GWwW2K4O+tEIzAYEzVWpQRlSXLtmi6Bagh8iL858LVnQmbtxd/xi4fdvOXo3l1Ov1sJLM99dc3DmgFyBigxI68Yw9S8BmgeiE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568168; c=relaxed/simple;
	bh=6qtaDL3rkdEPWOgz3AFRqb0KZOdqrrkg/QLukDLfkwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozd0KsdiP8+PWA84Kwb1Ry3jC1IKW/Yvsyz8YhOmLrMmEypZRYrSnleT+cfua5oDrsvI3fj21Tqk0g9qKIWDeoqBP9aXWSN+jQnX5jtBoHMOAhmDlc3XVN6jJrj5Ay52uCEb1Bf2QYQyUYm5akPmEb6NzYgnn84nt6YbqLWozAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7Iy/0my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA948C2BCAF;
	Tue,  7 Apr 2026 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568167;
	bh=6qtaDL3rkdEPWOgz3AFRqb0KZOdqrrkg/QLukDLfkwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s7Iy/0myh2XoTiCGzTr7pAQfaJK8PQYpFUeuGIvtYrG15N4Z7/mInStwzfAmSZ3rY
	 IlHhkckufO0oeL7Y8RS3u20t1VQ9DGYIb7wWjd9ow+jvw+pOrP1k5aLHNofIikfJYr
	 2DrBIydygTQgMN6vbKXdWHTIKW5gAySdWV6mUghwId1nzMlaGwQkKovcCKK5f5v4l/
	 M7lAuHj1ifCpTWv55/pv+HsOwfwtUf9rE69G2Epr35n0/Q9MR5Bbl/mMI7b3ORBn95
	 QMG7RDUa2UHFUQCSQh3IK0EHksrxjYCyaV/LCWcrbdHdbGhMsT4d9/FV1Ib5DjsCTB
	 /Ca5hRUzjCo0A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:24 -0400
Subject: [PATCH 11/24] nfsd: use RCU to protect fi_deleg_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-11-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7799; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6qtaDL3rkdEPWOgz3AFRqb0KZOdqrrkg/QLukDLfkwY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUGYsLcv0no2bvqBI0TQBweBQCeRNhjdIKsM
 F//SSRluBCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFBgAKCRAADmhBGVaC
 FZQQD/9C49RtvoS6zymbdCAB/rka0SQl/K0pcEq8pWo7l7vI4yB7n9Sd5hVvcbswURAnO2l7ZzR
 sQ09E8GutBut2RO+JYywjLPRnON0lJcWSnles715SSzc07/f+oSThCZU2tux1qNahfxuZ4lI1mv
 Qgj4Z0byOz3dRB+SGmxAAn0WFWiPyj8BKxUG7i7DAPGMibim0Ujur1Ro/MdPUmHN9qDMSSu1Nhq
 tk9vH8D9h2zipEg8+oTzJtlvHX1MVBLSQSeX38F1MVxkovQ7dtzdrA8TF0BO61JfSvrrZeIgW+U
 sGpjTThravizuS6l55nk1zm7JYYx3NuHvacpJ/Ox+Jaq9PKa2vIqNvMAkcLMOGK2HZtZltJvkB2
 /ZBmN0c+wPrx9d+rIHb1M1L3+fuXkymR9ztCyvxKaw/1EQt2OhUahkjOnldwBq4Dht52K6tCdmq
 65NEyNFu/JHNleEVVCvgj03YJFSRxU/NeyH5aCobi4A1b+MU8vqoNu6Y+Gfn8lZjE9a52asfYwJ
 o8ghx4MKIzjQF/aj9f9ouF/RD+YPMd3OD95q9Mb4pJcCQTo2b2BZIUBV/blJdObQNNevXDSlGsJ
 Herp9GGimDW/I5FoXNo8WA+YPPxJRBaXPv5MPen5CxcM4BIam92FehAxdyWoCl6e4uozK8qzBIi
 hBSMHMrqsMFRbGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20698-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C52513AF23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fi_deleg_file can be NULLed by put_deleg_file() when fi_delegees drops
to zero during delegation teardown (e.g. DELEGRETURN). Concurrent
accesses from workqueue callbacks -- such as CB_NOTIFY -- can
dereference a NULL pointer if they race with this teardown.

Annotate fi_deleg_file with __rcu and convert all accessors to use
proper RCU primitives:

- rcu_assign_pointer() / RCU_INIT_POINTER() for stores
- rcu_dereference_protected() for reads under fi_lock or where
  fi_delegees > 0 guarantees stability

This prepares for a subsequent patch that will use rcu_read_lock +
rcu_dereference + nfsd_file_get to safely acquire a reference from
the CB_NOTIFY callback path without holding fi_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c |  2 +-
 fs/nfsd/nfs4state.c   | 40 ++++++++++++++++++++++++----------------
 fs/nfsd/state.h       |  2 +-
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 8974e3d85d75..d32cc6b38c23 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -248,7 +248,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
 	if (parent->sc_type == SC_TYPE_DELEG)
-		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
+		ls->ls_file = nfsd_file_get(rcu_dereference_protected(fp->fi_deleg_file, 1));
 	else
 		ls->ls_file = find_any_file(fp);
 	BUG_ON(!ls->ls_file);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fd3d7cd427e1..4afe7e68fb51 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1210,7 +1210,9 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 	spin_lock(&fp->fi_lock);
 	if (--fp->fi_delegees == 0) {
-		swap(nf, fp->fi_deleg_file);
+		nf = rcu_dereference_protected(fp->fi_deleg_file,
+					       lockdep_is_held(&fp->fi_lock));
+		rcu_assign_pointer(fp->fi_deleg_file, NULL);
 		swap(rnf, fp->fi_rdeleg_file);
 	}
 	spin_unlock(&fp->fi_lock);
@@ -1293,7 +1295,7 @@ static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
-	struct nfsd_file *nf = fp->fi_deleg_file;
+	struct nfsd_file *nf = rcu_dereference_protected(fp->fi_deleg_file, 1);
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
@@ -3159,7 +3161,8 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	/* XXX: lease time, whether it's being recalled. */
 
 	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
+	file = rcu_dereference_protected(nf->fi_deleg_file,
+					 lockdep_is_held(&nf->fi_lock));
 	if (file) {
 		seq_puts(s, ", ");
 		nfs4_show_superblock(s, file);
@@ -4941,7 +4944,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	INIT_LIST_HEAD(&fp->fi_delegations);
 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
 	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
-	fp->fi_deleg_file = NULL;
+	RCU_INIT_POINTER(fp->fi_deleg_file, NULL);
 	fp->fi_rdeleg_file = NULL;
 	fp->fi_had_conflict = false;
 	fp->fi_share_deny = 0;
@@ -6082,7 +6085,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
-	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->c.flc_file = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 	return fl;
 }
 
@@ -6090,7 +6093,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 					 struct nfs4_file *fp)
 {
 	struct nfs4_ol_stateid *st;
-	struct file *f = fp->fi_deleg_file->nf_file;
+	struct file *f = rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file;
 	struct inode *ino = file_inode(f);
 	int writes;
 
@@ -6167,7 +6170,7 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 
 	exp_put(exp);
 	dput(child);
-	if (child != file_dentry(fp->fi_deleg_file->nf_file))
+	if (child != file_dentry(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file))
 		return -EAGAIN;
 
 	return 0;
@@ -6273,8 +6276,9 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 		status = -EAGAIN;
 	else if (nfsd4_verify_setuid_write(open, nf))
 		status = -EAGAIN;
-	else if (!fp->fi_deleg_file) {
-		fp->fi_deleg_file = nf;
+	else if (!rcu_dereference_protected(fp->fi_deleg_file,
+					    lockdep_is_held(&fp->fi_lock))) {
+		rcu_assign_pointer(fp->fi_deleg_file, nf);
 		/* increment early to prevent fi_deleg_file from being
 		 * cleared */
 		fp->fi_delegees = 1;
@@ -6299,7 +6303,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = kernel_setlease(fp->fi_deleg_file->nf_file,
+	status = kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
 				      fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
@@ -6320,7 +6324,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 * Now that the deleg is set, check again to ensure that nothing
 	 * raced in and changed the mode while we weren't looking.
 	 */
-	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
+	status = nfsd4_verify_setuid_write(open, rcu_dereference_protected(fp->fi_deleg_file, 1));
 	if (status)
 		goto out_unlock;
 
@@ -6341,7 +6345,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	return dp;
 out_unlock:
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
+			F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
@@ -6498,8 +6503,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		struct file *f = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+		struct file *f;
 
+		f = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
 				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -9638,8 +9644,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	/* existing delegation? */
 	if (nfs4_delegation_exists(clp, fp)) {
 		status = -EAGAIN;
-	} else if (!fp->fi_deleg_file) {
-		fp->fi_deleg_file = nfsd_file_get(nf);
+	} else if (!rcu_dereference_protected(fp->fi_deleg_file,
+					      lockdep_is_held(&fp->fi_lock))) {
+		rcu_assign_pointer(fp->fi_deleg_file, nfsd_file_get(nf));
 		fp->fi_delegees = 1;
 	} else {
 		++fp->fi_delegees;
@@ -9691,7 +9698,8 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	}
 
 	/* Something failed. Drop the lease and clean up the stid */
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
+			F_UNLCK, NULL, (void **)&dp);
 out_put_stid:
 	nfs4_put_stid(&dp->dl_stid);
 out_delegees:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 22c9a1e7d8fd..eb5946b0999e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -698,7 +698,7 @@ struct nfs4_file {
 	 */
 	atomic_t		fi_access[2];
 	u32			fi_share_deny;
-	struct nfsd_file	*fi_deleg_file;
+	struct nfsd_file __rcu	*fi_deleg_file;
 	struct nfsd_file	*fi_rdeleg_file;
 	int			fi_delegees;
 	struct knfsd_fh		fi_fhandle;

-- 
2.53.0


