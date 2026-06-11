Return-Path: <linux-nfs+bounces-22482-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LSg0Glv2Kmpm0AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22482-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:54:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA5567431A
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:54:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l3w8GaYO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22482-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22482-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FAA43040762
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869E4C9018;
	Thu, 11 Jun 2026 17:50:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67614C6F16;
	Thu, 11 Jun 2026 17:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200254; cv=none; b=EqEB6n8ll9g0hI353c/oqyQ6VdzTcCss70JeBgbKWEpq1Et+qQ0uK8779yOm48kjU3S09wRQNyJv5+NrtLNr7uAu60be5FVITTF9GHa/Ruj1NzZMyTjRdYumxGN+oYsjUHlGkZf+TPy4COkXf2T6ypO7SnoOXXcYG9HGfaeKToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200254; c=relaxed/simple;
	bh=xrXr6jUxmyI17X6MLZ6PG+4mPNOR/YYk82fJ8HI+J2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tW9BpI6oPeosl2KTwPOZkQqGhLzaVEKLLigZMEJDNFCDLostBxJhlGQ9DcL8rdahSeHe7DJ7ENeGSLYcE0jgEenjboU/cUDVKb/vFVIcecA70hFyIYYntHfRc9ib4ROQYWauT2eHvcBeY90Eznwrrxap71K4vjAZ+Ct4xTnBu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3w8GaYO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8D01F00893;
	Thu, 11 Jun 2026 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200249;
	bh=KNRuRyRRwYT8cq2ZFhNIo7FW66TtF6J8eQjeI51vxEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l3w8GaYOryZst+cOSynCv+xQAuCsxwBfRPeOJEel5lzZZ/OcWNSfT8kDgThGImxLN
	 MBhEJkuls4uIkZCqrZKbYlTi2mm2+AfVlXHmlNiHlBDVjfxpDJXNC4EyS0sPrOOZDW
	 TxOTy1inhiuhPyvdJy3CXQZHWW0kTekuEAOqvCqSiggF8qRcjHkdplGAqBKqZ8YhxM
	 mp5s40uaIlupmHWLeF/IlSh0cdhsmoBUGJaNIKxRtdHczSaja4s4CtKAN4mbT0hrnx
	 KrJI1zrW8pM74CI/Gthr+lDQDw3sSXjQN9JRhDgun1ptIaeVcOL/H3qCqJ7NzDRc1W
	 4i081icWyx0ng==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:15 -0400
Subject: [PATCH v6 09/20] nfsd: add data structures for handling CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-9-4c45080e5f3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9133; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xrXr6jUxmyI17X6MLZ6PG+4mPNOR/YYk82fJ8HI+J2o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVgnOSNphgivHYsyI9O0Ih5t/KN2CYTpEfOx
 BZrxKQsSrOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1YAAKCRAADmhBGVaC
 FR2ZD/9Rk7cCX9Q3bacPq6XKz7/KJT4vEJ7wJtITZBaN3jQ1oznK4lQzQijBmE0XxRs1wLi7B5N
 BcOq+wWBDrMVY90BrdlNQTfqb6/NrZRiVPAqeEUf5x6somrgb0lt5LdiyDa/oU1amA5Fo8pLwkA
 Ko9kUzbwx8T1aIW5dQ9V155kZrbpNyig1QFgI37BgPH7N5QFBKaYgKkbvbobDBHb2Gr5HXhlaWZ
 d17GK8j80/4vn58Rnj88TTpH1DXUUxQe/Kcypehj/6EKsIRBYbZ4J/7vVGnueBt8h8Juw4NsuLE
 rHm9/KkTWLsgG7t9ainREYUIsKuwoBf0c1CJTmhOCz0nByax1VzTr9oSPzaoSlmCuxEHBH4EsmW
 yblxSXC+sDVwDZraQffyPJKDXgxgICuSoqQHRAxnx9icN6+fiHNw2idATQH4V/ZG6A8PMMF4NyF
 B09ccmYRTYSsQNMzA27cAuRlKegw6OI8/uBZWkjVgeMJMOW5UxgvnFvanbalP38Wee+U11dKnQO
 nMgxdz+TBo3qUY0aFxJAI1xrxagURBSZJOJsEsE03qt38cEcPDOBvhd24dxndRobdjpSKbtTe/y
 Whk0XAVBjIpyHmOBCnZkKS90AS1hGLH14wt4Ir3bcsfdKXWqzW6biOslcl2Kav7mk7w13hXkxLe
 dkOv8ueyzWd87Ow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22482-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FA5567431A

Add the data structures, allocation helpers, and callback operations
needed for directory delegation CB_NOTIFY support:

- struct nfsd_notify_event: carries fsnotify events for CB_NOTIFY
- struct nfsd4_cb_notify: per-delegation state for notification handling
- Union dl_cb_fattr with dl_cb_notify in nfs4_delegation since a
  delegation is either a regular file delegation or a directory
  delegation, never both

Refactor alloc_init_deleg() into a common __alloc_init_deleg() base
with a pluggable sc_free callback, and add alloc_init_dir_deleg() which
allocates the page array and notify4 buffer needed for CB_NOTIFY
encoding.

Add skeleton nfsd4_cb_notify_ops with done/release handlers that will
be filled in when the notification path is wired up.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/state.h     |  47 +++++++++++++++++++-
 2 files changed, 152 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 18e81c7f9d19..0a15d7f3b543 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -126,6 +126,7 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1123,29 +1124,31 @@ static void block_delegations(struct knfsd_fh *fh)
 }
 
 static struct nfs4_delegation *
-alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
-		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
+__alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
+		   struct nfs4_clnt_odstate *odstate, u32 dl_type,
+		   void (*sc_free)(struct nfs4_stid *))
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_stid *stid;
 	long n;
 
-	dprintk("NFSD alloc_init_deleg\n");
+	if (delegation_blocked(&fp->fi_fhandle))
+		return NULL;
+
 	n = atomic_long_inc_return(&num_delegations);
 	if (n < 0 || n > max_delegations)
 		goto out_dec;
-	if (delegation_blocked(&fp->fi_fhandle))
-		goto out_dec;
-	stid = nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg);
+
+	stid = nfs4_alloc_stid(clp, deleg_slab, sc_free);
 	if (stid == NULL)
 		goto out_dec;
-	dp = delegstateid(stid);
 
 	/*
 	 * delegation seqid's are never incremented.  The 4.1 special
 	 * meaning of seqid 0 isn't meaningful, really, but let's avoid
-	 * 0 anyway just for consistency and use 1:
+	 * 0 anyway just for consistency and use 1.
 	 */
+	dp = delegstateid(stid);
 	dp->dl_stid.sc_stateid.si_generation = 1;
 	INIT_LIST_HEAD(&dp->dl_perfile);
 	INIT_LIST_HEAD(&dp->dl_perclnt);
@@ -1155,19 +1158,79 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	dp->dl_type = dl_type;
 	dp->dl_retries = 1;
 	dp->dl_recalled = false;
-	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
-		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
-	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
-			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
-	dp->dl_cb_fattr.ncf_file_modified = false;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
+	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
+		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
 	return dp;
 out_dec:
 	atomic_long_dec(&num_delegations);
 	return NULL;
 }
 
+static struct nfs4_delegation *
+alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
+		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
+{
+	struct nfs4_delegation *dp;
+
+	dp = __alloc_init_deleg(clp, fp, odstate, dl_type, nfs4_free_deleg);
+	if (!dp)
+		return NULL;
+
+	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
+			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
+	dp->dl_cb_fattr.ncf_file_modified = false;
+	return dp;
+}
+
+static void nfs4_free_dir_deleg(struct nfs4_stid *stid)
+{
+	struct nfs4_delegation	*dp = delegstateid(stid);
+	struct nfsd4_cb_notify *ncn = &dp->dl_cb_notify;
+	int i;
+
+	for (i = 0; i < ncn->ncn_evt_cnt; ++i)
+		nfsd_notify_event_put(ncn->ncn_evt[i]);
+	kfree(ncn->ncn_nf);
+	for (i = 0; i < NOTIFY4_PAGE_ARRAY_SIZE; i++) {
+		if (!ncn->ncn_pages[i])
+			break;
+		put_page(ncn->ncn_pages[i]);
+	}
+	nfs4_free_deleg(stid);
+}
+
+static struct nfs4_delegation *
+alloc_init_dir_deleg(struct nfs4_client *clp, struct nfs4_file *fp)
+{
+	struct nfs4_delegation *dp;
+	struct nfsd4_cb_notify *ncn;
+	int npages;
+
+	dp = __alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ, nfs4_free_dir_deleg);
+	if (!dp)
+		return NULL;
+
+	ncn = &dp->dl_cb_notify;
+
+	npages = alloc_pages_bulk(GFP_KERNEL, NOTIFY4_PAGE_ARRAY_SIZE, ncn->ncn_pages);
+	if (npages != NOTIFY4_PAGE_ARRAY_SIZE) {
+		nfs4_put_stid(&dp->dl_stid);
+		return NULL;
+	}
+
+	ncn->ncn_nf = kcalloc(NOTIFY4_EVENT_QUEUE_SIZE, sizeof(*ncn->ncn_nf), GFP_KERNEL);
+	if (!ncn->ncn_nf) {
+		nfs4_put_stid(&dp->dl_stid);
+		return NULL;
+	}
+	spin_lock_init(&ncn->ncn_lock);
+	nfsd4_init_cb(&ncn->ncn_cb, dp->dl_stid.sc_client,
+			&nfsd4_cb_notify_ops, NFSPROC4_CLNT_CB_NOTIFY);
+	return dp;
+}
+
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
@@ -3408,6 +3471,30 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
+static int
+nfsd4_cb_notify_done(struct nfsd4_callback *cb,
+				struct rpc_task *task)
+{
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_notify_release(struct nfsd4_callback *cb)
+{
+	struct nfsd4_cb_notify *ncn =
+			container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp =
+			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
+	nfs4_put_stid(&dp->dl_stid);
+}
+
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
 	.done		= nfsd4_cb_recall_any_done,
 	.release	= nfsd4_cb_recall_any_release,
@@ -3420,6 +3507,12 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 	.opcode		= OP_CB_GETATTR,
 };
 
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops = {
+	.done		= nfsd4_cb_notify_done,
+	.release	= nfsd4_cb_notify_release,
+	.opcode		= OP_CB_NOTIFY,
+};
+
 static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 {
 	struct nfs4_delegation *dp =
@@ -9788,7 +9881,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	/* Try to set up the lease */
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
+	dp = alloc_init_dir_deleg(clp, fp);
 	if (!dp)
 		goto out_delegees;
 	if (cstate->current_fh.fh_export)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4fca0537ca8b..ac9dd798ea22 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -197,6 +197,45 @@ struct nfs4_cb_fattr {
 #define NOTIFY4_EVENT_QUEUE_SIZE	3
 #define NOTIFY4_PAGE_ARRAY_SIZE		1
 
+struct nfsd_notify_event {
+	refcount_t	ne_ref;		// refcount
+	u32		ne_mask;	// FS_* mask from fsnotify callback
+	struct dentry	*ne_dentry;	// dentry reference to target
+	u32		ne_namelen;	// length of ne_name
+	char		ne_name[];	// name of dentry being changed
+};
+
+static inline struct nfsd_notify_event *nfsd_notify_event_get(struct nfsd_notify_event *ne)
+{
+	refcount_inc(&ne->ne_ref);
+	return ne;
+}
+
+static inline void nfsd_notify_event_put(struct nfsd_notify_event *ne)
+{
+	if (refcount_dec_and_test(&ne->ne_ref)) {
+		dput(ne->ne_dentry);
+		kfree(ne);
+	}
+}
+
+/*
+ * Represents a directory delegation. The callback is for handling CB_NOTIFYs.
+ * As notifications from fsnotify come in, allocate a new event, take the ncn_lock,
+ * and add it to the ncn_evt queue. The CB_NOTIFY prepare handler will take the
+ * lock, clean out the list and process it.
+ */
+struct nfsd4_cb_notify {
+	spinlock_t			ncn_lock;	// protects the evt queue and count
+	int				ncn_evt_cnt;	// count of events in ncn_evt
+	int				ncn_nf_cnt;	// count of valid entries in ncn_nf
+	struct nfsd_notify_event	*ncn_evt[NOTIFY4_EVENT_QUEUE_SIZE]; // list of events
+	struct page			*ncn_pages[NOTIFY4_PAGE_ARRAY_SIZE]; // for encoding
+	struct notify4			*ncn_nf;	// array of notify4's to be sent
+	bool				ncn_encode_err;	// did encoding fail?
+	struct nfsd4_callback		ncn_cb;		// notify4 callback
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -233,8 +272,12 @@ struct nfs4_delegation {
 	bool			dl_written;
 	bool			dl_setattr;
 
-	/* for CB_GETATTR */
-	struct nfs4_cb_fattr    dl_cb_fattr;
+	union {
+		/* for CB_GETATTR */
+		struct nfs4_cb_fattr    dl_cb_fattr;
+		/* for CB_NOTIFY */
+		struct nfsd4_cb_notify	dl_cb_notify;
+	};
 
 	/* For delegated timestamps */
 	struct timespec64	dl_atime;

-- 
2.54.0


