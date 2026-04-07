Return-Path: <linux-nfs+bounces-20699-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM7/Hi4G1WmczgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20699-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:27:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1E3AF0EC
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9338C30A0482
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5F3BA226;
	Tue,  7 Apr 2026 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh17iT23"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDA3B7B71;
	Tue,  7 Apr 2026 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568170; cv=none; b=n+Wg6CGa++LYHum5qJlKJtndVGkHjXqYJvRGnLQwvtR4/+ABDR17Qr+2ZjvFhHCNjxl3wAnOL2argczJI3bgzR9B7ScTSMXXC4N8/R6Uv/lOAtxkgtvNwhDzbOWfwnFiUyrOtuQ3m+W2x4eWUr1nSk3H7eqMuNReLRtSXKeVsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568170; c=relaxed/simple;
	bh=KI9Y73gpFpkREBJqDZaHuXcw1A6OI3TbZ6+Ci8pMqFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpS1A3c5M7dI9M6lSW9p9Hu8y7wDKCULkOqNi8YdG0IlwEOXI4vzJvo76XM/OiloXiGKSslpOfHHNfwi1tfCaw3CCxwaGQ348kb1+zqkV46CmOnxaItGMpjy6LxKafuDXR2jMRkQwfe4KQuo0N7s/NnisGTTN06NdJh1hwXHZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh17iT23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03880C116C6;
	Tue,  7 Apr 2026 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568170;
	bh=KI9Y73gpFpkREBJqDZaHuXcw1A6OI3TbZ6+Ci8pMqFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sh17iT23RohKQT5nPmE9xYPv7QFIYIaSi+QmBmk5Iaid24c/kI6h+70ZsV2M9idpQ
	 NbmnMJj/T0rYc8eXgznDnU09zwQto/hlRLrqYP2Es7g/ZRGib0cANAoN0dcU0XPw4Y
	 8DIMAt85SMdxwJB+kIh9J3ghuw3jks7UrU/joXYyr4vgbXeXsiPKRdsi502b4+V3SD
	 IlCRtQPcdNLGciRjddH+0rqhByUnwxOW56rhhI13061WV58QIVikD8z5uP2wJ1bugY
	 +rVKRwteOpFkHEs2Y8phx3VYab2ScPI7dwpD+oBzA9RHWS2PuufWYkDR9ZrwSb7BKM
	 IOqz4JQtoGZxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:25 -0400
Subject: [PATCH 12/24] nfsd: add data structures for handling CB_NOTIFY
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-12-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9027; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KI9Y73gpFpkREBJqDZaHuXcw1A6OI3TbZ6+Ci8pMqFc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUHPbJV2fy3FfTxF6+BUanjoTP5HQztisfaf
 sHKsVqncOuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFBwAKCRAADmhBGVaC
 FcScEACy+rF43hJ9TFJjTFnzIujKjQuzaohU8LprcdE2I72v6boOF/yOJB55+IgOR2l+W0vVOog
 G9mGmUDS1R+HWIBIs067V0Hq+8u1vknvnHJKp0xxCao2bkMKrK9D9wKkMVuhdSlhDV3pmXZTzZE
 ODtptmTKcoxNuxKQUpPjlFR6TUTtRsisZrFOVRumYQXymWXWbsUeIlz2ot2oebx4mi+vzEbTAl3
 Gu6Sybfk5Wz37T5mYoq/OYmFK8/gHx0LgzsoSnaKoEfXrsgJIQn5XOHoZ+TJRQS9eJD4ODG9P+N
 Xc3AFVgWjrCJIuf8SvfRFXgmyYFGjAfAR0vNuqHRvdnE6DARqxLU2SCc2vFgkZ6ZtDqyMbjstVi
 9AiNaN+f0akVpHILssHXT9zeX4yvurV/O5K/R8sWO9DRnDqnf1nor4WvraBLzAWXolVFmnN8Ljb
 bjD4P8ANTAsqIW2B4y3nj6FwAWZDRo3/88xN3Ol2qFtPflpGLTqB5zv5X2BwzpJscfnDRimunBZ
 15PaQf1wE5BuDwAsStuDJtceVyN+HJjU0NJmBb1ySpwkl8n1EzHVegsdiJsm2ulqePZPgTFUMsy
 STVut9YcYH2Qe5peA/mIh+3NX4S9jfQLAwCXvXlZwYMXiutx2NEYS120Ak8xsFW6m1vK7FyaHha
 bTVcGPeQlaOWleQ==
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
	TAGGED_FROM(0.00)[bounces-20699-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 00A1E3AF0EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 fs/nfsd/nfs4state.c | 117 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/state.h     |  46 ++++++++++++++++++++-
 2 files changed, 147 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4afe7e68fb51..b2b8c454fc0f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -124,6 +124,7 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1121,29 +1122,31 @@ static void block_delegations(struct knfsd_fh *fh)
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
@@ -1153,19 +1156,75 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
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
+	release_pages(ncn->ncn_pages, NOTIFY4_PAGE_ARRAY_SIZE);
+	kfree(ncn->ncn_nf);
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
+		nfs4_free_dir_deleg(&dp->dl_stid);
+		return NULL;
+	}
+
+	ncn->ncn_nf = kcalloc(NOTIFY4_EVENT_QUEUE_SIZE, sizeof(*ncn->ncn_nf), GFP_KERNEL);
+	if (!ncn->ncn_nf) {
+		nfs4_free_dir_deleg(&dp->dl_stid);
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
@@ -3381,6 +3440,30 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
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
@@ -3393,6 +3476,12 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
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
@@ -9661,7 +9750,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	/* Try to set up the lease */
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
+	dp = alloc_init_dir_deleg(clp, fp);
 	if (!dp)
 		goto out_delegees;
 	if (cstate->current_fh.fh_export)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index eb5946b0999e..500e07e47909 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -197,6 +197,44 @@ struct nfs4_cb_fattr {
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
+	struct nfsd4_callback		ncn_cb;		// notify4 callback
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -233,8 +271,12 @@ struct nfs4_delegation {
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
2.53.0


