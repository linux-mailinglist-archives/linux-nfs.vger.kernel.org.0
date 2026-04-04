Return-Path: <linux-nfs+bounces-20647-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFpgHjth0GnC7AYAu9opvQ
	(envelope-from <linux-nfs+bounces-20647-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:54:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94839965C
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 02:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DA853008447
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 00:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67821221D89;
	Sat,  4 Apr 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITkoU5iJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC532264A3
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775264053; cv=none; b=NS14Tis4bjAwF9GRVIiIR2GlDOfI2Lm6kwFENDPcw9Uxn3bZtCt8uFB733BpPFGmREdlVrfmzRsqLI3xLAuS2ZSUeijCa+i5LIeIKMybgf5sTOdLHnDQ0cf9gmj4bg8iUAPN3aENF7k+yBGu9Ar05Ik2KnQx4Pkrf+EO9UZLUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775264053; c=relaxed/simple;
	bh=t4G0m5rNulaX1PWhY85Y4ednmvNYtIY3s3pNNfkwvI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oM9gQ/1AkRJJk62lN+etUy0XLF5w5Eu363fPuLonDvy3SrfVy/w21QzAW3z61trFaXyHYSMy/xqfI9TAxKiuoKPDousPKFxKVej0KoGx75xR8WIXrzF6W6fUSX72xfLdWgnAzYbjWDTkmbn/hT91x1RcvuRqMDiMhgjYSUTz5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITkoU5iJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775264050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aiS3GXXCz1hy1WfO75g57/odz3A6YMwUMC7TPEIZLpg=;
	b=ITkoU5iJcxZpXuvia9lAY7GqOO02jGdJWkeUvxm2bUQyA9vAp4e3IqcQVA5LFQc/lFiVmk
	OyKdczr6eSbQ7CEEhgM2PuKNcIZuCC37YzEMU3Mc5UTeEG4fAorw3sIM/w9I4K7yM0qQyp
	iMTcuWnIxEyMs0cqheeyKrAkL1BLHKg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-utFyMkbgORafQPe6TG9qwg-1; Fri,
 03 Apr 2026 20:54:09 -0400
X-MC-Unique: utFyMkbgORafQPe6TG9qwg-1
X-Mimecast-MFC-AGG-ID: utFyMkbgORafQPe6TG9qwg_1775264048
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C49511800561;
	Sat,  4 Apr 2026 00:54:07 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 322DC30002D2;
	Sat,  4 Apr 2026 00:54:07 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 9658D749EB8;
	Fri, 03 Apr 2026 20:54:05 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: fix file change detection in CB_GETATTR
Date: Fri,  3 Apr 2026 20:54:05 -0400
Message-ID: <20260404005405.1565136-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-20647-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7E94839965C
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

Also, if we recall the delegation (because the client didn't respond to
the CB_GETATTR), then skip the logic that checks the nfs4_cb_fattr
fields.

Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
This patch is against Chuck's nfsd-testing branch.

A pynfs test that illustrates the issue is available here (delegated
timestamps must be disabled to make the test fail):
https://lore.kernel.org/linux-nfs/20260404003050.1560149-6-smayhew@redhat.com/T/#u

v2 changes:
- update kerneldoc comment for nfsd4_deleg_getattr_conflict()
- relocated declarations in nfsd4_deleg_getattr_conflict() to maintain
  reverse-xmas tree ordering
- pass the struct kstat from the nfsd4_fattr_args to
  nfsd4_deleg_getattr_conflict() instead of creating another one on the
  stack
- only call vfs_getattr() in nfsd4_deleg_getattr_conflict() for the
  !ncf_file_modified case (once the file has been flagged as modified,
  it remains so until the delegation is returned or revoked, so further
  calls to vfs_getattr() are unnecessary)
- if we recall the delegation (because the client didn't respond to the
  CB_GETATTR), then skip the CB_GETATTR comparison logic

Chuck - to test the last part I hacked a pynfs test to force a CB_RECALL
by not responding to the CB_GETATTR in a timely manner.  But nfsd has a
pretty aggressive timeout for the DELEGRETURN (30ms) before it responds
to the client that issued the GETATTR with NFS4ERR_DELAY.  On the system
I'm testing on, it looks like it's taking just over 30ms on average:

            nfsd-2971    [059] ...1.   451.007305: nfsd_cb_recall: addr=127.0.0.1:0 client 69d047c9:03b2de67 stateid 00000002:00000001
            nfsd-2971    [059] .....   451.037306: nfsd_delegret_wakeup: xid=0x16c768b1 inode=000000000a5c53d9 (timed out)
            nfsd-2971    [059] .....   451.037461: nfsd_deleg_return: client 69d047c9:03b2de67 stateid 00000002:00000001

So I bumped the timeout to 50ms (just in my test kernel) and it appears
to do the right thing... I'm just not sure how often it'll actually come
in play in normal usage.

 fs/nfsd/nfs4state.c | 35 ++++++++++++++++++++++++-----------
 fs/nfsd/nfs4xdr.c   |  3 ++-
 fs/nfsd/state.h     |  3 ++-
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fa657badf5f8..53d8e7e7d60b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9444,7 +9444,9 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
 /**
  * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
  * @rqstp: RPC transaction context
- * @dentry: dentry of inode to be checked for a conflict
+ * @path: used to get the inode and size of the file to be checked for a
+ * 	  conflict
+ * @stat: used to get the size of the file to be checked for a conflict
  * @pdp: returned WRITE delegation, if one was found
  *
  * This function is called when there is a conflict between a write
@@ -9459,17 +9461,18 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
  * caller must put the reference.
  */
 __be32
-nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
-			     struct nfs4_delegation **pdp)
+nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
+			     struct kstat *stat, struct nfs4_delegation **pdp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
+	struct inode *inode = d_inode(path->dentry);
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
 	struct nfs4_cb_fattr *ncf;
-	struct inode *inode = d_inode(dentry);
 	__be32 status;
+	int err;
 
 	ctx = locks_inode_context(inode);
 	if (!ctx)
@@ -9516,20 +9519,30 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		if (status != nfserr_jukebox ||
 		    !nfsd_wait_for_delegreturn(rqstp, inode))
 			goto out_status;
+		status = nfs_ok;
+		goto out_status;
+	}
+	if (!ncf->ncf_file_modified) {
+		if (ncf->ncf_initial_cinfo != ncf->ncf_cb_change) {
+			ncf->ncf_file_modified = true;
+		} else {
+			err = vfs_getattr(path, stat, STATX_SIZE,
+					  AT_STATX_SYNC_AS_STAT);
+			if (err) {
+				status = nfserrno(err);
+				goto out_status;
+			}
+			if (stat->size != ncf->ncf_cb_fsize)
+				ncf->ncf_file_modified = true;
+		}
 	}
-	if (!ncf->ncf_file_modified &&
-	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
-	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
-		ncf->ncf_file_modified = true;
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
index 2a0946c630e1..5e09682c8135 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3914,7 +3914,8 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
 			    FATTR4_WORD1_TIME_MODIFY |
 			    FATTR4_WORD1_TIME_METADATA))) {
-		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
+		status = nfsd4_deleg_getattr_conflict(rqstp, &path, &args.stat,
+						      &dp);
 		if (status)
 			goto out;
 	}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 811c148f36fc..4fa6329c75b4 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -904,7 +904,8 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
 }
 
 extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
-		struct dentry *dentry, struct nfs4_delegation **pdp);
+		struct path *path, struct kstat *stat,
+		struct nfs4_delegation **pdp);
 
 struct nfsd4_get_dir_delegation;
 struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
-- 
2.53.0


