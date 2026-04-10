Return-Path: <linux-nfs+bounces-20812-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGEgM78g2WkqmggAu9opvQ
	(envelope-from <linux-nfs+bounces-20812-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:09:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 646873DA1F6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A24933002B06
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDF3203B6;
	Fri, 10 Apr 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPXufvC5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD13CE4A2
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837373; cv=none; b=ggZ1XRK4y8/HuzILZh87vE/DtvS3mpzNC8mLXaT6YAIAiZCjBaHtKpUVRia4cSMUAGbzUUbXjoNq17W1oLq7QF8WmJ9vEURp+qjDJC6BR8Vqou5twRjIt2P/tAN4kHa8JNEIMJLntsCkxZUCKPWiAsrptZ3fnOsWzZjhtFgJ4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837373; c=relaxed/simple;
	bh=meCkjDdf4fuCofaErCpRhQpYx4yUPnQwcPAhdlV5ojk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwDoG+qezklHTfYvePA3xn+yWMqtXB1j6MY9xpHMfemhDfFoQ4nbUmTJLB5Woq7XYFoQCMPMq3mIVj1nVAnR1hI3K+RDzCCR8EIyS0si8Y1u58vQpiAQOQrgRY4sYdS6kLYSy/qL5jAFYji8kilRFlScr9xilojOrBpezBTcmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPXufvC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775837371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dL5SIUcyTSd5a7+j40uqyx/G0JyfXXrTWwHWdDLq3s=;
	b=KPXufvC5z+uRSRTOb4wy0kMOhHVUqRcE3vVPPn6WiYUU1ydM22HPmYeXFyrJEkGx3wTews
	FnklloY/8hTOXLFrpEbyrB12fbKS2kzZI5uzOXDTK0GxrPnhGWmzTt1JLpsYbpK+x4FyKV
	zyUGCqCB70yNpLBQ4Pw1jAFTvqLgsFA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-R6rTRH_GNCmbD2ilnyak0Q-1; Fri,
 10 Apr 2026 12:09:25 -0400
X-MC-Unique: R6rTRH_GNCmbD2ilnyak0Q-1
X-Mimecast-MFC-AGG-ID: R6rTRH_GNCmbD2ilnyak0Q_1775837364
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 486661954B0A;
	Fri, 10 Apr 2026 16:09:24 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BEE5195608E;
	Fri, 10 Apr 2026 16:09:23 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v4 1/2] nfsd: update mtime/ctime on CLONE in presense of delegated attributes
Date: Fri, 10 Apr 2026 12:09:19 -0400
Message-ID: <20260410160920.56855-2-okorniev@redhat.com>
In-Reply-To: <20260410160920.56855-1-okorniev@redhat.com>
References: <20260410160920.56855-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20812-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[okorniev@redhat.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 646873DA1F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When delegated attributes are given on open, the file is opened with
NOCMTIME and modifying operations do not update mtime/ctime as to not get
out-of-sync with the client's delegated view. However, for CLONE operation,
the server should update its view of mtime/ctime and reflect that in any
GETATTR queries.

Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRITE_ATTRS delegation")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4proc.c  |  3 +++
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++++++++++++++---------------
 fs/nfsd/state.h     |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6880c5c520e7..ffe85b21a9ac 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1413,6 +1413,9 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			dst, clone->cl_dst_pos, clone->cl_count,
 			EX_ISSYNC(cstate->current_fh.fh_export));
 
+	if (!status && (READ_ONCE(dst->nf_file->f_mode) & FMODE_NOCMTIME) != 0)
+		nfsd_update_cmtime_attr(dst->nf_file, 0);
+
 	nfsd_file_put(dst);
 	nfsd_file_put(src);
 out:
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89df..25a05f7fa3c7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1226,10 +1226,6 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
 {
-	struct iattr ia = { .ia_valid = ATTR_ATIME | ATTR_CTIME | ATTR_MTIME | ATTR_DELEG };
-	struct inode *inode = file_inode(f);
-	int ret;
-
 	/* don't do anything if FMODE_NOCMTIME isn't set */
 	if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) == 0)
 		return;
@@ -1247,17 +1243,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 		return;
 
 	/* Stamp everything to "now" */
-	inode_lock(inode);
-	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &ia, NULL);
-	inode_unlock(inode);
-	if (ret) {
-		struct inode *inode = file_inode(f);
-
-		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
-					MAJOR(inode->i_sb->s_dev),
-					MINOR(inode->i_sb->s_dev),
-					inode->i_ino, ret);
-	}
+	nfsd_update_cmtime_attr(f, ATTR_ATIME);
 }
 
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
@@ -9531,3 +9517,31 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	put_nfs4_file(fp);
 	return ERR_PTR(status);
 }
+
+/**
+ * nfsd_update_cmtime_attr - update file's delegated ctime/mtime
+	and optionally other attributes (ie ATTR_ATIME).
+ * @file: pointer to an opened file
+ * @flags: any additional flags that should be updated
+ *
+ * Given upon opening a file delegated attributes were issues, update
+ * @file attributes to current times.
+ */
+void nfsd_update_cmtime_attr(struct file *f, unsigned int flags)
+{
+	int ret;
+	struct inode *inode = file_inode(f);
+	struct iattr attr = {
+		.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_DELEG | flags,
+	};
+
+	inode_lock(inode);
+	ret = notify_change(&nop_mnt_idmap, f->f_path.dentry, &attr, NULL);
+	inode_unlock(inode);
+	if (ret)
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on "
+				      "inode %02x:%02x:%lu: %d\n",
+				      MAJOR(inode->i_sb->s_dev),
+				      MINOR(inode->i_sb->s_dev),
+				      inode->i_ino, ret);
+}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 6fcbf1e427d4..4cd35092b899 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -825,6 +825,7 @@ extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 void nfsd4_put_client(struct nfs4_client *clp);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);
 bool nfsd4_has_active_async_copies(struct nfs4_client *clp);
+void nfsd_update_cmtime_attr(struct file *f, unsigned int flags);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
-- 
2.52.0


