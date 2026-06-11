Return-Path: <linux-nfs+bounces-22478-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c2DNJfL1Kmo80AMAu9opvQ
	(envelope-from <linux-nfs+bounces-22478-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:52:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939226742B4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 19:52:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZHrCF75s;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22478-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22478-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 036E23018A25
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674D4ADD8B;
	Thu, 11 Jun 2026 17:50:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237D4A33E5;
	Thu, 11 Jun 2026 17:50:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200242; cv=none; b=XSZZ7azi/Y7W806MaidK+t1J8H8HX3nV8tURslJJBq7NarLi/cK7b2ZVZrUwJ/QUsiWnY1O+rZmM/TJuEQlQyS2IXxtdxLi0C+hxVChRVrVoy4sHk2yboTeHILxGTd6KMtOadRJZHJq1uuJ0hi5NeYyxbJfENZqJ62R4069WpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200242; c=relaxed/simple;
	bh=2mj7rilJ3++y8iwjD02Sk6de1eteiT1OmZ8l6jAnzs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NG3i6dxMmcDEItXHccMNKY/k7SRWlP5tca7E7ybkn1Ph2hfRJU1FO6chUkvjy7teTAzeZ6NH/xOef8+IFMSaAnNE5wSyhJnKMJycaTYhFu2Sb7Ff7hYoZqvn0qlP1w9KFRL82ZpdDvAssJrfdFTypC5F4jFZ5OuuLgHn89B7Ats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHrCF75s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5EF1F00893;
	Thu, 11 Jun 2026 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200241;
	bh=rlSdhSVKpu6D4XddoJBpjIt8rwUphSQXIugI32Vz1KI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZHrCF75skNgV8Ac7OHFU+mv/6QhEjLPbYL9YEMPJrmu8JfUUJ0Yegcz9pj2YvMOUJ
	 7/6Gtj0Ix+Dm6udPPi0ZleHXyVyS1ZKgQ9FEplJmLw0akjgF9jVePdKvT29gtTuRo0
	 OPpscY5N4ZV5Xc/zmi7BMt7jJ+H+utUZq31kaG8o5Zp+768yOuyU8cHMpm++QZ56O/
	 +9b5ZXIGF+2HV0eJCiD1RNW0KPM1HVPpxvBMeK8eudUxk6kXjt8H0XNsBQ+fc51/IP
	 a9lPNcCF9XlvD+mbjmAKNfBmQI7wEbRnMEb3FDKnEPApntgIaQURnV5A3EOBnal1vX
	 Z/G0Kgw5gMNTA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 13:50:11 -0400
Subject: [PATCH v6 05/20] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-dir-deleg-v6-5-4c45080e5f3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5219; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2mj7rilJ3++y8iwjD02Sk6de1eteiT1OmZ8l6jAnzs0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKvVe1rHK5wRojzx2heBdNq/ZpBQhnXKzxHfA/
 ytJQMeOa9qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCair1XgAKCRAADmhBGVaC
 FW73D/4jWQouGujqRB8d0B8Asj2gJ5HanD4kwefGctXhoPEO6LU+ZsxKDxaHu0+w+Oo2Fkl2FGH
 9SW/9aRYB1G+dcGH/y8u/b8JweYLk+DA9kvGcOhuUu0gJhjSNrZ87ULAmoptb+litv0UDCf9bq7
 +olaofq2WatUumEqw3WaakqIMRL0zpPzvc4wTlgK3TJpKBVO2UH5SvkVH0QN2oos4YyYUtZrdxS
 3H+bQ+BzJ6c/B3prVy416fUHcCxmLD/NqyRxeSElwWIQP1Muw5wQds6wjW7+aZbN0BwYsUELlMw
 3rGqskbT47lO+ne41D51vsVF10tJHH4IzjJo8j8az7ELYDjHz50MsiB8EreKVqa19XoWu3nfukV
 ofKmIb29CdvFs/moZdpNpw1SX8xW6j/uZB1lMXI2S1yi2hPmNu3GX0Ue1wFyzLo10lAT49Kh67u
 22HJSNecNKQXTF7y4G0WCmeJtJFKry25oTrFlwwDsTyK0FqheylEX0kA3qYx/Pd5GSWuLJkBn3F
 Zpagq2vpisZe1QI6//UdaZe7Zqq+l72gFhqWxBpsnTI1HZ47PymtSQ7omwHis7YFCTqSJtQuHCW
 aoaocJl5O1slW8Fo+CA1EmItr60G/27SWj3bHlFsIzy0sVVLPdDOEJukhg6fZCSnJ9tguzuWP57
 Xo6AlHbImHopfmg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22478-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 939226742B4

Add a new helper function that will update the mask on the nfsd_file's
fsnotify_mark to be a union of all current directory delegations on an
inode.

Call that when directory delegations are added or removed, since that
can change what fsnotify events nfsd requires from the VFS layer.

The fsnotify_mark is shared by every nfsd_file open on the inode, so
concurrent delegation adds and removes on the same directory can run
nfsd_fsnotify_recalc_mask() in parallel. Because it reads the lease
state and updates the mark in two separate locked sections, a recalc
working from a stale snapshot of the lease list could clobber a
concurrent update and leave the mark missing required events. Add an
nfm_recalc_mutex to the nfsd_file_mark and hold it across the recalc to
serialize callers.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  3 +++
 fs/nfsd/nfs4state.c |  5 +++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1ea2bfd51825..c5f2c5768324 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -192,6 +192,7 @@ nfsd_file_mark_find_or_create(struct inode *inode)
 		fsnotify_init_mark(&new->nfm_mark, nfsd_file_fsnotify_group);
 		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
 		refcount_set(&new->nfm_ref, 1);
+		mutex_init(&new->nfm_recalc_mutex);
 
 		err = fsnotify_add_inode_mark(&new->nfm_mark, inode, 0);
 
@@ -1473,3 +1474,54 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		seq_printf(m, "mean age (ms): -\n");
 	return 0;
 }
+
+/**
+ * nfsd_fsnotify_recalc_mask - recalculate the fsnotify mask for a nfsd_file
+ * @nf: nfsd_file to recalculate the mask on
+ *
+ * When a directory nfsd_file has a delegation added or removed, that may
+ * change the events that nfsd requires from the VFS layer. This function
+ * recalculates the fsnotify mask based on the leases present.
+ */
+void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+	u32 lease_mask, set = 0, clear = 0;
+	struct fsnotify_mark *mark;
+
+	/* This is only needed when adding or removing dir delegs */
+	if (!S_ISDIR(inode->i_mode) || !nf->nf_mark)
+		return;
+
+	mark = &nf->nf_mark->nfm_mark;
+
+	/*
+	 * The mark is shared by every nfsd_file on this inode, so concurrent
+	 * delegation add/remove on the same directory can recalc it in
+	 * parallel. Serialize the read of the lease state and the update of
+	 * the mark so that a recalc working from a stale snapshot of the
+	 * lease list can't clobber a concurrent recalc's update.
+	 */
+	mutex_lock(&nf->nf_mark->nfm_recalc_mutex);
+
+	/* Set up notifications for any ignored delegation events */
+	lease_mask = inode_lease_ignore_mask(inode);
+
+	if (lease_mask & FL_IGN_DIR_CREATE)
+		set |= FS_CREATE | FS_MOVED_TO;
+	else
+		clear |= FS_CREATE | FS_MOVED_TO;
+
+	if (lease_mask & FL_IGN_DIR_DELETE)
+		set |= FS_DELETE | FS_MOVED_FROM;
+	else
+		clear |= FS_DELETE | FS_MOVED_FROM;
+
+	if (lease_mask & FL_IGN_DIR_RENAME)
+		set |= FS_RENAME;
+	else
+		clear |= FS_RENAME;
+
+	fsnotify_modify_mark_mask(mark, set, clear);
+	mutex_unlock(&nf->nf_mark->nfm_recalc_mutex);
+}
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 683b6437cacc..b224902b438d 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -26,6 +26,8 @@
 struct nfsd_file_mark {
 	struct fsnotify_mark	nfm_mark;
 	refcount_t		nfm_ref;
+	/* serializes nfsd_fsnotify_recalc_mask() against itself */
+	struct mutex		nfm_recalc_mutex;
 };
 
 /*
@@ -86,4 +88,5 @@ __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 __be32 nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
+void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ae8505747dc2..0cbb37f73ee7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1255,6 +1255,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
+	nfsd_fsnotify_recalc_mask(nf);
 	put_deleg_file(fp);
 }
 
@@ -9725,8 +9726,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
  * @nf: nfsd_file opened on the directory
  *
  * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a delegation
- * on the directory to which @nf refers. Note that this does not set up any
- * sort of async notifications for the delegation.
+ * on the directory to which @nf refers.
  */
 struct nfs4_delegation *
 nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
@@ -9816,6 +9816,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	if (!status) {
 		put_nfs4_file(fp);
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
 	}
 

-- 
2.54.0


