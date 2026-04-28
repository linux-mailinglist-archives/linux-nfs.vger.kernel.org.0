Return-Path: <linux-nfs+bounces-21227-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GQqAyBf8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21227-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:17:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99747EA4D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12C9A30FAA7C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545133B0ADD;
	Tue, 28 Apr 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdGo5Sw7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7A3A6B6D;
	Tue, 28 Apr 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360290; cv=none; b=DLBmltVl+piFyyhVce8ih7qHHwNgKl9ihgBxBZ/v4QzOy1glpOAQQtliJY9/OHJzwOJk3Kr0PpP/HqpE4B1sJIBilPyh9PnyrcfkHeynA80rbUjYfcSkn7NIu5KKPth2kA2dRzpW8ctzH6HJPBKYmoXtqT1E6W1gtvnpVWcn+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360290; c=relaxed/simple;
	bh=No/DWtPORXDhdI5WkPJdJmmnosV5Q4Pg2jWF0WLDzwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQLktZV17Deo4FNQVn8hcC03+8enrdJUNTrn4vu8VwHSh6mwKn3shCrT1SvzWzjf6bXMSb7gy2LkicWaSi0fd/5nij4nkgqBvWGHSN4Hnq72Vml+377WyMnaONaLIGstxWd4kL3ThcNCqVJcygUShQFweMOXUrnrrEc+PjB+StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdGo5Sw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAD6C2BCB6;
	Tue, 28 Apr 2026 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360290;
	bh=No/DWtPORXDhdI5WkPJdJmmnosV5Q4Pg2jWF0WLDzwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qdGo5Sw7tq0oP9sGFUJBBijSzY2hjEUuakFBW5VISGUA98dKLbWP1OmybdX6kT667
	 AmgsqMRZJwSdtJJsbLQzjLKRKok1s1R3pFVlrxl8U3DB07D0WB1o9Aqt7HNsZ8W47y
	 OGEJk8bpg6S3elIY+/N+vpURVAPuYFeCQb+kOBCy9WvFIXyfVVlkpkZ9XloIyNGKUZ
	 L1LQJTSX4Sw7JS4FKdgEKNkuENp+6y9iGpdYS2M/NXNmByyaRUN1Z+jfqbP3KrgE0e
	 dfxiJ6SCoFhm5h4BSiaFMcm2m51u2kbylvp7glBgxm0c4js+1DIQvRc3/0EDanaAeS
	 kqkjc35em7Awg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:59 +0100
Subject: [PATCH v3 15/28] nfsd: use RCU to protect fi_deleg_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-15-5a0780ba9def@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7844; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=No/DWtPORXDhdI5WkPJdJmmnosV5Q4Pg2jWF0WLDzwk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1RkF5WuHxwNVWZJ1MbpLK7jRjb79uOfX/1c
 khRktj08LeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUQAKCRAADmhBGVaC
 FRn2D/9PFoBnQm1Qv/iECOPjs28AVeclsIDYZRg+40SW2liKczSE3ZhQQN1R4h4KguXp06E6rxt
 NCSUZbNjlvpMLbyWqez6vlfZd6HItIYxEzmB1RuxWPTiwtf8NhtkPMpKEjuCzo0lRFoy9z27F+t
 K5W1bGHZpsgqztw9fqmVtx+TNy+IzFLo2i/EBDiilSBueRf9ZDJtHqYhQI50qDt5pAwGE17jXJ8
 I2RbZqZl0XE5Bbe9O1CAEyMJXFlVnfxLVxxt/zu3ZSSh9c/v2j+v0anHKarj7KiVHRok0A4qMBl
 nrnMd1jWS19BX9Wsums14fRGXUXMR8i+vf6swReXEQ0OvlmuXnhJadl303tQdufKqkfRmXV4H4S
 6DNELXxXgYwOU0XJzVTHFEXxAMpooIhQvW8z15Kxo22ay0DRRvxKaAGHT+7elCzz7Ezp/4BSLY4
 y9YTUOFoJ44MarZjTlhFse/mp2lFKvHr5o7Vl6Hm6/koyYHbCdXw7tTEEuHbOcbQDVOJuXfHtTL
 V/ndW2qruP2WvjQPkC2js59Aoea/9g/8UjzXhfx7TqW4ekU5azS7Ke7wU5BNQO7OUAbch1gU4vN
 6aVcR8ctK+R9Apx2R4cwln/nhT+k9xYVDQjy2mDea0OFcIaJz5Havut4nznZZsKCZSMPrPjjM8y
 6ad6ruZAytsnMqA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 6F99747EA4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21227-lists,linux-nfs=lfdr.de];
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

Assisted-by: Claude (Anthropic Claude Code)
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
index c0046fc3c1b1..ef04e26b4f30 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1212,7 +1212,9 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 	spin_lock(&fp->fi_lock);
 	if (--fp->fi_delegees == 0) {
-		swap(nf, fp->fi_deleg_file);
+		nf = rcu_dereference_protected(fp->fi_deleg_file,
+					       lockdep_is_held(&fp->fi_lock));
+		rcu_assign_pointer(fp->fi_deleg_file, NULL);
 		swap(rnf, fp->fi_rdeleg_file);
 	}
 	spin_unlock(&fp->fi_lock);
@@ -1295,7 +1297,7 @@ static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
-	struct nfsd_file *nf = fp->fi_deleg_file;
+	struct nfsd_file *nf = rcu_dereference_protected(fp->fi_deleg_file, 1);
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
@@ -3167,7 +3169,8 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	/* XXX: lease time, whether it's being recalled. */
 
 	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
+	file = rcu_dereference_protected(nf->fi_deleg_file,
+					 lockdep_is_held(&nf->fi_lock));
 	if (file) {
 		seq_puts(s, ", ");
 		nfs4_show_superblock(s, file);
@@ -4949,7 +4952,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	INIT_LIST_HEAD(&fp->fi_delegations);
 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
 	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
-	fp->fi_deleg_file = NULL;
+	RCU_INIT_POINTER(fp->fi_deleg_file, NULL);
 	fp->fi_rdeleg_file = NULL;
 	fp->fi_had_conflict = false;
 	fp->fi_share_deny = 0;
@@ -6101,7 +6104,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
-	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->c.flc_file = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 	return fl;
 }
 
@@ -6109,7 +6112,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 					 struct nfs4_file *fp)
 {
 	struct nfs4_ol_stateid *st;
-	struct file *f = fp->fi_deleg_file->nf_file;
+	struct file *f = rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file;
 	struct inode *ino = file_inode(f);
 	int writes;
 
@@ -6186,7 +6189,7 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 
 	exp_put(exp);
 	dput(child);
-	if (child != file_dentry(fp->fi_deleg_file->nf_file))
+	if (child != file_dentry(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file))
 		return -EAGAIN;
 
 	return 0;
@@ -6292,8 +6295,9 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -6318,7 +6322,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = kernel_setlease(fp->fi_deleg_file->nf_file,
+	status = kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
 				      fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
@@ -6339,7 +6343,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 * Now that the deleg is set, check again to ensure that nothing
 	 * raced in and changed the mode while we weren't looking.
 	 */
-	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
+	status = nfsd4_verify_setuid_write(open, rcu_dereference_protected(fp->fi_deleg_file, 1));
 	if (status)
 		goto out_unlock;
 
@@ -6360,7 +6364,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	return dp;
 out_unlock:
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
+			F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
@@ -6517,8 +6522,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		struct file *f = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+		struct file *f;
 
+		f = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
 				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -9660,8 +9666,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
@@ -9713,7 +9720,8 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
2.54.0


