Return-Path: <linux-nfs+bounces-20624-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dYI9MQy/z2kM0QYAu9opvQ
	(envelope-from <linux-nfs+bounces-20624-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:22:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FBF394632
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 15:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541E5302414D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC81D3A6EE7;
	Fri,  3 Apr 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVy+68mr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF53A383C
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222536; cv=none; b=EzTy5giJ18q6UYTpz9iNVfiRS1pTUP7/Psh9szIi7W+CQ9xxTX70yAIOJVVsGTwrN9buiRiTW4JtQSoXTauNGtXqjNi7LjatwVQ+xRCuIAl18vEVI8QcUDiwy1wze3MGAQ8wn95uLrUnde5A+KMa12cEKvy8/q9PM8hxOci2JIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222536; c=relaxed/simple;
	bh=/AaWgwYvN86r0rRI8n4eSgnPejnhndA34zx9ReDq53c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJbOzC93ETbwVTpNq+2+b5no71xKKnA66WLBKnvJfkb51vUCDMRc82xpXyxhiD6shxJFJg8YVAVTeHe7FHLfcUF87eCiWc55fKCrNmXVEgsn4ja5HRIqAIlQ+4Bf8VunDkPwjaRjaLs+3iiQzt/CaaZKMFt5tZJ2OzjEzTcNJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVy+68mr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775222534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lrV1CpJcxz8qp9Shfb/YNZUza6ooeLg9dQ6FD1p57kY=;
	b=FVy+68mroh3c26SEuFPM9y/n5O8smNsQqK7IXxXkLyHq9mkSsubx96mHyVA3LsbY5Q2R+6
	8dBERLyhN89mlm9n1fkT8zDLXqgEPmJenFYyYjTuKaS4L6QWiowKnrWNzE9Q6kuUDqxkd+
	5MhY3RQzRjPSe0k6Pg9P1EV4L73xGpI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-bcBsyDh8PMymZL-s9d973A-1; Fri,
 03 Apr 2026 09:22:12 -0400
X-MC-Unique: bcBsyDh8PMymZL-s9d973A-1
X-Mimecast-MFC-AGG-ID: bcBsyDh8PMymZL-s9d973A_1775222531
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72DDB1956046;
	Fri,  3 Apr 2026 13:22:11 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BBE119560A6;
	Fri,  3 Apr 2026 13:22:11 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id A9DC6749DE8;
	Fri, 03 Apr 2026 09:22:09 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fix file change detection in CB_GETATTR
Date: Fri,  3 Apr 2026 09:22:09 -0400
Message-ID: <20260403132209.1479385-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20624-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16FBF394632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 8881, section 10.4.3 doesn't say anything about caching the file
size in the delegation record, nor does it say anything about comparing
a cached file size with the size reported by the client in the
CB_GETATTR reply for the purpose of determining if the client holds
modified data for the file.

What section 10.4.3 of RFC 8881 does say is that the server should
compare the *current* file size with size reported by the client holding
the delegation in the CB_GETATTR reply, and if they differ to treat it
as a modification regardless of the change attribute retrieved via the
CB_GETATTR.

Doing otherwise would cause the server to believe the client holding the
delegation has a modified version of the file, even if the client
flushed the modifications to the server prior to the CB_GETATTR.  This
would have the added side effect of subsequent CB_GETATTRs causing
updates to the mtime, ctime, and change attribute even if the client
holding the delegation makes no further updates to the file.

Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
via vfs_getattr().  Retain the ncf_cur_fsize field, since it's a
convenient way to return the file size back to nfsd4_encode_fattr4(),
but don't use it for the purpose of detecting file changes.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
Note this patch is against Chuck's nfsd-next branch.

Also, I have a pynfs test that illustrates the "bad" behavior.  See
"pynfs: add delegation test for CB_GETATTR after sync WRITE", which will
be sent shortly.

 fs/nfsd/nfs4state.c | 17 +++++++++++------
 fs/nfsd/nfs4xdr.c   |  2 +-
 fs/nfsd/state.h     |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b4d0e82b2690..2c82438918f6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9372,7 +9372,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
  * caller must put the reference.
  */
 __be32
-nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
+nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
 			     struct nfs4_delegation **pdp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
@@ -9381,7 +9381,9 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
 	struct nfs4_cb_fattr *ncf;
-	struct inode *inode = d_inode(dentry);
+	struct inode *inode = d_inode(path->dentry);
+	struct kstat stat;
+	int err;
 	__be32 status;
 
 	ctx = locks_inode_context(inode);
@@ -9430,19 +9432,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		    !nfsd_wait_for_delegreturn(rqstp, inode))
 			goto out_status;
 	}
+	err = vfs_getattr(path, &stat, STATX_SIZE, AT_STATX_SYNC_AS_STAT);
+	if (err) {
+		status = nfserrno(err);
+		goto out_status;
+	}
 	if (!ncf->ncf_file_modified &&
 	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
-	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
+	     stat.size != ncf->ncf_cb_fsize))
 		ncf->ncf_file_modified = true;
 	if (ncf->ncf_file_modified) {
-		int err;
-
 		/*
 		 * Per section 10.4.3 of RFC 8881, the server would
 		 * not update the file's metadata with the client's
 		 * modified size
 		 */
-		err = cb_getattr_update_times(dentry, dp);
+		err = cb_getattr_update_times(path->dentry, dp);
 		if (err) {
 			status = nfserrno(err);
 			goto out_status;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..b380c2545f6a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3914,7 +3914,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
 			    FATTR4_WORD1_TIME_MODIFY |
 			    FATTR4_WORD1_TIME_METADATA))) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
+		status = nfsd4_deleg_getattr_conflict(rqstp, &path, &dp);
 		if (status)
 			goto out;
 	}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 9b05462da4cc..edfb3402dfd2 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -889,7 +889,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-		struct dentry *dentry, struct nfs4_delegation **pdp);
+		struct path *path, struct nfs4_delegation **pdp);
 
 struct nfsd4_get_dir_delegation;
 struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
-- 
2.53.0


