Return-Path: <linux-nfs+bounces-22481-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h6l0D9T1Kmo30AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22481-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:52:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D453F6742A1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:52:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OxQkelA0;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22481-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22481-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E9A0304CF1C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AD4B8DEB;
	Thu, 11 Jun 2026 17:50:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281941325C;
	Thu, 11 Jun 2026 17:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200251; cv=none; b=Xe+0g6RGoO20OkEJGMUiMc8GBHqpKaE4V7OyFgNEUZVKJHgPxbumFIY6aCEZu2PsWTxQnxCfS90ZL/JqEsEU5hsUl6w5dzx/V9oGlTVI79MSUUUvsJQhcdG0cvt3HkYFSrGXB8s49hh/GQomWPj+odScAYaoY/QYTnEjkwqDEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200251; c=relaxed/simple;
	bh=iN6TK9RWLIPs5Fe0ntwppLzGgSTCWnO9MUgusZhsHUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMyhgVWyihSWkfkf0ZZlxJPbSDa+1tMNywsBhqNgxMsdM5opUsXXGBRkn82MJLAxEA6Rc6E8uKEuSWV09aiTHeSs92phtKPVXGI3Dxa0y3CwnGG58mUbAhEypWo6cjD3Kh52qhVMkxLgH15aDesaifXgzZJTav+FwDZmluyngMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxQkelA0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F171F0089A;
	Thu, 11 Jun 2026 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200247;
	bh=kno+CwgnyMJF0/5i/TqOY2JdOePrnndvsTg7Gt+DwtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OxQkelA0l4ha5xxZYceDjzc6ykwh7/yXgqbPj7EtHYzh4rU4nCq3VCsXNKQYhge3R
	 4N3anpoU6iNHVplqPdEjqHCF3r91KmAZF6au5U/jyFjTjbu8opogubv88xg/EFOBWe
	 oLzPiwOLB6+SxHE+YJDUiRTLiQKnRAUdoTvUmlTxQ3qPSA6X+GOI1LBwqRu5wRzrDD
	 C9Q3zVKQi2gHsa9HP0E+FzoUVwgDlwUxlJkmyz7lL+4U6l6ZnhFeSr57ovbZyeYJKd
	 elVx8xxYVws65zyx9sv3S3xMSkDjdEJwzwBXBz0WiDvhsrbO6ns5eNTtoJ3s9qPBRB
	 p5HUyHSI08rYg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:14 -0400
Subject: [PATCH v6 08/20] nfsd: use RCU to protect fi_deleg_file
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-8-4c45080e5f3f@kernel.org>
References: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
In-Reply-To: <20260611-dir-deleg-v6-0-4c45080e5f3f@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9332; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=iN6TK9RWLIPs5Fe0ntwppLzGgSTCWnO9MUgusZhsHUg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVfvJwv2Rf+SeHOeUBwgIxRwvyXsV2ADT4Cw
 koLzmcQgc6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1XwAKCRAADmhBGVaC
 FeNvEACNTGhJqOzSwaEnUCctGlsI85zRfGBVu6JjN+HLmAH0yxP2tfAfg3U1evDa6pQNCqA3f7l
 huAwE8eyw+w3Cq42quD4j7If/W2aILXs403mngVErAWDcE8mIb6jzBttrnPDC84K+rUxe9LoJf9
 BxWWN0OoxhT/RXsv9yKle92Vw7xIiCbehice6heOJkPjRBY+0ZMZ5Fz7QLrTQn/31iM/UsRirxp
 5qfeYqIaU0q4R4+uZWdA8mzwimdcinroZhoixSo7HwaI0E1WPb3Dqr3PAas8LfRzsHgIK5+BhU2
 7mt1JQWUWIQjtDJ5kbVymzbRPRgvRG9QNJgqZiI0pOfTt1RWX4Q2g8tp0fkZFFcaHtd2RllVu2R
 SvLSTA9d1++xcNlUt9n/25CXqnQC3c/RkcoEe9R+pL8LtHkLGyD3RTOWrostRB0PJ0YOEVBQ2XU
 xGkznFUizmVlOtNnoJsGDRMB5JffcW5FfGSz5IWMFsBS3ndi5qOIX++4LZjzO1OuRH1qhiuEV1w
 piEo662rhPB8aAjANVCGrPLrS8utGNITaFOepce4LvgXTO8gNdw3D7L0k8RmZR8DD10q1MI3otq
 X0X2bU9Ed9rbugZKsa1F7FuRO9LsZltCrKKrcZlj/9HmE2vTJsomXOWohY7VH9fxbEsDbmVuMtQ
 Fl93TNCTNLwMFhA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22481-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D453F6742A1

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

The error-path lease teardown in nfsd_get_dir_deleg() is one of these
accessors, and it must drop the lease against fi_deleg_file->nf_file
rather than this client's nf->nf_file. The lease's flc_file is
fi_deleg_file (set in nfs4_alloc_init_lease()), which differs from nf
when an earlier client already holds a delegation on the same directory.
generic_delete_lease() matches on flc_file, so unlocking the wrong file
would fail to remove the lease, leaking it on the inode and then freeing
its owning stid underneath it -- a use-after-free once the leaked lease
is later broken. Read fi_deleg_file there with rcu_dereference_protected()
like the other accessors, and recalculate the fsnotify mask after
dropping the lease to match the success path.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4layouts.c |  7 ++++---
 fs/nfsd/nfs4state.c   | 51 ++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/state.h       |  2 +-
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 4c3f253c7d07..22bcb6d09f70 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -248,12 +248,13 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 			NFSPROC4_CLNT_CB_LAYOUT);
 
 	if (parent->sc_type == SC_TYPE_DELEG) {
-		spin_lock(&fp->fi_lock);
-		ls->ls_file = nfsd_file_get(fp->fi_deleg_file);
-		spin_unlock(&fp->fi_lock);
+		rcu_read_lock();
+		ls->ls_file = nfsd_file_get(rcu_dereference(fp->fi_deleg_file));
+		rcu_read_unlock();
 	} else {
 		ls->ls_file = find_any_file(fp);
 	}
+
 	if (!ls->ls_file) {
 		nfs4_put_stid(stp);
 		return NULL;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1ff954a18f93..18e81c7f9d19 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1212,7 +1212,9 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 	spin_lock(&fp->fi_lock);
 	if (--fp->fi_delegees == 0) {
-		swap(nf, fp->fi_deleg_file);
+		nf = rcu_dereference_protected(fp->fi_deleg_file,
+					       lockdep_is_held(&fp->fi_lock));
+		RCU_INIT_POINTER(fp->fi_deleg_file, NULL);
 		swap(rnf, fp->fi_rdeleg_file);
 	}
 	spin_unlock(&fp->fi_lock);
@@ -1250,7 +1252,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
-	struct nfsd_file *nf = fp->fi_deleg_file;
+	struct nfsd_file *nf = rcu_dereference_protected(fp->fi_deleg_file, 1);
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
@@ -3186,7 +3188,8 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	/* XXX: lease time, whether it's being recalled. */
 
 	spin_lock(&nf->fi_lock);
-	file = nf->fi_deleg_file;
+	file = rcu_dereference_protected(nf->fi_deleg_file,
+					 lockdep_is_held(&nf->fi_lock));
 	if (file) {
 		seq_puts(s, ", ");
 		nfs4_show_superblock(s, file);
@@ -4995,7 +4998,7 @@ static void nfsd4_file_init(const struct svc_fh *fh, struct nfs4_file *fp)
 	INIT_LIST_HEAD(&fp->fi_delegations);
 	INIT_LIST_HEAD(&fp->fi_clnt_odstate);
 	fh_copy_shallow(&fp->fi_fhandle, &fh->fh_handle);
-	fp->fi_deleg_file = NULL;
+	RCU_INIT_POINTER(fp->fi_deleg_file, NULL);
 	fp->fi_rdeleg_file = NULL;
 	fp->fi_had_conflict = false;
 	fp->fi_share_deny = 0;
@@ -6149,7 +6152,7 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp, u32
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
-	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->c.flc_file = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 	return fl;
 }
 
@@ -6157,7 +6160,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 					 struct nfs4_file *fp)
 {
 	struct nfs4_ol_stateid *st;
-	struct file *f = fp->fi_deleg_file->nf_file;
+	struct file *f = rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file;
 	struct inode *ino = file_inode(f);
 	int writes;
 
@@ -6234,7 +6237,7 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *open, struct nfs4_file *fp,
 
 	exp_put(exp);
 	dput(child);
-	if (child != file_dentry(fp->fi_deleg_file->nf_file))
+	if (child != file_dentry(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file))
 		return -EAGAIN;
 
 	return 0;
@@ -6340,8 +6343,9 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
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
@@ -6366,7 +6370,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = kernel_setlease(fp->fi_deleg_file->nf_file,
+	status = kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
 				      fl->c.flc_type, &fl, NULL);
 	if (fl)
 		locks_free_lease(fl);
@@ -6387,7 +6391,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 * Now that the deleg is set, check again to ensure that nothing
 	 * raced in and changed the mode while we weren't looking.
 	 */
-	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
+	status = nfsd4_verify_setuid_write(open, rcu_dereference_protected(fp->fi_deleg_file, 1));
 	if (status)
 		goto out_unlock;
 
@@ -6408,7 +6412,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	return dp;
 out_unlock:
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
+			F_UNLCK, NULL, (void **)&dp);
 out_clnt_odstate:
 	put_clnt_odstate(dp->dl_clnt_odstate);
 	nfs4_put_stid(&dp->dl_stid);
@@ -6565,8 +6570,9 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
 	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
-		struct file *f = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+		struct file *f;
 
+		f = rcu_dereference_protected(dp->dl_stid.sc_file->fi_deleg_file, 1)->nf_file;
 		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
 				!nfs4_delegation_stat(dp, currentfh, &stat)) {
 			nfs4_put_stid(&dp->dl_stid);
@@ -9765,8 +9771,9 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
@@ -9822,8 +9829,18 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		return dp;
 	}
 
-	/* Something failed. Drop the lease and clean up the stid */
-	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
+	/*
+	 * Something failed after the lease was set. Drop the lease and clean
+	 * up the stid. The lease's flc_file is the fi_deleg_file (see
+	 * nfs4_alloc_init_lease()), which is not necessarily this client's
+	 * @nf when an earlier client already holds a delegation on @fp.
+	 * generic_delete_lease() matches on flc_file, so unlock against
+	 * fi_deleg_file or the lease will be leaked (and later freed with the
+	 * stid, leading to a use-after-free when it's eventually broken).
+	 */
+	kernel_setlease(rcu_dereference_protected(fp->fi_deleg_file, 1)->nf_file,
+			F_UNLCK, NULL, (void **)&dp);
+	nfsd_fsnotify_recalc_mask(nf);
 out_put_stid:
 	nfs4_put_stid(&dp->dl_stid);
 out_delegees:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 9f321e9ed76d..4fca0537ca8b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -699,7 +699,7 @@ struct nfs4_file {
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


