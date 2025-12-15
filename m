Return-Path: <linux-nfs+bounces-17108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB12CBF7EB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3A5330022FD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940933030E;
	Mon, 15 Dec 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giw0eB+F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E433030D
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825847; cv=none; b=sdGWxDjgYBJcsBTgJsaIrfEvnpYHRHCQeaUzn1TrCuRVrJ17j5qazo1oPObayx++o6rwShoGMbXFQn+r0AvQ5vX0CGBnPRry1TZE0sx3uYByitj+LrHpscjOMOvzoaFjczcIcjjIajg4gUkxTzHOSgxaaNejyS+ukpIZisHCJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825847; c=relaxed/simple;
	bh=aipnEWn9P3slVox2d0YGTZxg/hdqwIVDygK95dcZ8bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSJArmkPr8IooS6GBOJ6RaWavK04MqMiT6/1CEfJaS261l/eUhlC3Z6S6IC1kB4dAD9Hlfz935JtAia7OdpyVrj/qf/22hx7JzycPqqIo3mUjtwv3//+gx7kK2Fdrc37d/E1DPkYsgVJ0/UnSsLVXPd+nSD0ZDUWT6tKhilUsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giw0eB+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765825844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VSTQrpCqZl7O6QfMyYAW8oYplNNwNrxRc+lxQnxahE0=;
	b=giw0eB+FHAYTHgTCY+58iIe6Py37QtX3KuwXUh7yL2/P3BXAzMHg++eaOeOs0Z09iRS3ml
	7PgA/e3OTnztYojAWPs0uWyYaTgGN2z9MgY5R4Ru4MZD5QbOBqQsrzBrRgoSkOia/ltuW+
	5K+ojwVT1SI9Dsrgdx9PEfivZgVf1Kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-0G0iR3ixPmOK2K44TvE-tw-1; Mon,
 15 Dec 2025 14:10:41 -0500
X-MC-Unique: 0G0iR3ixPmOK2K44TvE-tw-1
X-Mimecast-MFC-AGG-ID: 0G0iR3ixPmOK2K44TvE-tw_1765825840
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE531195605F;
	Mon, 15 Dec 2025 19:10:39 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 845F31956056;
	Mon, 15 Dec 2025 19:10:37 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v3 1/1] nfsd: check that server is running in unlock_filesystem
Date: Mon, 15 Dec 2025 14:10:36 -0500
Message-ID: <20251215191036.17728-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If we are trying to unlock the filesystem via an administrative
interface and nfsd isn't running, it crashes the server. This
happens currently because nfsd4_revoke_states() access state
structures (eg., conf_id_hashtbl) that has been freed as a part
of the server shutdown.

[   59.465072] Call trace:
[   59.465308]  nfsd4_revoke_states+0x1b4/0x898 [nfsd] (P)
[   59.465830]  write_unlock_fs+0x258/0x440 [nfsd]
[   59.466278]  nfsctl_transaction_write+0xb0/0x120 [nfsd]
[   59.466780]  vfs_write+0x1f0/0x938
[   59.467088]  ksys_write+0xfc/0x1f8
[   59.467395]  __arm64_sys_write+0x74/0xb8
[   59.467746]  invoke_syscall.constprop.0+0xdc/0x1e8
[   59.468177]  do_el0_svc+0x154/0x1d8
[   59.468489]  el0_svc+0x40/0xe0
[   59.468767]  el0t_64_sync_handler+0xa0/0xe8
[   59.469138]  el0t_64_sync+0x1ac/0x1b0

Ensure this can't happen by taking the nfsd_mutex and checking that
the server is still up, and then holding the mutex across the call to
nfsd4_revoke_states().

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 1ac3629bf0125 ("nfsd: prepare for supporting admin-revocation of state")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 +--
 fs/nfsd/nfsctl.c    | 9 ++++++++-
 fs/nfsd/state.h     | 4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..191d67973e31 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1769,9 +1769,8 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
  * The clients which own the states will subsequently being notified that the
  * states have been "admin-revoked".
  */
-void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	unsigned int idhashval;
 	unsigned int sc_types;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2b79129703d5..eea8584df358 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -259,6 +259,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	struct path path;
 	char *fo_path;
 	int error;
+	struct nfsd_net *nn;
 
 	/* sanity check */
 	if (size == 0)
@@ -285,7 +286,13 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 3.  Is that directory the root of an exported file system?
 	 */
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
-	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
+	mutex_lock(&nfsd_mutex);
+	nn = net_generic(netns(file), nfsd_net_id);
+	if (nn->nfsd_serv)
+		nfsd4_revoke_states(nn, path.dentry->d_sb);
+	else
+		error = -EINVAL;
+	mutex_unlock(&nfsd_mutex);
 
 	path_put(&path);
 	return error;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1e736f402426..bf3394a01375 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -841,9 +841,9 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
 struct nfsd_file *find_any_file(struct nfs4_file *f);
 
 #ifdef CONFIG_NFSD_V4
-void nfsd4_revoke_states(struct net *net, struct super_block *sb);
+void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb);
 #else
-static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+static inline void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
 {
 }
 #endif
-- 
2.47.3


