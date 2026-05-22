Return-Path: <linux-nfs+bounces-21823-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONT0EmmzEGrRcgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21823-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:50:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C11995B9A50
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9643C3047E58
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57D37B02B;
	Fri, 22 May 2026 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSLZ6pTd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FF37B02A;
	Fri, 22 May 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478970; cv=none; b=aqLerL+w7HD9acVWJ98oQbDyezi5nC5pSap9FEyG4NTbW7Nf13qWn7DUyFAxSPK6wg1I3hrbey4dLvvXdsu5IvBQ5qVrzvH1LhHA9msoQ5egwvJZIWwSSUQ8Q+yoP+6KkOGol/5bO9ou/eMeb7eorPyOYxKbAFxXh+y6Csh1Dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478970; c=relaxed/simple;
	bh=qvNv3avOBk9oArnOhEgN0HSPFsi4RlLa8VUkMUtwkxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxLNjKz6DGRd8qOyfQ2y6aXm1YzGH7yz0OK9aMneA5/BT5rEgu/PpYIVsilhNEI0/z0PPSW4vDMPHEOsI/An7EGTfeWai2ofKLLl/fe/9xF30ipzIZXa4EewROO8o4fkwNAg5+LxVT26hAkYVDe1vP2/QyCCQJXzPuCJ7jCCnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSLZ6pTd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24F11F0155A;
	Fri, 22 May 2026 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478965;
	bh=3Oy1/PFMRSc/PeEI6oqyJ/bni/JvWJ/Zz2Yv0mwxI/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lSLZ6pTd9pbkCIjUck7N/u0rqbR2/AUjjbgroFALIE12235Xnd3G0RAXfGRxix2s5
	 wXp/4QUOYsLqiJFFaq9wJG+JkzbwKatEpGUq6//dBbDeHIgmET7Dw65zEyhfrQoS+H
	 8+xJt1To9FYHSl7cHaAQAa9+nNF5U/x+SlZ5M1Pbrfc/2nAVxek0r2EywCX8+2Gz68
	 SqYcXndonJFKrOlbv7UAkAl/ZLQbzCLruhhuqec5iVCBOwfVUapA5qC5O5HOXej0ne
	 rfUknGUOvah8blm/esVFw5L82wXSvL5SxmLIOMp0OmDDLfrE4g6O3yC9t46lmo2A28
	 MT6NRFF8TWQeg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:13 -0400
Subject: [PATCH v5 08/21] nfsd: use RCU to protect fi_deleg_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-8-542cddfad576@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7785; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qvNv3avOBk9oArnOhEgN0HSPFsi4RlLa8VUkMUtwkxo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGeYaTOa+mCPlZ7kyXCSbP8nY3OByaiXk9wg
 FH6ZaBEieuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxngAKCRAADmhBGVaC
 FUQ7D/435A1kDFUXpY3BY6y7gQFnO/3NKRCec7nDZ1Pz1CG0q8wAh2/ZmQxKuyXsNIqq0NOYxB0
 1gf+5V+1kBBD0C6jHDdFX2JB6b2BYsGwI6URUjSUkQ89sACKA8IZmRhuQW3uY2VENkaOmeoelhw
 zDubkkoFRgPRaaM+d6g0/3JcBLxQPCIMiY/fG2AxOZPNsSHW3oqlTi+WBALw2d+Q8/oKx0F34Fc
 zgWriBwcAdCTLkfzBzUl5QhC2xlkeTs8qfaHaSi977PmGHRBdcmHk4GVWJxQkhZqNn8Cba1DU5y
 YPOftZGJI+p+98aRYkRl/gHynF2b4RhgN+UNqwL6qlw/XWlpKRekECqKYdwxWJlhLnHLAcplq3i
 M6C6GnCgBDY1D4rHxPbd+S0aqIVdln+MJzDPwsO/a6Q1pp6yYsuFDeKp0fimdtW5eW/uTo5pUkY
 w1jWIboAxvMgh7XiAIOQIKZ1EXAMgyMnoYe6ajRBybniCxJW0pKtyubI/pSxshalLPMOWUP2EZN
 BeUYGNyP2tyQX9DCHfAjXwTgCxLfdaNLn/09ohZSSoh7REQqBFlFeOHql5DRMKV+xN3/CP0MC/b
 /87kBnhyp40ENhTBGuyG/vYobhevgog/SbgGVnXA67XrSiCZ6vbdED010jyVi+CGDHm08Us4Frh
 1zm5qNAk1wlrhpw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21823-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: C11995B9A50
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

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c |  2 +-
 fs/nfsd/nfs4state.c   | 39 +++++++++++++++++++++++----------------
 fs/nfsd/state.h       |  2 +-
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index e3984c90792e..9ed2e3d65062 100644
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
index 3efc53f0dde6..bd0517dfe881 100644
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
@@ -1282,7 +1284,7 @@ static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
-	struct nfsd_file *nf = fp->fi_deleg_file;
+	struct nfsd_file *nf = rcu_dereference_protected(fp->fi_deleg_file, 1);
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
@@ -3176,7 +3178,8 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	/* XXX: lease time, whether it's being recalled. */
 
 	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
+	file = rcu_dereference_protected(nf->fi_deleg_file,
+					 lockdep_is_held(&nf->fi_lock));
 	if (file) {
 		seq_puts(s, ", ");
 		nfs4_show_superblock(s, file);
@@ -4958,7 +4961,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	INIT_LIST_HEAD(&fp->fi_delegations);
 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
 	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
-	fp->fi_deleg_file = NULL;
+	RCU_INIT_POINTER(fp->fi_deleg_file, NULL);
 	fp->fi_rdeleg_file = NULL;
 	fp->fi_had_conflict = false;
 	fp->fi_share_deny = 0;
@@ -6110,7 +6113,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
-	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->c.flc_file = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 	return fl;
 }
 
@@ -6118,7 +6121,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 					 struct nfs4_file *fp)
 {
 	struct nfs4_ol_stateid *st;
-	struct file *f = fp->fi_deleg_file->nf_file;
+	struct file *f = rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file;
 	struct inode *ino = file_inode(f);
 	int writes;
 
@@ -6195,7 +6198,7 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 
 	exp_put(exp);
 	dput(child);
-	if (child != file_dentry(fp->fi_deleg_file->nf_file))
+	if (child != file_dentry(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file))
 		return -EAGAIN;
 
 	return 0;
@@ -6301,8 +6304,9 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -6327,7 +6331,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = kernel_setlease(fp->fi_deleg_file->nf_file,
+	status = kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
 				      fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
@@ -6348,7 +6352,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 * Now that the deleg is set, check again to ensure that nothing
 	 * raced in and changed the mode while we weren't looking.
 	 */
-	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
+	status = nfsd4_verify_setuid_write(open, rcu_dereference_protected(fp->fi_deleg_file, 1));
 	if (status)
 		goto out_unlock;
 
@@ -6369,7 +6373,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	return dp;
 out_unlock:
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
+			F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
@@ -6526,8 +6531,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		struct file *f = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+		struct file *f;
 
+		f = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
 				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -9669,8 +9675,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
@@ -9722,7 +9729,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	}
 
 	/* Something failed. Drop the lease and clean up the stid */
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 out_put_stid:
 	nfs4_put_stid(&dp->dl_stid);
 out_delegees:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 790282781243..9c6e2e7abc82 100644
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


