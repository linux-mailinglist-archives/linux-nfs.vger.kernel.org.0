Return-Path: <linux-nfs+bounces-20977-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLPaIZhM52lW6QEAu9opvQ
	(envelope-from <linux-nfs+bounces-20977-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:08:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36B439563
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83412305E8D1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C483B2FF0;
	Tue, 21 Apr 2026 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYeFQ5+m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BE35837E
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765672; cv=none; b=GUTKbNWQf67GeshvEuMGk+j581jJEePO7ubTSvLvjT4ygamaIyYysfjcSK8Elqo4DjARua1SFrjv42riBfJSAUb1Re19VKq9EgqMsp9wO34jVbCyCBy8wxM3i9tT/oiWPqYQlRi/88ZXUMQEy2N84XPFY//0yeT/4N+VFQtE7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765672; c=relaxed/simple;
	bh=Msm9wS72O3jtmQC5E7coLeZ5IEifwvrO0bhlcoKhX4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/iqTtcK2b4FFXmNeoZ75ewwJxNYfGAeHCY9Di+HweeuicwaauyTbZj10HtqrvGNvHVlumE/9JXcFc3iJUGpc00oWOCrg2Kzp3UNFHil1fkPfvLIkxufciCLOGrM3QLjwzGIpajx4aWiW6rSvbpk6y/zik3HXdFb2zA6wKdEP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYeFQ5+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776765669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXuHmg45dzWBU9awbW4HaCMq4Ho95PbKu8AvFg+S7ds=;
	b=IYeFQ5+moGlVYyVTeti25Vy7zeFnm4+5Rbzf/CiNFxe1LeK/9OB31lJZTloQtSVFdgySH9
	CH8eBH+70DbCfaUcMuCKel+lwY8BgjtpBfDpcHyjFrpuVWU9pHwX9o8TYNoX8wdnSWvhVI
	e0AWmGrH1+yJV6d0bJzeGFGxQZVZt7s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-NZLBd-W8MPWJA_61enht-A-1; Tue,
 21 Apr 2026 06:00:50 -0400
X-MC-Unique: NZLBd-W8MPWJA_61enht-A-1
X-Mimecast-MFC-AGG-ID: NZLBd-W8MPWJA_61enht-A_1776765649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CA70180049F;
	Tue, 21 Apr 2026 10:00:49 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.44.50.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEB4919560AB;
	Tue, 21 Apr 2026 10:00:47 +0000 (UTC)
From: Roberto Bergantinos Corpas <rbergant@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfs: set gencount on protocol-specific remove
Date: Tue, 21 Apr 2026 12:00:46 +0200
Message-ID: <20260421100046.930082-1-rbergant@redhat.com>
In-Reply-To: <20260420114331.700769-1-rbergant@redhat.com>
References: <20260420114331.700769-1-rbergant@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbergant@redhat.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20977-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED36B439563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit bd4928ec799b ("NFS: Avoid changing nlink when file removes and
attribute updates race") avoids races on attribute cache with any
inflight RPC that may modify inode attributes (and gencount) during
i.e. REMOVE.

However it does not take into account that REMOVE may trigger
a delegation return which also advances gencount (via the attribute
refresh during delegation return), and in that case the gencount
mismatch is not due to an inflight RPC that already reflected the
removal.

Push the setting of gencount under each version-specific layer,
reordering correctly for nfsv4 case after the delegation returns.

This fixes LTP/inotify04 failure after bd4928ec799b.

Fixes: bd4928ec799b ("NFS: Avoid changing nlink when file removes and attribute updates race")
Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
v2: Move gencount capture and nfs_drop_nlink into version-specific
remove handlers instead of using force flag (Trond)
---
 fs/nfs/dir.c      | 13 +++----------
 fs/nfs/internal.h |  1 +
 fs/nfs/nfs3proc.c |  8 ++++++++
 fs/nfs/nfs4proc.c |  5 +++++
 fs/nfs/proc.c     |  8 ++++++++
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d..e48e8a837d6f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1937,7 +1937,7 @@ static int nfs_dentry_delete(const struct dentry *dentry)
 }
 
 /* Ensure that we revalidate inode->i_nlink */
-static void nfs_drop_nlink(struct inode *inode, unsigned long gencount)
+void nfs_drop_nlink(struct inode *inode, unsigned long gencount)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 
@@ -1951,6 +1951,7 @@ static void nfs_drop_nlink(struct inode *inode, unsigned long gencount)
 			       NFS_INO_INVALID_NLINK);
 	spin_unlock(&inode->i_lock);
 }
+EXPORT_SYMBOL_GPL(nfs_drop_nlink);
 
 /*
  * Called when the dentry loses inode.
@@ -2542,7 +2543,6 @@ EXPORT_SYMBOL_GPL(nfs_rmdir);
 static int nfs_safe_remove(struct dentry *dentry)
 {
 	struct inode *dir = d_inode(dentry->d_parent);
-	struct inode *inode = d_inode(dentry);
 	int error = -EBUSY;
 		
 	dfprintk(VFS, "NFS: safe_remove(%pd2)\n", dentry);
@@ -2554,14 +2554,7 @@ static int nfs_safe_remove(struct dentry *dentry)
 	}
 
 	trace_nfs_remove_enter(dir, dentry);
-	if (inode != NULL) {
-		unsigned long gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
-
-		error = NFS_PROTO(dir)->remove(dir, dentry);
-		if (error == 0)
-			nfs_drop_nlink(inode, gencount);
-	} else
-		error = NFS_PROTO(dir)->remove(dir, dentry);
+	error = NFS_PROTO(dir)->remove(dir, dentry);
 	if (error == -ENOENT)
 		nfs_dentry_handle_enoent(dentry);
 	trace_nfs_remove_exit(dir, dentry, error);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 63e09dfc27a8..84d750de608e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -390,6 +390,7 @@ extern unsigned long nfs_access_cache_count(struct shrinker *shrink,
 					    struct shrink_control *sc);
 extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
+extern void nfs_drop_nlink(struct inode *inode, unsigned long gencount);
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 3e2de45c95fe..b077455fb019 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -442,13 +442,21 @@ nfs3_proc_remove(struct inode *dir, struct dentry *dentry)
 		.rpc_resp = &res,
 	};
 	int status = -ENOMEM;
+	struct inode *inode = d_inode(dentry);
+	unsigned long gencount;
 
 	dprintk("NFS call  remove %pd2\n", dentry);
 	res.dir_attr = nfs_alloc_fattr();
 	if (res.dir_attr == NULL)
 		goto out;
 
+	if (inode)
+		gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
+
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
+	if (status == 0 && inode)
+		nfs_drop_nlink(inode, gencount);
+
 	nfs_post_op_update_inode(dir, res.dir_attr);
 	nfs_free_fattr(res.dir_attr);
 out:
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 91bcf67bd743..85901714b4b5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4919,12 +4919,14 @@ static int nfs4_proc_remove(struct inode *dir, struct dentry *dentry)
 	};
 	struct inode *inode = d_inode(dentry);
 	int err;
+	unsigned long gencount;
 
 	if (inode) {
 		if (inode->i_nlink == 1)
 			nfs4_inode_return_delegation(inode);
 		else
 			nfs4_inode_make_writeable(inode);
+		gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
 	}
 	do {
 		err = _nfs4_proc_remove(dir, &dentry->d_name, NF4REG);
@@ -4932,6 +4934,9 @@ static int nfs4_proc_remove(struct inode *dir, struct dentry *dentry)
 		err = nfs4_handle_exception(NFS_SERVER(dir), err,
 				&exception);
 	} while (exception.retry);
+
+	if (err == 0 && inode)
+		nfs_drop_nlink(inode, gencount);
 	return err;
 }
 
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 8c3d2efa2636..a8d8ac421200 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -322,9 +322,17 @@ nfs_proc_remove(struct inode *dir, struct dentry *dentry)
 		.rpc_argp = &arg,
 	};
 	int			status;
+	struct inode *inode = d_inode(dentry);
+	unsigned long gencount;
 
 	dprintk("NFS call  remove %pd2\n",dentry);
+	if (inode)
+		gencount = READ_ONCE(NFS_I(inode)->attr_gencount);
+
 	status = rpc_call_sync(NFS_CLIENT(dir), &msg, 0);
+	if (status == 0 && inode)
+		nfs_drop_nlink(inode, gencount);
+
 	nfs_mark_for_revalidate(dir);
 
 	dprintk("NFS reply remove: %d\n", status);
-- 
2.53.0


